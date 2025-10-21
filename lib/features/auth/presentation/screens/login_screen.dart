import 'package:cached_network_image/cached_network_image.dart';
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
  const LoginScreen({super.key, this.isAuthLoading = false});

  final bool isAuthLoading;

  @override
  Widget build(BuildContext context) {
    return HandledExceptionSnackbarOverlay(
      child: _LoginScaffold(isAuthLoading: isAuthLoading),
    );
  }
}

class _LoginScaffold extends HookWidget {
  const _LoginScaffold({required this.isAuthLoading});

  final bool isAuthLoading;

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isValid = useState(false);
    final isSubmitting = useState(false);

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
          systemNavigationBarIconBrightness: Brightness.light,
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
      if (isSubmitting.value) return;

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

      final bloc = context.read<AuthBloc>();
      isSubmitting.value = true;
      bloc.add(AuthLoginRequested(email: username, password: password));
    }

    Widget buildHeader() {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

      // Responsive sizing
      final logoSize = keyboardVisible
          ? 60.0
          : (screenHeight < 600 ? 72.0 : 96.0);
      final titleFontSize = screenWidth < 400
          ? 28.0
          : (keyboardVisible ? 24.0 : 36.0);
      final subtitleFontSize = screenWidth < 400 ? 14.0 : 16.0;
      final topPadding = keyboardVisible
          ? 16.0
          : (32.0 + MediaQuery.of(context).padding.top);

      return Padding(
        padding: EdgeInsets.only(
          top: topPadding,
          left: 16,
          right: 16,
          bottom: keyboardVisible ? 4 : 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: logoSize,
              height: logoSize,
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
              child: Center(
                child: Icon(
                  Icons.eco,
                  color: AppColors.textOnBrown,
                  size: logoSize * 0.42,
                ),
              ),
            ),
            SizedBox(height: keyboardVisible ? 8 : 16),
            Text(
              'NoteToGoal',
              textAlign: TextAlign.center,
              style: AppTypography.headlineSmall.copyWith(
                color: AppColors.treeBrown,
                fontWeight: AppTypography.bold,
                fontSize: titleFontSize,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (!keyboardVisible) ...[
              const SizedBox(height: 6),
              Text(
                'Transform your notes into achievements',
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.treeBrown.withValues(alpha: 0.6),
                  fontSize: subtitleFontSize,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      );
    }

    Widget buildFormCard() {
      final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
      final formPadding = keyboardVisible ? 16.0 : 20.0;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: formPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: keyboardVisible ? 8 : 12),
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
            SizedBox(height: keyboardVisible ? 16 : 24),
            if (!keyboardVisible) ...[
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
            ],
            SizedBox(
              width: double.infinity,
              child: AppButton(
                leadingIcon: Icons.login,
                text: 'Log In',
                onPressed: (isValid.value && !isSubmitting.value)
                    ? handleLogin
                    : null,
                isLoading: isSubmitting.value,
                semanticLabel: 'Log in button',
                elevation: 8,
                borderRadius: 28,
                foregroundColor: AppColors.textOnBrown,
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
      );
    }

    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - keyboardInset;

    return BlocListener<AuthBloc, BaseState<AuthUser>>(
      listener: (context, state) {
        if (state is! AuthLoading) {
          isSubmitting.value = false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
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
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        availableHeight -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildHeader(),
                      const SizedBox(height: 20),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: buildFormCard(),
                        ),
                      ),
                      if (keyboardInset == 0) ...[
                        const SizedBox(height: 40),
                        buildTreeDecoration(),
                        const SizedBox(height: 20),
                      ] else
                        const SizedBox(height: 20),
                    ],
                  ),
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
      margin: const EdgeInsets.only(top: 20),
      child: Opacity(
        opacity: 0.4,
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl:
                  'https://storage.googleapis.com/uxpilot-auth.appspot.com/7f92239b55-3f9634816c4e2de38030.png',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.neutralLightGray,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.leafGreen,
                    strokeWidth: 2,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.neutralLightGray,
                child: const Icon(
                  Icons.eco,
                  color: AppColors.leafGreen,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
