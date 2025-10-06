import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:note_to_goal/core/bloc/base_state.dart';
import 'package:note_to_goal/features/auth/bloc/auth_bloc.dart';
import 'package:note_to_goal/features/auth/bloc/auth_event.dart';
import 'package:note_to_goal/features/auth/bloc/auth_state.dart';
import 'package:note_to_goal/features/auth/presentation/screens/login_screen.dart';
import 'package:note_to_goal/shared/exceptions/handled_exception.dart';
import 'package:note_to_goal/shared/widgets/handled_exception_snackbar_overlay.dart';
import 'package:note_to_goal/shared/widgets/main_shell.dart';

class AuthWrapper extends HookWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return HandledExceptionSnackbarOverlay(
      child: BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(),
        child: const _AuthGate(),
      ),
    );
  }
}

class _AuthGate extends HookWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    useEffect(() {
      bloc.add(const AuthSessionCheckRequested());
      return null;
    }, const []);

    return BlocConsumer<AuthBloc, BaseState<AuthUser>>(
      listener: (context, state) {
        if (state is AuthError) {
          HandledExceptionSnackbarOverlay.show(HandledException(state.message));
        }
      },
      builder: (context, state) {
        final route = ModalRoute.of(context);
        final isDev = true;
        final isAccountFlow = route?.settings.name == '/account';

        if (state is AuthAuthenticated) {
          return const MainShell();
        }
        if (isDev && isAccountFlow) {
          return const MainShell();
        }
        return LoginScreen(isAuthLoading: state is AuthLoading);
      },
    );
  }
}
