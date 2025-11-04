**Grow your dreams**

A beautiful Flutter application that helps you transform your notes into actionable goals. Organize your thoughts, track your progress, and celebrate your successes—all in one place.

## Features

- 📝 **Multiple Note Types**: Create goals, quick notes, journal entries, habits, inspirations, and track successes
- 📊 **Progress Tracking**: Monitor your goals with progress percentages and custom units
- 🎯 **Organized Library**: Browse and filter notes by type for easy access
- 📈 **Statistics Dashboard**: View your goals, successes, and notes count at a glance
- 🌱 **Modern UI**: Beautiful gradient-based design with smooth animations
- 🔐 **Authentication**: Secure user accounts with Serverpod backend
- 💾 **Offline Support**: Local storage with Hive for seamless experience

## Tech Stack

- **Framework**: Flutter 3.8.1+
- **State Management**: BLoC Pattern with Flutter Hooks
- **Backend**: Serverpod
- **Local Storage**: Hive
- **Serialization**: Dart Mappable
- **Architecture**: Feature-first modular architecture

## Getting Started

### Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart SDK 3.8.1 or higher
- Backend server running (see `../notetogoal_backend`)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate code:
   ```bash
   flutter pub run build_runner build
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/           # Core functionality (BLoC, theme, entry points)
├── features/       # Feature modules (auth, home, create, library, etc.)
├── navigations/    # App routing and navigation
├── services/       # Business logic services
└── shared/         # Shared utilities, widgets, and models
```

## Development

This project follows Flutter best practices:
- Uses Flutter Hooks instead of StatefulWidget
- BLoC pattern with Mappable serialization
- Feature-first architecture
- Clean code standards (no debug prints, self-documenting code)


