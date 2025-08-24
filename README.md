# Happy Order - Restaurant Ordering System

A comprehensive multi-tenant restaurant ordering system built with Laravel 11 and Vue.js 3, featuring real-time order tracking, payment processing, and administrative management.

## 🚀 Features

### Customer Features
- **Multi-restaurant browsing** with search and filtering
- **Real-time menu** with categories and product options
- **Shopping cart** with persistent storage
- **Multiple payment methods** (Stripe, PayPal, Cash on Delivery)
- **Order tracking** with live status updates
- **Customer accounts** with order history
- **PWA support** for mobile app-like experience
- **Multi-language support** (English/Arabic with RTL)

### Restaurant Features
- **Multi-tenant architecture** supporting multiple restaurants
- **Branch management** with delivery zones
- **Menu management** with categories and product options
- **Order management** with status tracking
- **Kitchen display system** for real-time order processing
- **Analytics dashboard** with sales reports
- **Staff management** with role-based permissions

### Admin Features
- **Comprehensive dashboard** with analytics
- **Restaurant and branch management**
- **User and customer management**
- **Order monitoring and management**
- **Payment tracking and reporting**
- **System configuration and settings**

### Technical Features
- **Real-time updates** using WebSockets (Pusher)
- **Payment gateway integration** (Stripe, PayPal)
- **RESTful API** with comprehensive documentation
- **Role-based access control** (RBAC)
- **Multi-language support** with i18n
- **PWA capabilities** with offline support
- **Responsive design** for all devices
- **Docker containerization** for easy deployment
- **Comprehensive testing** (PHPUnit, Vitest)
- **CI/CD pipeline** with GitHub Actions

## 🛠 Technology Stack

### Backend
- **Laravel 11** - PHP framework
- **MySQL 8.0** - Primary database
- **Redis** - Caching and session storage
- **Pusher** - Real-time WebSocket communication
- **Laravel Sanctum** - API authentication
- **Spatie Laravel Permission** - Role and permission management

### Frontend
- **Vue.js 3** - Progressive JavaScript framework
- **Vite** - Build tool and development server
- **Pinia** - State management
- **Vue Router** - Client-side routing
- **Vue I18n** - Internationalization
- **Tailwind CSS** - Utility-first CSS framework
- **Headless UI** - Unstyled, accessible UI components

### DevOps & Deployment
- **Docker & Docker Compose** - Containerization
- **GitHub Actions** - CI/CD pipeline
- **Nginx** - Web server and reverse proxy
- **Supervisor** - Process management

## 📋 Prerequisites

- **Docker** and **Docker Compose**
- **Node.js** 18+ and **npm**
- **PHP** 8.2+ and **Composer** (for local development)
- **MySQL** 8.0+ (for local development)
- **Redis** (for local development)

## 🚀 Quick Start

### Using Docker (Recommended)

1. **Clone the repository**
   \`\`\`bash
   git clone https://github.com/your-username/happy-order.git
   cd happy-order
   \`\`\`

2. **Copy environment file**
   \`\`\`bash
   cp .env.example .env
   \`\`\`

3. **Update environment variables**
   \`\`\`bash
   # Database
   DB_CONNECTION=mysql
   DB_HOST=mysql
   DB_PORT=3306
   DB_DATABASE=happy_order
   DB_USERNAME=happy_order
   DB_PASSWORD=secret

   # Redis
   REDIS_HOST=redis
   REDIS_PORT=6379

   # Pusher (for real-time features)
   PUSHER_APP_ID=your_app_id
   PUSHER_APP_KEY=your_app_key
   PUSHER_APP_SECRET=your_app_secret
   PUSHER_APP_CLUSTER=your_cluster

   # Payment Gateways
   STRIPE_KEY=your_stripe_key
   STRIPE_SECRET=your_stripe_secret
   PAYPAL_CLIENT_ID=your_paypal_client_id
   PAYPAL_CLIENT_SECRET=your_paypal_client_secret
   \`\`\`

4. **Start the application**
   \`\`\`bash
   docker-compose up -d
   \`\`\`

5. **Run database migrations and seeders**
   \`\`\`bash
   docker-compose exec app php artisan migrate --seed
   \`\`\`

6. **Access the application**
   - **Customer App**: http://localhost:8000
   - **Admin Panel**: http://localhost:8000/admin
   - **API Documentation**: http://localhost:8000/api/documentation

### Local Development Setup

1. **Install PHP dependencies**
   \`\`\`bash
   composer install
   \`\`\`

2. **Install Node.js dependencies**
   \`\`\`bash
   npm install
   \`\`\`

3. **Generate application key**
   \`\`\`bash
   php artisan key:generate
   \`\`\`

4. **Run database migrations**
   \`\`\`bash
   php artisan migrate --seed
   \`\`\`

5. **Start development servers**
   \`\`\`bash
   # Terminal 1: Laravel development server
   php artisan serve

   # Terminal 2: Vite development server
   npm run dev

   # Terminal 3: Queue worker
   php artisan queue:work

   # Terminal 4: WebSocket server (if using Laravel WebSockets)
   php artisan websockets:serve
   \`\`\`

## 🧪 Testing

### Backend Tests
\`\`\`bash
# Run all tests
./vendor/bin/phpunit

# Run with coverage
./vendor/bin/phpunit --coverage-html coverage

# Run specific test suite
./vendor/bin/phpunit --testsuite=Feature
./vendor/bin/phpunit --testsuite=Unit
\`\`\`

### Frontend Tests
\`\`\`bash
# Run all tests
npm run test

# Run with coverage
npm run test:coverage

# Run in watch mode
npm run test:watch
\`\`\`

### End-to-End Tests
\`\`\`bash
# Run Playwright tests
npm run test:e2e
\`\`\`

## 📚 API Documentation

The API documentation is automatically generated and available at `/api/documentation` when the application is running.

### Authentication
All API endpoints require authentication using Laravel Sanctum tokens.

\`\`\`bash
# Login and get token
curl -X POST http://localhost:8000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "customer@example.com", "password": "password"}'

# Use token in subsequent requests
curl -X GET http://localhost:8000/api/orders \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
\`\`\`

## 🚀 Deployment

### Production Deployment

1. **Clone repository on server**
   \`\`\`bash
   git clone https://github.com/your-username/happy-order.git
   cd happy-order
   \`\`\`

2. **Copy and configure environment**
   \`\`\`bash
   cp .env.example .env
   # Edit .env with production values
   \`\`\`

3. **Run deployment script**
   \`\`\`bash
   chmod +x deploy.sh
   ./deploy.sh
   \`\`\`

### Environment Variables

Key environment variables for production:

\`\`\`env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-domain.com

DB_CONNECTION=mysql
DB_HOST=your-db-host
DB_DATABASE=your-db-name
DB_USERNAME=your-db-user
DB_PASSWORD=your-db-password

REDIS_HOST=your-redis-host
REDIS_PASSWORD=your-redis-password

PUSHER_APP_ID=your-pusher-app-id
PUSHER_APP_KEY=your-pusher-key
PUSHER_APP_SECRET=your-pusher-secret
PUSHER_APP_CLUSTER=your-pusher-cluster

STRIPE_KEY=your-stripe-publishable-key
STRIPE_SECRET=your-stripe-secret-key
PAYPAL_CLIENT_ID=your-paypal-client-id
PAYPAL_CLIENT_SECRET=your-paypal-secret
\`\`\`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support, email support@happyorder.com or join our Slack channel.

## 🙏 Acknowledgments

- Laravel community for the amazing framework
- Vue.js team for the progressive framework
- All contributors who helped build this project
