import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../cubit/dashboard_cubit.dart';
import '../widgets/dashboard_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  late VoidCallback _onScrollCallback;
  bool _listenerAdded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_listenerAdded) {
      _scrollController.removeListener(_onScrollCallback);
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>(),
      child: BlocSelector<DashboardCubit, DashboardState, bool>(
        selector: (state) => state.maybeWhen(
          scrollChanged: (isCollapsed) => isCollapsed,
          orElse: () => false,
        ),
        builder: (context, isCollapsed) {
          if (!_listenerAdded) {
            _onScrollCallback = () {
              context.read<DashboardCubit>().updateScrollPosition(
                _scrollController,
                AppDimensions.height300,
              );
            };
            _scrollController.addListener(_onScrollCallback);
            _listenerAdded = true;
          }
          return Scaffold(
            body: CustomScrollView(
              controller: _scrollController,
              slivers: [
                DashboardAppBar(isCollapsed: isCollapsed),
                SliverPadding(
                  padding: EdgeInsets.all(AppDimensions.width16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppDimensions.height16,
                      crossAxisSpacing: AppDimensions.width16,
                      childAspectRatio: 3 / 2,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Card(
                        child: Center(
                          child: Text(
                            'Location ${index + 1}\n20°C, Cloudy',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }, childCount: 20),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
