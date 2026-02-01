# Features Directory

This directory contains all feature modules following Clean Architecture principles.

## Feature Structure

Each feature should follow this structure:

```
feature_name/
├── data/
│   ├── datasources/
│   │   ├── feature_remote_datasource.dart
│   │   └── feature_local_datasource.dart
│   ├── models/
│   │   └── feature_model.dart
│   ├── mappers/
│   │   └── feature_mapper.dart
│   └── repositories/
│       └── feature_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── feature_entity.dart
│   ├── repositories/
│   │   └── feature_repository.dart
│   └── usecases/
│       └── get_feature_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── feature_cubit.dart
    │   └── feature_state.dart
    ├── pages/
    │   └── feature_page.dart
    └── widgets/
        └── feature_widget.dart
```

## Guidelines

1. **Data Layer**: Contains data sources, models (DTOs), mappers, and repository implementations
2. **Domain Layer**: Contains entities, repository interfaces, and use cases (business logic)
3. **Presentation Layer**: Contains Cubits for state management, pages (screens), and widgets

## Example Feature

To create a new feature:
1. Create a new directory with the feature name
2. Follow the structure above
3. Implement data sources, models, and mappers in the data layer
4. Define entities, repository interfaces, and use cases in the domain layer
5. Create Cubits, pages, and widgets in the presentation layer
6. Register dependencies in the DI container using `@injectable` annotation
7. Add routes to the router configuration
