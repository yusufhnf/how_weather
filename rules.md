# AI rules for Flutter - How Weather Project

You are an expert in Flutter and Dart development. Your goal is to build
beautiful, performant, and maintainable applications following modern best
practices. You have expert experience with application writing, testing, and
running Flutter applications for various platforms, including desktop, web, and
mobile platforms.

## About This Project

**How Weather** is a Flutter application that follows Clean Architecture principles
with a feature-based organization structure. The project demonstrates modern
Flutter development practices with the following technology stack:

### Core Technologies
* **State Management:** flutter_bloc (Cubit pattern)
* **Dependency Injection:** get_it + injectable
* **Routing:** go_router
* **Data Serialization:** freezed + json_annotation
* **HTTP Client:** dio with interceptors
* **Local Storage:** hive + flutter_secure_storage
* **Functional Programming:** dartz (Either for error handling)
* **Logging & Error Handling:** talker with alice for network inspection
* **Responsive Design:** flutter_screenutil
* **Icons:** font_awesome_flutter, ionicons
* **Fonts:** google_fonts
* **Image Caching:** cached_network_image

### Project Architecture
The project follows Clean Architecture with three main layers organized by feature:
* **Data Layer:** Remote/local data sources, models (DTOs), mappers, repository implementations
* **Domain Layer:** Entities, repository interfaces, use cases
* **Presentation Layer:** Cubits (state management), pages (screens), widgets

### Core Module
Shared functionality across features:
* `di/` - Dependency injection with injectable
* `router/` - Navigation configuration with go_router
* `services/` - HTTP, storage, logging services
* `ui/` - Themes, shared widgets, generated assets
* `localization/` - i18n support
* `exceptions/` - Custom exception handling
* `validation/` - Reusable form validators

## Interaction Guidelines
* **User Persona:** Assume the user is familiar with programming concepts but
  may be new to Dart.
* **Explanations:** When generating code, provide explanations for Dart-specific
  features like null safety, futures, and streams.
* **Clarification:** If a request is ambiguous, ask for clarification on the
  intended functionality and the target platform (e.g., command-line, web,
  server).
* **Dependencies:** When suggesting new dependencies from `pub.dev`, explain
  their benefits.
* **Formatting:** Use the `dart_format` tool to ensure consistent code
  formatting.
* **Fixes:** Use the `dart_fix` tool to automatically fix many common errors,
  and to help code conform to configured analysis options.
* **Linting:** Use the Dart linter with a recommended set of rules to catch
  common issues. Use the `analyze_files` tool to run the linter.

## Project Structure
* **Standard Structure:** Assumes a standard Flutter project structure with
  `lib/main.dart` as the primary application entry point.

## Project Initialization
When initializing a new Flutter project following this architecture, create the following core structure:

### Core Module Structure
```
lib/
  core/
    constants/
      num_constants.dart
      string_constants.dart
    cubit/
      app_cubit.dart      # Global state management
      app_state.dart      # AppCubit state with Freezed
    di/
      injector.dart       # GetIt configuration
      register_module.dart # Third-party dependencies
    exceptions/
      app_exceptions.dart # Custom exceptions for Either pattern
    extensions/
      context_extensions.dart
      string_extensions.dart
      datetime_extensions.dart
    localization/
      i18n.dart          # Localization setup
    router/
      app_router.dart    # GoRouter configuration
    services/
      http_client_service.dart
      logger_service.dart
      hive_service.dart
      secure_storage_service.dart
      internet_connection_service.dart
    ui/
      generated/
        assets.gen.dart  # Generated assets
      theme/
        app_theme.dart
        app_colors.dart
      widgets/
        loading_widget.dart
        error_widget.dart
    utils/
      use_case.dart      # Base UseCase class
    validation/
      validators.dart    # Form validation utilities
  features/
    README.md            # Feature structure documentation
  main.dart
```

### Required Core Files

1. **Dependency Injection** (`core/di/`)
   - `injector.dart` - GetIt setup with Injectable
   - `register_module.dart` - Third-party dependencies registration

2. **Global State Management** (`core/cubit/`)
   - `app_cubit.dart` - Application-wide state (theme, auth, preferences)
   - `app_state.dart` - AppCubit state with Freezed annotations

3. **Services** (`core/services/`)
   - `http_client_service.dart` - Dio wrapper
   - `logger_service.dart` - Talker wrapper
   - `hive_service.dart` - Local storage
   - `secure_storage_service.dart` - Secure storage for tokens
   - `internet_connection_service.dart` - Network connectivity

4. **Router** (`core/router/`)
   - `app_router.dart` - GoRouter configuration

5. **Exceptions & Failures** (`core/exceptions/`)
   - `app_exceptions.dart` - Custom exceptions for error handling

6. **Constants** (`core/constants/`)
   - `num_constants.dart` - Numeric constants
   - `string_constants.dart` - String constants

7. **Extensions** (`core/extensions/`)
   - `context_extensions.dart` - BuildContext extensions
   - `string_extensions.dart` - String extensions
   - `datetime_extensions.dart` - DateTime extensions

8. **Theme** (`core/ui/theme/`)
   - `app_theme.dart` - Material theme configuration
   - `app_colors.dart` - Color definitions

9. **Widgets** (`core/ui/widgets/`)
   - `loading_widget.dart` - Loading indicator
   - `error_widget.dart` - Error display

10. **Localization** (`core/localization/`)
    - `i18n.dart` - I18n setup and delegate

11. **Utils** (`core/utils/`)
    - `use_case.dart` - Base UseCase class for domain layer

12. **Validation** (`core/validation/`)
    - `validators.dart` - Reusable form validators for email, password, etc.

13. **Main Entry** 
    - `main.dart` - App initialization with AppCubit provider

### Initialization Steps

1. Create all core files following the structure above
2. Run `flutter pub get` to install dependencies
3. Run `dart run build_runner build --delete-conflicting-outputs` to generate:
   - `injector.config.dart` (Injectable)
   - `app_state.freezed.dart` (Freezed)
   - Other generated files
4. Initialize AppCubit in main.dart with BlocProvider
5. Verify with `flutter analyze`

## Platform Configuration
* **App Naming Convention:** When setting up or modifying the app name across platforms, use proper spacing with uppercase first alphabet for each word (e.g., "Git Pedia", "My Awesome App").
* **Platform-Specific App Names:** Update the app name in all platform-specific configuration files:
  - **Android:** Modify `android/app/src/main/AndroidManifest.xml` - update the `android:label` attribute
  - **iOS:** Modify `ios/Runner/Info.plist` - update the `CFBundleDisplayName` and `CFBundleName` keys
  - **macOS:** Modify `macos/Runner/Configs/AppInfo.xcconfig` - update the `PRODUCT_NAME` variable
  - **Linux:** Modify `linux/CMakeLists.txt` - update the `BINARY_NAME` variable
  - **Windows:** Modify `windows/CMakeLists.txt` - update the `BINARY_NAME` variable
  - **Web:** Modify `web/index.html` and `web/manifest.json` - update the `title` and `name` fields
  - **pubspec.yaml:** Update the `name` field (use snake_case for package name, e.g., "git_pedia")
* **Consistency:** Ensure the display name is consistent across all platforms for better brand recognition and user experience.

## Flutter style guide
* **SOLID Principles:** Apply SOLID principles throughout the codebase.
* **Concise and Declarative:** Write concise, modern, technical Dart code.
  Prefer functional and declarative patterns.
* **Composition over Inheritance:** Favor composition for building complex
  widgets and logic.
* **Immutability:** Prefer immutable data structures. Widgets (especially
  `StatelessWidget`) should be immutable.
* **State Management:** Separate ephemeral state and app state. Use a state
  management solution for app state to handle the separation of concerns.
* **Widgets are for UI:** Everything in Flutter's UI is a widget. Compose
  complex UIs from smaller, reusable widgets.
* **Navigation:** Use a modern routing package like `auto_route` or `go_router`.
  See the [navigation guide](./navigation.md) for a detailed example using
  `go_router`.

