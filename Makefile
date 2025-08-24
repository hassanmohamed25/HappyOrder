.PHONY: help install up down build logs shell test lint format migrate seed

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install dependencies
	composer install
	npm install
	cp .env.example .env
	php artisan key:generate
	php artisan storage:link

up: ## Start all services
	docker-compose up -d

down: ## Stop all services
	docker-compose down

build: ## Build and start services
	docker-compose up -d --build

logs: ## Show logs
	docker-compose logs -f

shell: ## Access app container shell
	docker-compose exec app bash

mysql: ## Access MySQL shell
	docker-compose exec mysql mysql -u happy_order -p happy_order

redis: ## Access Redis CLI
	docker-compose exec redis redis-cli

test: ## Run tests
	php artisan test

lint: ## Run linters
	./vendor/bin/pint
	npm run lint

format: ## Format code
	./vendor/bin/pint
	npm run format

migrate: ## Run migrations
	php artisan migrate

migrate-fresh: ## Fresh migration with seeding
	php artisan migrate:fresh --seed

seed: ## Run seeders
	php artisan db:seed

horizon: ## Start Horizon
	php artisan horizon

websockets: ## Start WebSocket server
	php artisan websockets:serve

queue: ## Start queue worker
	php artisan queue:work

cache-clear: ## Clear all caches
	php artisan cache:clear
	php artisan config:clear
	php artisan route:clear
	php artisan view:clear

optimize: ## Optimize for production
	php artisan config:cache
	php artisan route:cache
	php artisan view:cache
	composer install --optimize-autoloader --no-dev

backup: ## Backup database
	php artisan backup:run

deploy: ## Deploy to production
	git pull origin main
	composer install --no-dev --optimize-autoloader
	npm ci && npm run build
	php artisan migrate --force
	php artisan config:cache
	php artisan route:cache
	php artisan view:cache
	php artisan queue:restart
