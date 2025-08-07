# Cats App

A Flutter application that displays cat breeds using clean architecture principles, Bloc state management, and GoRouter for navigation.

## Features

- **Splash Screen**: Loading screen with app branding
- **Cats Grid**: Display cats in a 2-column grid with search functionality
- **Cat Details**: Detailed view of individual cats with comprehensive information
- **Search**: Real-time search by cat name
- **Clean Architecture**: Proper separation of concerns with domain, data, and presentation layers
- **State Management**: Bloc pattern for predictable state management
- **Navigation**: GoRouter for declarative routing

## Architecture

The app follows clean architecture principles with the following structure:

```
lib/
├── app/                           # Application layer
│   ├── data/
│   │   ├── datasources/
│   │   │   └── cat_remote_datasource.dart
│   │   ├── models/
│   │   │   └── cat_model.dart
│   │   └── repositories/
│   │       └── cat_repository_impl.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── cat.dart
│   │   ├── repositories/
│   │   │   └── cat_repository.dart
│   │   └── usecases/
│   │       ├── get_cats_usecase.dart
│   │       └── get_cat_by_id_usecase.dart
│   └── presentation/
│       ├── blocs/
│       │   ├── cats_bloc.dart
│       │   └── cat_detail_bloc.dart
│       ├── pages/
│       │   ├── splash_page.dart
│       │   ├── cats_page.dart
│       │   └── cat_detail_page.dart
│       └── widgets/
│           ├── cat_card.dart
│           ├── cat_info_section.dart
│           └── search_box.dart
├── src/                           # Shared resources
│   ├── router/
│   │   └── app_router.dart
│   └── services/
│       └── api_service.dart
└── main.dart
```

### Layer Responsibilities

- **App Layer**: Contains the complete application with clean architecture
  - **Domain Layer**: Contains business logic, entities, and use cases
  - **Data Layer**: Handles data operations, API calls, and data models
  - **Presentation Layer**: Manages UI, state, and user interactions
- **Src Layer**: Contains shared resources and utilities
  - **Router**: Navigation configuration
  - **Services**: Shared services like API client

## Dependencies

- `flutter_bloc`: State management
- `equatable`: Value equality for objects
- `go_router`: Navigation
- `dio`: HTTP client for API calls
- `cached_network_image`: Image caching
- `shimmer`: Loading placeholders

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

## API

The app uses The Cat API (https://thecatapi.com/) to fetch cat breed information. The API provides comprehensive data about cat breeds including:

- Basic information (name, origin, life span)
- Physical characteristics
- Temperament and behavior
- Health and care information
- Images

## State Management

The app uses Bloc pattern for state management:

- **CatsBloc**: Manages the list of cats and search functionality
- **CatDetailBloc**: Manages individual cat detail information

## Navigation

Navigation is handled by GoRouter with the following routes:

- `/`: Splash screen
- `/cats`: Cats list with search
- `/cat-detail/:id`: Individual cat detail page

## Customization

You can easily customize the app by:

1. **Adding new features**: Create new use cases in the `app/domain/usecases/` layer
2. **Modifying UI**: Update widgets in the `app/presentation/widgets/` layer
3. **Changing API**: Modify the data layer in `app/data/` to use different data sources
4. **Adding new routes**: Update the router configuration in `src/router/`
5. **Adding new services**: Create shared services in `src/services/`

## Contributing

This is a starter implementation. Feel free to modify and extend it according to your needs.
