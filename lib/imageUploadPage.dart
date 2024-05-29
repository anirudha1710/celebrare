import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:widget_mask/widget_mask.dart';



class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _chooseFromDevice() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      showPopup(pickedFile);
    });
  }

  Image? _image;
  String maskPath = "asset/0.png";

  void showPopup(XFile? pickedFile) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, st) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Uploaded Image",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                pickedFile == null
                    ? const Text('Upload Image')
                    : maskPath != "asset/0.png"
                        ? WidgetMask(
                            blendMode: BlendMode.dstIn,
                            childSaveLayer: true,
                            mask: Image.asset(
                              maskPath,
                              fit: BoxFit.cover,
                            ),
                            child: Image.file(
                              File(pickedFile.path),
                              height: 300,
                            ),
                          )
                        : Image.file(
                            File(pickedFile.path),
                            height: 300,
                          ),
                Row(
                  children: [
                    Expanded(
                      child: CropButton(
                        "Original",
                        null,
                        0,
                        st,
                      ),
                    ),
                    Expanded(
                      child: CropButton(
                        null,
                        Image.asset(
                          "asset/user_image_frame_1.png",
                          scale: 0.5,
                        ),
                        1,
                        st,
                      ),
                    ),
                    Expanded(
                      child: CropButton(
                        null,
                        Image.asset(
                          "asset/user_image_frame_2.png",
                          scale: 0.5,
                        ),
                        2,
                        st,
                      ),
                    ),
                    Expanded(
                      child: CropButton(
                        null,
                        Image.asset(
                          "asset/user_image_frame_3.png",
                          scale: 0.5,
                        ),
                        3,
                        st,
                      ),
                    ),
                    Expanded(
                      child: CropButton(
                        null,
                        Image.asset(
                          "asset/user_image_frame_4.png",
                          scale: 0.5,
                        ),
                        4,
                        st,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }

  Widget CropButton(String? text, Image? image, int index, void fun) {
    return GestureDetector(
      onTap: () async {
        if (index == 1) {
          setState(() {
            maskPath = "asset/user_image_frame_1.png";
          });
        } else if (index == 2) {
          setState(() {
            maskPath = "asset/user_image_frame_2.png";
          });
        } else if (index == 3) {
          setState(() {
            maskPath = "asset/user_image_frame_3.png";
          });
        } else if (index == 4) {
          setState(() {
            maskPath = "asset/user_image_frame_4.png";
          });
        } else {
          setState(() {
            maskPath = "asset/0.png";
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: text == null
            ? image
            : Text(
                text,
                style: const TextStyle(color: Colors.black45, fontSize: 12),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.all(80),
          child: Text(
            'Add Image / Icon',
            style: TextStyle(color: Colors.black45),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            // Handle back button action
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _imageFile == null
                          ? const Text('Upload Image')
                          : Image.file(
                              File(_imageFile!.path),
                              height: 300,
                            ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _chooseFromDevice,
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.teal),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Choose from Device'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
