import 'dart:io';

Future<String> getLocalIPv4Address() async {
  String ipaddress = "192.168.0.192";
  // try {
  //   final interfaces = await NetworkInterface.list(
  //       includeLoopback: false, type: InternetAddressType.IPv4);
  //   for (var interface in interfaces) {
  //     for (var addr in interface.addresses) {
  //       if (!addr.isLoopback) {
  //         return addr.address;
  //       }
  //     }
  //   }
  // } on SocketException catch (e) {
  //   print('Error getting local IPv4 address: $e');
  // }

  return ipaddress;
}
