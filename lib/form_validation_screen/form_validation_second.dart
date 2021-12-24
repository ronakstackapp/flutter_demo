import 'package:flutter/material.dart';
import 'form_validation_screen.dart';

class SecondValidation extends StatefulWidget {
  @override
  _SecondValidationState createState() => _SecondValidationState();
}

class _SecondValidationState extends State<SecondValidation> {
  TextEditingController _controller = TextEditingController();
  bool isValidation = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  if (_controller.text.isEmpty) {
                    print("setState...........");
                    isValidation = true;
                  }else{
                    isValidation = false;
                  }
                });
              },
              decoration: InputDecoration(
                  hintText: "Text.........",
                  filled: true,
                  fillColor: Colors.green[100],
                  border: OutlineInputBorder()),
            ),
          ),

          isValidation ?  Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text("Enter valid Data",textAlign: TextAlign.left,style: TextStyle(color: Colors.red),),
              ],
            ),
          ):SizedBox(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Back")),
                ElevatedButton(
                    onPressed: () {
                     if(_controller.text.isEmpty){
                       setState(() {
                         isValidation = true;
                       });
                     }else{
                       print(" else --->> isValidation $isValidation");
                     }
                    },
                    child: Text("Save")),
                SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
