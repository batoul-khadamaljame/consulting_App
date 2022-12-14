
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            signOut(context);
          },
          child: Text('logout'),
        ),
      ),
    );
  }
}