## Package Management
* **Pub Tool:** To manage packages, use the `pub` tool, if available.
* **External Packages:** If a new feature requires an external package, use the
  `pub_dev_search` tool, if it is available. Otherwise, identify the most
  suitable and stable package from pub.dev.
* **Adding Dependencies:** To add a regular dependency, use the `pub` tool, if
  it is available. Otherwise, run `flutter pub add <package_name>`.
* **Adding Dev Dependencies:** To add a development dependency, use the `pub`
  tool, if it is available, with `dev:<package name>`. Otherwise, run `flutter
  pub add dev:<package_name>`.
* **Dependency Overrides:** To add a dependency override, use the `pub` tool, if
  it is available, with `override:<package name>:1.0.0`. Otherwise, run `flutter
  pub add override:<package_name>:1.0.0`.
* **Removing Dependencies:** To remove a dependency, use the `pub` tool, if it
  is available. Otherwise, run `dart pub remove <package_name>`.

## Code Quality
* **Code structure:** Adhere to maintainable code structure and separation of
  concerns (e.g., UI logic separate from business logic).
* **Naming conventions:** Avoid abbreviations and use meaningful, consistent,
  descriptive names for variables, functions, and classes.
* **Conciseness:** Write code that is as short as it can be while remaining
  clear.
* **Simplicity:** Write straightforward code. Code that is clever or
  obscure is difficult to maintain.
* **Error Handling:** Anticipate and handle potential errors. Don't let your
  code fail silently.
* **Styling:**
    * Line length: Lines should be 80 characters or fewer.
    * Use `PascalCase` for classes, `camelCase` for
      members/variables/functions/enums, and `snake_case` for files.
* **Functions:**
    * Functions short and with a single purpose (strive for less than 20 lines).
* **Testing:** Write code with testing in mind. Use the `file`, `process`, and
  `platform` packages, if appropriate, so you can inject in-memory and fake
  versions of the objects.
* **Logging:** Use the `logging` package instead of `print`.

