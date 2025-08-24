#!/bin/bash

# Happy Order Restaurant System Bootstrap Script
# This script creates the complete Laravel + Vue.js restaurant ordering system

set -e

PROJECT_NAME="happy-order"
CURRENT_DIR=$(pwd)

echo "🚀 Creating Happy Order Restaurant System..."
echo "📁 Project will be created in: $CURRENT_DIR/$PROJECT_NAME"

# Create project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Create directory structure
echo "📂 Creating directory structure..."
mkdir -p {app/{Http/{Controllers/Api/{Admin},Requests/{Auth,Order,Product,Customer},Resources,Middleware},Models,Services/{PaymentGateways},Events,Jobs,Observers},config,database/{migrations,seeders,factories},resources/{js/{components/{admin,ui},views/{admin,auth},stores,router,lang/{en,ar}},css,views},public/{images,js,css},storage/{app/{public,uploads},framework/{cache,sessions,views},logs},tests/{Feature,Unit},routes,.github/workflows,docker,scripts}

# Create Laravel configuration files
echo "⚙️ Creating Laravel configuration..."

cat > composer.json <<'EOF'
{
    "name": "happy-order/restaurant-system",
    "type": "project",
    "description": "Complete restaurant ordering system with Laravel and Vue.js",
    "keywords": ["laravel", "vue", "restaurant", "ordering", "pwa"],
    "license": "MIT",
    "require": {
        "php": "^8.2",
        "laravel/framework": "^11.0",
        "laravel/sanctum": "^4.0",
        "laravel/tinker": "^2.9",
        "pusher/pusher-php-server": "^7.2",
        "stripe/stripe-php": "^10.0",
        "paypal/rest-api-sdk-php": "^1.14",
        "intervention/image": "^3.0",
        "spatie/laravel-permission": "^6.0",
        "spatie/laravel-activitylog": "^4.8",
        "laravel/horizon": "^5.21",
        "predis/predis": "^2.2"
    },
    "require-dev": {
        "fakerphp/faker": "^1.23",
        "laravel/pint": "^1.13",
        "laravel/sail": "^1.26",
        "mockery/mockery": "^1.6",
        "nunomaduro/collision": "^8.0",
        "phpunit/phpunit": "^11.0",
        "spatie/laravel-ignition": "^2.4"
    },
    "autoload": {
        "psr-4": {
            "App\\": "app/",
            "Database\\Factories\\": "database/factories/",
            "Database\\Seeders\\": "database/seeders/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "Tests\\": "tests/"
        }
    },
    "scripts": {
        "post-autoload-dump": [
            "Illuminate\\Foundation\\ComposerScripts::postAutoloadDump",
            "@php artisan package:discover --ansi"
        ],
        "post-update-cmd": [
            "@php artisan vendor:publish --tag=laravel-assets --ansi --force"
        ],
        "post-root-package-install": [
            "@php -r \"file_exists('.env') || copy('.env.example', '.env');\""
        ],
        "post-create-project-cmd": [
            "@php artisan key:generate --ansi",
            "@php -r \"file_exists('database/database.sqlite') || touch('database/database.sqlite');\"",
            "@php artisan migrate --graceful --ansi"
        ]
    },
    "extra": {
        "laravel": {
            "dont-discover": []
        }
    },
    "config": {
        "optimize-autoloader": true,
        "preferred-install": "dist",
        "sort-packages": true,
        "allow-plugins": {
            "pestphp/pest-plugin": true,
            "php-http/discovery": true
        }
    },
    "minimum-stability": "stable",
    "prefer-stable": true
}
EOF

cat > package.json <<'EOF'
{
  "name": "happy-order",
  "version": "1.0.0",
  "description": "Restaurant ordering system frontend",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "lint": "eslint resources/js --ext .vue,.js,.ts --fix",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "test:coverage": "vitest --coverage"
  },
  "dependencies": {
    "vue": "^3.4.0",
    "vue-router": "^4.2.0",
    "pinia": "^2.1.0",
    "axios": "^1.6.0",
    "vue-i18n": "^9.8.0",
    "laravel-echo": "^1.15.0",
    "pusher-js": "^8.4.0",
    "@stripe/stripe-js": "^2.4.0",
    "chart.js": "^4.4.0",
    "vue-chartjs": "^5.3.0",
    "leaflet": "^1.9.0",
    "vue3-leaflet": "^1.0.0",
    "@vueuse/core": "^10.7.0",
    "date-fns": "^3.0.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^5.0.0",
    "vite": "^5.0.0",
    "vite-plugin-pwa": "^0.17.0",
    "eslint": "^8.56.0",
    "eslint-plugin-vue": "^9.19.0",
    "@vue/eslint-config-prettier": "^9.0.0",
    "prettier": "^3.1.0",
    "vitest": "^1.1.0",
    "@vue/test-utils": "^2.4.0",
    "jsdom": "^23.0.0",
    "@vitest/ui": "^1.1.0",
    "@vitest/coverage-v8": "^1.1.0",
    "autoprefixer": "^10.4.0",
    "postcss": "^8.4.0",
    "tailwindcss": "^3.4.0"
  }
}
EOF

