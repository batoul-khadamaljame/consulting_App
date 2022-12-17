
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ThemeColors.icons),
        backgroundColor: ThemeColors.backgroundColor,
        /*leading: Icon(

                        Icons.menu,
                        color: ThemeColors.icons,


                  ),*/
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: ThemeColors.icons,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.message,
              color: ThemeColors.icons,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/messege');
            },
          ),
        ],
        elevation: 0.0,
      ),
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
