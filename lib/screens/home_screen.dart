import 'package:flutter/material.dart';
import '../models/donation_model.dart';
import '../widgets/donation_card.dart';
import '../services/donation_service.dart';
// Change
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final DonationService _donationService = DonationService();

  // Controllers for Add Donation form
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  // Change
  File? _selectedImage;
  Uint8List? _selectedImageBytes;
  
  @override
  Widget build(BuildContext context) {
    final tabs = [
      _buildFeedTab(),
      _buildAddDonationTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("DonateNear"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(child: tabs[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Donation'),
        ],
      ),
    );
  }

  // ------------------------ FEED TAB ------------------------
  Widget _buildFeedTab() {
    final donations = _donationService.getDonations();

    if (donations.isEmpty) {
      return const Center(
        child: Text(
          "No donations yet. Be the first to help!",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: donations.length,
      itemBuilder: (context, index) {
        final donation = donations[index];
        return DonationCard(
          donation: donation,
          onTap: () {
            Navigator.pushNamed(context, '/details', arguments: donation);
          },
        );
      },
    );
  }

  // ------------------------ ADD DONATION TAB ------------------------
  Widget _buildAddDonationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add a New Donation",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildTextField(_nameController, "Donor Name (optional)"),
            _buildTextField(_typeController, "Donation Type (e.g., Clothes, Food)"),
            _buildTextField(_descController, "Description"),
            _buildTextField(_locationController, "Location"),

// CHNAGE
            const SizedBox(height: 20),

            Center(
              child: Column(
                children: [
                  _selectedImage == null && _selectedImageBytes == null
    ? const Text(
        "No image selected",
        style: TextStyle(color: Colors.black54),
      )
    : ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: kIsWeb
            ? Image.memory(
                _selectedImageBytes!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Image.file(
                _selectedImage!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
      ),

                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text("Pick Image"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  _addDonation();
                },
                icon: const Icon(Icons.check),
                label: const Text("Submit Donation"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _addDonation() {
    if (_typeController.text.isEmpty || _descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in donation type and description")),
      );
      return;
    }

    final newDonation = Donation(
  donorName: _nameController.text.isEmpty ? "Anonymous Donor" : _nameController.text,
  type: _typeController.text,
  description: _descController.text,
  location: _locationController.text,
  date: DateTime.now(),
  imagePath: _selectedImage?.path,
  imageBytes: _selectedImageBytes,
);


    _donationService.addDonation(newDonation);

    setState(() {
      _typeController.clear();
      _descController.clear();
      _nameController.clear();
      _locationController.clear();
      _selectedImage = null;

    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Donation added successfully!")),
    );

    _selectedIndex = 0;
  }

  // Chnage
  Future<void> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    if (kIsWeb) {
      // On web, get bytes instead of File
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = null;
        _selectedImageBytes = bytes;
      });
    } else {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _selectedImageBytes = null;
      });
    }
  }
}


}
