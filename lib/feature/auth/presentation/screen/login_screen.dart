import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/auth_header.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/auth_scaffold.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/auth_switch_footer.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/login/login_form.dart';
import 'package:stream_pro/generated/l10n.dart';

/// Login screen.
///
/// The [StatefulWidget] only owns the text controllers / focus nodes so it
/// can dispose them; it never calls setState. All reactive state comes from:
/// - [AuthCubit] (loading / success / failure) via BlocConsumer
/// - a [ValueNotifier] inside the password field for visibility toggling
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      context.showErrorSnackBar(message: state.message);
    } else if (state is AuthSuccess) {
      context.showSuccessSnackBar(message: S.current.loginSuccessfully);
      context.navigateToAndClearStack(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _onAuthStateChanged,
      builder: (context, state) {
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
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                emailFocusNode: _emailFocusNode,
                passwordFocusNode: _passwordFocusNode,
                isLoading: state is AuthLoading,
                onSubmit: (LoginParams params) {
                  context.read<AuthCubit>().login(params);
                },
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
