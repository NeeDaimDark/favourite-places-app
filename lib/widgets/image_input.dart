import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    super.key,
    required this.onPickImage,
  });

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      // Prefer rear camera for better optics
      preferredCameraDevice: CameraDevice.rear,
      // Keep original resolution and avoid JPEG recompression to preserve quality
      // (omit imageQuality/maxWidth/maxHeight)
      requestFullMetadata: true,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _imageFile = File(pickedImage.path);
    });
    widget.onPickImage(_imageFile!);
  }

  void _pickFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: true,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _imageFile = File(pickedImage.path);
    });
    widget.onPickImage(_imageFile!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Text(
      'No Image Taken',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
    if (_imageFile != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _imageFile!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          filterQuality: FilterQuality.high,
        ),
      );
    }
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withAlpha(77),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          content,
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(179),
                  ),
                  onPressed: _pickFromGallery,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(179),
                  ),
                  onPressed: _takePicture,
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
