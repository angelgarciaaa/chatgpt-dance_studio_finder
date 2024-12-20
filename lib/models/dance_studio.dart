class DanceStudio {
  final int id;
  final String name;
  final String address;
  final String fullAddress;
  final String description;
  final List<String> danceStyles;
  final double latitude;
  final double longitude;

  DanceStudio({
    required this.id,
    required this.name,
    required this.address,
    required this.fullAddress,
    required this.description,
    required this.danceStyles,
    required this.latitude,
    required this.longitude,
  });
}
