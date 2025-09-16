import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../features/auth/bloc/auth_bloc.dart';
import '../../../../features/auth/bloc/auth_event.dart';
import '../../../../features/auth/bloc/auth_state.dart';
import '../../../../shared/exceptions/handled_exception.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/handled_exception_snackbar_overlay.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, BaseState<AuthUser>>(
      listener: (context, state) {
        if (state is AuthError) {
          HandledExceptionSnackbarOverlay.show(HandledException(state.message));
        }
      },
      child: const HandledExceptionSnackbarOverlay(child: _LoginScaffold()),
    );
  }
}

class _LoginScaffold extends HookWidget {
  const _LoginScaffold();

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);
    final isValid = useState(false);

    void validate() {
      final username = usernameController.text.trim();
      final password = passwordController.text;
      final usernameOk = username.isNotEmpty;
      final passwordOk = password.length >= 6;
      isValid.value = usernameOk && passwordOk;
    }

    useEffect(() {
      validate();
      return null;
    }, const []);

    useEffect(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
      );
      return null;
    }, const []);

    useEffect(() {
      void listener() => validate();
      usernameController.addListener(listener);
      passwordController.addListener(listener);
      return () {
        usernameController.removeListener(listener);
        passwordController.removeListener(listener);
      };
    }, [usernameController, passwordController]);

    Future<void> handleLogin() async {
      if (isLoading.value) return;

      final username = usernameController.text.trim();
      final password = passwordController.text;

      if (username.isEmpty || password.isEmpty) {
        HandledExceptionSnackbarOverlay.show(
          HandledException(
            'Please fill in both username and password to continue',
          ),
        );
        return;
      }

      isLoading.value = true;
      try {
        final bloc = context.read<AuthBloc>();
        bloc.add(AuthLoginRequested(email: username, password: password));
      } finally {
        isLoading.value = false;
      }
    }

    Widget buildHeader() {
      return Padding(
        padding: EdgeInsets.only(
          top: 32 + MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,
          bottom: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [AppColors.leafGreen, AppColors.treeBrown],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(Icons.eco, color: AppColors.textOnBrown, size: 40),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'NoteToGoal',
              textAlign: TextAlign.center,
              style: AppTypography.headlineSmall.copyWith(
                color: AppColors.treeBrown,
                fontWeight: AppTypography.bold,
                fontSize: 36,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Transform your notes into achievements',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.treeBrown.withOpacity(0.6),
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildFormCard() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            AppTextField(
              hint: 'Username',
              controller: usernameController,
              type: AppTextFieldType.text,
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.person,
              prefixIconColor: AppColors.neutralDarkGray,
              validator: (value) {
                if (value.trim().isEmpty) return 'Username is required';
                return null;
              },
              autofillHints: const [AutofillHints.username],
              backgroundColor: Colors.white,
              borderRadius: 16,
              borderColor: Colors.transparent,
              focusedBorderColor: Colors.transparent,
              errorColor: AppColors.accentError,
              borderWidth: 0,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
              semanticLabel: 'Username input field',
            ),
            const SizedBox(height: 16),
            AppTextField(
              hint: 'Password',
              controller: passwordController,
              type: AppTextFieldType.password,
              textInputAction: TextInputAction.done,
              prefixIcon: Icons.lock,
              prefixIconColor: AppColors.neutralDarkGray,
              suffixIconColor: AppColors.neutralDarkGray,
              onSubmitted: (_) => handleLogin(),
              validator: (value) {
                if (value.isEmpty) return 'Password is required';
                if (value.length < 6) return 'Minimum 6 characters';
                return null;
              },
              autofillHints: const [AutofillHints.password],
              backgroundColor: Colors.white,
              borderRadius: 16,
              borderColor: Colors.transparent,
              focusedBorderColor: Colors.transparent,
              errorColor: AppColors.accentError,
              borderWidth: 0,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
              semanticLabel: 'Password input field',
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.leafGreen,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    leadingIcon: Icons.login,
                    text: '  Log In',
                    onPressed: isValid.value ? handleLogin : null,
                    isLoading: isLoading.value,
                    semanticLabel: 'Log in button',
                    elevation: 8,
                    borderRadius: 28,
                    backgroundGradient: const LinearGradient(
                      colors: [AppColors.leafGreen, AppColors.primaryBrown],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    size: AppButtonSize.large,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.warmYellow,
                AppColors.softCream,
                AppColors.leafGreen,
              ],
              stops: [0.0, 0.5, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildHeader(),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: Stack(children: [buildFormCard()]),
                      ),
                    ),
                    const SizedBox(height: 56),
                    const SizedBox(height: 40),
                    buildTreeDecoration(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTreeDecoration() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Opacity(
        opacity: 0.4,
        child: Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                'https://storage.googleapis.com/uxpilot-auth.appspot.com/7f92239b55-3f9634816c4e2de38030.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
