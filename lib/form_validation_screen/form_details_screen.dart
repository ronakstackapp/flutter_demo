import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/form_model.dart';
import 'package:flutter_demo/screen/main_screen.dart';
import 'package:flutter_demo/screen/third_screen.dart';
import 'package:intl/intl.dart';
import 'form_validation_screen.dart';

class FormDetailsScreen extends StatefulWidget {
  // final FormModel? model;
  //
  // const FormDetailsScreen( this.model);
//  final List<FormModel>? formListModel;

//  const FormDetailsScreen({this.formListModel});
  @override
  _FormDetailsScreenState createState() => _FormDetailsScreenState();
}

class _FormDetailsScreenState extends State<FormDetailsScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
        await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MainScreen(4)), (route) => false);
        return false;
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return FormValidationScreen();
              }));
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
          body: ListView.builder(
            itemCount: listModel.length,
            itemBuilder: (BuildContext context, int index) {
              print("Data ${listModel[index].hobby}");
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("E-mail:- ${listModel[index].email}"),
                              Text("UserName:- ${listModel[index].userName}"),
                              Text("Number:- ${listModel[index].number}"),
                              // Text("DoB:- ${widget.model!.dob}"),
                              Text(
                                  "DoB :-  ${DateFormat('dd-MM-yyyy').format(listModel[index].dob ?? DateTime.now())}"),
                              Text("Gender:- ${listModel[index].gender}"),
                              Text(
                                  "Lang:- ${listModel[index].lang!.join(" ,")}"),
                              Text(
                                  "Hobby:- ${listModel[index].hobby!.join(', ')}"),
                              Text("Address:- ${listModel[index].address}"),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          listModel.removeAt(index);
                                        });
                                      },
                                      child: Icon(Icons.delete)),
                                ),
                              ),
                              Container(
                                height: 200,
                                width: 200,
                                child: Image.file(listModel[index].image!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}