## Dart Best Practices
* **Effective Dart:** Follow the official Effective Dart guidelines
  (https://dart.dev/effective-dart)
* **Class Organization:** Define related classes within the same library file.
  For large libraries, export smaller, private libraries from a single top-level
  library.
* **Library Organization:** Group related libraries in the same folder.
* **API Documentation:** Add documentation comments to all public APIs,
  including classes, constructors, methods, and top-level functions.
* **Comments:** Write clear comments for complex or non-obvious code. Avoid
  over-commenting.
* **Trailing Comments:** Don't add trailing comments.
* **Async/Await:** Ensure proper use of `async`/`await` for asynchronous
  operations with robust error handling.
    * Use `Future`s, `async`, and `await` for asynchronous operations.
    * Use `Stream`s for sequences of asynchronous events.
* **Null Safety:** Write code that is soundly null-safe. Leverage Dart's null
  safety features. Avoid `!` unless the value is guaranteed to be non-null.
* **Pattern Matching:** Use pattern matching features where they simplify the
  code.
* **Records:** Use records to return multiple types in situations where defining
  an entire class is cumbersome.
* **Switch Statements:** Prefer using exhaustive `switch` statements or
  expressions, which don't require `break` statements.
* **Exception Handling:** Use `try-catch` blocks for handling exceptions, and
  use exceptions appropriate for the type of exception. Use custom exceptions
  for situations specific to your code. This project defines custom exceptions
  in `core/exceptions/app_exceptions.dart`.
* **Error Handling with Dartz:** This project uses `dartz` for functional error
  handling. Use `Either<AppException, Success>` pattern in repositories and use cases
  to handle errors gracefully. All exceptions extend `AppException` which includes
  Equatable for comparison and proper error messages.
* **Arrow Functions:** Use arrow syntax for simple one-line functions.

## Flutter Best Practices
* **Immutability:** Widgets (especially `StatelessWidget`) are immutable; when
  the UI needs to change, Flutter rebuilds the widget tree.
* **Composition:** Prefer composing smaller widgets over extending existing
  ones. Use this to avoid deep widget nesting.
* **Private Widgets:** Use small, private `Widget` classes instead of private
  helper methods that return a `Widget`.
* **Build Methods:** Break down large `build()` methods into smaller, reusable
  private Widget classes.
* **List Performance:** Use `ListView.builder` or `SliverList` for long lists to
  create lazy-loaded lists for performance.
* **Isolates:** Use `compute()` to run expensive calculations in a separate
  isolate to avoid blocking the UI thread, such as JSON parsing.
* **Const Constructors:** Use `const` constructors for widgets and in `build()`
  methods whenever possible to reduce rebuilds.
* **Build Method Performance:** Avoid performing expensive operations, like
  network calls or complex computations, directly within `build()` methods.

## API Design Principles
When building reusable APIs, such as a library, follow these principles.

* **Consider the User:** Design APIs from the perspective of the person who will
  be using them. The API should be intuitive and easy to use correctly.
* **Documentation is Essential:** Good documentation is a part of good API
  design. It should be clear, concise, and provide examples.

## Application Architecture
* **Separation of Concerns:** Aim for separation of concerns similar to MVC/MVVM, with defined Model,
  View, and ViewModel/Controller roles.
* **Logical Layers:** Organize the project into logical layers:
    * Presentation (widgets, screens)
    * Domain (business logic classes)
    * Data (model classes, API clients)
    * Core (shared classes, utilities, and extension types)
* **Feature-based Organization:** For larger projects, organize code by feature,
  where each feature has its own presentation, domain, and data subfolders. This
  improves navigability and scalability.

## Extensions & Context Helpers
* **ContextExtensions:** This project provides convenient extensions on `BuildContext`
  in `core/extensions/context_extensions.dart` to simplify common operations:
* **Theme Access:** Quick access to theme properties:
  ```dart
  context.theme        // ThemeData
  context.textTheme    // TextTheme
  context.colorScheme  // ColorScheme
  ```
* **Media Query:** Simplified screen size and padding access:
  ```dart
  context.screenWidth
  context.screenHeight
  context.topPadding
  context.bottomPadding
  context.isKeyboardVisible
  ```
* **Localization Access:** Direct access to localized strings via `context.i18n`:
  ```dart
  // Instead of: final i18n = AppLocalizations.of(context);
  Text(context.i18n.welcomeBack)
  Text(context.i18n.loginSuccess(user.name))
  
  // In validators
  validator: (value) => Validators.email(value, context)
  // Internally uses: context.i18n.emailRequired
  ```
* **Navigation Helpers:**
  ```dart
  context.push(NextScreen())
  context.pop()
  context.unfocus() // Dismiss keyboard
  ```
* **Snackbar Helper:**
  ```dart
  context.showSnackBar('Success message')
  context.showSnackBar('Error', duration: Duration(seconds: 5))
  ```
* **Usage Pattern:** Always prefer `context.i18n` over `AppLocalizations.of(context)`
  for cleaner, more readable code throughout the application.

## Lint Rules

Include the package in the `analysis_options.yaml` file. Use the following
analysis_options.yaml file as a starting point:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    # Add additional lint rules here as needed
```

### State Management
* **Bloc/Cubit Pattern:** This project uses `flutter_bloc` for state management.
  Cubits are preferred for simpler state management scenarios, while Blocs are
  used for more complex event-driven scenarios.
* **Freezed for State Classes:** All state classes use `freezed` for immutable
  data structures with `copyWith` functionality.
* **Injectable Annotation:** Mark Cubits and Blocs with `@injectable` to enable
  automatic dependency injection via GetIt.
* **BlocProvider:** Use `BlocProvider` to provide Cubit/Bloc instances to the
  widget tree. Fetch instances from GetIt within the provider.
* **BlocBuilder/BlocConsumer:** Use `BlocBuilder` for rebuilding UI based on
  state changes, and `BlocConsumer` when you need both building and side effects.
* **Global State with AppCubit:** For application-wide state (theme, login
  session, user preferences, etc.), create an `AppCubit`:
  - Register AppCubit as `@lazySingleton` so it persists across the app lifecycle
  - Wrap the entire app with `BlocProvider<AppCubit>` in `main.dart`
  - Access global state anywhere using `context.read<AppCubit>()` or `context.watch<AppCubit>()`
  ```dart
  // app_cubit.dart
  @lazySingleton
  class AppCubit extends Cubit<AppState> {
    AppCubit() : super(const AppState());
    
    void updateTheme(ThemeMode mode) {
      emit(state.copyWith(themeMode: mode));
    }
    
    void setUserSession(User user) {
      emit(state.copyWith(user: user, isLoggedIn: true));
    }
  }
  
  // main.dart - Wrap app with BlocProvider.value for lazySingleton
  class MainApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return BlocProvider<AppCubit>.value(
        value: GetIt.I<AppCubit>(),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, appState) {
            return MaterialApp(
              themeMode: appState.themeMode,
              // ... rest of MaterialApp config
            );
          },
        ),
      );
    }
  }
  
  // Access from any widget
  final appCubit = context.read<AppCubit>();
  appCubit.updateTheme(ThemeMode.dark);
  
  // Or watch for changes
  final appState = context.watch<AppCubit>().state;
  ```
* **State Organization:** Organize state files alongside cubit files:
  - `feature_cubit.dart` - Contains the Cubit logic
  - `feature_state.dart` - Contains the state classes with Freezed
* **Testing:** Use `bloc_test` package for testing Cubits and Blocs with clear
  arrange-act-assert patterns.

### Dependency Injection
* **GetIt + Injectable:** This project uses `get_it` as the service locator
  and `injectable` for code generation. All dependencies are registered
  automatically through annotations.
* **Injectable Annotations:** Use annotations to register dependencies:
  - `@injectable` - Standard registration for transient dependencies
  - `@lazySingleton` - Lazy singleton instances (created on first use)
  - `@singleton` - Eager singleton instances (created at app start)
  - `@RegisterModule` - For registering third-party dependencies
* **Dependency Access:** Access dependencies using `GetIt.I<T>()` or
  inject them via constructor parameters.
* **Configuration:** Run `flutter pub run build_runner build` after adding new
  injectable classes to regenerate `injector.config.dart`.

### Data Flow
* **Data Structures:** This project separates data models and domain entities:
  - **Models (DTOs):** In the data layer (`data/models/`), represent API responses
  - **Entities:** In the domain layer (`domain/entities/`), represent business objects
* **Mappers:** Use mapper classes in `data/mappers/` to convert between models
  and entities. This keeps the domain layer independent of data sources.
  ```dart
  // Example mapper
  class UserMapper {
    static User toEntity(UserModel model) {
      return User(
        id: model.id,
        name: model.displayName,
      );
    }
  }
  ```
* **Repository Pattern:** Repositories in the data layer implement interfaces
  defined in the domain layer, providing an abstraction over data sources.
* **Use Cases:** Business logic is encapsulated in use case classes in the
  domain layer. Each use case represents a single business operation.
* **Error Handling:** Use `dartz` Either type for error handling:
  - Left side contains exceptions (AppException and its subclasses)
  - Right side contains successful results
  ```dart
  Future<Either<AppException, User>> getUser(String id);
  ```
* **Exception Flow:** In repositories, catch thrown exceptions and return them
  in Either's Left side. Don't convert to different exception types:
  ```dart
  try {
    final result = await dataSource.getData();
    return Right(result);
  } on NetworkException catch (e) {
    return Left(e); // Return the exception directly
  } catch (e) {
    return Left(UnknownException(e.toString()));
  }
  ```

### Routing
* **GoRouter:** This project uses `go_router` for declarative navigation, deep
  linking, and web support.
* **Router Configuration:** Define routes in `core/router/app_router.dart` as a
  centralized routing configuration.
* **BlocProvider Integration:** Integrate BlocProvider within route builders to
  provide Cubits to specific routes:
  ```dart
  GoRoute(
    path: '/home',
    builder: (context, state) => BlocProvider<HomeCubit>(
      create: (context) => GetIt.I<HomeCubit>(),
      child: const HomeScreen(),
    ),
  )
  ```
* **Auth Guard:** Use route redirects for authentication logic (see
  `core/router/auth_guard.dart`).

* **Navigator:** Use the built-in `Navigator` for short-lived screens that do
  not need to be deep-linkable, such as dialogs or temporary views.

### Storage & Persistence
* **Hive:** This project uses Hive for local key-value storage. Initialize Hive
  in `main()` before running the app:
  ```dart
  await Hive.initFlutter();
  await Hive.openBox('How Weather');
  ```
* **HiveService:** Use the injectable `HiveService` abstraction for storage
  operations instead of accessing Hive directly.
* **Secure Storage:** Use `flutter_secure_storage` for sensitive data like
  tokens through the `SecureStorageService`.
* **Storage Methods:** HiveService provides:
  - `put()` / `get()` - Basic storage operations
  - `getTyped<T>()` - Type-safe retrieval
  - `getList<T>()` - List storage and retrieval
  - `containsKey()` / `delete()` / `clear()` - Management operations

### Data Handling & Serialization
* **Freezed for Models:** Use `freezed` package for immutable data models with
  built-in JSON serialization, equality, and copyWith functionality.
* **JSON Annotation:** Combine Freezed with `json_annotation` for JSON
  serialization. Use `@JsonKey` for custom field names.
* **Field Naming:** Use `@JsonKey(name: 'field_name')` to map between Dart's
  camelCase and API's snake_case conventions.
* **Generated Files:** Run `flutter pub run build_runner build` to generate:
  - `.freezed.dart` - Freezed code generation
  - `.g.dart` - JSON serialization code
* **Freezed Pattern:** Define models using Freezed factory constructors:
  ```dart
  @freezed
  class User with _$User {
    const factory User({
      required String id,
      @JsonKey(name: 'display_name') required String displayName,
    }) = _User;
    
    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  }
  ```

### Logging & Error Handling
* **Talker Package:** This project uses the `talker` package for comprehensive
  error handling and logging in Dart and Flutter applications.
* **Features:** Talker provides:
  - Structured logging with different log levels
  - Error and exception tracking
  - Network request/response logging
  - BLoC state monitoring
  - Beautiful console output with colors
  - In-app log viewer for debugging
* **Logger Service:** Access logging through the `LoggerService` abstraction
  registered in dependency injection, which wraps Talker functionality.
* **Error Tracking:** Use Talker to automatically catch and log errors:
  ```dart
  // Initialize in main.dart
  final talker = Talker();
  FlutterError.onError = (details) => talker.handle(details.exception, details.stack);
  
  // Log messages
  talker.log('User logged in');
  talker.error('Failed to fetch data');
  talker.warning('Network is slow');
  ```
* **Development Tools:** `alice` and `pretty_dio_logger` are integrated for
  HTTP request/response inspection during development.

### HTTP Client & Networking
* **Dio:** This project uses `dio` as the HTTP client for API requests.
* **HttpClientService:** Use the injectable `HttpClientService` abstraction
  instead of accessing Dio directly.
* **Interceptors:** HTTP interceptors are configured for:
  - Request/response logging with `pretty_dio_logger`
  - Network inspection with `alice_dio`
  - Authentication token injection
  - Error handling and retry logic
* **Connectivity:** Use `connectivity_plus` through `InternetConnectionService`
  to check network availability before making requests.
* **Error Handling:** Define custom exceptions in `core/exceptions/` for
  handling various HTTP error scenarios.

### Form Validation
* **Validators Class:** This project uses a centralized `Validators` class in
  `core/validation/validators.dart` for all form validation logic.
* **Reusability:** All validators are static methods that can be used across
  different screens and features, promoting DRY (Don't Repeat Yourself) principle.
* **Localized Messages:** All validators require `BuildContext` parameter to
  access localized error messages from `AppLocalizations.of(context)`.
* **Case 1 - Using Validators with Context:** Wrap validators in anonymous
  functions to pass BuildContext:
  ```dart
  TextFormField(
    controller: emailController,
    decoration: InputDecoration(labelText: i18n.email),
    validator: (value) => Validators.email(value, context),
    autovalidateMode: AutovalidateMode.onUserInteraction,
  )
  
  TextFormField(
    controller: passwordController,
    decoration: InputDecoration(labelText: i18n.password),
    validator: (value) => Validators.password(value, context), // Uses default minLength of 8
    obscureText: true,
  )
  ```
* **Case 2 - Using Validators with Custom Parameters:** Pass both context and
  custom parameters:
  ```dart
  TextFormField(
    controller: passwordController,
    decoration: InputDecoration(labelText: i18n.password),
    validator: (value) => Validators.password(value, context, minLength: 12), // Custom minimum length
    obscureText: true,
  )
  
  TextFormField(
    controller: nameController,
    decoration: InputDecoration(labelText: i18n.name),
    validator: (value) => Validators.minLength(value, 3, context, fieldName: 'Name'),
  )
  
  TextFormField(
    controller: confirmPasswordController,
    decoration: InputDecoration(labelText: i18n.confirmPassword),
    validator: (value) => Validators.match(value, passwordController.text, context, fieldName: 'Password'),
  )
  ```
* **Available Validators:**
  - `Validators.email(value, context)` - Email format validation
  - `Validators.password(value, context, {minLength: 8})` - Password with minimum length
  - `Validators.required(value, context, {fieldName: 'Field'})` - Required field check
  - `Validators.minLength(value, min, context, {fieldName})` - Minimum character length
  - `Validators.maxLength(value, max, context, {fieldName})` - Maximum character length
  - `Validators.phoneNumber(value, context)` - Phone number format
  - `Validators.url(value, context)` - URL format validation
  - `Validators.match(value, compareValue, context, {fieldName})` - Match two fields
  - `Validators.numeric(value, context, {fieldName})` - Numeric input only
  - `Validators.alphabetic(value, context, {fieldName})` - Letters only
  - `Validators.alphanumeric(value, context, {fieldName})` - Letters and numbers only
* **Localized Error Messages:** All validators return error messages from I18n based
  on current locale. Messages automatically switch between English and Indonesian.
* **Validation Pattern:** Always use `autovalidateMode: AutovalidateMode.onUserInteraction`
  for better UX, showing errors only after user starts typing.

### Localization
* **Multi-language Support:** This project uses a custom internationalization
  setup in `core/localization/` with support for **English (en)** and 
  **Indonesian (id)** languages.
* **I18n Interface:** The `I18n` abstract class defines all localization strings
  with implementations `I18nEn` (English) and `I18nId` (Indonesian).
* **Accessing Translations:** Use `context.i18n` extension for cleaner access to
  localized strings (recommended) or `AppLocalizations.of(context)`:
  ```dart
  // Recommended: Using context extension
  Text(context.i18n.welcomeBack)
  Text(context.i18n.loginSuccess(user.name))
  
  // Alternative: Direct AppLocalizations access
  final i18n = AppLocalizations.of(context);
  Text(i18n.welcomeBack)
  ```
* **Supported Locales:** Both `Locale('en', 'US')` and `Locale('id', 'ID')` are
  supported in `I18nDelegate.supportedLocales`.
* **String Types:** The I18n interface includes:
  - Simple getters: `context.i18n.login`, `context.i18n.email`, `context.i18n.password`
  - Methods with parameters: `context.i18n.loginSuccess(name)`, `context.i18n.passwordMinLength(8)`
* **Delegate Registration:** Register `I18nDelegate` in `MaterialApp`:
  ```dart
  MaterialApp(
    localizationsDelegates: [
      const I18nDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: I18nDelegate.supportedLocales,
  )
  ```

#### Localization Guidelines for Features
* **Rule 1 - Never Use Hardcoded Strings in UI:** All user-facing strings (labels,
  buttons, titles, messages) MUST be localized. Always use `context.i18n` extension
  for cleaner access:
  ```dart
  // ❌ Bad - Hardcoded string
  Text('Welcome Back')
  ElevatedButton(child: Text('Login'))
  
  // ✅ Good - Localized string with context extension
  Text(context.i18n.welcomeBack)
  ElevatedButton(child: Text(context.i18n.login))
  
  // ✅ Also acceptable - Direct AppLocalizations access
  final i18n = AppLocalizations.of(context);
  Text(i18n.welcomeBack)
  ```
* **Rule 2 - Localize All Validation Messages:** Validators must accept `BuildContext`
  to access localized error messages. Never return hardcoded error strings:
  ```dart
  // ❌ Bad - Hardcoded validation message
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }
  
  // ✅ Good - Localized validation message using context.i18n
  static String? email(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.i18n.emailRequired;
    }
    return null;
  }
  
  // Usage in TextFormField
  TextFormField(
    validator: (value) => Validators.email(value, context),
  )
  ```
* **Adding New Strings:** When creating new features or screens:
  1. Add new string getters/methods to the `I18n` abstract class
  2. Implement in both `I18nEn` and `I18nId` classes
  3. Use `context.i18n` to access in widgets for cleaner code
  4. For validators, always pass `BuildContext` parameter
* **Success/Error Messages:** All user feedback messages must be localized:
  ```dart
  // ✅ Success message with parameter using context.i18n
  context.showSnackBar(context.i18n.loginSuccess(user.name))
  
  // ✅ Error messages
  context.showSnackBar(context.i18n.networkError)
  context.showSnackBar(context.i18n.serverError)
  ```
* **Dynamic Content:** For strings with dynamic values, use methods with parameters:
  ```dart
  // In I18n interface
  String loginSuccess(String name);
  String passwordMinLength(int length);
  
  // In I18nEn
  String loginSuccess(String name) => 'Login successful! Welcome $name';
  
  // In I18nId
  String loginSuccess(String name) => 'Login berhasil! Selamat datang $name';
  
  // Usage with context.i18n
  Text(context.i18n.loginSuccess('John'))
  ```

  ```dart
  import 'dart:developer' as developer;

  // For simple messages
  developer.log('User logged in successfully.');

  // For structured error logging
  try {
    // ... code that might fail
  } catch (e, s) {
    developer.log(
      'Failed to fetch data',
      name: 'myapp.network',
      level: 1000, // SEVERE
      error: e,
      stackTrace: s,
    );
  }
  ```

## Code Generation
* **Build Runner:** This project uses code generation for multiple purposes.
  `build_runner` is a dev dependency in `pubspec.yaml`.
* **Generated Code:** The following packages require code generation:
  - `freezed` - Immutable models with copyWith, equality, and toString
  - `json_serializable` - JSON serialization for Freezed models
  - `injectable` - Dependency injection configuration
  - `envied` - Environment configuration
* **Running Build Runner:** After modifying files with annotations, run:
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
* **Watch Mode:** For continuous generation during development:
  ```bash
  flutter pub run build_runner watch --delete-conflicting-outputs
  ```

  ```shell
  dart run build_runner build --delete-conflicting-outputs
  ```

### Current Environment Implementation
- Use the [envied](https://pub.dev/packages/envied) package for environment variable management.
- Store environment variables in `.env` files (e.g., `.env.dev`, `.env`).
- Add your variables to `.env`, then run code generation to update the generated environment class.
- Example usage:
  ```dart
  import 'package:How Weather/env/env.dart';
  final apiUrl = Env.githubBaseUrl;
  ```
- Never hardcode secrets or API URLs; always use the generated environment class.

### Asset Generation Implementation
- Use [flutter_gen](https://pub.dev/packages/flutter_gen) or similar tools to generate type-safe asset references.
- Configure asset generation in `pubspec.yaml` and run code generation to update `core/ui/generated/assets.gen.dart`.
- Example usage:
  ```dart
  import 'package:How Weather/core/ui/generated/assets.gen.dart';
  Image.asset(Assets.images.logo.path);
  ```
- Always use generated asset references instead of hardcoded asset paths.

### Required Pub Commands
- After adding or updating dependencies, or modifying files with code generation annotations, always run:
  ```sh
  flutter pub get
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
- This ensures all generated files are up to date and dependencies are resolved.

