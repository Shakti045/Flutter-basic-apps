import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput(this.setpickedimage, {super.key});

  final void Function(File image) setpickedimage;
  @override
  State<ImageInput> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<ImageInput> {
  File? _pickedimage;

  void selectfromsource(ImageSource source, BuildContext context) async {
    final imagePicker = ImagePicker();
    XFile? pickedimage = await imagePicker.pickImage(
        source: source, imageQuality: 50, maxWidth: 100);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    if (pickedimage == null) {
      return;
    }

    setState(() {
      _pickedimage = File(pickedimage.path);
      widget.setpickedimage(_pickedimage!);
    });
  }

  void pickimage() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Choose an image'),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        selectfromsource(ImageSource.gallery, context);
                      },
                      icon: const Icon(
                        Icons.album,
                        size: 30,
                      ),
                      label: const Text('Pick fom gallery')),
                  TextButton.icon(
                      onPressed: () {
                        selectfromsource(ImageSource.camera, context);
                      },
                      icon: const Icon(Icons.camera, size: 30),
                      label: const Text('Pick from camers')),
                ],
              ),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.withOpacity(0.9),
          foregroundImage:
              _pickedimage != null ? FileImage(_pickedimage!) : null,
        ),
        OutlinedButton(
          onPressed: pickimage,
          child: const Text('Pick an image'),
        ),
      ],
    );
  }
}
