import 'dart:convert';
import 'dart:io'; // Required for Platform checks

import 'package:device_info_plus/device_info_plus.dart'; // Ensure this package is in your pubspec.yaml

/// Gathers device information based on the platform and returns it as a JSON string.
/// This function is designed to be used for attaching device data to HTTP headers
/// or request bodies.
Future<String> attachDeviceInfoToHeaders() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Map<String, dynamic> deviceData = {};

  try {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo info = await deviceInfo.androidInfo;
      deviceData = {
        'platform': 'android',
        'model': info.model,
        'manufacturer': info.manufacturer,
        'name': info.device, // Often the device codename
        'os_version': info.version.release,
        'identifier': info.id, // A unique ID for the device's build
      };
    } else if (Platform.isIOS) {
      final IosDeviceInfo info = await deviceInfo.iosInfo;
      deviceData = {
        'platform': 'ios',
        'model': info.utsname.machine, // e.g., "iPhone13,4"
        'manufacturer': 'Apple',
        'name': info.name, // The user-assigned device name (e.g., "My iPhone")
        'os_version': info.systemVersion,
        'identifier': info
            .identifierForVendor, // Persistent unique ID for the app's vendor
      };
    } else if (Platform.isWindows) {
      final WindowsDeviceInfo info = await deviceInfo.windowsInfo;
      deviceData = {
        'platform': 'windows',
        'name': info.computerName,
        'os_build_number': info.buildNumber,
        'os_release_id': info.releaseId,
        'model': info.productName, // e.g., "Windows 10 Pro"
        'os_version': info.displayVersion, // e.g., "22H2"
        'identifier': info.deviceId, // A unique ID for the Windows device
      };
    } else if (Platform.isLinux) {
      final LinuxDeviceInfo info = await deviceInfo.linuxInfo;
      deviceData = {
        'platform': 'linux',
        'name': info.name, // e.g., "Ubuntu"
        'version': info.version, // e.g., "20.04 LTS (Focal Fossa)"
        'id': info.id, // e.g., "ubuntu"
        'pretty_name': info.prettyName, // e.g., "Ubuntu 20.04 LTS"
        'build_id': info.buildId,
        'identifier': info.machineId, // A unique ID for the Linux machine
      };
    } else if (Platform.isMacOS) {
      final MacOsDeviceInfo info = await deviceInfo.macOsInfo;
      deviceData = {
        'platform': 'macos',
        'computer_name': info.computerName,
        'model': info.model, // e.g., "MacBookPro16,1"
        'os_release': info.osRelease, // e.g., "11.2.3"
        'arch': info.arch, // e.g., "arm64" or "x86_64"
        'kernel_version': info.kernelVersion,
        'identifier': info.systemGUID, // A unique GUID for the macOS system
      };
    } else if (Platform.isFuchsia) {
      // Fuchsia is typically for embedded systems, less common for general apps
      // DeviceInfoPlus might not provide specific Fuchsia info yet,
      // or it might be very basic.
      // You'd need to check the package's capabilities for Fuchsia.
      deviceData = {
        'platform': 'fuchsia',
        'error':
            'Fuchsia details not fully implemented or available via device_info_plus.',
      };
    } else {
      // Fallback for any other unsupported or unknown platform
      deviceData = {
        'platform': 'unknown',
        'model': '',
        'manufacturer': '',
        'name': '',
        'os_version': '',
        'identifier': '',
      };
    }
  } catch (e) {
    // Catch any errors during device info retrieval (e.g., permissions issues)
    // and include the error message in the device data.
    deviceData = {
      'platform': 'error_retrieving_info',
      'error': e.toString(),
    };
  }

  // Encode the map to a JSON string
  return jsonEncode(deviceData);
}