cat > .env.example <<'EOF'
APP_NAME="Happy Order"
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_TIMEZONE=UTC
APP_URL=http://localhost:8000

APP_LOCALE=en
APP_FALLBACK_LOCALE=en
APP_FAKER_LOCALE=en_US

APP_MAINTENANCE_DRIVER=file
APP_MAINTENANCE_STORE=database

BCRYPT_ROUNDS=12

LOG_CHANNEL=stack
LOG_STACK=single
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=happy_order
DB_USERNAME=root
DB_PASSWORD=

SESSION_DRIVER=database
SESSION_LIFETIME=120
SESSION_ENCRYPT=false
SESSION_PATH=/
SESSION_DOMAIN=null

BROADCAST_CONNECTION=pusher
FILESYSTEM_DISK=local
QUEUE_CONNECTION=redis

CACHE_STORE=redis
CACHE_PREFIX=

MEMCACHED_HOST=127.0.0.1

REDIS_CLIENT=phpredis
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=log
MAIL_HOST=127.0.0.1
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

VITE_APP_NAME="${APP_NAME}"

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"

STRIPE_KEY=
STRIPE_SECRET=
STRIPE_WEBHOOK_SECRET=

PAYPAL_CLIENT_ID=
PAYPAL_CLIENT_SECRET=
PAYPAL_MODE=sandbox

GOOGLE_MAPS_API_KEY=
FIREBASE_SERVER_KEY=

TELESCOPE_ENABLED=false
HORIZON_ENABLED=true
EOF

# Create Laravel Models
echo "📝 Creating Laravel Models..."

cat > app/Models/Restaurant.php <<'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Activitylog\LogOptions;

class Restaurant extends Model
{
    use HasFactory, SoftDeletes, LogsActivity;

    protected $fillable = [
        'name',
        'slug',
        'description',
        'logo',
        'cover_image',
        'phone',
        'email',
        'website',
        'address',
        'city',
        'country',
        'postal_code',
        'latitude',
        'longitude',
        'cuisine_type',
        'price_range',
        'rating',
        'total_reviews',
        'delivery_fee',
        'minimum_order',
        'delivery_time',
        'is_active',
        'opens_at',
        'closes_at',
        'settings'
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'latitude' => 'decimal:8',
        'longitude' => 'decimal:8',
        'delivery_fee' => 'decimal:2',
        'minimum_order' => 'decimal:2',
        'rating' => 'decimal:2',
        'opens_at' => 'datetime:H:i',
        'closes_at' => 'datetime:H:i',
        'settings' => 'array'
    ];

    public function branches(): HasMany
    {
        return $this->hasMany(Branch::class);
    }

    public function categories(): HasMany
    {
        return $this->hasMany(Category::class);
    }

    public function products(): HasMany
    {
        return $this->hasMany(Product::class);
    }

    public function orders(): HasMany
    {
        return $this->hasMany(Order::class);
    }

    public function users(): HasMany
    {
        return $this->hasMany(User::class);
    }

    public function coupons(): HasMany
    {
        return $this->hasMany(Coupon::class);
    }

    public function deliveryZones(): HasMany
    {
        return $this->hasMany(DeliveryZone::class);
    }

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logOnly(['name', 'is_active', 'phone', 'email'])
            ->logOnlyDirty();
    }

    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    public function isOpen(): bool
    {
        $now = now()->format('H:i');
        return $now >= $this->opens_at->format('H:i') && $now <= $this->closes_at->format('H:i');
    }
}
EOF

cat > app/Models/Branch.php <<'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Branch extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'restaurant_id',
        'name',
        'address',
        'city',
        'phone',
        'latitude',
        'longitude',
        'is_active',
        'opens_at',
        'closes_at',
        'delivery_radius'
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'latitude' => 'decimal:8',
        'longitude' => 'decimal:8',
        'delivery_radius' => 'decimal:2',
        'opens_at' => 'datetime:H:i',
        'closes_at' => 'datetime:H:i'
    ];

    public function restaurant(): BelongsTo
    {
        return $this->belongsTo(Restaurant::class);
    }

    public function orders(): HasMany
    {
        return $this->hasMany(Order::class);
    }

    public function tables(): HasMany
    {
        return $this->hasMany(Table::class);
    }

    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    public function isOpen(): bool
    {
        $now = now()->format('H:i');
        return $now >= $this->opens_at->format('H:i') && $now <= $this->closes_at->format('H:i');
    }
}
EOF

