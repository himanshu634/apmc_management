import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_data.dart';
import '../user_widgets/user_details.dart';

class UserBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context, listen: false);
    return FutureBuilder(
      future: userData.fetchAndSetUserData(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return UserDetails();
        }
      },
    );
  }
}
