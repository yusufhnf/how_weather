# How Weather

A modern Flutter weather application built with Clean Architecture principles, demonstrating best practices in mobile development.

## 📱 About

**How Weather** is a Flutter application that showcases professional-grade app development with:
- Clean Architecture with feature-based organization
- BLoC/Cubit state management pattern
- Dependency injection with GetIt + Injectable
- Type-safe routing with GoRouter
- Comprehensive error handling with dartz Either
- Local and secure storage solutions
- Modern Material Design 3 theming
- **Reusable test helpers for DRY, maintainable tests**

## 🏗️ Architecture

This project follows **Clean Architecture** principles with three distinct layers:

### Data Layer
- **Remote/Local Data Sources**: API clients and local storage interfaces
- **Models (DTOs)**: Data transfer objects with JSON serialization
- **Mappers**: Convert between DTOs and domain entities
- **Repository Implementations**: Concrete implementations of domain repositories

### Domain Layer
- **Entities**: Core business objects
- **Repository Interfaces**: Abstract contracts for data access
- **Use Cases**: Single-responsibility business logic units

### Presentation Layer
- **Cubits**: State management with flutter_bloc
- **Pages**: Screen-level widgets
- **Widgets**: Reusable UI components

## 🚀 Tech Stack

### Core Dependencies
- **State Management**: `flutter_bloc` ^8.1.6
- **Dependency Injection**: `get_it` ^8.0.3, `injectable` ^2.6.2
- **Routing**: `go_router` ^14.6.2
- **Data Serialization**: `freezed` ^2.5.7, `json_annotation` ^4.9.0
- **HTTP Client**: `dio` ^5.7.0, `pretty_dio_logger` ^1.4.0
- **Local Storage**: `hive` ^2.2.3, `flutter_secure_storage` ^9.2.2
- **Functional Programming**: `dartz` ^0.10.1
- **Logging**: `talker` ^4.6.1, `talker_flutter` ^4.6.1
- **Responsive Design**: `flutter_screenutil` ^5.9.3
- **UI**: `google_fonts` ^6.2.1, `font_awesome_flutter` ^10.8.0
- **Testing**: `bloc_test` ^9.1.7, `mocktail` ^1.0.4

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/          # App-wide constants
│   ├── cubit/             # Global AppCubit for theme, auth, locale
│   ├── di/                # Dependency injection setup
│   ├── exceptions/        # Custom exceptions and failures
│   ├── extensions/        # Dart/Flutter extensions
│   ├── localization/      # i18n configuration
│   ├── router/            # GoRouter configuration
│   ├── services/          # Core services (HTTP, storage, logger)
│   ├── ui/
│   │   ├── generated/     # Generated assets
│   │   ├── theme/         # App theme and colors
│   │   └── widgets/       # Shared widgets
│   └── utils/             # Utility classes and helpers
├── features/              # Feature modules (Clean Architecture)
│   └── feature_name/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   ├── mappers/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── cubit/
│           ├── pages/
│           └── widgets/
└── main.dart

test/
├── features/
│   └── ... (mirrors lib/features structure)
└── helpers/
    └── test_helpers.dart   # Centralized test utilities
```

## 🛠️ Getting Started

### Prerequisites
- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS development)

### Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yusufhnf/how_weather.git
   cd how_weather
   ```

2. **Add environment variables**
   - Copy `.env.example` to `.env` and fill in required values (API keys, etc.)
   - If using multiple environments, create `.env.dev`, `.env.prod`, etc.

3. **Clean and get dependencies**
   ```bash
   flutter clean
   flutter pub get
   ```

4. **Generate code**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

6. **Login Sample**
    ```bash
   email: admin@meetucup.com
    password: admin1234 
   ```
    

## 🔧 Development

### Code Generation

This project uses code generation for:
- **Injectable**: Dependency injection (`injector.config.dart`)
- **Freezed**: Immutable data classes (`.freezed.dart`)
- **JSON Serialization**: JSON parsing (`.g.dart`)
- **Envied**: Environment variable management (`env_config.g.dart`)
- **flutter_gen**: Type-safe asset references (`assets.gen.dart`)

Run code generation when you add/modify:
- Injectable classes (`@injectable`, `@lazySingleton`)
- Freezed models (`@freezed`)
- JSON serializable classes (`@JsonSerializable`)
- Environment variables in `.env`
- Asset declarations in `pubspec.yaml`

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
# Or watch mode:
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

### Running Tests

- **All tests:**
  ```bash
  flutter test
  ```
- **With coverage:**
  ```bash
  flutter test --coverage
  ```