cat > app/Models/Category.php <<'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Category extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'restaurant_id',
        'name',
        'description',
        'image',
        'sort_order',
        'is_active'
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'sort_order' => 'integer'
    ];

    public function restaurant(): BelongsTo
    {
        return $this->belongsTo(Restaurant::class);
    }

    public function products(): HasMany
    {
        return $this->hasMany(Product::class);
    }

    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    public function scopeOrdered($query)
    {
        return $query->orderBy('sort_order');
    }
}
EOF

cat > app/Models/Product.php <<'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'restaurant_id',
        'category_id',
        'name',
        'description',
        'image',
        'price',
        'sale_price',
        'sku',
        'ingredients',
        'allergens',
        'nutritional_info',
        'preparation_time',
        'calories',
        'is_vegetarian',
        'is_vegan',
        'is_gluten_free',
        'is_spicy',
        'spice_level',
        'is_available',
        'is_featured',
        'sort_order'
    ];

    protected $casts = [
        'price' => 'decimal:2',
        'sale_price' => 'decimal:2',
        'preparation_time' => 'integer',
        'calories' => 'integer',
        'spice_level' => 'integer',
        'is_vegetarian' => 'boolean',
        'is_vegan' => 'boolean',
        'is_gluten_free' => 'boolean',
        'is_spicy' => 'boolean',
        'is_available' => 'boolean',
        'is_featured' => 'boolean',
        'sort_order' => 'integer',
        'ingredients' => 'array',
        'allergens' => 'array',
        'nutritional_info' => 'array'
    ];

    public function restaurant(): BelongsTo
    {
        return $this->belongsTo(Restaurant::class);
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function optionGroups(): BelongsToMany
    {
        return $this->belongsToMany(ProductOptionGroup::class, 'product_option_group_assignments');
    }

    public function orderItems(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function scopeAvailable($query)
    {
        return $query->where('is_available', true);
    }

    public function scopeFeatured($query)
    {
        return $query->where('is_featured', true);
    }

    public function scopeOrdered($query)
    {
        return $query->orderBy('sort_order');
    }

    public function getCurrentPrice(): float
    {
        return $this->sale_price ?? $this->price;
    }

    public function isOnSale(): bool
    {
        return !is_null($this->sale_price) && $this->sale_price < $this->price;
    }
}
EOF

# Continue with more models...
cat > app/Models/Order.php <<'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Activitylog\LogOptions;

class Order extends Model
{
    use HasFactory, LogsActivity;

    const STATUS_PENDING = 'pending';
    const STATUS_CONFIRMED = 'confirmed';
    const STATUS_PREPARING = 'preparing';
    const STATUS_READY = 'ready';
    const STATUS_OUT_FOR_DELIVERY = 'out_for_delivery';
    const STATUS_DELIVERED = 'delivered';
    const STATUS_CANCELLED = 'cancelled';

    const TYPE_DELIVERY = 'delivery';
    const TYPE_PICKUP = 'pickup';
    const TYPE_DINE_IN = 'dine_in';

    protected $fillable = [
        'restaurant_id',
        'branch_id',
        'customer_id',
        'order_number',
        'type',
        'status',
        'subtotal',
        'tax_amount',
        'delivery_fee',
        'discount_amount',
        'total_amount',
        'currency',
        'payment_status',
        'payment_method',
        'delivery_address',
        'delivery_instructions',
        'estimated_delivery_time',
        'actual_delivery_time',
        'notes',
        'coupon_code',
        'table_id'
    ];

    protected $casts = [
        'subtotal' => 'decimal:2',
        'tax_amount' => 'decimal:2',
        'delivery_fee' => 'decimal:2',
        'discount_amount' => 'decimal:2',
        'total_amount' => 'decimal:2',
        'delivery_address' => 'array',
        'estimated_delivery_time' => 'datetime',
        'actual_delivery_time' => 'datetime'
    ];

    public function restaurant(): BelongsTo
    {
        return $this->belongsTo(Restaurant::class);
    }

    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class);
    }

    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class);
    }

    public function items(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function payment(): HasOne
    {
        return $this->hasOne(Payment::class);
    }

    public function table(): BelongsTo
    {
        return $this->belongsTo(Table::class);
    }

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logOnly(['status', 'payment_status', 'total_amount'])
            ->logOnlyDirty();
    }

    public function scopeByStatus($query, $status)
    {
        return $query->where('status', $status);
    }

    public function scopeByType($query, $type)
    {
        return $query->where('type', $type);
    }

    public function isDelivered(): bool
    {
        return $this->status === self::STATUS_DELIVERED;
    }

    public function isCancelled(): bool
    {
        return $this->status === self::STATUS_CANCELLED;
    }

    public function canBeCancelled(): bool
    {
        return in_array($this->status, [self::STATUS_PENDING, self::STATUS_CONFIRMED]);
    }
}
EOF

