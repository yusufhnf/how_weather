import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

  void updateScrollPosition(
    ScrollController controller,
    double expandedHeight,
  ) {
    final isCollapsed =
        controller.hasClients &&
        controller.offset > (expandedHeight - kToolbarHeight);

    // Only emit new state if the collapsed state has changed
    final currentIsCollapsed = state.maybeWhen(
      scrollChanged: (isCollapsed) => isCollapsed,
      orElse: () => false,
    );

    if (isCollapsed != currentIsCollapsed) {
      emit(DashboardState.scrollChanged(isCollapsed: isCollapsed));
    }
  }
}
