# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Rockserwis Podcaster is a Flutter mobile app for streaming podcasts from rockserwis.fm internet radio. The app uses Firebase for analytics/crashlytics, ObjectBox for local data persistence, and audio_service for background audio playback.

## Development Commands

### Building & Running
- `flutter run` - Run the app in development mode
- `flutter build apk` - Build APK for Android
- `flutter build ios` - Build for iOS

### Code Generation
- `dart run build_runner build` - Generate code for Riverpod, Freezed, and ObjectBox
- `dart run build_runner build --delete-conflicting-outputs` - Force regenerate all generated files

### Testing & Quality
- `flutter test` - Run all unit and widget tests
- `flutter analyze` - Run static analysis (configured in analysis_options.yaml)
- `dart run custom_lint` - Run Riverpod linting rules

### Dependency Management
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies

## Architecture

### State Management
- **Riverpod 2.x** with code generation for dependency injection and state management
- All providers use `@Riverpod` annotation and code generation
- Generated files have `.g.dart` suffix

### Data Layer
- **ObjectBox** for local SQLite-like database storage
- **HTTP API** communication with rockserwis.fm backend
- Repository pattern with separate providers for podcasts, episodes, and player state

### Key Providers Structure
- `lib/providers/` contains all Riverpod providers
- `objectbox_repository.dart` - Database initialization and store management
- `audio_service.dart` - Background audio service configuration  
- `podcast_repository.dart` - Podcast data management
- `episode_repository.dart` - Episode data and favorites management
- `player_repository.dart` - Audio player state management

### Models
- **Freezed** for immutable data classes with JSON serialization
- Generated files have `.freezed.dart` and `.g.dart` suffixes
- Core models: `Podcast`, `Episode`, `Author`, `PlayerState`, `Schedule`

### Navigation
- **GoRouter** with StatefulShellRoute for bottom tab navigation
- Routes defined in `app_routes.dart`
- Main sections: Podcasts, Favorites, History, Player

### Audio System
- **audio_service** package for background audio playback
- **just_audio** as the underlying audio engine
- Custom `MyAudioHandler` in `utils/audio_handler.dart`
- Supports media controls, notifications, and background playback

### UI Architecture
- Material Design with dark/light theme support
- Shared components in `lib/components/`
- Screen-specific widgets in `lib/screens/`
- Custom scaffold with bottom navigation in `components/scaffold.dart`

## Firebase Integration

The app uses Firebase for:
- **Crashlytics** - Crash reporting and error tracking
- **Analytics** - Usage analytics
- Firebase configuration in `utils/firebase_options.dart`

## Important Patterns

### Code Generation Workflow
1. Modify model classes, providers, or API classes
2. Run `dart run build_runner build` to regenerate code
3. Generated files are committed to git

### Testing
- Unit tests for repositories and business logic in `test/api/`
- Widget tests for components in `test/components/`  
- Uses **mockito** for mocking dependencies

### Error Handling
- All async operations should handle errors appropriately
- Use Riverpod's AsyncValue for async state management
- Firebase Crashlytics captures unhandled errors

## Development Notes

- The app requires a rockserwis.fm account for full functionality
- Uses SharedPreferences for simple key-value storage (theme, settings)
- ObjectBox database schema changes require migration handling
- Audio playback works in background with proper notification controls