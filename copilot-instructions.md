# Copilot Instructions for How Weather App Project

## General Guidelines
- Be concise and direct
- Prefer single-line outputs when possible
- Avoid emojis in all outputs
- Avoid unnecessary explanations
- Do not add bullet points unless explicitly asked
- Assume the user is familiar with programming concepts but may be new to Dart
- When generating code, provide explanations for Dart-specific features like null safety, futures, and streams
- If a request is ambiguous, ask for clarification on the intended functionality and the target platform
- When suggesting new dependencies from pub.dev, explain their benefits
- Use the dart_format tool to ensure consistent code formatting
- Use the dart_fix tool to automatically fix many common errors and help code conform to configured analysis options
- Use the Dart linter with a recommended set of rules to catch common issues
- Use the analyze_files tool to run the linter

## Project Overview
- How Weather is a Flutter application that follows Clean Architecture principles with a feature-based organization structure
- Core Technologies: flutter_bloc (Cubit pattern), get_it + injectable, go_router, freezed + json_annotation, dio with interceptors, hive + flutter_secure_storage, dartz (Either for error handling), talker with alice for network inspection, flutter_screenutil, font_awesome_flutter, ionicons, google_fonts, cached_network_image
- Project Architecture: Data Layer (remote/local data sources, models DTOs, mappers, repository implementations), Domain Layer (entities, repository interfaces, use cases), Presentation Layer (Cubits state management, pages screens, widgets)
- Core Module: di/ (dependency injection), router/ (navigation), services/ (HTTP, storage, logging), ui/ (themes, shared widgets, generated assets), localization/ (i18n support), exceptions/ (custom exception handling), validation/ (reusable form validators)

## Project Structure
- Standard Flutter project structure with lib/main.dart as the primary application entry point
- Feature-based organization: each feature has its own presentation, domain, and data subfolders
- Core module structure: constants/, cubit/, di/, exceptions/, extensions/, localization/, router/, services/, ui/, utils/, validation/

## Code Quality
- Adhere to maintainable code structure and separation of concerns
- Avoid abbreviations and use meaningful, consistent, descriptive names for variables, functions, and classes
- Write code that is as short as it can be while remaining clear
- Write straightforward code; avoid clever or obscure code
- Anticipate and handle potential errors; don't let code fail silently
- Line length: Lines should be 80 characters or fewer
- Functions should be short and with a single purpose (strive for less than 20 lines)
- Write code with testing in mind
- Use the logging package instead of print

