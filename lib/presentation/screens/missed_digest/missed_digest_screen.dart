import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/missed_notification.dart';
import '../../theme/app_theme.dart';
import 'missed_digest_viewmodel.dart';

class MissedDigestScreen extends StatelessWidget {
  const MissedDigestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MissedDigestViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Missed Digest'),
        actions: [
          if (vm.notifications.isNotEmpty)
            TextButton(
              onPressed: vm.markAllHandled,
              child: const Text('Mark all handled'),
            ),
        ],
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.notifications.isEmpty
              ? const _EmptyView()
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (vm.calls.isNotEmpty) ...[
                      _Label('Missed Calls (${vm.calls.length})'),
                      ...vm.calls.map((n) => _NotifTile(notif: n)),
                      const SizedBox(height: 16),
                    ],
                    if (vm.messages.isNotEmpty) ...[
                      _Label('Messages (${vm.messages.length})'),
                      ...vm.messages.map((n) => _NotifTile(notif: n)),
                    ],
                  ],
                ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  const _NotifTile({required this.notif});
  final MissedNotification notif;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          notif.category == NotificationCategory.call
              ? Icons.call_missed
              : Icons.message_outlined,
          color: AppColors.primary,
        ),
        title: Text(notif.displayName,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: notif.preview != null
            ? Text(notif.preview!,
                maxLines: 1, overflow: TextOverflow.ellipsis)
            : null,
        trailing: notif.category == NotificationCategory.call
            ? IconButton(
                icon: const Icon(Icons.call_outlined),
                tooltip: 'Call back',
                onPressed: () =>
                    _launch('tel:${notif.appPackageName}'),
              )
            : IconButton(
                icon: const Icon(Icons.reply_outlined),
                tooltip: 'Reply',
                onPressed: () =>
                    _launch('sms:${notif.appPackageName}'),
              ),
      ),
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
              letterSpacing: 0.5)),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline,
              size: 64, color: AppColors.tertiary),
          SizedBox(height: 16),
          Text('No missed notifications',
              style: TextStyle(
                  color: AppColors.onSurfaceVariant, fontSize: 16)),
        ],
      ),
    );
  }
}
