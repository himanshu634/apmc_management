import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../providers/user_data.dart';
import './user_item.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  File? _image;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * .6,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: CircleAvatar(
                              minRadius: 20,
                              maxRadius: 70,
                              child: _image == null
                                  ? Icon(
                                      Icons.person,
                                      size: 50,
                                    )
                                  : Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            child: Text("Take Photo"),
                            onPressed: () async {
                              await _pickImage();
                            },
                          ),
                        ],
                      ),
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
