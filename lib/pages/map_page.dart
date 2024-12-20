import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/dance_studios_data.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final markers = DanceStudiosData.studios.map((studio) {
      return Marker(
        markerId: MarkerId(studio.id.toString()),
        position: LatLng(studio.latitude, studio.longitude),
        infoWindow: InfoWindow(
          title: studio.name,
          snippet: studio.address,
        ),
      );
    }).toSet();

    return Scaffold(
      appBar: AppBar(title: Text("Full Map View")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(60.1695, 24.9354),
          zoom: 14,
        ),
        markers: markers,
      ),
    );
  }
}
