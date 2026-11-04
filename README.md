# 🎈 Evently App

A modern, full-featured Event Management and Discovery Application built with **Flutter**, **Firebase**, **Cloud Firestore**, and **Google Maps**. Evently allows users to seamlessly explore upcoming events, create and customize their own events with location tagging, filter events by category, manage favorite events in real-time, and personalize their experience with dark/light themes and multi-language support (English & Arabic).

---

## ✨ Features

- 🔐 **Firebase Authentication**:
  - Email & Password Sign Up / Sign In / Password Reset.
  - One-tap **Google Sign-In** integration.
  - Authenticated user session persistence.

- 📅 **Event Management & Firestore Integration**:
  - **Create Event**: Pick category, title, description, date, time, and custom map location.
  - **Real-Time Live Updates**: Powered by Cloud Firestore streams for instantaneous UI sync.
  - **Category Filtering**: Explore events by categories (*All, Book Club, Sport, Birthday, Meeting, Holiday*).
  - **Event Details & Edit**: View comprehensive event details or edit/delete created events.
  - **User Isolation**: Users manage and view their own created & favorited events safely.

- 📍 **Google Maps & Location Services**:
  - **Interactive Map Picker**: Drag-and-drop marker on Google Maps to set precise event coordinates.
  - **Reverse Geocoding**: Automatically resolves coordinates to city and country names (*e.g., Cairo, Egypt*).
  - **Location Detection**: Live device location detection.

- 🎨 **Theme & Localization (State Management with Provider)**:
  - **Theme Switching**: Full support for Light Mode and Dark Mode with custom color palettes.
  - **Localization (L10n)**: Built-in support for English and Arabic with Right-to-Left (RTL) layout handling.
  - **Provider Architecture**: Clean state management using `ChangeNotifierProvider`.

- 🚀 **Onboarding & UX**:
  - Interactive Onboarding flow with preferences configuration saved locally via `SharedPreferences`.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: [Flutter](https://flutter.dev) (Dart SDK 3.5+)
- **Backend / Database**: Firebase Auth, Cloud Firestore
- **State Management**: Provider (`ChangeNotifierProvider`)
- **Maps & Location**: `google_maps_flutter`, `geolocator`, `geocoding`
- **UI & Assets**: Custom Theme Manager, Custom Dropdowns, `flutter_easyloading`, `bot_toast`, Lottie Animations
- **Localization**: `flutter_localizations`, ARB templates (`gen-l10n`)

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (v3.5.3 or higher)
- Android Studio / VS Code
- Firebase Project configured for Android & Web

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Abdallasala/Evently_App.git
   cd Evently_App
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Copy `android/app/google-services.json.example` to `android/app/google-services.json` and insert your Firebase credentials.
   - Copy `lib/firebase_options.dart.example` to `lib/firebase_options.dart` with your platform configuration keys.

4. **Run the Application**:
   ```bash
   flutter run
   ```

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