- **Specific file:**
  ```bash
  flutter test test/path/file_test.dart
  ```

#### Test Helpers

This project uses centralized test helpers in `test/helpers/test_helpers.dart` for DRY, maintainable, and consistent test setup:
- `TestWindowConfig`: Window size setup/reset for widget tests (multi-window API)
- `TestWidgetBuilder`: MaterialApp, ScreenUtil, and BLoC provider wrappers
- `TestStreamControllers`: Broadcast stream controller utilities

**Usage Example:**
```dart
setUp(() {
  TestWindowConfig.setupWindowSize();
});
tearDown(() {
  TestWindowConfig.resetWindowSize();
});
```

**Best Practices:**
- Remove unnecessary comments (e.g., // Arrange, // Act, // Assert)
- Use helpers for all widget and BLoC test setup
- Keep tests concise and focused

## 📦 Adding New Features

### Feature Structure Template

Each feature should follow this structure:

```
features/
└── new_feature/
    ├── data/
    │   ├── datasources/
    │   │   ├── new_feature_remote_datasource.dart
    │   │   └── new_feature_local_datasource.dart
    │   ├── models/
    │   │   └── new_feature_model.dart
    │   ├── mappers/
    │   │   └── new_feature_mapper.dart
    │   └── repositories/
    │       └── new_feature_repository_impl.dart
    ├── domain/
    │   ├── entities/
    │   │   └── new_feature_entity.dart
    │   ├── repositories/
    │   │   └── new_feature_repository.dart
    │   └── usecases/
    │       └── get_new_feature_usecase.dart
    └── presentation/
        ├── cubit/
        │   ├── new_feature_cubit.dart
        │   └── new_feature_state.dart
        ├── pages/
        │   └── new_feature_page.dart
        └── widgets/
            └── new_feature_widget.dart
```

### Step-by-Step Feature Creation

1. **Domain Layer** (Start here - business logic first)
   - Create entity classes
   - Define repository interface
   - Implement use cases

2. **Data Layer** (Implementation details)
   - Create model classes with Freezed
   - Implement data sources
   - Create mappers
   - Implement repository

3. **Presentation Layer** (UI)
   - Create state classes with Freezed
   - Implement Cubit
   - Build pages and widgets
   - Add routes to router

4. **Register Dependencies**
   - Mark classes with `@injectable` or `@lazySingleton`
   - Run code generation

5. **Add Tests**
   - Unit tests for domain and data layers
   - Widget tests for presentation
   - Integration tests for critical flows

## 🧠 AI Workflow Implementation

This project is designed for seamless collaboration with AI coding assistants. To ensure high-quality, maintainable, and consistent code, follow these AI workflow guidelines:

### 1. Project Initialization
- Use the Clean Architecture structure as defined above
- Set up all core modules and feature folders
- Configure dependency injection, theming, localization, and routing
- Run code generation and verify with `flutter analyze`

### 2. Feature Development
- Always start with the domain layer (entities, repository interface, use case)
- Implement data layer (models, datasources, mappers, repository)
- Implement presentation layer (state, cubit, page, widgets)
- Register dependencies with `@injectable` or `@lazySingleton`
- Add/modify routes in `app_router.dart`
- Run code generation after changes
- Write unit, widget, and integration tests for all new code

### 3. Testing & Code Quality
- Use test helpers for all widget and BLoC tests
- Remove unnecessary comments and keep tests clean
- Aim for >90% code coverage
- Run `flutter test` and `flutter analyze` before committing

### 4. Commit Messages
- Use imperative, concise commit messages (e.g., "Add login cubit", "Fix theme bug")
- Keep under 50 characters, no period at the end

### 5. Documentation
- Update `README.md` and `rules.md` with any new patterns, dependencies, or workflows
- Ensure documentation matches the actual implementation

### 6. Error Handling
- Use `Either<Failure, Success>` for all error handling in domain/data layers
- Use custom exceptions for all error cases

### 7. Naming Conventions
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/Functions: `camelCase`
- Constants: `camelCase`
- Cubits: `FeatureNameCubit`
- States: `FeatureNameState`
- Use Cases: `VerbNounUseCase`
- Repositories: `FeatureNameRepository`
- Models: `FeatureNameModel`
- Entities: `FeatureNameEntity`

For more details, see `rules.md` in the project root.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Authors

- **Yusuf Umar Hanafi** - [@yusufhnf](https://github.com/yusufhnf)

## 📞 Support

For issues, questions, or contributions, please open an issue on GitHub.

---

Built with ❤️ using Flutter and Clean Architecture
