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
```

## 🛠️ Getting Started

### Prerequisites
- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yusufhnf/how_weather.git
   cd how_weather
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Development

### Code Generation

This project uses code generation for:
- **Injectable**: Dependency injection (`injector.config.dart`)
- **Freezed**: Immutable data classes (`.freezed.dart`)
- **JSON Serialization**: JSON parsing (`.g.dart`)

Run code generation when you add/modify:
- Injectable classes (`@injectable`, `@lazySingleton`)
- Freezed models (`@freezed`)
- JSON serializable classes (`@JsonSerializable`)

```bash
# One-time generation
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-generates on file changes)
dart run build_runner watch --delete-conflicting-outputs
```

### Running Tests

```bash
flutter test                    # Run all tests
flutter test --coverage        # Run tests with coverage
flutter test test/path/file_test.dart  # Run specific test
```

### Code Analysis

```bash
flutter analyze                # Static analysis
dart format lib/ test/         # Format code
```

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

## 🎨 Theme & Styling

The app uses Material Design 3 with custom theming:

```dart
// Access theme colors
context.colorScheme.primary
context.colorScheme.secondary

// Access text styles
context.textTheme.headlineMedium
context.textTheme.bodyLarge

// Change theme
context.read<AppCubit>().changeTheme(ThemeMode.dark);
```

## 🌍 Localization

Add new translations in `lib/core/localization/i18n.dart`:

```dart
static String get yourNewString => 'Your Translation';
```

Access translations:
```dart
I18n.yourNewString
// or
AppLocalizations.loc.yourNewString
```

## 🔐 State Management

### Global State (AppCubit)
For app-wide state (theme, auth, locale):

```dart
// Change theme
context.read<AppCubit>().changeTheme(ThemeMode.dark);

// Login
await context.read<AppCubit>().login(token: token, userId: userId);

// Watch state changes
BlocBuilder<AppCubit, AppState>(
  builder: (context, state) {
    return Text('Theme: ${state.themeMode}');
  },
)
```

### Feature State (Feature Cubits)
For feature-specific state, create feature cubits:

```dart
@injectable
class FeatureCubit extends Cubit<FeatureState> {
  final GetFeatureUseCase _getFeatureUseCase;
  
  FeatureCubit(this._getFeatureUseCase) : super(const FeatureState.initial());
  