### Feature Creation and Testing
- When creating a new feature, always create corresponding tests:
  - **Unit tests** for domain logic and use cases
  - **Integration tests** for data layer and repository integration
  - **Widget tests** for UI components and screens
- Place tests in the appropriate `test/` subfolders mirroring the feature structure.
- Ensure code coverage is **greater than 90%** for all new features (domain, data, and presentation layers).
- Use `flutter test --coverage` to check coverage and maintain high quality.
- Exclude generated files (e.g., `*.g.dart`, `*.freezed.dart`) from coverage reports.

## Testing

This project follows a comprehensive testing strategy with three types of tests: **Unit Tests**, **Widget Tests**, and **Integration Tests**. All tests are located in the `test/` directory, mirroring the structure of `lib/`.

### Test Structure
```
test/
  features/
    login/
      domain/
        usecases/
          login_usecase_test.dart
      data/
        mappers/
          user_mapper_test.dart
        repositories/
          auth_repository_impl_test.dart
      presentation/
        cubit/
          login_cubit_test.dart
        pages/
          login_screen_test.dart
      integration/
        login_integration_test.dart
  helpers/
    test_helpers.dart    # Reusable test utilities
```

### Test Helpers

This project includes reusable test utilities in `test/helpers/test_helpers.dart` to eliminate code duplication and maintain consistent test setup across all test files.

