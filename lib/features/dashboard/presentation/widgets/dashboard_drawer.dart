import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: AppDimensions.height30,
                      backgroundColor: AppColors.white,
                      child: Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: AppDimensions.height24,
                      ),
                    ),
                    SizedBox(height: AppDimensions.height10),
                    Text(
                      appState.userLogged?.name ?? context.loc.unknown,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppDimensions.style18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      appState.userLogged?.email ?? '',
                      style: TextStyle(
                        color: AppColors.grey200,
                        fontSize: AppDimensions.style14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.brightness_6, color: AppColors.primary),
                title: Text(context.loc.theme),
                subtitle: Text(_getThemeModeText(appState.themeMode, context)),
                onTap: () => _showThemeDialog(context, appState.themeMode),
              ),
              ListTile(
                leading: Icon(Icons.language, color: AppColors.primary),
                title: Text(context.loc.language),
                subtitle: Text(_getLanguageText(appState.locale, context)),
                onTap: () => _showLanguageDialog(context, appState.locale),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: AppColors.error),
                title: Text(
                  context.loc.logout,
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getThemeModeText(ThemeMode themeMode, BuildContext context) {
    switch (themeMode) {
      case ThemeMode.light:
        return context.loc.lightTheme;
      case ThemeMode.dark:
        return context.loc.darkTheme;
      case ThemeMode.system:
        return context.loc.systemTheme;
    }
  }

  String _getLanguageText(Locale? locale, BuildContext context) {
    if (locale?.languageCode == 'id') {
      return context.loc.indonesian;
    }
    return context.loc.english;
  }

  void _showThemeDialog(BuildContext context, ThemeMode currentThemeMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.loc.selectTheme),
        content: DropdownButton<ThemeMode>(
          value: currentThemeMode,
          onChanged: (value) {
            if (value != null) {
              context.read<AppCubit>().changeTheme(value);
              Navigator.of(context).pop();
            }
          },
          items: [
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text(context.loc.lightTheme),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text(context.loc.darkTheme),
            ),
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text(context.loc.systemTheme),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.loc.cancel),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, Locale? currentLocale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.loc.selectLanguage),
        content: DropdownButton<String>(
          value: currentLocale?.languageCode ?? 'en',
          onChanged: (value) {
            if (value != null) {
              Navigator.of(context).pop();
              final locale = value == 'id'
                  ? const Locale('id', 'ID')
                  : const Locale('en', 'US');
              context.read<AppCubit>().changeLocale(locale);
            }
          },
          items: [
            DropdownMenuItem(value: 'en', child: Text(context.loc.english)),
            DropdownMenuItem(value: 'id', child: Text(context.loc.indonesian)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.loc.cancel),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    final goRouter = GoRouter.of(context).go;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.loc.logout),
        content: Text(context.loc.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.loc.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.loc.logout),
          ),
        ],
      ),
    ).then((shouldLogout) {
      if (shouldLogout == true) {
        appCubit.logout();
        goRouter(AppRouter.loginRoute);
      }
    });
  }
}
