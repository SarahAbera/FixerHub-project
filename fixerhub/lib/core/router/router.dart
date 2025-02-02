import 'package:go_router/go_router.dart';
import 'package:fixerhub/features/auth/presentation/screens/splash_screen.dart';
import 'package:fixerhub/features/auth/presentation/screens/welcome_screen.dart';
import 'package:fixerhub/features/auth/presentation/screens/register_role_screen.dart';
import 'package:fixerhub/features/auth/presentation/screens/client_registration_screen.dart';
import 'package:fixerhub/features/auth/presentation/screens/professional_registration_screen.dart';
import 'package:fixerhub/features/auth/presentation/screens/professional_verification_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/register-role',
      builder: (context, state) => const RegisterRoleScreen(),
    ),
    GoRoute(
      path: '/register-client',
      builder: (context, state) => const ClientRegistrationScreen(),
    ),
    GoRoute(
      path: '/register-professional',
      builder: (context, state) => const ProfessionalRegistrationScreen(),
    ),
    GoRoute(
      path: '/professional-verification',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return ProfessionalVerificationScreen(registrationData: extra);
      },
    ),
  ],
);