## Dart Best Practices
- Follow the official Effective Dart guidelines (https://dart.dev/effective-dart)
- Define related classes within the same library file; for large libraries, export smaller, private libraries
- Group related libraries in the same folder
- Add documentation comments to all public APIs, including classes, constructors, methods, and top-level functions
- Write clear comments for complex or non-obvious code; avoid over-commenting
- Don't add trailing comments
- Ensure proper use of async/await for asynchronous operations with robust error handling
- Write code that is soundly null-safe; leverage Dart's null safety features; avoid ! unless the value is guaranteed to be non-null
- Use pattern matching features where they simplify the code
- Use records to return multiple types in situations where defining an entire class is cumbersome
- Prefer using exhaustive switch statements or expressions, which don't require break statements
- Use try-catch blocks for handling exceptions, and use exceptions appropriate for the type of exception
- Use custom exceptions in core/exceptions/app_exceptions.dart
- Use dartz for functional error handling with Either<AppException, Success> pattern in repositories and use cases
- Use arrow syntax for simple one-line functions

## Flutter Best Practices
- Widgets (especially StatelessWidget) are immutable; when the UI needs to change, Flutter rebuilds the widget tree
- Prefer composing smaller widgets over extending existing ones; use this to avoid deep widget nesting
- Use small, private Widget classes instead of private helper methods that return a Widget
- Break down large build() methods into smaller, reusable private Widget classes
- Use ListView.builder or SliverList for long lists to create lazy-loaded lists for performance
- Use compute() to run expensive calculations in a separate isolate to avoid blocking the UI thread
- Use const constructors for widgets and in build() methods whenever possible to reduce rebuilds
- Avoid performing expensive operations, like network calls or complex computations, directly within build() methods

## Architecture Adherence
- Follow Clean Architecture patterns as defined in rules.md
- Use BLoC/Cubit for state management
- Apply Freezed for all data classes
- Implement proper dependency injection with Injectable/GetIt
- Separate ephemeral state and app state
- Use a state management solution for app state to handle separation of concerns
- Everything in Flutter's UI is a widget; compose complex UIs from smaller, reusable widgets
- Use go_router for navigation
- Separate data models (DTOs) and domain entities
- Use mapper classes to convert between models and entities
- Use repository pattern with interfaces in domain layer
- Use Either<AppException, Success> for error handling
- Use custom exceptions that extend AppException
- Use freezed for immutable data models with JSON serialization
- Use injectable annotations for dependency injection
- Use talker for logging and error handling
- Use dio as HTTP client with interceptors
- Use hive for local storage and flutter_secure_storage for sensitive data
- Use centralized Validators class for form validation with localized messages
- Use custom i18n setup with context.i18n extension for localization
- Use flutter_screenutil for responsive design
- Use google_fonts for typography
- Use cached_network_image for image caching
- Use build_runner for code generation (freezed, injectable, json_serializable, envied, flutter_gen)

## Package Management
- Use flutter pub add <package_name> for regular dependencies
- Use flutter pub add dev:<package_name> for dev dependencies
- Use flutter pub add override:<package_name>:1.0.0 for dependency overrides
- Use dart pub remove <package_name> for removing dependencies
- Run flutter pub get after adding/updating dependencies
- Run dart run build_runner build --delete-conflicting-outputs after code generation annotations

## Testing
- Write unit tests for domain logic and use cases
- Write integration tests for data layer and repository integration
- Write widget tests for UI components and screens
- Maintain >90% code coverage across all layers
- Use mocktail for mocking (preferred) or mockito
- Use bloc_test for testing Cubits and Blocs
- Use TestWindowConfig for widget tests
- Use TestWidgetBuilder for reusable widget test setups
- Use TestStreamControllers for managing stream controllers in tests
- Run flutter test --coverage for coverage
- Exclude generated files (*.g.dart, *.freezed.dart, injector.config.dart) from coverage

## Git Commit Messages
- Use a single short sentence (imperative tone)
- Start with a verb (e.g., "Add", "Fix", "Update", "Remove")
- Keep under 50 characters when possible
- No periods at the end
- Examples:
  - "Add scroll indicator color customization"
  - "Fix scrollbar theme positioning"
  - "Update organizational unit list styling"

## Code Comments
- Keep comments minimal and meaningful
- Explain "why" not "what" when the code is clear
- Use single-line comments for brief explanations
- Add documentation comments to all public APIs
- Write clear comments for complex or non-obvious code
- Avoid over-commenting and trailing comments

## Platform Configuration
- Use proper spacing with uppercase first alphabet for each word in app names (e.g., "Git Pedia", "My Awesome App")
- Update app name in all platform-specific configuration files:
  - Android: android/app/src/main/AndroidManifest.xml (android:label)
  - iOS: ios/Runner/Info.plist (CFBundleDisplayName, CFBundleName)
  - macOS: macos/Runner/Configs/AppInfo.xcconfig (PRODUCT_NAME)
  - Linux: linux/CMakeLists.txt (BINARY_NAME)
  - Windows: windows/CMakeLists.txt (BINARY_NAME)
  - Web: web/index.html and web/manifest.json (title, name)
  - pubspec.yaml: name field (use snake_case)
- Ensure display name is consistent across all platforms

## Flutter Style Guide
- Apply SOLID principles throughout the codebase
- Write concise, modern, technical Dart code
- Prefer functional and declarative patterns
- Favor composition for building complex widgets and logic
- Prefer immutable data structures
- Separate ephemeral state and app state
- Use a state management solution for app state
- Compose complex UIs from smaller, reusable widgets
- Use go_router for navigation

## API Design Principles
- Design APIs from the perspective of the person who will be using them
- Make APIs intuitive and easy to use correctly
- Good documentation is essential for API design
- Documentation should be clear, concise, and provide examples

## Application Architecture
- Aim for separation of concerns similar to MVC/MVVM
- Organize into logical layers: Presentation (widgets, screens), Domain (business logic classes), Data (model classes, API clients), Core (shared classes, utilities, extension types)
- Use feature-based organization for larger projects

## Extensions & Context Helpers
- Use context extensions for simplified operations
- Prefer context.i18n over AppLocalizations.of(context) for cleaner code
- Use context extensions for theme access, media query, navigation helpers, snackbar helper

## Lint Rules
- Include package:flutter_lints/flutter.yaml in analysis_options.yaml
- Add additional lint rules as needed

## State Management
- Use flutter_bloc with Cubit pattern for simpler scenarios, Bloc for complex event-driven scenarios
- Use freezed for immutable state classes with copyWith
- Mark Cubits/Blocs with @injectable for automatic DI
- Use BlocProvider to provide instances to widget tree
- Use BlocBuilder for UI rebuilding, BlocConsumer for building and side effects
- Create AppCubit for application-wide state (theme, auth, preferences)
- Register AppCubit as @lazySingleton
- Wrap app with BlocProvider<AppCubit>.value for lazySingleton
- Access global state with context.read<AppCubit>() or context.watch<AppCubit>()
- Organize state files alongside cubit files: feature_cubit.dart, feature_state.dart
- Use bloc_test for testing with arrange-act-assert patterns

## Dependency Injection
- Use get_it as service locator and injectable for code generation
- Annotations: @injectable (transient), @lazySingleton (lazy), @singleton (eager), @RegisterModule (third-party)
- Access with GetIt.I<T>() or constructor injection
- Run flutter pub run build_runner build after adding injectable classes

## Data Flow
- Separate models (DTOs in data layer) and entities (domain layer)
- Use mappers to convert between models and entities
- Implement repository pattern with domain interfaces
- Encapsulate business logic in use case classes
- Use Either<AppException, Success> for error handling
- Catch exceptions in repositories and return in Either Left side
- Don't convert to different exception types in repositories

## Routing
- Use go_router for declarative navigation, deep linking, web support
- Define routes centrally in core/router/app_router.dart
- Integrate BlocProvider within route builders
- Use route redirects for authentication logic

## Storage & Persistence
- Use Hive for local key-value storage, initialize in main()
- Use HiveService abstraction instead of direct Hive access
- Use flutter_secure_storage for sensitive data via SecureStorageService
- Storage methods: put/get, getTyped<T>/getList<T>, containsKey/delete/clear

## Data Handling & Serialization
- Use freezed for immutable models with JSON serialization
- Combine with json_annotation and @JsonKey for custom field names
- Map between camelCase and snake_case with @JsonKey(name: 'field_name')
- Run build_runner to generate .freezed.dart and .g.dart files
- Use Freezed factory constructors

## Logging & Error Handling
- Use talker package for comprehensive logging and error handling
- Features: structured logging, error tracking, network logging, BLoC monitoring, in-app viewer
- Use LoggerService abstraction wrapping Talker
- Initialize Talker in main.dart and handle errors
- Use alice and pretty_dio_logger for HTTP inspection

## HTTP Client & Networking
- Use dio as HTTP client with HttpClientService abstraction
- Configure interceptors for logging, alice, auth, error handling, retry
- Use connectivity_plus via InternetConnectionService for network checks
- Define custom exceptions for HTTP error scenarios

## Form Validation
- Use centralized Validators class in core/validation/validators.dart
- Static methods reusable across screens and features
- Require BuildContext for localized error messages
- Wrap validators in anonymous functions to pass context
- Available validators: email, password, required, minLength, maxLength, phoneNumber, url, match, numeric, alphabetic, alphanumeric
- Localized error messages from I18n
- Use autovalidateMode: AutovalidateMode.onUserInteraction

## Localization
- Custom i18n setup in core/localization/ with English (en) and Indonesian (id)
- I18n abstract class with I18nEn and I18nId implementations
- Use context.i18n extension for cleaner access (preferred)
- Supported locales: Locale('en', 'US'), Locale('id', 'ID')
- String types: simple getters, methods with parameters
- Register I18nDelegate in MaterialApp

## Localization Guidelines
- Never use hardcoded strings in UI; always localize
- Use context.i18n extension for cleaner code
- Localize all validation messages with BuildContext
- Never return hardcoded error strings in validators
- Localize success/error messages
- Use methods with parameters for dynamic content

## Code Generation
- Use build_runner for code generation
- Packages: freezed, json_serializable, injectable, envied, flutter_gen
- Run flutter pub run build_runner build --delete-conflicting-outputs
- Use watch mode: flutter pub run build_runner watch --delete-conflicting-outputs

## Environment Implementation
- Use envied package for environment variables
- Store in .env files (.env.dev, .env)
- Run code generation to update generated environment class
- Never hardcode secrets or API URLs

## Asset Generation Implementation
- Use flutter_gen for type-safe asset references
- Configure in pubspec.yaml
- Run code generation to update core/ui/generated/assets.gen.dart
- Always use generated asset references instead of hardcoded paths

## Required Pub Commands
- Run flutter pub get after dependencies changes
- Run flutter pub run build_runner build --delete-conflicting-outputs after annotations

## Feature Creation and Testing
- Create corresponding tests for new features: unit, integration, widget tests
- Maintain >90% code coverage
- Use flutter test --coverage
- Exclude generated files from coverage reports

## Testing Best Practices
- Mock external dependencies (repositories, data sources, services)
- Never mock entities or value objects from domain layer
- Use fakes for simple implementations
- Register fallback values for mocks
- Verify interactions with verify()
- Use verifyNever() for error scenarios
- Arrange-Act-Assert pattern without excessive comments
- Group related tests with group()
- Use setUp/tearDown for common setup/cleanup
- Use setUpAll/tearDownAll for expensive operations
- MaterialApp wrapper for widget tests
- Include i18n delegates for localized tests
- Use MultiBlocProvider for multiple cubits
- pumpAndSettle for animations and async operations
- pump for single frame rebuilds

## Flutter API Updates
- Use new multi-window API for window configuration in tests (Flutter 3.9+)
- TestWindowConfig.setupWindowSize() for consistent test windows
- Reset window size in tearDown

## Code Coverage
- Target >90% coverage: 95%+ domain, 90%+ data, 85%+ presentation
- Run flutter test --coverage
- View HTML reports with genhtml
- Exclude generated files in analysis_options.yaml or test directory

## Example Test References
- Unit: login_usecase_test.dart
- Mapper: user_mapper_test.dart
- Repository: auth_repository_impl_test.dart
- Cubit: login_cubit_test.dart
- Page: login_screen_test.dart
- Integration: login_integration_test.dart

## Utilities & Extensions
- Define extension methods in core/extensions/
- Use for adding functionality to existing types
- Define constants in core/constants/: num_constants.dart, string_constants.dart
- Place helpers in core/utils/

## Visual Design & Theming
- Build beautiful and intuitive UIs following modern design guidelines
- Ensure mobile responsive and adapt to different screen sizes
- Provide intuitive navigation
- Use typography to emphasize hierarchy
- Apply subtle noise texture to background
- Use multi-layered drop shadows for depth
- Incorporate icons for better understanding
- Use shadows with color glow for interactive elements

## Theming
- Define themes in core/ui/themes/app_theme.dart
- Split into app_theme.dart, pallet.dart, textstyles.dart, dimensions.dart
- Use Pallet class for consistent colors
- Use google_fonts for custom typography
- Use flutter_screenutil for responsive sizing
- ColorScheme.fromSeed() for harmonious palettes
- Define light and dark themes
- Customize component themes (elevatedButtonTheme, cardTheme, appBarTheme)
- Use google_fonts for custom fonts

## Assets and Images
- Declare paths in pubspec.yaml
- Use Image.asset for local images
- Use Image.network with loadingBuilder and errorBuilder
- Use cached_network_image for cached images
- Use ImageIcon for custom icons

## UI Theming and Styling Code
- Use LayoutBuilder or MediaQuery for responsive UIs
- Use Theme.of(context).textTheme for text styles
- Configure textCapitalization and keyboardType for text fields
- Use LayoutBuilder for complex responsive layouts
- Use Stack with Positioned and Align for layering
- Use OverlayPortal for overlays like dropdowns

## Material Theming Best Practices
- Embrace ThemeData and Material 3
- Use ColorScheme.fromSeed() for palettes
- Define light and dark themes
- Centralize component styles
- Support system brightness with themeMode
- Use ThemeExtension for custom tokens
- Implement copyWith and lerp for extensions
- Register extensions in ThemeData
- Access with Theme.of(context).extension<MyColors>()!

## Styling with WidgetStateProperty
- Use WidgetStateProperty.resolveWith for state-based values
- Use WidgetStateProperty.all for same values across states

## Layout Best Practices
- Use Expanded for filling available space
- Use Flexible for shrinking to fit
- Use Wrap for overflow handling
- Use SingleChildScrollView for fixed-size content
- Use ListView/GridView with builder constructors
- Use FittedBox for scaling
- Use LayoutBuilder for space-based decisions
- Use Positioned for Stack positioning
- Use Align for Stack alignment
- Use OverlayPortal for overlays

## Color Scheme Best Practices
- Meet WCAG 2.1 standards: 4.5:1 for normal text, 3:1 for large text
- Define clear color hierarchy: primary, secondary, accent
- Use 60-30-10 rule for balanced schemes
- Use complementary colors with caution
- Example palette: Primary #0D47A1, Secondary #1976D2, Accent #FFC107, Neutral #212121, Background #FEFEFE

## Font Best Practices
- Limit to one or two font families
- Prioritize legibility on screens
- Use sans-serif for UI body text
- Use system fonts when possible
- Use google_fonts for selection
- Establish scale: displayLarge, titleLarge, bodyLarge, etc.
- Use font weights for differentiation
- Adjust line height to 1.4x-1.6x font size
- Aim for 45-75 characters per line
- Avoid all caps for long text

## Documentation
- Write dartdoc-style comments for public APIs
- Start with single-sentence summary
- Add blank line after summary
- Avoid redundancy
- Don't document both getter and setter
- Place doc comments before annotations
- Be brief and avoid jargon
- Use backticks for code
- Document parameters, return values, exceptions
- Write for the user, anticipating questions

## Project Documentation Maintenance
- Keep README.md synchronized with rules.md
- Update README.md when architecture, dependencies, structure, or workflows change
- Sync sections: installation, architecture, technologies, environment setup, build commands, testing, development workflows
- Update on changes to dependencies, build/run commands, testing strategies, coverage requirements, development tools

## Documentation Philosophy
- Comment on why, not what
- Self-explanatory code doesn't need comments
- Provide context for non-obvious code
- Consistent terminology
- Brief and direct
- Avoid jargon and abbreviations
- Use Markdown sparingly, no HTML
- Use backticks for code

## Commenting Style
- Use /// for doc comments
- Single-sentence summary ending with period
- Separate summary with blank line
- Avoid redundancy and obvious information
- Document one for getter/setter pairs
- Before annotations

## Writing Style
- Be brief
- Avoid jargon and acronyms
- Markdown sparingly
- Backticks for code

## What to Document
- Public APIs priority
- Consider private APIs
- Library-level comments helpful
- Include code samples
- Explain parameters, return values, exceptions
- Place before annotations

## Accessibility (A11Y)
- Contrast ratio 4.5:1 for normal text, 3:1 for large text
- Test dynamic text scaling
- Use Semantics widget for labels
- Test with TalkBack (Android) and VoiceOver (iOS)