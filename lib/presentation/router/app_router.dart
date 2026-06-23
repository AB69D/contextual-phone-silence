import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/di/service_locator.dart';

// Screen imports — these will be created in the screens phase
// Using forward declarations to avoid circular imports
import '../screens/splash/splash_screen.dart';
import '../screens/splash/splash_viewmodel.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/onboarding/onboarding_viewmodel.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/home_viewmodel.dart';
import '../screens/profiles/profiles_screen.dart';
import '../screens/profiles/profiles_viewmodel.dart';
import '../screens/history/history_screen.dart';
import '../screens/history/history_viewmodel.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/settings_viewmodel.dart';
import '../screens/permissions/permissions_screen.dart';
import '../screens/permissions/permissions_viewmodel.dart';
import '../screens/missed_digest/missed_digest_screen.dart';
import '../screens/missed_digest/missed_digest_viewmodel.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding/:step';
  static const home = '/home';
  static const profiles = '/profiles';
  static const history = '/history';
  static const settings = '/settings';
  static const permissions = '/permissions';
  static const missedDigest = '/digest';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => sl<SplashViewModel>(),
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/onboarding/:step',
      builder: (_, state) => ChangeNotifierProvider(
        create: (_) => sl<OnboardingViewModel>(),
        child: OnboardingScreen(
            step: int.tryParse(
                    state.pathParameters['step'] ?? '0') ??
                0),
      ),
    ),
    ShellRoute(
      builder: (_, __, child) => _MainShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (_, __) => ChangeNotifierProvider(
            create: (_) => sl<HomeViewModel>(),
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.profiles,
          builder: (_, __) => ChangeNotifierProvider(
            create: (_) => sl<ProfilesViewModel>(),
            child: const ProfilesScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.history,
          builder: (_, __) => ChangeNotifierProvider(
            create: (_) => sl<HistoryViewModel>(),
            child: const HistoryScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (_, __) => ChangeNotifierProvider(
            create: (_) => sl<SettingsViewModel>(),
            child: const SettingsScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.permissions,
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => sl<PermissionsViewModel>(),
        child: const PermissionsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.missedDigest,
      builder: (_, state) {
        final sessionId =
            int.tryParse(state.uri.queryParameters['sessionId'] ?? '0') ?? 0;
        return ChangeNotifierProvider(
          create: (_) => sl<MissedDigestViewModel>()..load(sessionId),
          child: const MissedDigestScreen(),
        );
      },
    ),
  ],
);

class _MainShell extends StatefulWidget {
  const _MainShell({required this.child});
  final Widget child;

  @override
  State<_MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<_MainShell> {
  int _selectedIndex = 0;

  static const _destinations = [
    (route: AppRoutes.home, icon: Icons.home_outlined, label: 'Home'),
    (route: AppRoutes.profiles, icon: Icons.tune_outlined, label: 'Profiles'),
    (route: AppRoutes.history, icon: Icons.history_outlined, label: 'History'),
    (route: AppRoutes.settings, icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) {
          setState(() => _selectedIndex = i);
          context.go(_destinations[i].route);
        },
        destinations: _destinations
            .map((d) => NavigationDestination(
                  icon: Icon(d.icon),
                  label: d.label,
                ))
            .toList(),
      ),
    );
  }
}
