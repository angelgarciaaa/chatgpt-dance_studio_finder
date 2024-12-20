import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/dance_studio.dart';

class InfoStudioPage extends StatelessWidget {
  final DanceStudio studio;

  InfoStudioPage({required this.studio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(studio.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Name: ${studio.name}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Address: ${studio.fullAddress}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Description: ${studio.description}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Dance Styles: ${studio.danceStyles.join(', ')}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 300, // Ajusta la altura del mapa
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(studio.latitude, studio.longitude),
                  zoom: 15, // Zoom más cercano
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(studio.id.toString()),
                    position: LatLng(studio.latitude, studio.longitude),
                    infoWindow: InfoWindow(
                      title: studio.name,
                      snippet: studio.address,
                    ),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
