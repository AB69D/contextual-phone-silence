import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/di/service_locator.dart';
import '../../theme/app_theme.dart';
import 'manual_silence_viewmodel.dart';

class ManualSilenceSheet extends StatelessWidget {
  const ManualSilenceSheet({super.key});

  static const _options = [
    (label: '15 min', d: Duration(minutes: 15)),
    (label: '30 min', d: Duration(minutes: 30)),
    (label: '1 hour', d: Duration(hours: 1)),
    (label: '2 hours', d: Duration(hours: 2)),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<ManualSilenceViewModel>(),
      child: Consumer<ManualSilenceViewModel>(
        builder: (ctx, vm, _) => DraggableScrollableSheet(
          initialChildSize: 0.45,
          minChildSize: 0.35,
          maxChildSize: 0.65,
          expand: false,
          builder: (_, controller) => Container(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.onSurfaceVariant.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  vm.isSilenced ? 'Phone is silenced' : 'Silence your phone',
                  style: Theme.of(ctx)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  vm.isSilenced && vm.endsAt != null
                      ? 'Ends at ${_fmtTime(vm.endsAt!)}'
                      : 'Choose a duration',
                  style: const TextStyle(
                      color: AppColors.onSurfaceVariant, fontSize: 14),
                ),
                const SizedBox(height: 20),
                if (!vm.isSilenced) ...[
                  Wrap(
                    spacing: 8,
                    children: _options
                        .map((o) => ChoiceChip(
                              label: Text(o.label),
                              selected: vm.selectedDuration == o.d,
                              onSelected: (_) => vm.selectDuration(o.d),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                ],
                vm.isSilenced
                    ? FilledButton.tonal(
                        onPressed: () async {
                          await vm.endManualSilence();
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: const Text('End silence now'),
                      )
                    : FilledButton(
                        onPressed: vm.isLoading
                            ? null
                            : () async {
                                await vm.startManualSilence();
                                if (!vm.hasError && ctx.mounted) {
                                  Navigator.pop(ctx);
                                }
                              },
                        child: vm.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white),
                              )
                            : const Text('Silence now'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _fmtTime(DateTime dt) {
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m ${dt.hour >= 12 ? 'PM' : 'AM'}';
  }
}
