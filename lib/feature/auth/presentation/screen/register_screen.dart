import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/auth_header.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/auth_scaffold.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/auth_switch_footer.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/register/register_form.dart';
import 'package:stream_pro/generated/l10n.dart';

/// Register screen.
///
/// The [StatefulWidget] only owns the text controllers / focus nodes and the
/// terms [ValueNotifier] so it can dispose them; it never calls setState.
/// All reactive state comes from:
/// - [AuthCubit] (loading / success / failure) via BlocConsumer
/// - [ValueNotifier]s inside the password field and terms checkbox
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final ValueNotifier<bool> _termsAccepted = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _termsAccepted.dispose();
    super.dispose();
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      context.showErrorSnackBar(message: state.message);
    } else if (state is AuthSuccess) {
      context.showSuccessSnackBar(
        message: S.current.accountCreatedSuccessFully,
      );
      // TODO: navigate to home once it exists.
      // context.navigateToAndClearStack(AppRoutes.home);
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
                title: S.current.signup,
                subtitle: S.current.signupSubtitle,
              ),
              SizedBox(height: 32.h),
              RegisterForm(
                formKey: _formKey,
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                nameFocusNode: _nameFocusNode,
                emailFocusNode: _emailFocusNode,
                passwordFocusNode: _passwordFocusNode,
                confirmPasswordFocusNode: _confirmPasswordFocusNode,
                termsAccepted: _termsAccepted,
                isLoading: state is AuthLoading,
                onSubmit: (RegisterParams params) =>
                    context.read<AuthCubit>().register(params),
              ),
              SizedBox(height: 24.h),
              AuthSwitchFooter(
                question: S.current.alreadyHaveAccount,
                actionLabel: S.current.login,
                onTap: () => context.navigateBack(),
              ),
            ],
          ),
        );
      },
    );
  }
}
