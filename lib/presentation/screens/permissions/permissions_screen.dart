import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import 'permissions_viewmodel.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<PermissionsViewModel>().checkAll());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      context.read<PermissionsViewModel>().checkAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PermissionsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Permissions')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _PermTile(
            icon: Icons.do_not_disturb_on_outlined,
            title: 'Do Not Disturb',
            description:
                'Required to silence your phone completely during meetings.',
            granted: vm.status['dndAccess'] as bool? ?? false,
            onGrant: vm.openDnd,
          ),
          _PermTile(
            icon: Icons.calendar_today_outlined,
            title: 'Calendar',
            description:
                'Read your calendar to detect upcoming meetings.',
            granted: vm.status['calendarRead'] as bool? ?? false,
            onGrant: vm.grantCalendar,
          ),
          _PermTile(
            icon: Icons.alarm_outlined,
            title: 'Exact Alarms',
            description:
                'Required to fire at the exact start/end of each event.',
            granted: vm.status['exactAlarm'] as bool? ?? false,
            onGrant: () =>
                vm.permissionDataSource.openExactAlarmSettings(),
          ),
          _PermTile(
            icon: Icons.battery_full_outlined,
            title: 'Battery Optimization',
            description:
                'Prevent Android from delaying or killing alarms.',
            granted:
                vm.status['batteryOptimizationExcluded'] as bool? ?? false,
            onGrant: vm.openBatterySettings,
          ),
          if (vm.hasOemSteps) ...[
            const SizedBox(height: 16),
            const Text('Manufacturer Steps',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurfaceVariant,
                    fontSize: 12,
                    letterSpacing: 0.5)),
            const SizedBox(height: 8),
            ...vm.oemSteps.asMap().entries.map((e) => _OemTile(
                  step: e.value,
                  onTap: () => vm.launchOemStep(e.key),
                )),
          ],
        ],
      ),
    );
  }
}

class _PermTile extends StatelessWidget {
  const _PermTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.granted,
    required this.onGrant,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool granted;
  final VoidCallback onGrant;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon,
            color: granted
                ? AppColors.tertiary
                : AppColors.onSurfaceVariant),
        title: Text(title),
        subtitle: Text(description,
            style: const TextStyle(
                color: AppColors.onSurfaceVariant, fontSize: 12)),
        trailing: granted
            ? const Icon(Icons.check_circle_rounded,
                color: AppColors.tertiary)
            : FilledButton.tonal(
                onPressed: onGrant,
                child: const Text('Grant'),
              ),
      ),
    );
  }
}

class _OemTile extends StatelessWidget {
  const _OemTile({required this.step, required this.onTap});
  final Map<String, dynamic> step;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.15),
          child: Text('${(step['stepIndex'] as int) + 1}',
              style: const TextStyle(color: AppColors.primary)),
        ),
        title: Text(step['label'] as String),
        subtitle: Text(step['instructions'] as String,
            style: const TextStyle(
                color: AppColors.onSurfaceVariant, fontSize: 12)),
        trailing:
            const Icon(Icons.open_in_new, size: 16),
        onTap: onTap,
      ),
    );
  }
}
