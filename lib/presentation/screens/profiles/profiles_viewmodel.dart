import 'package:drift/drift.dart';
import '../../../core/base/base_viewmodel.dart';
import '../../../data/database/app_database.dart' as db;
import '../../../domain/entities/silence_profile.dart';

class ProfilesViewModel extends BaseViewModel {
  ProfilesViewModel({required this.database});
  final db.AppDatabase database;

  List<SilenceProfile> _profiles = [];
  List<SilenceProfile> get profiles => _profiles;

  Future<void> loadProfiles() async {
    setLoading(true);
    final rows = await database.getAllProfiles();
    _profiles = rows
        .map((r) => SilenceProfile(
              id: r.id,
              name: r.name,
              icon: r.icon,
              color: r.color,
              isActive: r.isActive,
            ))
        .toList();
    setLoading(false);
  }

  Future<void> activateProfile(int id) async {
    await database.activateProfile(id);
    await loadProfiles();
  }

  Future<void> createProfile(SilenceProfile profile) async {
    await database.insertProfile(db.SilenceProfilesCompanion(
      name: Value(profile.name),
      icon: Value(profile.icon),
      color: Value(profile.color),
    ));
    await loadProfiles();
  }

  Future<void> deleteProfile(int id) async {
    await database.deleteProfile(id);
    await loadProfiles();
  }
}
