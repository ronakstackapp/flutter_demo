import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_demo/model/share_model.dart';
import 'package:flutter_demo/shared_preference/shared_preference_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class Home extends StatefulWidget {
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ///map
  Map<String, bool> mapNumber = {
    'One': false,
    'Two': false,
    'Three': false,
    'Four': false,
    'Five': false,
    'Six': false,
    'Seven': false,
  };

  RestaurantModel model = RestaurantModel();

  addModelDate() {
    model.name = "abc";
    model.fieldEnglishName = "english";
    model.fieldTaxonTypes = "types";
    print("Model ---->> ${model.toJson()}");
  }

  Map<String, String> addNumberMap = {};

  getItems() {
    mapNumber.forEach((key, value) {
      if (value == true) {
        addNumberMap[key] = key;
      }
    });
    print("Empty Map Fill -->>>$addNumberMap");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Shared Preferences Storage, Retrieval & Clear",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.brown,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                ClipPath(
                    clipper: MessageClipper(),
                    child: RaisedButton(child: Text("Save Data"), onPressed: save)),
                RaisedButton(child: Text("Fetch Data"), onPressed: fetch),
                RaisedButton(child: Text("Clear Data"), onPressed: remove),
                Column(
                  children: mapNumber.keys.map((String key) {
                    return CheckboxListTile(
                      title: Text(key),
                      value: mapNumber[key],
                      activeColor: Colors.pink,
                      checkColor: Colors.white,
                      onChanged: (bool? value) {
                        setState(() {
                          mapNumber[key] = value!;
                        });
                        print("checkbox --->>${mapNumber}");
                      },
                    );
                  }).toList(),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getItems();
                        addModelDate();
                      });
                    },
                    child: Text("** map Save**")),
                ElevatedButton(
                    onPressed: () async {

                  ///model
                  var res =  await MySharedPreferences.saveModel("model", json.encode(model));
                  print("save done ___${res}");

                  ///****
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString(
                          "mapDate", json.encode(addNumberMap));
                       await prefs.setString("model1", json.encode(model.toJson()));
                    },
                    child: Text("Save Map Share Pref")),
                ElevatedButton(
                    onPressed: () async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      var getModelMap = prefs.getString("mapDate");
                       var getModelMap1 = prefs.getString("model1");

                      ///model
                     String getModelMapModel =  await MySharedPreferences.modelRead("model");

                      print("Map Data:-$getModelMap");
                      print("Model Data:-${getModelMap1}");
                      print("Model Data:-${json.decode(getModelMapModel)}");
                    },
                    child: Text("Show Date Map Share Pref")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

save() async {
  await Home.init();

  prefs.setInt('int', 10);

  prefs.setString('string', "Abhi");

  prefs.setDouble('double', 3.14);

  prefs.setBool('boolean', true);

  prefs.setStringList('stringlist', ['horse', 'cow', 'sheep']);
}

fetch() {
  final myInt = prefs.getInt('int') ?? 0;

  final myDouble = prefs.getDouble('double') ?? 0.0;

  final myBool = prefs.getBool('boolean') ?? false;

  final myString = prefs.getString('string') ?? '';

  final myStringList = prefs.getStringList('stringlist') ?? [];

  log("\n Int  - $myInt \n double - $myDouble \n boolean - $myBool \n string - $myString \n stringlist - $myStringList");
}

remove() async {
  prefs.remove('int');
}

class MessageClipper extends CustomClipper<Path> {
  final double borderRadius = 15;
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double rheight = height - height / 3;
    double oneThird = width / 3;

    final path = Path()
      ..lineTo(0, rheight - borderRadius)
      ..cubicTo(0, rheight - borderRadius, 0, rheight, borderRadius, rheight)
      ..lineTo(oneThird, rheight)
      ..lineTo(width/2-borderRadius, height-borderRadius)
      ..cubicTo(width / 2 - borderRadius, height - borderRadius, width / 2,
          height, width / 2 + borderRadius, height - borderRadius )
      ..lineTo(2 * oneThird, rheight)
      ..lineTo(width-borderRadius, rheight)
      ..cubicTo(width - borderRadius, rheight, width, rheight, width,
          rheight - borderRadius)
      ..lineTo(width, 0)
      ..lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