#### TestWindowConfig

Provides window size configuration for widget tests to prevent layout overflow and ensure consistent viewport dimensions:

```dart
import 'package:flutter_test/flutter_test.dart';
import '../helpers/test_helpers.dart';

void main() {
  setUp(() {
    TestWindowConfig.setupWindowSize(); // Default: 1080x1920
    // Or custom size:
    // TestWindowConfig.setupWindowSize(size: Size(800, 600), pixelRatio: 2.0);
  });

  tearDown(() {
    TestWindowConfig.resetWindowSize();
  });
}
```

**Key Features:**
* Default test window: 1080x1920 pixels (common mobile size)
* Customizable size and pixel ratio
* Proper cleanup with resetWindowSize()
* Uses new Flutter multi-window API (`platformDispatcher.views.first`)

#### TestWidgetBuilder

Provides reusable widget builders with MaterialApp, ScreenUtilInit, theme, and BLoC integration:

```dart
// Simple MaterialApp wrapper
Widget widget = TestWidgetBuilder.buildMaterialApp(
  child: MyWidget(),
);

// With Router and single BLoC
Widget widget = TestWidgetBuilder.buildMaterialAppWithRouter<MyCubit, MyState>(
  router: myRouter,
  bloc: mockCubit,
);

// With multiple BLoC providers
Widget widget = TestWidgetBuilder.buildMaterialAppWithMultiProviders(
  providers: [
    BlocProvider<LoginCubit>.value(value: mockLoginCubit),
    BlocProvider<AppCubit>.value(value: mockAppCubit),
  ],
  child: LoginScreen(),
);
```

**Key Features:**
* Automatic ScreenUtilInit integration (1080x1920 design size)
* Includes AppTheme.lightTheme and AppTheme.darkTheme
* Supports single or multiple BLoC providers
* GoRouter integration for navigation tests
* Customizable design size

#### TestStreamControllers

Utilities for managing stream controllers in tests:

```dart
void main() {
  late StreamController<MyState> stateController;

  setUp(() {
    stateController = TestStreamControllers.createBroadcast<MyState>();
  });

  tearDown(() {
    TestStreamControllers.closeAll([stateController, anotherController]);
  });
}
```

**Key Features:**
* Create broadcast stream controllers
* Batch close multiple controllers
* Consistent controller lifecycle management

#### Usage Guidelines

* **Import once:** `import '../helpers/test_helpers.dart'` or `import '../../../../helpers/test_helpers.dart'` based on depth
* **Window config:** Always use in setUp/tearDown for widget tests
* **Widget builders:** Use instead of manually wrapping with MaterialApp + ScreenUtilInit
* **Stream controllers:** Use for BLoC/Cubit testing with proper cleanup

### Running Tests
* **All Tests:** `flutter test`
* **Specific File:** `flutter test test/features/login/domain/usecases/login_usecase_test.dart`
* **With Coverage:** `flutter test --coverage`
* **View Coverage:** `genhtml coverage/lcov.info -o coverage/html && open coverage/html/index.html`

### 1. Unit Tests

Unit tests verify individual components in isolation. Mock all external dependencies to focus on the specific logic being tested.

#### Domain Layer - Use Cases

Test use cases to ensure they correctly handle business logic and error scenarios.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase', () {
    const email = 'test@example.com';
    const password = 'password123';
    const user = UserEntity(id: '1', email: email, name: 'Test', token: 'token');

    test('should return UserEntity when login is successful', () async {
      // Arrange
      when(() => mockRepository.login(email, password))
          .thenAnswer((_) async => const Right(user));

      // Act
      final result = await useCase(LoginParams(email: email, password: password));

      // Assert
      expect(result, const Right(user));
      verify(() => mockRepository.login(email, password)).called(1);
    });

    test('should return ValidationException for invalid email', () async {
      // Arrange
      const invalidEmail = 'invalid-email';
      when(() => mockRepository.login(invalidEmail, password))
          .thenAnswer((_) async => const Left(ValidationException('Invalid email')));

      // Act
      final result = await useCase(LoginParams(email: invalidEmail, password: password));

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (exception) => expect(exception, isA<ValidationException>()),
        (_) => fail('Should return ValidationException'),
      );
    });
  });
}
```

#### Data Layer - Mappers

Test mappers to ensure correct conversion between models and entities.

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserMapper', () {
    test('toEntity should convert UserModel to UserEntity', () {
      // Arrange
      const model = UserModel(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        token: 'token123',
      );

      // Act
      final entity = UserMapper.toEntity(model);

      // Assert
      expect(entity.id, model.id);
      expect(entity.email, model.email);
      expect(entity.name, model.name);
      expect(entity.token, model.token);
    });

    test('toModel should convert UserEntity to UserModel', () {
      // Arrange
      const entity = UserEntity(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        token: 'token123',
      );

      // Act
      final model = UserMapper.toModel(entity);

      // Assert
      expect(model.id, entity.id);
      expect(model.email, entity.email);
      expect(model.name, entity.name);
      expect(model.token, entity.token);
    });
  });
}
```

#### Data Layer - Repositories

Test repository implementations to ensure correct exception handling.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  group('AuthRepositoryImpl', () {
    const email = 'test@example.com';
    const password = 'password123';
    const userModel = UserModel(id: '1', email: email, name: 'Test', token: 'token');

    test('should return UserEntity when remote call is successful', () async {
      // Arrange
      when(() => mockDataSource.login(email, password))
          .thenAnswer((_) async => userModel);

      // Act
      final result = await repository.login(email, password);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should return UserEntity'),
        (entity) {
          expect(entity.id, userModel.id);
          expect(entity.email, userModel.email);
        },
      );
      verify(() => mockDataSource.login(email, password)).called(1);
    });

    test('should return NetworkException on network error', () async {
      // Arrange
      when(() => mockDataSource.login(email, password))
          .thenThrow(const NetworkException('No internet'));

      // Act
      final result = await repository.login(email, password);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (exception) => expect(exception, isA<NetworkException>()),
        (_) => fail('Should return NetworkException'),
      );
    });
  });
}
```

### 2. Widget Tests

Widget tests verify UI components and user interactions. Use BlocProvider for widgets that depend on Cubits.

#### Testing Presentation - Cubits

Use `bloc_test` package for testing state management logic.

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginCubit cubit;
  late MockLoginUseCase mockUseCase;

  setUpAll(() {
    registerFallbackValue(const LoginParams(email: '', password: ''));
  });

  setUp(() {
    mockUseCase = MockLoginUseCase();
    cubit = LoginCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('LoginCubit', () {
    const email = 'test@example.com';
    const password = 'password123';
    const user = UserEntity(id: '1', email: email, name: 'Test', token: 'token');

    blocTest<LoginCubit, LoginState>(
      'emits [loading, success] when login succeeds',
      build: () {
        when(() => mockUseCase(any()))
            .thenAnswer((_) async => const Right(user));
        return cubit;
      },
      act: (cubit) => cubit.login(email, password),
      expect: () => [
        const LoginState.loading(),
        const LoginState.success(user),
      ],
      verify: (_) {
        verify(() => mockUseCase(any())).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, failure] when validation fails',
      build: () {
        when(() => mockUseCase(any())).thenAnswer(
          (_) async => const Left(ValidationException('Invalid email')),
        );
        return cubit;
      },
      act: (cubit) => cubit.login('invalid', password),
      expect: () => [
        const LoginState.loading(),
        const LoginState.failure(ValidationException('Invalid email')),
      ],
    );
  });
}
```

