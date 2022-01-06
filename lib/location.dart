import 'package:geolocator/geolocator.dart';

bool? enabled;
LocationPermission? permission;

Future<Position> whereAmI() async {
  enabled = await Geolocator.isLocationServiceEnabled();
  if (!enabled!) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }
  return await Geolocator.getCurrentPosition();
}
