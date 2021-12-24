import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

class FirstScreen extends StatefulWidget {
  final bool isSwitch;

  FirstScreen(this.isSwitch);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<DropdownMenuItem> dropdownList = [
    DropdownMenuItem(child: Text("Not relevant")),
    DropdownMenuItem(child: Text("Illegal")),
    DropdownMenuItem(child: Text("Spam")),
    DropdownMenuItem(child: Text("Offensive")),
    DropdownMenuItem(child: Text("Uncivil")),
  ];
  List<String> items = ['🏘', '🚓', '🚛', '🏍', '🎉'];
  List<String> selectedReportList = [];
  DateTime DatePicker = DateTime.now();

  String radioText = "";
  int radioValue = 0;
  double sliderValue = 0;
  RangeValues values = RangeValues(5, 100);
  RangeLabels labels = RangeLabels('1', "100");

  bool checkBoxBool1 = true;
  bool checkBoxBool2 = true;
  bool checkBoxBool3 = true;

  String dropdownValue = "";

  bool CircularIndicator = false;

  String? _value1 = "Name1";


  final List<String> nameList = <String>[
    "Name1",
    "Name2",
    "Name3",
    "Name4",
    "Name5",
    "Name6",
    "Name7",
    "Name8"
  ];

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Report Video"),
            content: MultiSelectChip(
              items,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedReportList = selectedList;
                });
              },
              maxSelection: 10,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Report"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print("radioValue ~~~$radioValue");
    return Stack(
      children: [
        Scaffold(
          // key: _scaffoldkey,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                widget.isSwitch
                    ? Center(
                        child: RaisedButton(
                          child: Text("Multi Selector"),
                          onPressed: () => _showReportDialog(),
                        ),
                      )
                    : SizedBox(),
                widget.isSwitch
                    ? Text(selectedReportList.join(" , "))
                    : SizedBox(),
                widget.isSwitch
                    ? Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: RaisedButton(
                              child: Text("Date Picker"),
                              onPressed: () => _datePicker(),
                            ),
                          ),
                          Text(
                              "${DateFormat('dd-MM-yyyy hh:mm a').format(DatePicker)}"),
                        ],
                      )
                    : SizedBox(),
                // Text("${DatePicker.split(" ").first}")

                SizedBox(
                  height: 20,
                ),
                widget.isSwitch
                    ? Column(
                        children: [
                          RadioListTile(
                            title: Text("First"),
                            value: 1,
                            groupValue: radioValue,
                            onChanged: (int? value) {
                              print("value -->${value.runtimeType}");
                              setState(() {
                                radioValue = value!;
                              });
                            },
                            // onChanged: (newValue) => setState(() => radioValue = newValue),
                          ),
                          RadioListTile(
                              title: Text("Second"),
                              value: 2,
                              groupValue: radioValue,
                              activeColor: Colors.yellow,
                              onChanged: (int? val) {
                                setState(() {
                                  radioValue = val!;
                                });
                                print("RadioListTile -->>$radioValue");
                              }),
                          RadioListTile(
                              title: Text("third"),
                              value: 3,
                              activeColor: Colors.red,
                              groupValue: radioValue,
                              onChanged: (int? val) {
                                setState(() {
                                  radioValue = val!;
                                });
                              }),
                        ],
                      )
                    : SizedBox(),
                widget.isSwitch
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            CheckboxListTile(
                                title: Text("check 1"),
                                activeColor: Colors.red,
                                value: checkBoxBool1,
                                onChanged: (v) {
                                  print("CheckboxListTile -->>$v");
                                  setState(() {
                                    checkBoxBool1 = v!;
                                  });
                                }),
                            CheckboxListTile(
                                title: Text("check 2"),
                                activeColor: Colors.green,
                                value: checkBoxBool2,
                                onChanged: (v) {
                                  print("CheckboxListTile -->>$v");
                                  setState(() {
                                    checkBoxBool2 = v!;
                                  });
                                }),
                            CheckboxListTile(
                                title: Text("check 3"),
                                activeColor: Colors.blue,
                                value: checkBoxBool3,
                                onChanged: (v) {
                                  print("CheckboxListTile -->>$v");
                                  setState(() {
                                    checkBoxBool3 = v!;
                                  });
                                }),
                          ],
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Slider",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Slider(
                    label: "$sliderValue",
                    value: sliderValue,
                    min: 0,
                    max: 100,
                    activeColor: Colors.green,
                    divisions: 5,
                    autofocus: true,
                    onChanged: (double? v) {
                      setState(() {
                        sliderValue = v!;
                      });
                      print("sliderValue -->>$v");
                    }),
                Text("Slider value = ${sliderValue.toInt()}"),
                RangeSlider(
                  min: 1,
                  max: 100,
                  divisions: 5,
                  activeColor: Colors.green[700],
                  inactiveColor: Colors.green[300],
                  labels: labels,
                  values: values,
                  onChanged: (val) {
                    setState(() {
                      values = val;
                      labels = RangeLabels("${val.start.toInt().toString()}",
                          "${val.end.toInt().toString()}");
                    });
                  },
                ),
                Text("RangeSlider value = ${labels}"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    "Snackbar",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: RaisedButton(
                    child: Text('SHOW A SNACKBAR 1'),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Hello!'),
                        // action: SnackBarAction(
                        //     label: 'BacK', onPressed: _scaffoldkey.currentState!.hideCurrentSnackBar),
                      ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        child: Text('Indicator On'),
                        onPressed: () {
                          setState(() {
                            CircularIndicator = true;
                          });
                        },
                      ),
                      RaisedButton(
                        child: Text('Indicator Off'),
                        onPressed: () {
                          setState(() {
                            CircularIndicator = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    "Drop Down",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                ///Drop_Down
                DropdownButton(
                  style: TextStyle(fontSize: 25,color: Colors.black),
                  hint: Text("NAME"),
                  value: _value1,
                  onChanged: (String? value) {
                    setState(() {
                      _value1 = value!;
                    });
                  },
                  items: nameList.map(
                    (item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        ),
        CircularIndicator
            ? Center(child: CircularProgressIndicator())
            : SizedBox(),
      ],
    );
  }

  _datePicker() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime(2100),
    );
    // DatePicker = "";
    if (picker != null) {
      setState(() {
        DatePicker = picker;
      });

      print("DatePicker -->> $DatePicker");
    }

    // showDialog(builder: (BuildContext context) {
    //   return AlertDialog(title: Text("Open AlertDialog "),
    //   actions: [
    //     Text("Ok")
    //   ],);
    // }, context: context);
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>)? onSelectionChanged;
  final Function(List<String>)? onMaxSelected;
  final int? maxSelection;

  MultiSelectChip(this.reportList,
      {this.onSelectionChanged, this.onMaxSelected, this.maxSelection});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            if (selectedChoices.length == (widget.maxSelection ?? -1) &&
                !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                widget.onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
