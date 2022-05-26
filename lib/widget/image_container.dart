import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageContainer extends StatefulWidget {
  final void Function(File pickImage) imageFn;

  const ImageContainer({
    Key? key,
    required this.imageFn,
  }) : super(key: key);

  @override
  _ImageContainerState createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  File? _userImage;

  void _chooseImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _userImage = pickedImageFile;
    });
    widget.imageFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).accentColor,
          backgroundImage: _userImage != null ? FileImage(_userImage!) : null,
          radius: 40,
        ),
        FlatButton.icon(
          color: Theme.of(context).accentColor,
          onPressed: _chooseImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
