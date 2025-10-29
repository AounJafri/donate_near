import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/donation_model.dart';

class DonationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Add a new donation
  Future<void> addDonation(Donation donation) async {
    String? imageUrl;

    // If imageBytes exist (for web), upload to Firebase Storage
    if (donation.imageBytes != null) {
      final ref = _storage.ref().child('donation_images/${DateTime.now().millisecondsSinceEpoch}.png');
      await ref.putData(donation.imageBytes!, SettableMetadata(contentType: 'image/png'));
      imageUrl = await ref.getDownloadURL();
    }

    // Save donation data to Firestore
    await _firestore.collection('donations').add({
      'donorName': donation.donorName,
      'type': donation.type,
      'description': donation.description,
      'location': donation.location,
      'date': donation.date.toIso8601String(),
      'imageUrl': imageUrl, // stored as downloadable link
    });
  }

  /// Retrieve donations (newest first)
  Stream<List<Donation>> getDonationsStream() {
    return _firestore
        .collection('donations')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return Donation(
                donorName: data['donorName'],
                type: data['type'],
                description: data['description'],
                location: data['location'],
                date: DateTime.parse(data['date']),
                imagePath: data['imageUrl'],
              );
            }).toList());
  }

  /// Optionally: get all donations once (not live)
  Future<List<Donation>> getDonationsOnce() async {
    final snapshot = await _firestore
        .collection('donations')
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Donation(
        donorName: data['donorName'],
        type: data['type'],
        description: data['description'],
        location: data['location'],
        date: DateTime.parse(data['date']),
        imagePath: data['imageUrl'],
      );
    }).toList();
  }
}










// import '../models/donation_model.dart';

// class DonationService {
//   // Temporary in-memory list of donations
//   static final List<Donation> _donations = [];

//   List<Donation> getDonations() {
//     return _donations.reversed.toList(); // newest first
//   }

//   void addDonation(Donation donation) {
//     _donations.add(donation);
//   }
// }