# Create more essential files
echo "🔧 Creating configuration files..."

cat > config/cors.php <<'EOF'
<?php

return [
    'paths' => ['api/*', 'sanctum/csrf-cookie'],
    'allowed_methods' => ['*'],
    'allowed_origins' => ['*'],
    'allowed_origins_patterns' => [],
    'allowed_headers' => ['*'],
    'exposed_headers' => [],
    'max_age' => 0,
    'supports_credentials' => false,
];
EOF

cat > routes/api.php <<'EOF'
<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\RestaurantController;
use App\Http\Controllers\Api\MenuController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\Api\CustomerController;
use App\Http\Controllers\Api\Admin\DashboardController;
use App\Http\Controllers\Api\Admin\OrderController as AdminOrderController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

// Public routes
Route::prefix('auth')->group(function () {
    Route::post('login', [AuthController::class, 'login']);
    Route::post('register', [AuthController::class, 'register']);
    Route::post('forgot-password', [AuthController::class, 'forgotPassword']);
    Route::post('reset-password', [AuthController::class, 'resetPassword']);
});

Route::get('restaurants', [RestaurantController::class, 'index']);
Route::get('restaurants/{restaurant}', [RestaurantController::class, 'show']);
Route::get('restaurants/{restaurant}/menu', [MenuController::class, 'index']);
Route::get('products/{product}', [MenuController::class, 'show']);

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('auth/logout', [AuthController::class, 'logout']);
    Route::get('auth/me', [AuthController::class, 'me']);
    
    // Customer routes
    Route::prefix('customer')->group(function () {
        Route::get('profile', [CustomerController::class, 'profile']);
        Route::put('profile', [CustomerController::class, 'updateProfile']);
        Route::get('addresses', [CustomerController::class, 'addresses']);
        Route::post('addresses', [CustomerController::class, 'storeAddress']);
        Route::put('addresses/{address}', [CustomerController::class, 'updateAddress']);
        Route::delete('addresses/{address}', [CustomerController::class, 'deleteAddress']);
        Route::get('orders', [CustomerController::class, 'orders']);
    });
    
    // Order routes
    Route::prefix('orders')->group(function () {
        Route::get('/', [OrderController::class, 'index']);
        Route::post('/', [OrderController::class, 'store']);
        Route::get('{order}', [OrderController::class, 'show']);
        Route::put('{order}/cancel', [OrderController::class, 'cancel']);
        Route::get('{order}/track', [OrderController::class, 'track']);
    });
    
    // Payment routes
    Route::prefix('payments')->group(function () {
        Route::post('process', [PaymentController::class, 'process']);
        Route::post('webhook/stripe', [PaymentController::class, 'stripeWebhook']);
        Route::post('webhook/paypal', [PaymentController::class, 'paypalWebhook']);
    });
    
    // Admin routes
    Route::middleware('role:admin|restaurant_admin')->prefix('admin')->group(function () {
        Route::get('dashboard', [DashboardController::class, 'index']);
        Route::get('analytics', [DashboardController::class, 'analytics']);
        
        Route::prefix('orders')->group(function () {
            Route::get('/', [AdminOrderController::class, 'index']);
            Route::get('{order}', [AdminOrderController::class, 'show']);
            Route::put('{order}/status', [AdminOrderController::class, 'updateStatus']);
            Route::get('export/csv', [AdminOrderController::class, 'exportCsv']);
        });
    });
});
EOF

# Create Vue.js main files
echo "🎨 Creating Vue.js frontend..."

cat > resources/js/main.js <<'EOF'
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { createI18n } from 'vue-i18n'
import router from './router'
import App from './App.vue'
import './axios'
import './echo'

// Import translations
import en from './lang/en/messages.json'
import ar from './lang/ar/messages.json'

// Create i18n instance
const i18n = createI18n({
  legacy: false,
  locale: localStorage.getItem('locale') || 'en',
  fallbackLocale: 'en',
  messages: {
    en,
    ar
  }
})

// Create app
const app = createApp(App)

// Use plugins
app.use(createPinia())
app.use(router)
app.use(i18n)

