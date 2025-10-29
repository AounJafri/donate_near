import 'package:flutter/material.dart';
import '../models/donation_model.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;


class DonationDetailsScreen extends StatelessWidget {
  const DonationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the passed donation object
    final Donation donation =
        ModalRoute.of(context)!.settings.arguments as Donation;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Details"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CHANGE
                if (donation.imagePath != null || donation.imageBytes != null)
  ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: kIsWeb
        ? Image.memory(
            donation.imageBytes!,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          )
        : Image.file(
            File(donation.imagePath!),
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
  ),



                // Donation Type
                Text(
                  donation.type,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 12),

                // Donor Name
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      donation.donorName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        donation.location.isNotEmpty
                            ? donation.location
                            : "No location specified",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Date
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      "${donation.date.day}/${donation.date.month}/${donation.date.year}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const Divider(height: 30, thickness: 1),

                // Description
                const Text(
                  "Description:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  donation.description,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
                const Spacer(),

                // Action button
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "You expressed interest in '${donation.type}' donation!",
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite_border),
                    label: const Text("I'm Interested"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
