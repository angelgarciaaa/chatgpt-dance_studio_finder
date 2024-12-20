import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/dance_studios_data.dart';
import '../models/dance_studio.dart';
import '../pages/info_studio_page.dart';
import '../widgets/filters_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";
  List<DanceStudio> filteredStudios = DanceStudiosData.studios;
  Set<Marker> markers = {};
  List<String> selectedStyles = [];

  @override
  void initState() {
    super.initState();
    _updateMarkers();
  }

  void _updateMarkers() {
    markers = filteredStudios.map((studio) {
      return Marker(
        markerId: MarkerId(studio.id.toString()),
        position: LatLng(studio.latitude, studio.longitude),
        infoWindow: InfoWindow(
          title: studio.name,
          snippet: studio.address,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoStudioPage(studio: studio)),
            );
          },
        ),
      );
    }).toSet();
  }

  void _filterStudios(String query) {
    setState(() {
      searchQuery = query;
      filteredStudios = DanceStudiosData.studios.where((studio) {
        bool matchesQuery = studio.name.toLowerCase().contains(query.toLowerCase()) ||
            studio.description.toLowerCase().contains(query.toLowerCase());
        bool matchesStyle = selectedStyles.isEmpty ||
            studio.danceStyles.any((style) => selectedStyles.contains(style));
        return matchesQuery && matchesStyle;
      }).toList();
      _updateMarkers();
    });
  }

  void _showFilterDialog() {
    List<String> allStyles = DanceStudiosData.studios
        .expand((s) => s.danceStyles as List<String>)
        .toSet()
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) { // Usar setState propio del diálogo
            return AlertDialog(
              title: Text("Filter by Dance Styles"),
              content: SingleChildScrollView(
                child: Column(
                  children: allStyles.map((style) {
                    return CheckboxListTile(
                      title: Text(style),
                      value: selectedStyles.contains(style),
                      onChanged: (bool? value) {
                        setStateDialog(() { // setState propio del diálogo
                          if (value == true) {
                            selectedStyles.add(style);
                          } else {
                            selectedStyles.remove(style);
                          }
                        });
                        setState(() { // setState general para actualizar la lista
                          _filterStudios(searchQuery);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dance Studio Finder"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterStudios,
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudios.length,
              itemBuilder: (context, index) {
                final studio = filteredStudios[index];
                return ListTile(
                  title: Text(studio.name),
                  subtitle: Text(studio.address),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InfoStudioPage(studio: studio)),
                  ),
                );
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(60.1695, 24.9354),
                zoom: 14,
              ),
              markers: markers,
            ),
          ),
        ],
      ),
    );
  }
}
