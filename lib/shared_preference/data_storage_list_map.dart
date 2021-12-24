import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';



class SharedPreferencesDemo extends StatefulWidget {
  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

  List formDetails = [
    "Email",
    "Password",
  ];

  List<TextEditingController> controllers =
  List.generate(2, (index) => TextEditingController());

  Map<bool, String> passData = {};

  List<CheckBox> checkList = [
    CheckBox(false, "Apple"),
    CheckBox(false, "Banana"),
    CheckBox(false, "Kiwi"),
    CheckBox(false, "Mango")
  ];

  List<String> tempList = [];
  List<String> list = [];

  Map<String, bool> mapNumber = {
    'One': true,
    'Two': false,
    'Three': false,
    'Four': false,
    'Five': false,
    'Six': false,
    'Seven': false,
  };

  Map<String, String> addNumberMap = {};

  getItems() {
    mapNumber.forEach((key, value) {
      if (value == true) {
        addNumberMap[key] = key;
      }
    });

    // Printing all selected items on Terminal screen.
    print(addNumberMap);
    // Here you will get all your selected Checkbox items.

    // // Clear array after use.
    // addNumberList.clear();
  }


  Model m = Model(one: true);

  modelValue (){
    m.one = true;
    m.two = false;
    m.toJson();
    print(m.one);
    print(m.two);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Demo'),
      ),
      body: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: scaffoldKey,
            child: ListView(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: checkList
                          .map((e) => Column(
                        children: [
                          Checkbox(
                            value: e.checkBox,
                            checkColor: Colors.white,
                            activeColor: Colors.pinkAccent,
                            onChanged: (val) {
                              e.checkBox = val;
                              if (e.checkBox == true) {
                                tempList.add(e.title!.toString());
                                list = tempList.toSet().toList();
                                print(list);
                              } else {}
                              setState(() {});
                            },
                          ),
                          Text(e.title!),
                        ],
                      ))
                          .toList(),
                    )),

                const SizedBox(
                  height: 20,
                ),
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
                      },
                    );
                  }).toList(),
                ),

                TextButton(
                    onPressed: () async {
                      getItems();
                      // final SharedPreferences prefs =  await _prefs;
                      // await prefs.setStringList("fruitList", list);
                      //  print(list);
                    },
                    child: const Text("Map Data Fill")),
                TextButton(
                    onPressed: () async {
                      modelValue();
                      // final SharedPreferences prefs =  await _prefs;
                      // await prefs.setStringList("fruitList", list);
                      // print(list);
                    },
                    child: const Text("Model data Fill")),

                TextButton(
                    onPressed: () async {
                      // print(listMAp);
                      // print(jsonEncode(listMAp));

                      final SharedPreferences prefs = await _prefs;
                      await prefs.setStringList("fruitList", list);
                      await prefs.setString("numberMap", json.encode(addNumberMap));
                      await prefs.setString("modelValue", json.encode(m.toJson()));
                      print(list);
                      print(addNumberMap);
                      print(jsonEncode(addNumberMap));
                      print(jsonEncode(m.toJson()));
                    },
                    child: const Text("Store Data SharedPref")),

                TextButton(
                    onPressed: () async {
                      sharedPref();
                    },
                    child: const Text("show Store Data SharedPref")),
                const SizedBox(
                  height: 30,
                ),
                Text("Hive Plugin :-"),
                const SizedBox(
                  height: 20,
                ),

                TextButton(
                    onPressed: () {
                      // HiveData();
                    },
                    child: Text("Save Hive DataBase"))
              ],
            ),
          )),
    );
  }

  sharedPref() async {
    final SharedPreferences prefs = await _prefs;
    var getEmail = prefs.getString("email");
    var getList = prefs.getStringList("fruitList");
    var getNumberMap = prefs.getString("numberMap");
    var getModelMap = prefs.getString("modelValue");

    print("getEmail:-$getEmail");
    print("getFruitList:-$getList");
    print("GetNumberMap -->>>$getNumberMap");
    print("get NumberMap:-$getModelMap");
  }

// HiveData()async{
//


//   var box = await Hive.openBox('testBox');
//
//    box = Hive.box('myBox');
//
//   box.put('name', 'David');
//
//   var name = box.get('name');
//
//   print('Name: $name');
// }

}

class CheckBox {
  bool? checkBox;
  String? title;

  CheckBox(this.checkBox, this.title);
}


class Model {
  bool? one;
  bool? two;

  Model({this.one, this.two});

  Model.fromJson(Map<String, dynamic> json) {
    one = json['one'];
    two = json['two'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['one'] = this.one;
    data['two'] = this.two;
    return data;
  }
}