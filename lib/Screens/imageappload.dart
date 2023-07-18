import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ImageUploadScreen extends StatefulWidget {
  static const routeName = '/image-screen';

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _imageFile;

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('No Image Selected'),
          content: Text('Please select an image to upload.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    var url = Uri.parse("http://192.168.1.15/projet_api/insertdata.php");

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Attach the file to the request
    request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));

    // Send the request
    var response = await request.send();

    // Check the response status
    if (response.statusCode == 200) {
      // Image uploaded successfully
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Image Uploaded'),
          content: Text('The image was successfully uploaded.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Error uploading image
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while uploading the image.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    // Implement your image picking logic here
    // This example uses the image_picker package
    // Make sure to include the package in your pubspec.yaml file
    // See: https://pub.dev/packages/image_picker

    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                height: 200,
              ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
