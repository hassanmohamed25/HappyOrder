#!/bin/bash

# Happy Order Deployment Script
set -e

echo "🚀 Starting Happy Order deployment..."

# Configuration
APP_NAME="happy-order"
DOCKER_IMAGE="happy-order:latest"
BACKUP_DIR="/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    log_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup database
log_info "Creating database backup..."
docker-compose exec -T mysql mysqldump -u happy_order -psecret happy_order > "$BACKUP_DIR/db_backup_$TIMESTAMP.sql"

# Backup storage files
log_info "Creating storage backup..."
docker-compose exec -T app tar -czf - /var/www/html/storage > "$BACKUP_DIR/storage_backup_$TIMESTAMP.tar.gz"

# Pull latest changes
log_info "Pulling latest code..."
git pull origin main

# Build new Docker image
log_info "Building Docker image..."
docker-compose build --no-cache

# Stop services
log_info "Stopping services..."
docker-compose down

# Start services
log_info "Starting services..."
docker-compose up -d

# Wait for services to be ready
log_info "Waiting for services to be ready..."
sleep 30

# Run database migrations
log_info "Running database migrations..."
docker-compose exec -T app php artisan migrate --force

# Clear caches
log_info "Clearing application caches..."
docker-compose exec -T app php artisan config:clear
docker-compose exec -T app php artisan cache:clear
docker-compose exec -T app php artisan route:clear
docker-compose exec -T app php artisan view:clear

# Optimize application
log_info "Optimizing application..."
docker-compose exec -T app php artisan config:cache
docker-compose exec -T app php artisan route:cache
docker-compose exec -T app php artisan view:cache

# Check application health
log_info "Checking application health..."
if curl -f http://localhost:8000/api/health > /dev/null 2>&1; then
    log_info "✅ Application is healthy!"
else
    log_error "❌ Application health check failed!"
    
    # Rollback if health check fails
    log_warn "Rolling back to previous version..."
    docker-compose down
    
    # Restore database backup
    log_info "Restoring database backup..."
    docker-compose up -d mysql
    sleep 10
    docker-compose exec -T mysql mysql -u happy_order -psecret happy_order < "$BACKUP_DIR/db_backup_$TIMESTAMP.sql"
    
    # Restore storage backup
    log_info "Restoring storage backup..."
    docker-compose exec -T app tar -xzf - -C / < "$BACKUP_DIR/storage_backup_$TIMESTAMP.tar.gz"
    
    exit 1
fi

# Clean up old backups (keep last 5)
log_info "Cleaning up old backups..."
ls -t $BACKUP_DIR/db_backup_*.sql | tail -n +6 | xargs -r rm
ls -t $BACKUP_DIR/storage_backup_*.tar.gz | tail -n +6 | xargs -r rm

# Clean up old Docker images
log_info "Cleaning up old Docker images..."
docker image prune -f

log_info "🎉 Deployment completed successfully!"
log_info "Application is running at: http://localhost:8000"
log_info "Admin panel: http://localhost:8000/admin"
