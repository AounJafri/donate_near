import 'package:flutter/material.dart';
import '../models/donation_model.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;



class DonationCard extends StatelessWidget {
  final Donation donation;
  final VoidCallback? onTap;

  const DonationCard({super.key, required this.donation, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CHNAGE
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


              Text(
                donation.type,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                donation.description,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "By: ${donation.donorName}",
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  Text(
                    "${donation.date.day}/${donation.date.month}/${donation.date.year}",
                    style: const TextStyle(color: Colors.black45, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
