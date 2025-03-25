# Tanami Capital POC

## Overview
Welcome to the **Tanami Capital Flutter App**! This project is a mobile investment platform used daily by thousands of investors across the MENA region. The application provides a seamless user experience while ensuring strict security and regulatory compliance.

## Features
- **User Authentication**: Login using PIN-based authentication or biometric authentication.
- **Dashboard**: Displays a welcome message and a summary of investment data.
- **Investment Opportunities**: Fetches and displays a list of investment opportunities from a simulated REST API.
- **State Management**: Uses **Provider** for efficient state management.
- **Secure Storage**: Stores authentication tokens securely.
- **Multi-Language Support** (Bonus): Supports RTL layout for Arabic.

## Project Structure
```
/tanamicapital
│── lib
│   │── main.dart
│   │── screens
│   │   │── login_screen.dart
│   │   │── dashboard_screen.dart
│   │   │── feature_screen.dart
│   │   │── registration_screen.dart
│   │── assets
│   │   │── tanami_logo.dart
│   │── models
│   │   │── investment_opportunity.dart
│   │── services
│   │   │── investment_service.dart
│   │── theme
│   │   │── colors.dart
│   │   │── text_styles.dart
│   │── widgets
│   │   │── custom_button.dart
│   │   │── custom_text_field.dart
│   │   │── investment_card.dart
│   │   │── step_indicator.dart
│── web
│── test
│── pubspec.yaml
│── README.md
```

## Installation & Setup
### Prerequisites
- **Flutter SDK** (Latest stable version)
- **Dart**
- **Android Studio / Xcode**

### Steps
1. **Clone the repository:**
   ```sh
   git clone https://github.com/shaikhhamad/tanami-capital-poc.git
   cd tanami-capital-poc
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

## Technical intro abount POC app tasks
The app fetches investment opportunities from a sample JSON. You can replace it with a real backend service when needed. Tried to create app which simulates the tanami theme, and according my imagination and market RND, added dashboard screen with soe sample data and investment opportunities with sample investment options that are scrollable and can be segregated by selecting a their type.

## USED ChatGPT
I used chat GPT for logo file, sample data. and boilerplate code