// Mount app
app.mount('#app')

// Register service worker
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/sw.js')
      .then((registration) => {
        console.log('SW registered: ', registration)
      })
      .catch((registrationError) => {
        console.log('SW registration failed: ', registrationError)
      })
  })
}
EOF

cat > resources/js/App.vue <<'EOF'
<template>
  <div id="app" :class="{ 'rtl': isRTL }">
    <router-view />
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useI18n } from 'vue-i18n'

const { locale } = useI18n()

const isRTL = computed(() => locale.value === 'ar')

// Apply RTL class to document
document.documentElement.dir = isRTL.value ? 'rtl' : 'ltr'
document.documentElement.lang = locale.value
</script>

<style>
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';

.rtl {
  direction: rtl;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.slide-enter-active,
.slide-leave-active {
  transition: transform 0.3s ease;
}

.slide-enter-from {
  transform: translateX(100%);
}

.slide-leave-to {
  transform: translateX(-100%);
}
</style>
EOF

# Create package scripts and configuration
cat > Makefile <<'EOF'
.PHONY: help install setup-docker dev build test clean deploy

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
	php artisan migrate
	php artisan db:seed

setup-docker: ## Setup with Docker
	docker-compose up -d
	docker-compose exec app composer install
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan migrate
	docker-compose exec app php artisan db:seed
	npm install

dev: ## Start development servers
	php artisan serve &
	npm run dev

build: ## Build for production
	composer install --optimize-autoloader --no-dev
	npm run build
	php artisan config:cache
	php artisan route:cache
	php artisan view:cache

test: ## Run tests
	php artisan test
	npm run test

clean: ## Clean cache and logs
	php artisan cache:clear
	php artisan config:clear
	php artisan route:clear
	php artisan view:clear
	rm -rf storage/logs/*.log

deploy: ## Deploy to production
	git pull origin main
	composer install --optimize-autoloader --no-dev
	npm run build
	php artisan migrate --force
	php artisan config:cache
	php artisan route:cache
	php artisan view:cache
	php artisan queue:restart
EOF

# Create Docker configuration
cat > docker-compose.yml <<'EOF'
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: happy-order-app
    restart: unless-stopped
    working_dir: /var/www
    volumes:
      - ./:/var/www
      - ./docker/php/local.ini:/usr/local/etc/php/conf.d/local.ini
    networks:
      - happy-order
    depends_on:
      - db
      - redis

  nginx:
    image: nginx:alpine
    container_name: happy-order-nginx
    restart: unless-stopped
    ports:
      - "8000:80"
    volumes:
      - ./:/var/www
      - ./docker/nginx/default.conf:/etc/nginx/conf.d/default.conf
    networks:
      - happy-order
    depends_on:
      - app

  db:
    image: mysql:8.0
    container_name: happy-order-db
    restart: unless-stopped
    environment:
      MYSQL_DATABASE: happy_order
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_PASSWORD: secret
      MYSQL_USER: happy_order
    volumes:
      - dbdata:/var/lib/mysql
    ports:
      - "3306:3306"
    networks:
      - happy-order

  redis:
    image: redis:7-alpine
    container_name: happy-order-redis
    restart: unless-stopped
    ports:
      - "6379:6379"
    networks:
      - happy-order

  mailhog:
    image: mailhog/mailhog
    container_name: happy-order-mailhog
    ports:
      - "1025:1025"
      - "8025:8025"
    networks:
      - happy-order

volumes:
  dbdata:
    driver: local

networks:
  happy-order:
    driver: bridge
EOF

cat > Dockerfile <<'EOF'
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxpm-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --with-xpm
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u 1000 -d /home/happy-order happy-order
RUN mkdir -p /home/happy-order/.composer && \
    chown -R happy-order:happy-order /home/happy-order

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=happy-order:happy-order . /var/www

# Change current user to happy-order
USER happy-order

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
EOF

# Create nginx configuration
mkdir -p docker/nginx
cat > docker/nginx/default.conf <<'EOF'
server {
    listen 80;
    index index.php index.html;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /var/www/public;
    
    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass app:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
        gzip_static on;
    }
    
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
EOF

echo "✅ Happy Order project created successfully!"
echo ""
echo "📁 Project: $PROJECT_NAME"
echo "🚀 Next steps:"
echo "   1. cd $PROJECT_NAME"
echo "   2. make setup-docker  (or make install for manual setup)"
echo "   3. Visit http://localhost:8000"
echo ""
echo "📚 For detailed setup instructions, see the README.md file"
echo "🎉 Happy coding!"
EOF

chmod +x bootstrap.sh
