import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermissions() async {
  final List<Permission> permissionsToRequest = [
    Permission.notification,
    Permission.storage,
  ];

  Map<Permission, PermissionStatus> permissionStatuses = await _getPermissions(permissionsToRequest);

  bool allGranted = permissionStatuses.values.every((status) => status == PermissionStatus.granted);

  if (!allGranted) {
    permissionStatuses = await _requestPermissions(permissionsToRequest);
    allGranted = permissionStatuses.values.every((status) => status == PermissionStatus.granted);
  }

  return allGranted;
}

Future<Map<Permission, PermissionStatus>> _getPermissions(List<Permission> permissions) async {
  final Map<Permission, PermissionStatus> permissionStatuses = {};
  for (final permission in permissions) {
    final PermissionStatus status = await permission.status;
    permissionStatuses[permission] = status;
  }
  return permissionStatuses;
}

Future<Map<Permission, PermissionStatus>> _requestPermissions(List<Permission> permissions) async {
  final Map<Permission, PermissionStatus> permissionStatuses = {};
  for (final permission in permissions) {
    final PermissionStatus status = await permission.request();
    permissionStatuses[permission] = status;
  }
  return permissionStatuses;
}