import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../services/auth_service.dart';
import '../../../../shared/exceptions/handled_exception.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/handled_exception_snackbar_overlay.dart';

class LoginForm extends HookWidget {
  const LoginForm({super.key, this.onSuccess});

  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final isLoading = useState(false);
    final emailError = useState<String?>(null);
    final passwordError = useState<String?>(null);

    String? validateEmail(String value) {
      if (value.isEmpty) return 'Email is required';
      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
      return null;
    }

    String? validatePassword(String value) {
      if (value.isEmpty) return 'Password is required';
      if (value.length < 6) return 'At least 6 characters';
      return null;
    }

    Future<void> handleSubmit() async {
      if (isLoading.value) return;
      final emailValue = email.text.trim();
      final passwordValue = password.text;
      emailError.value = validateEmail(emailValue);
      passwordError.value = validatePassword(passwordValue);
      if (emailError.value != null || passwordError.value != null) return;
      isLoading.value = true;
      try {
        await AuthService.instance.login(
          email: emailValue,
          password: passwordValue,
        );
        isLoading.value = false;
        onSuccess?.call();
      } on HandledException catch (error) {
        isLoading.value = false;
        HandledExceptionSnackbarOverlay.show(error);
      } catch (error) {
        isLoading.value = false;
        HandledExceptionSnackbarOverlay.show(
          HandledException(error.toString()),
        );
      }
    }

    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Welcome back', style: AppTypography.headlineSmall),
          AppSpacing.verticalSpaceMedium,
          AppTextField(
            label: 'Email',
            hint: 'you@example.com',
            controller: email,
            type: AppTextFieldType.email,
            textInputAction: TextInputAction.next,
            validator: (value) => validateEmail(value),
            autofillHints: const [AutofillHints.email],
            prefixIcon: Icons.mail_outline,
            isLoading: false,
          ),
          if (emailError.value != null)
            Padding(
              padding: AppSpacing.inputErrorPadding,
              child: Text(emailError.value!, style: AppTypography.errorText),
            ),
          AppSpacing.verticalSpaceMedium,
          AppTextField(
            label: 'Password',
            hint: 'Your password',
            controller: password,
            type: AppTextFieldType.password,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => handleSubmit(),
            validator: (value) => validatePassword(value),
            autofillHints: const [AutofillHints.password],
            prefixIcon: Icons.lock_outline,
            isLoading: false,
          ),
          if (passwordError.value != null)
            Padding(
              padding: AppSpacing.inputErrorPadding,
              child: Text(passwordError.value!, style: AppTypography.errorText),
            ),
          AppSpacing.verticalSpaceLarge,
          AppButton(
            onPressed: handleSubmit,
            text: 'Log in',
            isLoading: isLoading.value,
            minimumSize: const Size.fromHeight(AppSpacing.touchTargetMinimum),
            semanticLabel: 'Log in to your account',
          ),
        ],
      ),
    );
  }
}
