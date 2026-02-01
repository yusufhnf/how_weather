library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:how_weather/core/core.dart';

class TestWindowConfig {
  static const Size _testWindowSize = Size(1080, 1920);
  static const double _testPixelRatio = 1.0;

  static void setupWindowSize({
    Size size = _testWindowSize,
    double pixelRatio = _testPixelRatio,
  }) {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first.physicalSize = size;
    binding.platformDispatcher.views.first.devicePixelRatio = pixelRatio;
  }

  static void resetWindowSize() {
    final binding = TestWidgetsFlutterBinding.instance;
    binding.platformDispatcher.views.first.resetPhysicalSize();
    binding.platformDispatcher.views.first.resetDevicePixelRatio();
  }
}

class TestWidgetBuilder {
  static const Size _designSize = Size(1080, 1920);

  static Widget buildMaterialApp({
    required Widget child,
    Size designSize = _designSize,
  }) {
    return ScreenUtilInit(
      designSize: designSize,
      builder: (context, _) => MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: child,
      ),
    );
  }

  static Widget
  buildMaterialAppWithRouter<T extends StateStreamableSource<S>, S>({
    required GoRouter router,
    required T bloc,
    Size designSize = _designSize,
  }) {
    return ScreenUtilInit(
      designSize: designSize,
      builder: (context, _) => BlocProvider<T>.value(
        value: bloc,
        child: MaterialApp.router(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: router,
        ),
      ),
    );
  }

  static Widget buildMaterialAppWithMultiProviders({
    required List<BlocProvider> providers,
    required Widget child,
    Size designSize = _designSize,
  }) {
    return ScreenUtilInit(
      designSize: designSize,
      builder: (context, _) => MultiBlocProvider(
        providers: providers,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: child,
        ),
      ),
    );
  }
}

class TestStreamControllers {
  static StreamController<T> createBroadcast<T>() {
    return StreamController<T>.broadcast();
  }

  static void closeAll(List<StreamController> controllers) {
    for (final controller in controllers) {
      controller.close();
    }
  }
}
