import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviews_slider/reviews_slider.dart';



class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int? selectedValue1;
  int? selectedValue2;

  bool isChoiceChip = true;
  int selectedIndex = 0;
  int selectedIndexDemo = 0;
  TimeOfDay _timeOfDay = TimeOfDay.now();

  void onChange1(int value) {
    setState(() {
      selectedValue1 = value + 1;
    });
  }

  void onChange2(int value) {
    setState(() {
      selectedValue2 = value;
    });
  }

  List<Tech> _chipsList = [
    Tech("Android", Colors.green),
    Tech("Flutter", Colors.blueGrey),
    Tech("Ios", Colors.deepOrange),
    Tech("Python", Colors.cyan),
    Tech("Go lang", Colors.yellow)
  ];

  List<CompanyWidget> _companies = [
    CompanyWidget('CEO'),
    CompanyWidget('Director'),
    CompanyWidget('Manager'),
    CompanyWidget('Team Leader'),
    CompanyWidget('Employee'),
  ];
  List<String> _filters = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'How was the help you received?',
                  style: TextStyle(color: Color(0xFF6f7478), fontSize: 18),
                ),
                SizedBox(height: 20),
                ReviewSlider(
                  onChange: onChange1,
                ),
                Text((selectedValue1).toString()),
                SizedBox(height: 20),
                ChoiceChip(
                  label: Text("demo"),
                  selected: isChoiceChip,
                  autofocus: true,
                  avatar: Icon(Icons.ac_unit),
                  backgroundColor: Colors.green[100],
                  disabledColor: Colors.yellow,
                  elevation: 10,
                  avatarBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 10, color: Colors.red)),
                  onSelected: (bool value) {
                    setState(() {
                      isChoiceChip = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  direction: Axis.horizontal,
                  children: techChips(),
                ),
                SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  elevation: 20,
                  child: Container(
                    height: 100,
                    width: 250,
                    child: Center(
                        child: Text(
                      "Card",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                   var res =  await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                   print("res -->>>$res");
                   setState(() {
                     _timeOfDay = res!;
                   });
                    },
                    child: Text("Time Picker")),
                Text("Time Picker : ${_timeOfDay.format(context)}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          label: Text(_chipsList[i].label),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: _chipsList[i].color,
          selected: selectedIndex == i,
          onSelected: (bool value) {
            setState(() {
              selectedIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}

class CompanyWidget {
  const CompanyWidget(this.name);

  final String name;
}

///model
class Tech {
  String label;
  Color color;

  Tech(this.label, this.color);
}
