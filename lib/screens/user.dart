// ignore_for_file: unused_element

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/widgets/text_widget.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController = TextEditingController();

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Hi,  ',
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'MyName',
                        style: TextStyle(
                          color: color,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('My name is tapped....');
                          }),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextWidget(
                text: 'test@test.com',
                color: color,
                textSize: 22,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              _listTiles(
                title: 'Address 2',
                subtitle: 'My Subtitle',
                icon: IconlyLight.profile,
                color: color,
                onPressed: () async {
                  await _showAddressDialog();
                },
              ),
              _listTiles(
                title: 'Orders',
                icon: IconlyLight.bag,
                color: color,
                onPressed: () {},
              ),
              //Wishlist
              _listTiles(
                title: 'Wishlist',
                icon: IconlyLight.heart,
                color: color,
                onPressed: () {},
              ),

              //Viewed Items
              _listTiles(
                title: 'Viewed',
                icon: IconlyLight.show,
                color: color,
                onPressed: () {},
              ),

              //Forget Password
              _listTiles(
                title: 'Forget Password',
                icon: IconlyLight.unlock,
                color: color,
                onPressed: () {},
              ),

              SwitchListTile(
                  title: TextWidget(
                    text: themeState.getDarkTheme ? 'Dark Mode' : 'Light Mode',
                    color: color,
                    textSize: 22,
                  ),
                  secondary: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  },
                  value: themeState.getDarkTheme),
              //logout
              _listTiles(
                title: 'Logout',
                icon: IconlyLight.logout,
                color: color,
                onPressed: () {
                  _showLogoutDialog();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

//function fpr logout dialog
  Future<void> _showLogoutDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/warning-sign.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Sign Out'),
              ),
            ],
          ),
          content: const Text('Do you wanna logout?'),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child:
                  TextWidget(text: 'Cancel', color: Colors.cyan, textSize: 18),
            ),
            TextButton(
              onPressed: () {},
              child: TextWidget(text: 'Yes', color: Colors.red, textSize: 18),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update'),
          content: TextField(
            // onChanged: (value) {
            // print('_addressTextController.text: ${value}');
            //},
            controller: _addressTextController,
            maxLines: 5,
            decoration: const InputDecoration(hintText: "Your address"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                print(_addressTextController.text);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle == null ? "" : subtitle,
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
