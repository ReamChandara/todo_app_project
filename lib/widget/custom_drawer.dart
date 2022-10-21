import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/setting_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        children: [
          const DrawerHeader(child: Text("Hello")),
          ListTile(
            onTap: () {
              Get.to(const SettingScreen());
            },
            leading: const Icon(Icons.settings),
            title: const Text("Setting"),
          )
        ],
      ),
    );
  }
}
