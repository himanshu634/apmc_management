import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart' as pp;

class ImageWidget extends StatefulWidget {
  final String imageLink;
  final File? image;
  const ImageWidget({required this.imageLink, this.image});
  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  Directory? dir;
  double _percentage = 0;
  File? _imageFile ;
  bool _imageExists = false;

  Future<void> _downloadImage() async {
    try {
      dir = await pp.getTemporaryDirectory();
      await dir!.delete(recursive: true);
      final dio = Dio();
      await dio.download(
        widget.imageLink,
        "${dir!.path}/profile_pic.jpg",
        onReceiveProgress: (actualBytes, totalBytes) {
          var per = actualBytes / totalBytes;
          setState(() {
            this._percentage = per;
            if (this._percentage == 1.0) {
              _imageFile = File("${dir!.path}/profile_pic.jpg");
              _imageExists = true;
            }
          });
        },
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    if (widget.image == null) {
      Future.delayed(Duration()).then((_) {
        _downloadImage();
      });
    } else {
      setState(() {
        _imageExists = true;
        _imageFile = widget.image;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: 50,
      maxRadius: 70,
      child: !_imageExists
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  value: _percentage,
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(_imageFile!),
                ),
              ),
            ),
    );
  }
}
