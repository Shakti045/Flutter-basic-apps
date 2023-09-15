import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.setimage});

  final void Function(File img) setimage;
  @override
  State<ImageInput> createState() {
    return _ImageInput();
  }
}

class _ImageInput extends State<ImageInput> {
  File? _selectedimage;
  void _openimagepicker() async {
    final imagepicker = ImagePicker();
    final pickedImage =
        await imagepicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedimage = File(pickedImage.path);
      widget.setimage(_selectedimage!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Text('Provide an image of the place');

    if (_selectedimage != null) {
      content = Image.file(
        _selectedimage!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return GestureDetector(
        onTap: _openimagepicker,
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 250,
          width: double.infinity,
          margin: const EdgeInsetsDirectional.only(top: 15),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: const Color.fromARGB(119, 255, 255, 255)),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: content,
          ),
        ));
  }
}
