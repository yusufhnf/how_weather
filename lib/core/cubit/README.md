# AppCubit Usage Guide

The `AppCubit` manages global application state including theme mode, locale, and authentication state.

## Features

### Theme Management
```dart
// Get AppCubit instance
final appCubit = context.read<AppCubit>();

// Change theme
appCubit.changeTheme(ThemeMode.dark);
appCubit.changeTheme(ThemeMode.light);
appCubit.changeTheme(ThemeMode.system);

// Check current theme
if (appCubit.isDarkTheme) {
  // Dark theme is active
}
```

### Locale Management
```dart
// Change locale
appCubit.changeLocale(Locale('en', 'US'));
appCubit.changeLocale(Locale('id', 'ID'));
```

### Authentication
```dart
// Login
await appCubit.login(
  token: 'user_token',
  userId: 'user_id',
);

// Logout
await appCubit.logout();

// Check auth state
if (context.read<AppCubit>().state.isAuthenticated) {
  // User is authenticated
}
```

## Accessing State

### Using BlocBuilder (Rebuilds on state change)
```dart
BlocBuilder<AppCubit, AppState>(
  builder: (context, state) {
    return Text('Theme: ${state.themeMode}');
  },
)
```

### Using BlocConsumer (Rebuilds + side effects)
```dart
BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    if (state.isAuthenticated) {
      // Navigate to home
    }
  },
  builder: (context, state) {
    return LoginPage();
  },
)
```

### Using context.read (No rebuild)
```dart
final appCubit = context.read<AppCubit>();
appCubit.changeTheme(ThemeMode.dark);
```

### Using context.watch (Rebuilds on change)
```dart
final appState = context.watch<AppCubit>().state;
return Text('Theme: ${appState.themeMode}');
```

## State Persistence

The AppCubit automatically persists:
- Theme mode → Hive storage
- Locale → Hive storage
- Authentication token → Secure storage
- User ID → Secure storage

All state is restored when the app restarts.
