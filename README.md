# 🌸 Flowery

<p align="center">

**An enterprise-grade, beautifully designed Flowers & Gifting E-Commerce mobile platform built with Flutter.**

</p>

<p align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge\&logo=flutter\&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge\&logo=dart\&logoColor=white)
![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20%2F%20Feature--First-00599C?style=for-the-badge)
![BLoC](https://img.shields.io/badge/BLoC-0175C2?style=for-the-badge)
![Dio](https://img.shields.io/badge/Dio-EA4335?style=for-the-badge)
![Retrofit](https://img.shields.io/badge/Retrofit-4CAF50?style=for-the-badge)
![GetIt](https://img.shields.io/badge/GetIt-7B1FA2?style=for-the-badge)
![Injectable](https://img.shields.io/badge/Injectable-009688?style=for-the-badge)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?style=for-the-badge\&logo=githubactions\&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge\&logo=git\&logoColor=white)
![Android Studio](https://img.shields.io/badge/Android%20Studio-3DDC84?style=for-the-badge\&logo=androidstudio\&logoColor=white)

</p>

---

<p align="center">
  <a href="https://youtu.be/gFJznvhCz_A">
    <img src="https://img.youtube.com/vi/gFJznvhCz_A/maxresdefault.jpg" alt="Flowery App Demo" width="800"/>
  </a>
</p>

<p align="center">
  <a href="https://youtu.be/gFJznvhCz_A">
     <strong>Watch the Demo on YouTube</strong>
  </a>
</p>

---

## Overview

**Flowery** is a cross-platform Flutter e-commerce application designed for discovering, browsing, and ordering flowers and gifts.

The application provides a complete end-to-end shopping experience, starting from product discovery and authentication, through cart and checkout, and continuing with order management, notifications, and real-time delivery tracking.

Flowery follows a **feature-first Clean Architecture** approach with a clear separation between presentation, domain, data, and API layers.

The customer application communicates with the **Elevate Flower backend** and integrates with a dedicated **Driver App**, creating a connected delivery ecosystem where drivers can manage deliveries and provide real-time tracking information to customers.

---

## Features

### 🛍️ Shopping

* Home screen with categories, occasions, and best sellers
* Browse products by category
* Browse products by occasion
* Best sellers listing
* Product search
* Product details
* Add products to cart
* Remove items from cart
* Update product quantities
* View cart totals
* Checkout and order placement

### 🔐 Authentication & Profile

* Login
* Sign up
* Logout
* Forgot password
* Change password
* Profile information management
* Edit profile
* Upload and update profile photo
* Language selection

### 📦 Orders

* Place orders
* View order history
* View order details
* Track order status
* Delivery status updates
* Driver assignment information
* Real-time delivery tracking

### 📍 Real-Time Tracking

* Real-time driver location tracking
* Live delivery status updates
* Track the assigned driver during delivery
* Connected delivery flow with the Driver App
* Automatic tracking updates while the order is being delivered

### 🔔 Notifications

* Push notifications for important order events
* Real-time delivery notifications
* Driver assignment notifications
* Order status notifications
* Delivery started notifications
* Order delivered notifications
* In-app notification list
* Persistent notification history
* Navigate from notifications to the related order or feature

### 🌍 Localization & Infrastructure

* English and Arabic localization
* Secure local persistence
* API integration using Dio and Retrofit
* JSON serialization
* Cubit-based state management
* Dependency injection using GetIt and Injectable
* Centralized routing using GoRouter
* Reusable shared widgets
* Unit and state-management testing
* CI/CD automation using GitHub Actions
* Responsive mobile UI

---

## Screenshots

> Add your application screenshots inside the `screenshots/` directory.

### Authentication

<p align="center">
  <img src="screenshots/Create-Account1.png" width="160"/>
  <img src="screenshots/login.png" width="160"/>
  <img src="screenshots/Email-Verification.png" width="160"/>
  <img src="screenshots/reset-password.png" width="160"/>
  <img src="screenshots/logout.png" width="160"/>
</p>

### Home

<p align="center">
  <img src="screenshots/home.png" width="160"/>
  <img src="screenshots/home2.png" width="160"/>
  <img src="screenshots/home-search.png" width="160"/>
  <img src="screenshots/occasion1.png" width="160"/>
  <img src="screenshots/occasion2.png" width="160"/>
</p>


### Product Discovery

<p align="center">
  <img src="screenshots/explore1.png" width="170"/>
  <img src="screenshots/explore2.png" width="170"/>
  <img src="screenshots/best-seller.png" width="170"/>
  <img src="screenshots/best-seller2.png" width="170"/>
</p>
<p align="center">
  <img src="screenshots/product-sort-by.png" width="220"/>
  <img src="screenshots/product-sort-by-ar.png" width="220"/>
</p>


### Product Details

<p align="center">
  <img src="screenshots/product-details.png" width="220"/>
  <img src="screenshots/added-product-details.png" width="220"/>
</p>


### Cart

<p align="center">
  <img src="screenshots/cart1.png" width="220"/>
  <img src="screenshots/cart-ar.png" width="220"/>
  <img src="screenshots/delete-product-cart.png" width="220"/>
</p>

<p align="center">
  <img src="screenshots/empty-cart.png" width="220"/>
  <img src="screenshots/empty-cart-ar.png" width="220"/>
</p>


### Checkout

<p align="center">
  <img src="screenshots/checkout.png" width="220"/>
  <img src="screenshots/checkout2.png" width="220"/>
  <img src="screenshots/select-address.png" width="220"/>
</p>


### Orders

<p align="center">
  <img src="screenshots/order-placed.png" width="200"/>
  <img src="screenshots/order-placed-ar.png" width="200"/>
  <img src="screenshots/my-orders.png" width="200"/>
  <img src="screenshots/my-orders-ar.png" width="200"/>
</p>


### Order Tracking

<p align="center">
  <img src="screenshots/Track-Order1.png" width="220"/>
  <img src="screenshots/Track-Order1-ar.png" width="220"/>
  <img src="screenshots/Track-Order2.png" width="220"/>
</p>

<p align="center">
  <img src="screenshots/Order-Delivered4.png" width="220"/>
  <img src="screenshots/Order-Delivered4-ar.png" width="220"/>
</p>



### Profile

<p align="center">
  <img src="screenshots/profile.png" width="200"/>
  <img src="screenshots/profile-ar.png" width="200"/>
  <img src="screenshots/edit-profile.png" width="200"/>
  <img src="screenshots/edit-profile-ar.png" width="200"/>
</p>


### Addresses

<p align="center">
  <img src="screenshots/address.png" width="200"/>
  <img src="screenshots/select-address.png" width="200"/>
  <img src="screenshots/saved-address.png" width="200"/>
  <img src="screenshots/Saved-address2.png" width="200"/>
</p>

### Notifications

<p align="center">
  <img src="screenshots/notifications.png" width="220"/>
  <img src="screenshots/about-us.png" width="220"/>
  <img src="screenshots/Terms-Conditions-ar.png" width="220"/>
</p>

## Tech Stack

* **Flutter / Dart** — Cross-platform application development
* **flutter_bloc** — State management using Cubits
* **go_router** — Application navigation and route management
* **dio** — HTTP networking and API communication
* **retrofit** — Type-safe REST API clients
* **json_serializable** — JSON serialization and model generation
* **get_it + injectable** — Dependency injection
* **flutter_secure_storage** — Secure local storage
* **flutter_localizations + ARB files** — English and Arabic localization
* **mocktail + bloc_test** — Unit and state-management testing
* **GitHub Actions** — CI/CD automation

---

## Architecture

The project follows a **Feature-First Clean Architecture** approach.

Most features are separated into:

* `presentation` — Views, widgets, Cubits, intents, and UI states
* `domain` — Entities, repository contracts, and use cases
* `data` — DTOs, repository implementations, and data source contracts
* `api` — Retrofit API clients and remote data source implementations

This separation keeps the **UI, business rules, data mapping, API communication, notifications, and tracking logic** organized and independently testable.

---

## Project Structure

```text
lib/
│
├── config/
│   ├── di/
│   │   └── Dependency injection setup
│   │
│   ├── dio/
│   │   └── Dio configuration
│   │
│   └── security_storage/
│       └── Secure storage abstraction
│
├── core/
│   ├── errors/
│   │   └── Exceptions and failures
│   │
│   ├── localization/
│   │   └── App locale controller
│   │
│   ├── network/
│   │   └── API interceptor
│   │
│   ├── notifications/
│   │   └── Push notification infrastructure
│   │
│   ├── router/
│   │   └── GoRouter setup and route paths
│   │
│   ├── shared_features/
│   │   └── Shared products and home data
│   │
│   ├── theme/
│   │   └── Colors, text styles, and app theme
│   │
│   ├── tracking/
│   │   └── Real-time delivery tracking infrastructure
│   │
│   ├── values/
│   │   └── Generated assets, fonts, and API constants
│   │
│   └── widgets/
│       └── Shared UI widgets
│
├── features/
│   │
│   ├── app_sections/
│   │   └── Main app shell, home, cart, categories, profile
│   │
│   ├── auth/
│   │   └── Login, sign up, and forgot password
│   │
│   ├── best_seller/
│   │   └── Best seller listing
│   │
│   ├── change_password/
│   │   └── Change password flow
│   │
│   ├── edit_profile/
│   │   └── Edit profile flow
│   │
│   ├── occasion/
│   │   └── Occasion listing
│   │
│   ├── orders/
│   │   └── Orders listing and order management
│   │
│   ├── product_details/
│   │   └── Product details screen
│   │
│   ├── search/
│   │   └── Product search
│   │
│   ├── notifications/
│   │   └── Notification list and notification state
│   │
│   └── tracking/
│       └── Real-time driver tracking
│
├── l10n/
│   └── Localization ARB files and generated classes
│
└── test/
    └── Unit and Cubit tests

assets/
├── icons/
│   └── SVG assets
│
└── fonts/
    └── Inter font family
```

---

## Order Tracking & Driver Integration

Flowery is connected to a dedicated **Driver App** to provide a complete delivery management and tracking experience.

The customer application and Driver App communicate through the backend delivery system.

The Driver App is responsible for the driver-side delivery workflow, while Flowery provides the customer with the corresponding order status and real-time tracking experience.

### Delivery Flow

```text
Customer places order
        ↓
Order is processed
        ↓
Order becomes ready for delivery
        ↓
Driver is assigned
        ↓
Driver accepts delivery
        ↓
Driver starts delivery
        ↓
Customer receives push notification
        ↓
Customer opens Order Tracking
        ↓
Real-Time Driver Location
        ↓
Driver completes delivery
        ↓
Customer receives delivery notification
        ↓
Order marked as Delivered
```

### Real-Time Tracking Flow

```text
             ┌──────────────────┐
             │   Driver App     │
             │                  │
             │ Driver Location  │
             │ Delivery Status  │
             └────────┬─────────┘
                      │
                      │ Real-Time Updates
                      ↓
             ┌──────────────────┐
             │     Backend      │
             │ Delivery System  │
             └────────┬─────────┘
                      │
                      │ Live Updates
                      ↓
             ┌──────────────────┐
             │ Flowery Customer │
             │       App        │
             └────────┬─────────┘
                      │
                      ↓
             ┌──────────────────┐
             │ Tracking Screen  │
             │                  │
             │ Driver Location  │
             │ Delivery Status  │
             └──────────────────┘
```

This allows customers to follow their delivery while the Driver App continuously provides the delivery-side updates.

---

## Notifications

Flowery provides both **push notifications** and an **in-app notification list**.

### Push Notifications

Push notifications keep users informed about important events even when the application is not currently open.

Examples include:

* Order confirmed
* Order status changed
* Order ready for delivery
* Driver assigned
* Driver started delivery
* Delivery progress
* Order delivered
* Important account updates

### Notification List

In addition to push notifications, Flowery provides an in-app notification list where users can access their notification history.

Users can:

* View received notifications
* Review previous order updates
* Open the related order from a notification
* Keep track of delivery events
* Access notifications after dismissing the original push notification

### Notification Flow

```text
Backend Event
      ↓
Push Notification Service
      ↓
Push Notification
      ↓
Customer Device
      ↓
Flowery Notification Handler
      ↓
Notification List
      ↓
Related Order / Screen
```

This provides two notification experiences:

```text
                    Notification Event
                           │
              ┌────────────┴────────────┐
              ↓                         ↓
      Push Notification          In-App Notification
              │                         │
              ↓                         ↓
      Customer Device            Notification List
              │                         │
              └────────────┬────────────┘
                           ↓
                    Related Order
```

---

## Main App Flow

1. The application starts and initializes the required dependencies.
2. Dependency injection is configured using **GetIt** and **Injectable**.
3. Dio is initialized with the required network configuration and interceptors.
4. Secure storage is checked for persisted authentication information.
5. The application determines the appropriate initial route.
6. Authenticated users can access the main application sections.
7. Users browse categories, occasions, and best-selling products.
8. Users search for products and open product details.
9. Products can be added to the shopping cart.
10. Users review their cart and proceed through checkout.
11. The order is submitted to the backend.
12. Users receive a push notification confirming important order events.
13. Users can view their order and follow its status.
14. When the order reaches the delivery stage, a driver is assigned.
15. The customer receives a driver assignment notification.
16. The Driver App manages the delivery process.
17. Driver location and delivery status are updated in real time.
18. The customer can open the tracking screen and follow the active delivery.
19. Delivery events generate relevant push notifications.
20. All received notifications are also available in the in-app notification list.
21. Once delivery is completed, the order is marked as delivered.

---

## State Management

Flowery uses **BLoC / Cubit** for predictable and testable state management.

Each feature owns its state and business interaction through dedicated Cubits.

A typical feature follows this flow:

```text
User Interaction
       ↓
     Cubit
       ↓
   Use Case
       ↓
 Repository
       ↓
 Data Source
       ↓
     API
       ↓
   Backend
```

For real-time tracking:

```text
Driver App
     ↓
Delivery / Tracking Updates
     ↓
Backend
     ↓
Tracking Data Source
     ↓
Tracking Repository
     ↓
Tracking Use Case
     ↓
Tracking Cubit
     ↓
Tracking UI
```

This keeps real-time delivery logic isolated while allowing the UI to react to location and status changes.

---

## Dependency Injection

Dependency injection is handled using:

* **GetIt** — Service locator
* **Injectable** — Automatic dependency registration and code generation

The dependency configuration is centralized under:

```text
lib/config/di/
```

Services, repositories, API clients, notification services, and tracking components can be registered through the dependency injection layer.

---

## Networking

The application uses **Dio** and **Retrofit** for API communication.

```text
Flutter UI
    ↓
Cubit
    ↓
Use Case
    ↓
Repository
    ↓
Remote Data Source
    ↓
Retrofit API
    ↓
Dio
    ↓
Elevate Flower Backend
```

Networking is centralized to keep API communication isolated from presentation and domain logic.

---

## Localization

Flowery supports:

* 🇬🇧 English
* 🇪🇬 Arabic

Localization is implemented using Flutter's localization system with ARB translation files.

```text
lib/
└── l10n/
    ├── app_en.arb
    ├── app_ar.arb
    └── generated localization files
```

---

## Secure Storage

Authentication-related information and application preferences that require secure persistence are handled using:

```text
flutter_secure_storage
```

The storage implementation is abstracted so application features do not directly depend on the underlying storage mechanism.

---

## Testing

The project includes unit and state-management tests covering important application layers.

Testing tools include:

* **mocktail** — Mocking dependencies
* **bloc_test** — Testing Cubits and BLoC states

Tests cover areas such as:

* API data sources
* Repository implementations
* Use cases
* Cubits
* Order management
* Notification logic
* Tracking logic
* Business rules

---

## CI/CD

The project is prepared for automated CI/CD using **GitHub Actions**.

The CI pipeline can be used to automate:

* Dependency installation
* Static analysis
* Code generation
* Unit tests
* Build verification

Example workflow location:

```text
.github/
└── workflows/
    └── flutter.yml
```

---

## Key Packages

* [flutter_bloc](https://pub.dev/packages/flutter_bloc)
* [go_router](https://pub.dev/packages/go_router)
* [dio](https://pub.dev/packages/dio)
* [retrofit](https://pub.dev/packages/retrofit)
* [json_serializable](https://pub.dev/packages/json_serializable)
* [get_it](https://pub.dev/packages/get_it)
* [injectable](https://pub.dev/packages/injectable)
* [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
* [flutter_localizations](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html)
* [mocktail](https://pub.dev/packages/mocktail)
* [bloc_test](https://pub.dev/packages/bloc_test)

---

## Getting Started

### Prerequisites

* Flutter SDK compatible with Dart `^3.11.0`
* Android Studio or Xcode
* Configured Android emulator, iOS simulator, or physical device
* Git
* Access to the required backend/API environment

### Clone the Repository

```bash
git clone https://github.com/omarameen77/flower-ecommerce.git
cd flower-ecommerce
```

### Install Dependencies

```bash
flutter pub get
```

### Generate Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run the Application

```bash
flutter run
```

### Run Tests

```bash
flutter test
```

### Analyze the Project

```bash
flutter analyze
```
<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=26&duration=3000&pause=1000&color=36BCF7&center=true&vCenter=true&width=500&lines=Team+Members;Flutter+Developers" alt="Team Animation"/>
</p>
<table width="100%">
<tr>
<td width="20%" align="center" valign="middle">

<img src="https://github.com/omarameen77.png" width="110" alt="Omar Ameen"/>

</td>

<td width="80%" valign="middle">

### Omar Ameen

**Mobile Developer**

<a href="https://github.com/omarameen77">
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
</a>
<a href="https://www.linkedin.com/in/omar-amin-083645344">
<img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/>
</a>
<a href="https://wa.me/201031430691">
<img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white"/>
</a>

📧 **Email:** [omar.amin.saad1@gmail.com](mailto:omar.amin.saad1@gmail.com)

📱 **Phone:** +20 103 143 0691

</td>
</tr>

<tr>
<td colspan="2" align="center">

<img src="https://capsule-render.vercel.app/api?type=rect&height=3&color=36BCF7" width="92%"/>

</td>
</tr>

<tr>
<td width="20%" align="center" valign="middle">

<img src="https://github.com/YassmenaAbdullah.png" width="110" alt="Yasmeen Abdallah"/>

</td>

<td width="80%" valign="middle">

### Yasmeen Abdallah

**Mobile Developer**

<a href="https://github.com/YassmenaAbdullah">
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
</a>
<a href="https://www.linkedin.com/in/yasmena-abdallah">
<img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/>
</a>
<a href="https://wa.me/20155188312">
<img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white"/>
</a>

📧 **Email:** [yassmenabdallah76@gmail.com](mailto:yassmenabdallah76@gmail.com)

📱 **Phone:** +20 155 188 312

</td>
</tr>

<tr>
<td colspan="2" align="center">

<img src="https://capsule-render.vercel.app/api?type=rect&height=3&color=36BCF7" width="92%"/>

</td>
</tr>

<tr>
<td width="20%" align="center" valign="middle">

<img src="https://via.placeholder.com/110" width="110" alt="Ziad Sleem"/>

</td>

<td width="80%" valign="middle">

### Ziad Sleem

**Mobile Developer**

<a href="YOUR_ZIAD_GITHUB_URL">
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
</a>
<a href="YOUR_ZIAD_LINKEDIN_URL">
<img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/>
</a>
<a href="https://wa.me/YOUR_ZIAD_WHATSAPP_NUMBER">
<img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white"/>
</a>

📧 **Email:** YOUR_ZIAD_EMAIL

📱 **Phone:** YOUR_ZIAD_PHONE

</td>
</tr>
</table>

<p align="left">

🌸 **Flowery — Flowers, Gifts & Moments**

</p>
