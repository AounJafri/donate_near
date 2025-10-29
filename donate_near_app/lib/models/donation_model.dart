import 'dart:typed_data';


class Donation {
  final String donorName;
  final String type;
  final String description;
  final String location;
  final DateTime date;
  final String? imagePath; // for mobile
  final Uint8List? imageBytes; // for web

  Donation({
    required this.donorName,
    required this.type,
    required this.description,
    required this.location,
    required this.date,
    this.imagePath,
    this.imageBytes,
  });
}
