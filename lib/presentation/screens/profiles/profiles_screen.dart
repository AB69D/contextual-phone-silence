import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/silence_profile.dart';
import '../../theme/app_theme.dart';
import 'profiles_viewmodel.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<ProfilesViewModel>().loadProfiles());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfilesViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profiles')),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: vm.profiles.length + 1,
              itemBuilder: (context, i) {
                if (i == vm.profiles.length) {
                  return _AddCard(
                      onTap: () => _showAddDialog(context, vm));
                }
                final p = vm.profiles[i];
                return _ProfileCard(
                  profile: p,
                  onTap: () => vm.activateProfile(p.id!),
                  onDelete: () => _confirmDelete(context, vm, p),
                );
              },
            ),
    );
  }

  void _showAddDialog(BuildContext ctx, ProfilesViewModel vm) {
    final ctrl = TextEditingController();
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('New Profile'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(labelText: 'Profile name'),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                vm.createProfile(SilenceProfile(
                  name: ctrl.text.trim(),
                  icon: Icons.work_outlined.codePoint,
                  color: AppColors.primary.value,
                ));
                Navigator.pop(ctx);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
      BuildContext ctx, ProfilesViewModel vm, SilenceProfile p) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text('Delete "${p.name}"?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              vm.deleteProfile(p.id!);
              Navigator.pop(ctx);
            },
            style: TextButton.styleFrom(
                foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.profile,
    required this.onTap,
    required this.onDelete,
  });

  final SilenceProfile profile;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final color = Color(profile.color);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: profile.isActive ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onDelete,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                IconData(profile.icon, fontFamily: 'MaterialIcons'),
                color: color,
                size: 32,
              ),
              const Spacer(),
              Text(profile.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15)),
              if (profile.isActive) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Active',
                      style: TextStyle(
                          fontSize: 11,
                          color: color,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AddCard extends StatelessWidget {
  const _AddCard({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: AppColors.onSurfaceVariant.withOpacity(0.4),
              width: 1.5),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: AppColors.onSurfaceVariant),
              SizedBox(height: 8),
              Text('Add Profile',
                  style: TextStyle(
                      color: AppColors.onSurfaceVariant, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
