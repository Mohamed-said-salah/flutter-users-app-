# Flutter Users App

A Flutter application that demonstrates infinite scrolling pagination using the reqres.in API.

## Packages Used

- **flutter_bloc**: For state management
- **dartz**: For functional programming and error handling
- **get_it**: For dependency injection
- **injectable**: For dependency injection code generation
- **infinite_scroll_pagination**: For implementing infinite scrolling pagination
- **freezed**: For immutable data classes
- **json_annotation**: For JSON serialization
- **json_serializable**: For JSON serialization code generation
- **dio**: For HTTP requests
- **equatable**: For value equality

## Application Flow

1. **Data Layer**:
   - Uses reqres.in API to fetch user data
   - Implements repository pattern with data sources
   - Handles data models and entities

2. **Domain Layer**:
   - Contains business logic
   - Defines use cases (GetUsers)
   - Uses entities for business objects

3. **Presentation Layer**:
   - Implements BLoC pattern for state management
   - Uses infinite scrolling pagination
   - Features:
     - User list with infinite scroll
     - Pull-to-refresh functionality
     - Error handling with retry option
     - User detail view
     - Loading indicators for first page and new pages

## Infinite Scroll Pagination Implementation

The app uses `infinite_scroll_pagination` package to implement efficient pagination:

### Key Features
- **Automatic Loading**: Automatically loads the next page when user scrolls near the bottom
- **Page Size**: Fetches 6 users per page from the API
- **State Management**: 
  - Shows loading indicator for first page
  - Shows loading indicator for new pages
  - Handles empty states
  - Handles error states with retry option
- **Pull to Refresh**: Supports refreshing the entire list
- **Memory Efficient**: Only keeps necessary pages in memory
- **Smooth Scrolling**: Maintains smooth scrolling performance

### Implementation Details
- Uses `PagingController` to manage pagination state
- Implements `PagedListView` for efficient list rendering
- Handles page loading through `PagedChildBuilderDelegate`
- Supports error states with retry functionality
- Manages loading states for both first page and subsequent pages

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter pub run build_runner build` to generate code
4. Run the app using `flutter run`

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

  ## Video

https://github.com/user-attachments/assets/31c0dca9-5e24-40dc-8121-c3a0c77b299a