  Future<void> loadFeature() async {
    emit(const FeatureState.loading());
    final result = await _getFeatureUseCase(NoParams());
    result.fold(
      (failure) => emit(FeatureState.error(failure.message)),
      (data) => emit(FeatureState.loaded(data)),
    );
  }
}
```

## 📝 Code Style Guidelines

- Follow [Effective Dart](https://dart.dev/effective-dart)
- Use `const` constructors whenever possible
- Prefer composition over inheritance
- Keep functions under 20 lines
- Write descriptive variable names
- Add documentation for public APIs
- Use `Either<Failure, Success>` for error handling
- Mark all Cubits/Blocs with `@injectable`
- Use Freezed for all data classes

## 🤖 AI Development Prompts

### For AI Assistants Working on This Project

When implementing features or modifying this codebase, follow these guidelines:

#### 1. Initializing New Project Architecture

**Prompt Template:**
```
Initialize a Flutter project following Clean Architecture with:
- Core module structure (di, services, router, exceptions, extensions, theme, localization)
- AppCubit for global state (theme, auth, locale)
- Dependency injection with GetIt + Injectable
- All required core files as defined in rules.md
- Run code generation and verify build
```

**Expected Actions:**
- Create all files in `lib/core/` following the structure in rules.md
- Set up `main.dart` with AppCubit provider
- Configure `pubspec.yaml` with all dependencies
- Run `flutter pub get` and `dart run build_runner build`
- Verify with `flutter analyze`

#### 2. Creating a New Feature

**Prompt Template:**
```
Create a new feature called [FEATURE_NAME] with:
- Domain: [Entity], [Repository interface], [Use case]
- Data: [Model with Freezed], [Remote/Local datasource], [Mapper], [Repository impl]
- Presentation: [State with Freezed], [Cubit], [Page], [Widgets]
- Follow Clean Architecture layers
- Use Either<Failure, Success> for error handling
- Add to router configuration
- Generate code and verify
```

**Expected Actions:**
1. Create feature folder structure
2. Implement domain layer (entities, repository, use case)
3. Implement data layer (models, datasources, mapper, repository)
4. Implement presentation layer (state, cubit, page, widgets)
5. Mark dependencies with `@injectable`
6. Add routes to `app_router.dart`
7. Run `dart run build_runner build`
8. Create corresponding tests

#### 3. Modifying Existing Features

**Prompt Template:**
```
Modify [FEATURE_NAME] to [DESCRIPTION]:
- Update domain layer if business logic changes
- Update data layer if API/storage changes
- Update presentation layer if UI changes
- Maintain Clean Architecture boundaries
- Update tests accordingly
- Run code generation if needed
```

**Key Rules:**
- Don't mix layer responsibilities
- Update mappers if models/entities change
- Regenerate code after Freezed/Injectable changes
- Update tests to match changes
- Use existing patterns and conventions

#### 4. Adding Dependencies

**Prompt Template:**
```
Add dependency [PACKAGE_NAME] for [PURPOSE]:
- Add to pubspec.yaml in appropriate section
- Register in RegisterModule if third-party
- Create service wrapper if needed
- Mark with @lazySingleton if singleton required
- Update documentation
```

#### 5. Implementing State Management

**Prompt Template:**
```
Implement state management for [FEATURE]:
- Create FeatureState with Freezed (initial, loading, loaded, error states)
- Create FeatureCubit with @injectable
- Inject required use cases via constructor
- Use Either for error handling
- Emit appropriate states
- Provide via BlocProvider in route or page
```

#### 6. Best Practices Checklist

When implementing ANY code changes, ensure:

**Architecture:**
- [ ] Follow Clean Architecture layers
- [ ] Data flows: UI → Cubit → Use Case → Repository → DataSource
- [ ] Domain layer has no Flutter/external dependencies
- [ ] Use dependency injection for all dependencies

**State Management:**
- [ ] Use Freezed for state classes
- [ ] Mark Cubits with `@injectable` or `@lazySingleton`
- [ ] Use `Either<Failure, Success>` pattern
- [ ] Emit states for loading, success, error

**Code Quality:**
- [ ] Functions under 20 lines
- [ ] Meaningful variable names
- [ ] No abbreviations
- [ ] Add documentation for public APIs
- [ ] Use `const` constructors where possible

**Code Generation:**
- [ ] Run `dart run build_runner build` after changes
- [ ] Verify no analysis errors with `flutter analyze`
- [ ] Check generated files are created

**Testing:**
- [ ] Create unit tests for use cases
- [ ] Create tests for repository implementations
- [ ] Create widget tests for pages
- [ ] Aim for >90% code coverage

#### 7. Error Handling Pattern

Always use this pattern for error handling:

```dart
// In repository
Future<Either<Failure, Entity>> getData() async {
  try {
    final result = await dataSource.getData();
    return Right(mapper.toEntity(result));
  } on NetworkException {
    return Left(NetworkFailure('Network error'));
  } on ServerException {
    return Left(ServerFailure('Server error'));
  } catch (e) {
    return Left(UnknownFailure(e.toString()));
  }
}

// In use case
Future<Either<Failure, Entity>> call(Params params) async {
  return await repository.getData();
}

// In cubit
Future<void> loadData() async {
  emit(const State.loading());
  final result = await useCase(NoParams());
  result.fold(
    (failure) => emit(State.error(failure.message)),
    (data) => emit(State.loaded(data)),
  );
}
```

#### 8. Naming Conventions

Follow these naming patterns:

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `camelCase` (not SCREAMING_CASE)
- **Private members**: `_leadingUnderscore`
- **Cubits**: `FeatureNameCubit`
- **States**: `FeatureNameState`
- **Use Cases**: `VerbNounUseCase` (e.g., `GetWeatherUseCase`)
- **Repositories**: `FeatureNameRepository`
- **Models**: `FeatureNameModel`
- **Entities**: `FeatureNameEntity`

#### 9. Git Commit Messages

Use this format (as per copilot-instructions.md):
```
Add feature description
Fix specific issue
Update component with changes
Remove deprecated code
```

- Use imperative mood (Add, Fix, Update, Remove)
- Keep under 50 characters
- No periods at the end
- Be specific and concise

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
