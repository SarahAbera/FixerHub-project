import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';

class ProfessionalVerificationScreen extends StatefulWidget {
  final Map<String, dynamic>? registrationData;
  
  const ProfessionalVerificationScreen({
    Key? key,
    this.registrationData,
  }) : super(key: key);

  @override
  State<ProfessionalVerificationScreen> createState() => _ProfessionalVerificationScreenState();
}

class _ProfessionalVerificationScreenState
    extends State<ProfessionalVerificationScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;
  File? _idCard;
  File? _certificate;

  Future<void> _pickImage(ImageSource source, String type) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          switch (type) {
            case 'profile':
              _profileImage = File(image.path);
              break;
            case 'id':
              _idCard = File(image.path);
              break;
            case 'certificate':
              _certificate = File(image.path);
              break;
          }
        });
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  void _showImageSourceDialog(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera, type);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery, type);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadCard(String title, File? image, String type) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _showImageSourceDialog(type),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          image,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.add_photo_alternate,
                        size: 50,
                        color: Colors.grey,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Verification Documents',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Please upload the following documents:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _buildImageUploadCard('Profile Photo', _profileImage, 'profile'),
            const SizedBox(height: 16),
            _buildImageUploadCard('Government ID', _idCard, 'id'),
            const SizedBox(height: 16),
            _buildImageUploadCard('Legal Certificate', _certificate, 'certificate'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _profileImage != null &&
                      _idCard != null &&
                      _certificate != null
                  ? () {
                      // TODO: Implement sign up logic with documents
                      print('Registration data: ${args?.toString()}');
                      print('Profile Image: ${_profileImage?.path}');
                      print('ID Card: ${_idCard?.path}');
                      print('Certificate: ${_certificate?.path}');
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 