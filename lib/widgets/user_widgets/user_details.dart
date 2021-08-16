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
    final userData = Provider.of<UserData>(context, listen: true);
    File? _image;

    Future<void> _pickImage() async {
      try {
        //TODO  some improvements are pending
        showModalBottomSheet(
          context: context,
          builder: (ctx) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextButton(
                    child: const Text("Take Picture"),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                        maxHeight: 300,
                        maxWidth: 500,
                      );
                      Navigator.of(context).pop();
                      if (pickedFile != null) {
                        setState(() {
                          _image = File(pickedFile.path);
                        });
                        await userData.addPhoto(_image!);
                      }
                    },
                  ),
                  const Divider(thickness: 2),
                  TextButton(
                    child: const Text("Choose From Gallery"),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 300,
                        maxWidth: 500,
                      );
                      Navigator.of(context).pop();
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                        await userData.addPhoto(_image!);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
          shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            ),
          ),
          elevation: 10,
        );
      } catch (error) {
        //TODO remove this and add snackbar
        print(error);
      }
    }

    return SafeArea(
      child: FutureBuilder(
        future: userData.fetchAndSetUserData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: const CircularProgressIndicator(),
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
                              ? const CircleAvatar(
                                  minRadius: 50,
                                  maxRadius: 70,
                                  child: const Icon(
                                    Icons.person,
                                    size: 50,
                                  ),
                                )
                              : ImageWidget(
                                  imageLink: imageLink, image: _image),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          child: const Text("Choose Picture"),
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
