import { defineConfig } from "vite"
import vue from "@vitejs/plugin-vue"
import laravel from "laravel-vite-plugin"
import { VitePWA } from "vite-plugin-pwa"
import { resolve } from "path"

export default defineConfig({
  plugins: [
    laravel({
      input: ["resources/css/app.css", "resources/js/app.js"],
      refresh: true,
    }),
    vue(),
    VitePWA({
      registerType: "autoUpdate",
      workbox: {
        globPatterns: ["**/*.{js,css,html,ico,png,svg,woff2}"],
        runtimeCaching: [
          {
            urlPattern: /^https:\/\/api\./,
            handler: "StaleWhileRevalidate",
            options: {
              cacheName: "api-cache",
              expiration: {
                maxEntries: 100,
                maxAgeSeconds: 60 * 60 * 24, // 24 hours
              },
            },
          },
        ],
      },
      manifest: {
        name: "Happy Order",
        short_name: "HappyOrder",
        description: "Restaurant Ordering System",
        theme_color: "#2563eb",
        background_color: "#ffffff",
        display: "standalone",
        start_url: "/",
        icons: [
          {
            src: "/icons/icon-192x192.png",
            sizes: "192x192",
            type: "image/png",
          },
          {
            src: "/icons/icon-512x512.png",
            sizes: "512x512",
            type: "image/png",
          },
        ],
      },
    }),
  ],
  resolve: {
    alias: {
      "@": resolve(__dirname, "resources/js"),
      "~": resolve(__dirname, "resources"),
    },
  },
  server: {
    host: "0.0.0.0",
    port: 3000,
    hmr: {
      host: "localhost",
    },
  },
})
