import '../../../core/base/base_viewmodel.dart';
import '../../../data/datasources/permission_data_source.dart';
import '../../../domain/usecases/audio/request_dnd_permission_usecase.dart';
import '../../../domain/usecases/calendar/request_calendar_permission_usecase.dart';

class PermissionsViewModel extends BaseViewModel {
  PermissionsViewModel({
    required this.requestCalendar,
    required this.requestDnd,
    required this.permissionDataSource,
  });

  final RequestCalendarPermissionUseCase requestCalendar;
  final RequestDndPermissionUseCase requestDnd;
  final PermissionDataSource permissionDataSource;

  Map<String, dynamic> _status = {};
  List<Map<String, dynamic>> _oemSteps = [];

  Map<String, dynamic> get status => _status;
  List<Map<String, dynamic>> get oemSteps => _oemSteps;
  bool get hasOemSteps => _oemSteps.isNotEmpty;

  Future<void> checkAll() async {
    _status = await permissionDataSource.checkAll();
    if (_status['hasOemSpecificSteps'] == true) {
      _oemSteps = await permissionDataSource.getOemBatterySteps();
    }
    notifyListeners();
  }

  Future<void> grantCalendar() async {
    await requestCalendar();
    await checkAll();
  }

  Future<void> openDnd() => permissionDataSource.openDndSettings();

  Future<void> openBatterySettings() =>
      permissionDataSource.openBatteryOptimizationSettings();

  Future<void> launchOemStep(int index) =>
      permissionDataSource.launchOemBatteryStep(index);
}
