# Flutter Users App

A Flutter application that displays users from a mock API using Clean Architecture principles. The app demonstrates pagination, caching, and modern Flutter development practices.

## Features

- **User List**: Displays a paginated list of users from the reqres.in API
- **User Details**: Shows detailed information when a user is tapped
- **Pagination**: Automatically loads more users when scrolling to the bottom
- **Pull to Refresh**: Refresh the user list by pulling down
- **Offline Support**: Caches users locally using SharedPreferences
- **Error Handling**: Graceful error handling with retry functionality
- **Modern UI**: Clean and responsive Material Design 3 interface

## Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                   # Core functionality
│   ├── error/             # Error handling and failures
│   ├── network/           # Network utilities
│   └── utils/             # Common utilities
├── data/                  # Data layer
│   ├── datasources/       # Remote and local data sources
│   ├── models/            # Data models with JSON serialization
│   └── repositories/      # Repository implementations
├── domain/                # Domain layer
│   ├── entities/          # Business entities
│   ├── repositories/      # Repository interfaces
│   └── usecases/          # Business use cases
└── presentation/          # Presentation layer
    ├── bloc/              # BLoC state management
    ├── pages/             # UI screens
    └── widgets/           # Reusable UI components
```

## Technologies Used

- **State Management**: BLoC (Business Logic Component) pattern
- **Networking**: Retrofit with Dio for HTTP requests
- **Code Generation**: Freezed for immutable data classes
- **Local Storage**: SharedPreferences for caching
- **Dependency Injection**: GetIt with Injectable
- **Image Caching**: CachedNetworkImage
- **UI Enhancements**: Shimmer loading effects

## API Endpoints

The app uses the [reqres.in](https://reqres.in) mock API:

- **Get Users**: `GET https://reqres.in/api/users?page={page}`
- **Get User by ID**: `GET https://reqres.in/api/users/{id}`

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (2.17.0 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_users_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Code Generation

This project uses code generation for:
- Freezed data classes
- JSON serialization
- Retrofit API services
- Injectable dependency injection

To regenerate code after making changes:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Project Structure Details

### Data Layer
- **Models**: Freezed data classes with JSON serialization
- **Data Sources**: Separate remote (API) and local (SharedPreferences) data sources
- **Repository Implementation**: Combines remote and local data sources

### Domain Layer
- **Entities**: Pure Dart classes representing business objects
- **Use Cases**: Single-responsibility classes for business logic
- **Repository Interface**: Abstract contracts for data access

### Presentation Layer
- **BLoC**: State management with events and states
- **Pages**: Full-screen UI components
- **Widgets**: Reusable UI components

## Key Features Implementation

### Pagination
- Automatic loading when scrolling near the bottom
- Loading indicators for better UX
- Handles end-of-list scenarios

### Caching
- Users are cached locally using SharedPreferences
- Offline support when network is unavailable
- Cache invalidation on refresh

### Error Handling
- Network error handling with user-friendly messages
- Retry functionality for failed requests
- Graceful degradation to cached data

### State Management
- BLoC pattern for predictable state management
- Separate BLoCs for different features
- Event-driven architecture

## Testing

The project includes unit tests for:
- Use cases
- Repository implementations
- BLoC logic

Run tests with:
```bash
flutter test
```

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Dependencies

### Core Dependencies
- `flutter_bloc`: State management
- `dio`: HTTP client
- `retrofit`: Type-safe HTTP client
- `freezed_annotation`: Immutable data classes
- `shared_preferences`: Local storage
- `get_it`: Dependency injection
- `injectable`: Code generation for DI
- `cached_network_image`: Image caching
- `shimmer`: Loading animations
- `equatable`: Value equality
- `dartz`: Functional programming utilities

### Dev Dependencies
- `build_runner`: Code generation
- `retrofit_generator`: Retrofit code generation
- `json_serializable`: JSON serialization
- `freezed`: Data class generation
- `injectable_generator`: DI code generation
- `bloc_test`: BLoC testing utilities
- `mocktail`: Mocking framework

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [reqres.in](https://reqres.in) for providing the mock API
- Flutter team for the excellent framework
- BLoC library maintainers for the state management solution

