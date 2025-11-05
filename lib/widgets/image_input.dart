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
  void _takePicture() async{
    final imagePicker =  ImagePicker();
    final pickedImage =await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxWidth: 600,
    );
    if(pickedImage == null){
      return;
    }
    setState(() {
      _imageFile = File(pickedImage.path);
    });
    widget.onPickImage(_imageFile!);
  }


  @override
  Widget build(BuildContext context) {
    Widget content = const Text('No Image Taken',textAlign: TextAlign.center,

    style: TextStyle(
        fontSize: 16,

        color: Colors.grey,
      )
    );
    if(_imageFile != null){
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _imageFile!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
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
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),

      child: Stack(
        fit: StackFit.expand,
        children: [
          content,
          Positioned(
            bottom: 10,
            right: 10,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              ),
              onPressed: _takePicture,
              icon: const Icon(Icons.camera),
              label: const Text('Take Picture'),
            ),
          ),
        ],
      )

    );
  }
}
