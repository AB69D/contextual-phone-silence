import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/error_banner.dart';
import 'settings_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<SettingsViewModel>().load());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      context.read<SettingsViewModel>().load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SettingsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                if (vm.hasError)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ErrorBanner(message: vm.error!.message),
                  ),
                _HealthCard(vm: vm),
                const Divider(height: 1),
                _Section(title: 'Automation', children: [
                  SwitchListTile(
                    title: const Text('Auto-silence'),
                    subtitle: const Text(
                        'Silence phone based on calendar events'),
                    value: vm.autoSilenceEnabled,
                    onChanged: vm.setAutoSilence,
                  ),
                  SwitchListTile(
                    title: const Text('Auto-restore'),
                    subtitle: const Text(
                        'Restore phone settings after session ends'),
                    value: vm.autoRestoreEnabled,
                    onChanged: vm.setAutoRestore,
                  ),
                ]),
                const Divider(height: 1),
                _Section(title: 'Notifications', children: [
                  SwitchListTile(
                    title: const Text('Missed Digest'),
                    subtitle: const Text(
                        'Show missed calls/messages after each session'),
                    value: vm.missedDigestEnabled,
                    onChanged: vm.setMissedDigest,
                  ),
                ]),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Pending alarms: ${vm.pendingAlarmCount}',
                    style: const TextStyle(
                        color: AppColors.onSurfaceVariant, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
    );
  }
}

class _HealthCard extends StatelessWidget {
  const _HealthCard({required this.vm});
  final SettingsViewModel vm;

  @override
  Widget build(BuildContext context) {
    final healthy = vm.serviceHealthy;
    final s = vm.permissionStatus;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    healthy
                        ? Icons.check_circle_outline_rounded
                        : Icons.warning_amber_rounded,
                    color:
                        healthy ? AppColors.tertiary : AppColors.error,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    healthy ? 'Service healthy' : 'Action required',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: healthy
                            ? AppColors.tertiary
                            : AppColors.error),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _PermRow('Do Not Disturb',
                  s['dndAccess'] as bool? ?? false),
              _PermRow(
                  'Exact Alarms', s['exactAlarm'] as bool? ?? false),
              _PermRow('Battery Optimized',
                  s['batteryOptimizationExcluded'] as bool? ?? false),
              if (!healthy) ...[
                const SizedBox(height: 12),
                FilledButton.tonal(
                  onPressed: () => vm.permissionDataSource
                      .openAppSettings(),
                  child: const Text('Open Settings'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PermRow extends StatelessWidget {
  const _PermRow(this.label, this.ok);
  final String label;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(ok ? Icons.check : Icons.close,
              size: 16,
              color: ok ? AppColors.tertiary : AppColors.error),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  color: AppColors.onSurfaceVariant, fontSize: 13)),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(title.toUpperCase(),
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 1)),
        ),
        ...children,
      ],
    );
  }
}
