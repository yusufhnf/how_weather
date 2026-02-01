import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.loc.loginTitle), elevation: 0.0),
      body: BlocProvider<LoginCubit>(
        create: (context) => getIt<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (user) {
                context.read<AppCubit>().login(
                  token: user.token,
                  userId: user.id,
                );
                context.showSnackBar(context.loc.loginSuccess(user.name));
                context.replace(AppRouter.dashboardRoute);
              },
              failure: (message) {
                context.showSnackBar(message);
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(AppDimensions.width16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Assets.svg.loginImage.svg(
                              height: AppDimensions.height144,
                            ),
                            SizedBox(height: AppDimensions.height32),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: context.loc.email,
                                prefixIcon: const Icon(Icons.email_outlined),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              enabled: !isLoading,
                              validator: (value) =>
                                  Validators.email(value, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            SizedBox(height: AppDimensions.height16),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: context.loc.password,
                                prefixIcon: const Icon(Icons.lock_outline),
                              ),
                              obscureText: true,
                              enabled: !isLoading,
                              validator: (value) =>
                                  Validators.password(value, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),

                            SizedBox(height: AppDimensions.height24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () => _handleLogin(context),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: AppDimensions.height16,
                                  ),
                                  backgroundColor: context.colorScheme.primary,
                                ),
                                child: isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      )
                                    : Text(
                                        context.loc.login,
                                        style: TextStyle(
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    }
  }
}
