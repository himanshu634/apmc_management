import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_data.dart';
import './user_item.dart';

class UserDetails extends StatelessWidget {
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
          return SingleChildScrollView(
            child: Column(
              children: [
                //TODO photo logic
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * .5,
                  child: Center(
                    child: CircleAvatar(
                      minRadius: 20,
                      maxRadius: 70,
                      child: Icon(
                        Icons.person,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                UserItem(
                  data: userData.userData!['user_name'],
                  dataType: "User Name",
                ),
                UserItem(
                  data: userData.userData!['village_name'],
                  dataType: "Vilage/City Name",
                ),
                UserItem(
                  data: userData.userData!['mobile_number'],
                  dataType: "Mobile Number",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
