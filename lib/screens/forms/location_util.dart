
import 'package:geolocator/geolocator.dart';

class LocationUtils {
  Future<Position> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location denied again.Please turn on location');
    }
    return await Geolocator.getCurrentPosition();
  }

}
