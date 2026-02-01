import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/cubit/app_cubit.dart';
import 'core/cubit/app_state.dart';
import 'core/di/injector.dart';
import 'core/localization/i18n.dart';
import 'core/router/app_router.dart';
import 'core/ui/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await configureDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<AppCubit>(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, appState) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                title: 'How Weather',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: appState.themeMode,
                routerConfig: AppRouter.router,
                locale: appState.locale,
                localizationsDelegates: const [I18nDelegate()],
                supportedLocales: I18nDelegate.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
