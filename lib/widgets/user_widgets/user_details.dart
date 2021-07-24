import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../providers/user_data.dart';
import './user_item.dart';
import './image_widget.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    File? _image;

    Future<void> _pickImage() async {
      try {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 500,
        );
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          await userData.addPhoto(_image!);
        }
      } catch (error) {
        print(error);
      }
    }

    return SafeArea(
      child: FutureBuilder(
        future: userData.fetchAndSetUserData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final imageLink = userData.userData!['profile_pic_link'];
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * .7,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: imageLink == null
                              ? CircleAvatar(
                                  minRadius: 50,
                                  maxRadius: 70,
                                  child: const Icon(
                                    Icons.person,
                                    size: 50,
                                  ),
                                )
                              : ImageWidget(imageLink),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          child: Text("Take Photo"),
                          onPressed: _pickImage,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.grey[500],
                  ),
                  UserItem(
                    data: userData.userData!['user_name'],
                    dataType: "User Name",
                    editFunc: userData.editUserName,
                  ),
                  UserItem(
                    data: userData.userData!['village_name'],
                    dataType: "Vilage/City Name",
                    editFunc: userData.editVillageName,
                  ),
                  UserItem(
                    data: userData.userData!['mobile_number'],
                    dataType: "Mobile Number",
                    editFunc: userData.editMobileNumber,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("something went wrong"),
            );
          }
          // return Center(
          //   child: CircularProgressIndicator(),
          // );
        },
      ),
    );
  }
}
