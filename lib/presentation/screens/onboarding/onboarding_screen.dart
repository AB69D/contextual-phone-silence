import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../router/app_router.dart';
import 'onboarding_viewmodel.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.step});
  final int step;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<OnboardingViewModel>().checkPermissions());
  }

  void _next() {
    final nextStep = widget.step + 1;
    if (nextStep < 5) {
      context.go('/onboarding/$nextStep');
    } else {
      context.read<OnboardingViewModel>().completeOnboarding().then((_) {
        if (mounted) context.go(AppRoutes.home);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.step > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/onboarding/${widget.step - 1}'),
              )
            : null,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(child: _buildStep(widget.step)),
    );
  }

  Widget _buildStep(int step) => switch (step) {
        0 => _WelcomeStep(onNext: _next),
        1 => _DndStep(onNext: _next),
        2 => _CalendarStep(onNext: _next),
        3 => _BatteryStep(onNext: _next),
        _ => _DoneStep(onDone: _next),
      };
}

// ── Step widgets ──────────────────────────────────────────────────────────────

class _WelcomeStep extends StatelessWidget {
  const _WelcomeStep({required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return _StepShell(
      icon: Icons.volume_off_rounded,
      iconColor: AppColors.primary,
      title: 'Your phone silences itself.',
      body:
          'Contextual Silence reads your calendar and silences your phone at the exact start of every meeting — then restores it the moment it ends. No tapping. No forgetting.',
      primaryLabel: 'Get started',
      onPrimary: onNext,
    );
  }
}

class _DndStep extends StatelessWidget {
  const _DndStep({required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return _StepShell(
      icon: Icons.do_not_disturb_on_outlined,
      iconColor: AppColors.primary,
      title: 'Allow Do Not Disturb',
      body:
          'Contextual Silence needs permission to control Do Not Disturb so it can silence your phone during meetings.',
      primaryLabel: 'Open DND Settings',
      onPrimary: () async {
        await context.read<OnboardingViewModel>().openDndSettings();
        onNext();
      },
      secondaryLabel: 'Skip for now',
      onSecondary: onNext,
    );
  }
}

class _CalendarStep extends StatelessWidget {
  const _CalendarStep({required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return _StepShell(
      icon: Icons.calendar_today_outlined,
      iconColor: AppColors.primary,
      title: 'Connect your calendar',
      body:
          'Contextual Silence reads your calendar to know when meetings start and end. Your calendar data never leaves your device.',
      primaryLabel: 'Allow Calendar Access',
      onPrimary: () async {
        await context.read<OnboardingViewModel>().grantCalendarPermission();
        onNext();
      },
      secondaryLabel: 'Skip for now',
      onSecondary: onNext,
    );
  }
}

class _BatteryStep extends StatelessWidget {
  const _BatteryStep({required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OnboardingViewModel>();
    final hasOem = vm.permissionStatus['hasOemSpecificSteps'] == true;

    if (!hasOem) {
      WidgetsBinding.instance.addPostFrameCallback((_) => onNext());
      return const SizedBox.shrink();
    }

    return _StepShell(
      icon: Icons.battery_charging_full_outlined,
      iconColor: AppColors.tertiary,
      title: 'One more step for reliability',
      body:
          'Your phone manufacturer may stop apps from running in the background. Whitelist this app to ensure alarms fire on time.',
      primaryLabel: 'Open Battery Settings',
      onPrimary: () async {
        await vm.permissionDataSource.openBatteryOptimizationSettings();
        onNext();
      },
      secondaryLabel: "I'll do this later",
      onSecondary: onNext,
    );
  }
}

class _DoneStep extends StatelessWidget {
  const _DoneStep({required this.onDone});
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return _StepShell(
      icon: Icons.check_circle_outline_rounded,
      iconColor: AppColors.tertiary,
      title: "You're all set!",
      body:
          'Your phone will now silence itself during meetings automatically.',
      primaryLabel: 'Go to Home',
      onPrimary: onDone,
    );
  }
}

// ── Shared shell ──────────────────────────────────────────────────────────────

class _StepShell extends StatelessWidget {
  const _StepShell({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Icon(icon, size: 64, color: iconColor),
          const SizedBox(height: 24),
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(body,
              style: const TextStyle(
                  color: AppColors.onSurfaceVariant, fontSize: 16)),
          const Spacer(),
          FilledButton(
            onPressed: onPrimary,
            child: Text(primaryLabel),
          ),
          if (secondaryLabel != null) ...[
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: onSecondary,
                child: Text(secondaryLabel!),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
