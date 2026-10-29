import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:stream_pro/feature/auth/presentation/controllers/login_form_controller.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/auth_divider.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/auth_header.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/auth_scaffold.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/auth_switch_footer.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/login/login_form.dart';
import 'package:stream_pro/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginFormController _formController = LoginFormController();

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      context.showErrorSnackBar(message: state.message);
    } else if (state is AuthSuccess) {
      final message = state.source == AuthSuccessSource.register
          ? S.current.accountCreatedSuccessFully
          : S.current.loginSuccessfully;
      context.showSuccessSnackBar(message: message);
      context.navigateToAndClearStack(AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _onAuthStateChanged,
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final isLocalLoading =
            state is AuthLoading && state.source == AuthLoadingSource.local;
        final isGoogleLoading =
            state is AuthLoading && state.source == AuthLoadingSource.google;

        return AuthScaffold(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthHeader(
                title: S.current.login,
                subtitle: S.current.loginSubtitle,
              ),
              SizedBox(height: 32.h),
              LoginForm(
                controller: _formController,
                isLoading: isLocalLoading,
                isEnabled: !isLoading,
                onSubmit: (LoginParams params) {
                  context.read<AuthCubit>().login(params);
                },
              ),
              SizedBox(height: 24.h),
              const AuthDivider(),
              SizedBox(height: 16.h),
              GoogleSignInButton(
                isLoading: isGoogleLoading,
                isEnabled: !isLoading,
                onPressed: () => context.read<AuthCubit>().loginWithGoogle(),
              ),
              SizedBox(height: 24.h),
              AuthSwitchFooter(
                question: S.current.dontHaveAccount,
                actionLabel: S.current.registerNow,
                onTap: () => context.navigateTo(AppRoutes.register),
              ),
            ],
          ),
        );
      },
    );
  }
}