#### Testing Presentation - Pages

Test UI rendering, validation, and user interactions. Use test helpers to reduce boilerplate.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../helpers/test_helpers.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}
class MockAppCubit extends Mock implements AppCubit {}

void main() {
  late MockLoginCubit mockLoginCubit;
  late MockAppCubit mockAppCubit;

  setUp(() {
    TestWindowConfig.setupWindowSize();
    mockLoginCubit = MockLoginCubit();
    mockAppCubit = MockAppCubit();
    when(() => mockLoginCubit.state).thenReturn(const LoginState.initial());
    when(() => mockAppCubit.login(any())).thenAnswer((_) async {});
  });

  tearDown(() {
    TestWindowConfig.resetWindowSize();
  });

  Widget createApp() {
    return TestWidgetBuilder.buildMaterialAppWithMultiProviders(
      providers: [
        BlocProvider<LoginCubit>.value(value: mockLoginCubit),
        BlocProvider<AppCubit>.value(value: mockAppCubit),
      ],
      child: const LoginScreen(),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('renders email and password fields', (tester) async {
      await tester.pumpWidget(createApp());

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows validation error for invalid email', (tester) async {
      await tester.pumpWidget(createApp());

      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'invalid-email');
      await tester.pump();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('calls cubit.login when form is submitted', (tester) async {
      await tester.pumpWidget(createApp());

      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(() => mockLoginCubit.login('test@example.com', 'password123')).called(1);
    });
  });
}
```

### 3. Integration Tests

Integration tests verify complete user flows from UI to repository. They test multiple components working together.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockAppCubit mockAppCubit;

  setUpAll(() {
    registerFallbackValue(const UserEntity(id: '', email: '', name: '', token: ''));
  });

  setUp(() {
    mockAppCubit = MockAppCubit();
    when(() => mockAppCubit.login(any())).thenAnswer((_) async {});
  });

  Widget createApp() {
    return MaterialApp(
      localizationsDelegates: const [I18nEn.delegate, I18nId.delegate],
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>.value(value: mockAppCubit),
          BlocProvider<LoginCubit>(create: (_) => getIt<LoginCubit>()),
        ],
        child: const LoginScreen(),
      ),
    );
  }

  group('Login Integration Tests', () {
    testWidgets('Complete login flow - success path', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Enter credentials
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      await tester.pumpAndSettle();

      // Submit form
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      // Verify success
      expect(find.byType(SnackBar), findsOneWidget);
      verify(() => mockAppCubit.login(any())).called(1);
    });

    testWidgets('Complete login flow - validation error', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      await tester.pumpAndSettle();

      // Verify error message
      expect(find.text('Please enter a valid email address'), findsOneWidget);
      verifyNever(() => mockAppCubit.login(any()));
    });
  });
}
```

### Testing Best Practices

#### Mocking Strategy
* **Mocktail (Recommended):** Prefer `mocktail` for its simplicity and no code generation requirement:
  ```dart
  import 'package:mocktail/mocktail.dart';
  
  class MockRepository extends Mock implements UserRepository {}
  
  // In tests
  final mockRepo = MockRepository();
  when(() => mockRepo.getUser(any())).thenAnswer((_) async => Right(user));
  ```
* **Mockito:** Use for complex scenarios requiring code generation or legacy code:
  ```dart
  import 'package:mockito/annotations.dart';
  
  @GenerateMocks([UserRepository])
  void main() {
    // Tests using generated MockUserRepository
  }
  ```

#### Mock Best Practices
* Mock external dependencies (repositories, data sources, services)
* Never mock entities or value objects from domain layer
* Use fakes for simple implementations (e.g., in-memory storage)
* Register fallback values: `registerFallbackValue(MyClass())`
* Verify interactions: `verify(() => mock.method()).called(1)`
* Use `verifyNever()` to ensure methods weren't called in error scenarios

#### Test Organization
* **Arrange-Act-Assert Pattern:** Structure tests logically but avoid excessive comments
* **Group Related Tests:** Use `group()` to organize related test cases
* **setUp/tearDown:** Use for common setup and cleanup
* **setUpAll/tearDownAll:** Use for expensive one-time setup
* **Comment Guidelines:**
  * Remove `// Arrange`, `// Act`, `// Assert` section markers - test structure should be self-evident
  * Avoid inline explanatory comments like `// 6 shimmer placeholders` when the expect statement is clear
  * Keep only essential comments that explain non-obvious test logic or workarounds
  * Example of clean test:
    ```dart
    testWidgets('should display loading grid when state is forecastLoading', (tester) async {
      when(() => mockCubit.state).thenReturn(const DashboardState.forecastLoading());
      
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      
      expect(find.byType(SliverGrid), findsOneWidget);
      expect(find.byType(Shimmer), findsNWidgets(6));
    });
    ```

#### Widget Test Helpers
* **MaterialApp Wrapper:** Always wrap widgets with MaterialApp for proper context
* **Localization Delegates:** Include i18n delegates when testing localized strings
* **BlocProvider:** Use MultiBlocProvider for widgets depending on multiple cubits
* **pumpAndSettle:** Wait for all animations and async operations
* **pump:** Trigger a single frame rebuild

#### Flutter API Updates
* **Window Configuration (Flutter 3.9+):** Use the new multi-window API instead of deprecated window properties:
  ```dart
  // ❌ Deprecated (Flutter < 3.9)
  TestWidgetsFlutterBinding.instance.window.physicalSize = Size(1080, 1920);
  TestWidgetsFlutterBinding.instance.window.devicePixelRatio = 1.0;
  
  // ✅ Current (Flutter 3.9+)
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  binding.platformDispatcher.views.first.physicalSize = Size(1080, 1920);
  binding.platformDispatcher.views.first.devicePixelRatio = 1.0;
  
  // ✅ Best practice - use TestWindowConfig helper
  TestWindowConfig.setupWindowSize();
  ```
* **Reset After Tests:** Always reset window properties in tearDown:
  ```dart
  tearDown(() {
    TestWindowConfig.resetWindowSize();
    // Or manually:
    // binding.platformDispatcher.views.first.resetPhysicalSize();
    // binding.platformDispatcher.views.first.resetDevicePixelRatio();
  });
  ```

### Code Coverage

#### Coverage Target
Maintain **>90% code coverage** across all layers:
* **Domain Layer:** 95%+ (entities, use cases, repository interfaces)
* **Data Layer:** 90%+ (repositories, data sources, mappers, models)
* **Presentation Layer:** 85%+ (Cubits, widgets, pages)

#### Running Coverage
```bash
# Generate coverage
flutter test --coverage

# View HTML report (macOS/Linux)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# View HTML report (Windows)
perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml coverage/lcov.info -o coverage/html
start coverage/html/index.html
```

#### Excluding Generated Files
Add to `test/` directory or update `analysis_options.yaml`:
```yaml
analyzer:
  exclude:
    - '**/*.g.dart'
    - '**/*.freezed.dart'
    - '**/injector.config.dart'
```

### Example Test Reference

For complete examples of unit, widget, and integration tests, see the login feature tests:
* **Use Case:** [test/features/login/domain/usecases/login_usecase_test.dart](test/features/login/domain/usecases/login_usecase_test.dart)
* **Mapper:** [test/features/login/data/mappers/user_mapper_test.dart](test/features/login/data/mappers/user_mapper_test.dart)
* **Repository:** [test/features/login/data/repositories/auth_repository_impl_test.dart](test/features/login/data/repositories/auth_repository_impl_test.dart)
* **Cubit:** [test/features/login/presentation/cubit/login_cubit_test.dart](test/features/login/presentation/cubit/login_cubit_test.dart)
* **Page:** [test/features/login/presentation/pages/login_screen_test.dart](test/features/login/presentation/pages/login_screen_test.dart)
* **Integration:** [test/features/login/integration/login_integration_test.dart](test/features/login/integration/login_integration_test.dart)

## Utilities & Extensions
* **Extensions Organization:** Define extension methods in `core/extensions/`
  for adding functionality to existing types.
* **Constants:** Define app-wide constants in `core/constants/`:
  - `num_constants.dart` - Numeric values like page sizes, timeouts
  - Add more constant files as needed for different categories
* **Helper Classes:** Place utility functions and helpers in `core/utils/`.
* **Generated Assets:** Use `flutter_gen` or similar tools to generate type-safe
  asset references in `core/ui/generated/assets.gen.dart`.

## Visual Design & Theming
* **UI Design:** Build beautiful and intuitive user interfaces that follow
  modern design guidelines.
* **Responsiveness:** Ensure the app is mobile responsive and adapts to
  different screen sizes, working perfectly on mobile and web.
* **Navigation:** If there are multiple pages for the user to interact with,
  provide an intuitive and easy navigation bar or controls.
* **Typography:** Stress and emphasize font sizes to ease understanding, e.g.,
  hero text, section headlines, list headlines, keywords in paragraphs.
* **Background:** Apply subtle noise texture to the main background to add a
  premium, tactile feel.
* **Shadows:** Multi-layered drop shadows create a strong sense of depth; cards
  have a soft, deep shadow to look "lifted."
* **Icons:** Incorporate icons to enhance the user’s understanding and the
  logical navigation of the app.
* **Interactive Elements:** Buttons, checkboxes, sliders, lists, charts, graphs,
  and other interactive elements have a shadow with elegant use of color to
  create a "glow" effect.

### Theming
* **Centralized Theme:** Define themes in `core/ui/themes/app_theme.dart` to
  ensure consistent application-wide styling.
* **Theme Organization:** Split theme-related code into:
  - `app_theme.dart` - Main ThemeData configuration
  - `pallet.dart` - Color constants and palette
  - `textstyles.dart` - Typography definitions
  - `dimensions.dart` - Spacing and sizing constants
* **Custom Theme Properties:** Use defined color constants from `Pallet` class
  for consistent color usage across the app.
* **Google Fonts:** This project uses `google_fonts` package for custom
  typography.
* **Screen Util:** `flutter_screenutil` is used for responsive sizing across
  different screen sizes and densities.

  ```dart
  final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    // ... other theme properties
  );
  ```
* **Color Palette:** Include a wide range of color concentrations and hues in
  the palette to create a vibrant and energetic look and feel.
* **Component Themes:** Use specific theme properties (e.g., `appBarTheme`,
  `elevatedButtonTheme`) to customize the appearance of individual Material
  components.
* **Custom Fonts:** For custom fonts, use the `google_fonts` package. Define a
  `TextTheme` to apply fonts consistently.

  ```dart
  // 1. Add the dependency
  // flutter pub add google_fonts

  // 2. Define a TextTheme with a custom font
  final TextTheme appTextTheme = TextTheme(
    displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.openSans(fontSize: 14),
  );
  ```

### Assets and Images
* **Image Guidelines:** If images are needed, make them relevant and meaningful,
  with appropriate size, layout, and licensing (e.g., freely available). Provide
  placeholder images if real ones are not available.
* **Asset Declaration:** Declare all asset paths in your `pubspec.yaml` file.

    ```yaml
    flutter:
      uses-material-design: true
      assets:
        - assets/images/
    ```

* **Local Images:** Use `Image.asset` for local images from your asset
  bundle.

    ```dart
    Image.asset('assets/images/placeholder.png')
    ```
* **Network images:** Use NetworkImage for images loaded from the network.
* **Cached images:** For cached images, use NetworkImage a package like
  `cached_network_image`.
* **Custom Icons:** Use `ImageIcon` to display an icon from an `ImageProvider`,
  useful for custom icons not in the `Icons` class.
* **Network Images:** Use `Image.network` to display images from a URL, and
  always include `loadingBuilder` and `errorBuilder` for a better user
  experience.

    ```dart
    Image.network(
      'https://picsum.photos/200/300',
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
    )
    ```
## UI Theming and Styling Code

* **Responsiveness:** Use `LayoutBuilder` or `MediaQuery` to create responsive
  UIs.
* **Text:** Use `Theme.of(context).textTheme` for text styles.
* **Text Fields:** Configure `textCapitalization`, `keyboardType`, and
* **Responsiveness:** Use `LayoutBuilder` or `MediaQuery` to create responsive
  UIs.
* **Text:** Use `Theme.of(context).textTheme` for text styles.
  remote images.

```dart
// When using network images, always provide an errorBuilder.
Image.network(
  'https://example.com/image.png',
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.error); // Show an error icon
  },
);
```

## Material Theming Best Practices

### Embrace `ThemeData` and Material 3

* **Use `ColorScheme.fromSeed()`:** Use this to generate a complete, harmonious
  color palette for both light and dark modes from a single seed color.
* **Define Light and Dark Themes:** Provide both `theme` and `darkTheme` to your
  `MaterialApp` to support system brightness settings seamlessly.
* **Centralize Component Styles:** Customize specific component themes (e.g.,
  `elevatedButtonTheme`, `cardTheme`, `appBarTheme`) within `ThemeData` to
  ensure consistency.
* **Dark/Light Mode and Theme Toggle:** Implement support for both light and
  dark themes using `theme` and `darkTheme` properties of `MaterialApp`. The
  `themeMode` property can be dynamically controlled (e.g., via a
  `ChangeNotifierProvider`) to allow for toggling between `ThemeMode.light`,
  `ThemeMode.dark`, or `ThemeMode.system`.

```dart
// main.dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14.0, height: 1.4),
    ),
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  ),
  home: const MyHomePage(),
);
```

### Implement Design Tokens with `ThemeExtension`

For custom styles that aren't part of the standard `ThemeData`, use
`ThemeExtension` to define reusable design tokens.

* **Create a Custom Theme Extension:** Define a class that extends
  `ThemeExtension<T>` and include your custom properties.
* **Implement `copyWith` and `lerp`:** These methods are required for the
  extension to work correctly with theme transitions.
* **Register in `ThemeData`:** Add your custom extension to the `extensions`
  list in your `ThemeData`.
* **Access Tokens in Widgets:** Use `Theme.of(context).extension<MyColors>()!`
  to access your custom tokens.

```dart
// 1. Define the extension
@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({required this.success, required this.danger});

  final Color? success;
  final Color? danger;

  @override
  ThemeExtension<MyColors> copyWith({Color? success, Color? danger}) {
    return MyColors(success: success ?? this.success, danger: danger ?? this.danger);
  }

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      success: Color.lerp(success, other.success, t),
      danger: Color.lerp(danger, other.danger, t),
    );
  }
}

// 2. Register it in ThemeData
theme: ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    MyColors(success: Colors.green, danger: Colors.red),
  ],
),

// 3. Use it in a widget
Container(
  color: Theme.of(context).extension<MyColors>()!.success,
)
```

### Styling with `WidgetStateProperty`

* **`WidgetStateProperty.resolveWith`:** Provide a function that receives a
  `Set<WidgetState>` and returns the appropriate value for the current state.
* **`WidgetStateProperty.all`:** A shorthand for when the value is the same for
  all states.

```dart
// Example: Creating a button style that changes color when pressed.
final ButtonStyle myButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.green; // Color when pressed
      }
      return Colors.red; // Default color
    },
  ),
);
```

## Layout Best Practices

### Building Flexible and Overflow-Safe Layouts

#### For Rows and Columns

* **`Expanded`:** Use to make a child widget fill the remaining available space
  along the main axis.
* **`Flexible`:** Use when you want a widget to shrink to fit, but not
  necessarily grow. Don't combine `Flexible` and `Expanded` in the same `Row` or
  `Column`.
* **`Wrap`:** Use when you have a series of widgets that would overflow a `Row`
  or `Column`, and you want them to move to the next line.

#### For General Content

* **`SingleChildScrollView`:** Use when your content is intrinsically larger
  than the viewport, but is a fixed size.
* **`ListView` / `GridView`:** For long lists or grids of content, always use a
  builder constructor (`.builder`).
* **`FittedBox`:** Use to scale or fit a single child widget within its parent.
* **`LayoutBuilder`:** Use for complex, responsive layouts to make decisions
  based on the available space.

### Layering Widgets with Stack

* **`Positioned`:** Use to precisely place a child within a `Stack` by anchoring it to the edges.
* **`Align`:** Use to position a child within a `Stack` using alignments like `Alignment.center`.

### Advanced Layout with Overlays

* **`OverlayPortal`:** Use this widget to show UI elements (like custom
  dropdowns or tooltips) "on top" of everything else. It manages the
  `OverlayEntry` for you.

  ```dart
  class MyDropdown extends StatefulWidget {
    const MyDropdown({super.key});

    @override
    State<MyDropdown> createState() => _MyDropdownState();
  }

  class _MyDropdownState extends State<MyDropdown> {
    final _controller = OverlayPortalController();

    @override
    Widget build(BuildContext context) {
      return OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (BuildContext context) {
          return const Positioned(
            top: 50,
            left: 10,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('I am an overlay!'),
              ),
            ),
          );
        },
        child: ElevatedButton(
          onPressed: _controller.toggle,
          child: const Text('Toggle Overlay'),
        ),
      );
    }
  }
  ```

## Color Scheme Best Practices

### Contrast Ratios

* **WCAG Guidelines:** Aim to meet the Web Content Accessibility Guidelines
  (WCAG) 2.1 standards.
* **Minimum Contrast:**
    * **Normal Text:** A contrast ratio of at least **4.5:1**.
    * **Large Text:** (18pt or 14pt bold) A contrast ratio of at least **3:1**.

### Palette Selection

* **Primary, Secondary, and Accent:** Define a clear color hierarchy.
* **The 60-30-10 Rule:** A classic design rule for creating a balanced color scheme.
    * **60%** Primary/Neutral Color (Dominant)
    * **30%** Secondary Color
    * **10%** Accent Color

### Complementary Colors

* **Use with Caution:** They can be visually jarring if overused.
* **Best Use Cases:** They are excellent for accent colors to make specific
  elements pop, but generally poor for text and background pairings as they can
  cause eye strain.

### Example Palette

* **Primary:** #0D47A1 (Dark Blue)
* **Secondary:** #1976D2 (Medium Blue)
* **Accent:** #FFC107 (Amber)
* **Neutral/Text:** #212121 (Almost Black)
* **Background:** #FEFEFE (Almost White)

## Font Best Practices

### Font Selection

* **Limit Font Families:** Stick to one or two font families for the entire
  application.
* **Prioritize Legibility:** Choose fonts that are easy to read on screens of
  all sizes. Sans-serif fonts are generally preferred for UI body text.
* **System Fonts:** Consider using platform-native system fonts.
* **Google Fonts:** For a wide selection of open-source fonts, use the
  `google_fonts` package.

### Hierarchy and Scale

* **Establish a Scale:** Define a set of font sizes for different text elements
  (e.g., headlines, titles, body text, captions).
* **Use Font Weight:** Differentiate text effectively using font weights.
* **Color and Opacity:** Use color and opacity to de-emphasize less important
  text.

### Readability

* **Line Height (Leading):** Set an appropriate line height, typically **1.4x to
  1.6x** the font size.
* **Line Length:** For body text, aim for a line length of **45-75 characters**.
* **Avoid All Caps:** Do not use all caps for long-form text.

### Example Typographic Scale

```dart
// In your ThemeData
textTheme: const TextTheme(
  displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
  titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
  bodyLarge: TextStyle(fontSize: 16.0, height: 1.5),
  bodyMedium: TextStyle(fontSize: 14.0, height: 1.4),
  labelSmall: TextStyle(fontSize: 11.0, color: Colors.grey),
),
```

## Documentation

* **`dartdoc`:** Write `dartdoc`-style comments for all public APIs.

### Project Documentation Maintenance

* **README.md Synchronization:** Always keep `README.md` synchronized with the latest guidelines and practices defined in `rules.md`. When you update architecture patterns, add new dependencies, modify project structure, or change development workflows in `rules.md`, immediately update the corresponding sections in `README.md` to reflect these changes.
* **Key Sections to Sync:**
  - Installation steps and prerequisites
  - Project architecture overview
  - Core technologies and packages
  - Environment setup (envied configuration)
  - Code generation commands
  - Testing requirements and coverage targets
  - Development workflows
* **Update Triggers:** Update `README.md` when:
  - New features or architectural patterns are documented in `rules.md`
  - Dependencies are added, removed, or significantly updated
  - Build/run commands or configuration steps change
  - Testing strategies or coverage requirements are modified
  - Development tools or workflows are updated
* **Consistency:** Ensure terminology, code examples, and instructions in `README.md` match those in `rules.md` to avoid confusion for developers onboarding to the project.

### Documentation Philosophy

* **Comment wisely:** Use comments to explain why the code is written a certain
  way, not what the code does. The code itself should be self-explanatory.
* **Document for the user:** Write documentation with the reader in mind. If you
  had a question and found the answer, add it to the documentation where you
  first looked. This ensures the documentation answers real-world questions.
* **No useless documentation:** If the documentation only restates the obvious
  from the code's name, it's not helpful. Good documentation provides context
  and explains what isn't immediately apparent.
* **Consistency is key:** Use consistent terminology throughout your
  documentation.

### Commenting Style

* **Use `///` for doc comments:** This allows documentation generation tools to
  pick them up.
* **Start with a single-sentence summary:** The first sentence should be a
  concise, user-centric summary ending with a period.
* **Separate the summary:** Add a blank line after the first sentence to create
  a separate paragraph. This helps tools create better summaries.
* **Avoid redundancy:** Don't repeat information that's obvious from the code's
  context, like the class name or signature.
* **Don't document both getter and setter:** For properties with both, only
  document one. The documentation tool will treat them as a single field.

### Writing Style

* **Be brief:** Write concisely.
* **Avoid jargon and acronyms:** Don't use abbreviations unless they are widely
  understood.
* **Use Markdown sparingly:** Avoid excessive markdown and never use HTML for
  formatting.
* **Use backticks for code:** Enclose code blocks in backtick fences, and
  specify the language.

### What to Document

* **Public APIs are a priority:** Always document public APIs.
* **Consider private APIs:** It's a good idea to document private APIs as well.
* **Library-level comments are helpful:** Consider adding a doc comment at the
  library level to provide a general overview.
* **Include code samples:** Where appropriate, add code samples to illustrate usage.
* **Explain parameters, return values, and exceptions:** Use prose to describe
  what a function expects, what it returns, and what errors it might throw.
* **Place doc comments before annotations:** Documentation should come before
  any metadata annotations.

## Accessibility (A11Y)
Implement accessibility features to empower all users, assuming a wide variety
of users with different physical abilities, mental abilities, age groups,
education levels, and learning styles.

* **Color Contrast:** Ensure text has a contrast ratio of at least **4.5:1**
  against its background.
* **Dynamic Text Scaling:** Test your UI to ensure it remains usable when users
  increase the system font size.
* **Semantic Labels:** Use the `Semantics` widget to provide clear, descriptive
  labels for UI elements.
* **Screen Reader Testing:** Regularly test your app with TalkBack (Android) and
  VoiceOver (iOS).