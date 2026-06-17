import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/photos/photo_service.dart';

class TripPhotosScreen extends StatefulWidget {
  final String tripName;

  const TripPhotosScreen({
    super.key,
    required this.tripName,
  });

  @override
  State<TripPhotosScreen> createState() =>
      _TripPhotosScreenState();
}

class _TripPhotosScreenState
    extends State<TripPhotosScreen> {
  final ImagePicker picker =
      ImagePicker();

  List<String> photos = [];

  @override
  void initState() {
    super.initState();

    photos =
        PhotoService.loadPhotos(
      widget.tripName,
    );
  }

  Future<void> save() async {
    await PhotoService.savePhotos(
      widget.tripName,
      photos,
    );
  }

  Future<void> pickImage() async {
    final XFile? image =
        await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    setState(() {
      photos.add(image.path);
    });

    await save();
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.tripName} Photos",
        ),
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: pickImage,
        child:
            const Icon(Icons.add_a_photo),
      ),
      body: photos.isEmpty
          ? const Center(
              child: Text(
                "No Photos Yet",
              ),
            )
          : GridView.builder(
              padding:
                  const EdgeInsets.all(12),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount:
                  photos.length,
             itemBuilder:
    (context, index) {
  return Card(
    clipBehavior:
        Clip.antiAlias,
    child: Image.file(
      File(photos[index]),
      fit: BoxFit.cover,
    ),
  );
},
            ),
    );
  }
}