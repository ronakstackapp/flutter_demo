import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/form_validation_screen/form_details_screen.dart';
import 'package:flutter_demo/form_validation_screen/form_validation_screen.dart';
import 'package:flutter_demo/screen/pageview_screen.dart';
import 'package:flutter_demo/shared_preference/data_storage_list_map.dart';
import 'package:flutter_demo/shared_preference/share_pref_use_class_one_screen.dart';
import 'package:flutter_demo/shared_preference/share_pref_use_class_second_screen.dart';
import 'package:flutter_demo/shared_preference/shared_preference_screen.dart';
import 'package:flutter_demo/squlite_demo/squlite_demo_screen.dart';
import 'package:flutter_demo/squlite_demo/squlite_screen.dart';

import 'cliper_path_exmple.dart';
import 'custom_shape.dart';
import 'file_picker.dart';
import '../permission_heanding_and_file_storage/permissions_handling_screen.dart';
import '../permission_heanding_and_file_storage/storage_file_device_screen.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return FormValidationScreen();
                  }));
                },
                child: Text("Form Validation")),
            Container(
              height: 5,
              width: double.infinity,
              color: Colors.white,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return FormDetailsScreen();
                  }));
                },
                child: Text("FormDetailsScreen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return FilePickerScreen();
                  }));
                },
                child: Text("FilePickerScreen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return FilePickerScreen();
                  }));
                },
                child: Text("File Picker")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return PageViewScreen();
                  }));
                },
                child: Text("Page View")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return PermissionHendler();
                  }));
                },
                child: Text("Permissions Handling")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return StorageSaveData();
                  }));
                },
                child: Text("StorageSaveData")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Home();
                  }));
                },
                child: Text("SharedPreference Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SharedPreferencesDemo();
                  }));
                },
                child: Text("SharedPreference Screen use common class")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return CustomShape();
                  }));
                },
                child: Text("CustomShape")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return CliperPathDemo();
                  }));
                },
                child: Text("CliperPathDemo")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return DesignPage();
                  }));
                },
                child: Text("SQLite Screen Demo")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return HomePage();
                  }));
                },
                child: Text("SQLite Screen")),

          ],
        ),
      ),
    );
  }
}
