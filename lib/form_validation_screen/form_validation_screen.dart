import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/common_widget/textfield_widget.dart';
import 'package:flutter_demo/model/form_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'form_details_screen.dart';
import 'form_validation_second.dart';

class FormValidationScreen extends StatefulWidget {
  @override
  FormValidationScreenState createState() => FormValidationScreenState();
}

List<FormModel> listModel = [];

class FormValidationScreenState extends State<FormValidationScreen> {
  final _key = GlobalKey<FormState>();

  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController conformPassController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  int gender = 0;
  String genderName = "";
  List<String> hobbiesList = [];
  List<String> langList = [];
  bool hobby1 = false;
  bool hobby2 = false;
  bool hobby3 = false;
  bool lang1 = false;
  bool lang2 = false;
  bool lang3 = false;
  bool privacy = true;
  bool teams = true;

  bool isDoB = false;
  bool img = false;

  DateTime dateOfBirth = DateTime.now();
  String? username;
  String username1 = "";

  // List<FormModel> listModel = [];

  File? imageFile;
  PlatformFile? file;

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    print("_getFromGallery -->>$imageFile");
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _getFromVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result == null) return;
    file = result.files.first;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: img ? Colors.red: Color(0xFF64B5F6),
                        child: CircleAvatar(
                            backgroundColor: img ? Colors.red: Colors.white,
                            radius: 48,
                            child: imageFile != null
                                ? CircleAvatar(
                                    backgroundImage: FileImage(imageFile!),
                                    radius: 47,
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 47,
                                  )),
                      ),
                      Positioned(
                        bottom: 8,
                        right: -6,
                        child: InkWell(
                          onTap: () {
                            _getFromGallery();
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Color(0xFF64B5F6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              /*  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _getFromVideo();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Color(0xFF64B5F6),
                        ),
                      ),
                      file ==null ? Container(height: 100,width: 100,color: Colors.red,):Container(height: 100,width: 100,color: Colors.yellow,)
                    ],
                  ),
                ),*/
                ///**PICK FROM GALLERY*** & **PICK FROM CAMERA***
                // Container(
                //     child: imageFile == null
                //         ? Container(
                //             alignment: Alignment.center,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: <Widget>[
                //                 RaisedButton(
                //                   color: Colors.greenAccent,
                //                   onPressed: () {
                //                     _getFromGallery();
                //                   },
                //                   child: Text("PICK FROM GALLERY"),
                //                 ),
                //                 Container(
                //                   height: 40.0,
                //                 ),
                //                 RaisedButton(
                //                   color: Colors.lightGreenAccent,
                //                   onPressed: () {
                //                     _getFromCamera();
                //                   },
                //                   child: Text("PICK FROM CAMERA"),
                //                 )
                //               ],
                //             ),
                //           )
                //         : Container(
                //             child: Image.file(
                //               imageFile!,
                //               fit: BoxFit.cover,
                //             ),
                //           )),
                NewWidget(
                    onChanged: (value) {
                      setState(() {
                        username = value;
                        username1 = value;
                      });
                    },
                    textInputAction: TextInputAction.next,
                    userController: userController,
                    hintText: "UserName",
                    validator: (String? value) {
                      //   String Patten2 = r"^[a-zA-Z_ ]{6,}*$";
                      RegExp regex = RegExp(r'^[a-zA-Z]+$');
                      if (value == null || value.isEmpty) {
                        return 'Enter User Name';
                      } else if (!regex.hasMatch(value)) {
                        return 'Only Alphabet Allow';
                      } else
                        return null;
                    }
                    ),
                NewWidget(
                    textInputAction: TextInputAction.next,
                    userController: emailController,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      String pattern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      RegExp regex = RegExp(pattern);
                      if (value == null ||
                          value.isEmpty ||
                          !regex.hasMatch(value))
                        return 'Enter a valid email address';
                      else
                        return null;
                    }

                    ),
                NewWidget(
                    textInputAction: TextInputAction.next,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    userController: phoneNumberController,
                    hintText: "PhoneNumber",
                    validator: (String? value) {
                      String patten1 = r"^(?:[+0]9)?[0-9]{10}$";
                      RegExp regex1 = RegExp(patten1);
                      if (value == null || value.isEmpty) {
                        return 'Enter Phone Number';
                      } else if (phoneNumberController.text.length <= 9 ||
                          !regex1.hasMatch(value)) {
                        return 'Enter Valid Number';
                      } else
                        return null;
                    }),
                NewWidget(
                    textInputAction: TextInputAction.done,
                    userController: passwordController,
                    hintText: "Enter PassWord",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter PassWord';
                      } else if (passwordController.text.length <= 5) {
                        return 'Max 6 character PassWord';
                      } else
                        return null;
                    }
                    ),
                NewWidget(
                    textInputAction: TextInputAction.done,
                    userController: conformPassController,
                    hintText: "Confirm Password ",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter PassWord';
                      } else if (passwordController.text !=
                          conformPassController.text) {
                        return 'Password not Match';
                      } else if (conformPassController.text.length <= 5) {
                        return 'Max 6 character PassWord';
                      } else
                        return null;
                    }),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 12, bottom: 5),
                  child: Container(
                    height: 58,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:
                            isDoB
                                ? Color(0xFFd32f2f)
                                : Color(0xFF64B5F6),
                            width: 0.8),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${DateFormat('dd/MM/yyyy').format(dateOfBirth)}"),
                          InkWell(
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());

                                DateTime? Picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1800),
                                    lastDate: DateTime(2100));
                                if (Picked != null) {
                                  setState(() {
                                    dateOfBirth = Picked;
                                  });
                                }

                              },
                              child: Icon(
                                Icons.date_range_outlined,
                                color: isDoB
                                    ? Color(0xFFd32f2f)
                                    : Color(0xFF64B5F6),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                isDoB
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 12),
                        child: Row(
                          children: [
                            Text(
                              "adult only allowed",
                              style: TextStyle(
                                  color: Color(0xFFd32f2f), fontSize: 10),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Text(
                        "Gender:-",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      _commonRadio(1, "Male"),
                      _commonRadio(2, "Female"),
                      _commonRadio(3, "Other")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Text(
                        "Hobbies:-",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                _hobbiesCheckBox(),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Text(
                        "language :-",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                _languageCheckBox(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Scrollbar(
                      interactive: true,
                      radius: Radius.circular(10),
                      controller: _scrollController,
                      child: TextField(
                        controller: addressController,
                        scrollController: _scrollController,
                        scrollPhysics: BouncingScrollPhysics(),
                        scrollPadding: const EdgeInsets.only(top: 8, bottom: 8),
                        maxLines: 5,
                        showCursor: false,
                        maxLength: 80,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8, bottom: 8),
                            hintText: "Address.....",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF64B5F6),
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(20)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: teams,
                            onChanged: (bool? value) {
                              setState(() {
                                teams = value!;
                              });
                            },
                          ),
                          Text("Terms And Conditions")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: privacy,
                            onChanged: (bool? value) {
                              setState(() {
                                privacy = value!;
                              });
                            },
                          ),
                          Text("Privacy Policy")
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      print(
                          "Done 00 DateTime -->${DateTime.now().year - dateOfBirth.year > 18}");

                      FormModel formModel = FormModel(
                          address: addressController.text,
                          userName: userController.text,
                          email: emailController.text,
                          number: phoneNumberController.text.toString(),
                          dob: dateOfBirth,
                          gender: genderName,
                          hobby: hobbiesList,
                          lang: langList,
                          image: imageFile);

                      print("formModel imageFile--->>${formModel.image}");

                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (BuildContext context) {
                      //   return FormDetailsScreen(formListModel: listModel,);
                      // }));

                      if ((_key.currentState!.validate() && (DateTime.now().year - dateOfBirth.year > 18)) && (imageFile != null)  ) {
                        setState(() {
                          img =false;
                          isDoB = false;
                        });


                        print("Done 00 -->>");
                        FocusScope.of(context).requestFocus(FocusNode());
                        listModel.add(formModel);
                        print("Model ~~~~~~~$formModel");
                        print("ListData ~~~~~~~${listModel.length}");

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return FormDetailsScreen();
                            }));

                        // if (DateTime.now().year - dateOfBirth.year > 18) {
                        //   print("DateTime.now().year - dateOfBirth.year > 18-->> ${DateTime.now().year - dateOfBirth.year > 18}");
                        //   setState(() {
                        //     isDoB = false;
                        //   });
                        //   print("Done 00 -->>");
                        //   FocusScope.of(context).requestFocus(FocusNode());
                        //   listModel.add(formModel);
                        //   print("Model ~~~~~~~$formModel");
                        //   print("ListData ~~~~~~~${listModel.length}");
                        //
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (BuildContext context) {
                        //     return FormDetailsScreen();
                        //   }));
                        // } else {
                        //   print("dateOfBirth -->");
                        //   setState(() {
                        //     isDoB = true;
                        //   });
                        // }


                      } else {
                        FocusScope.of(context).requestFocus(FocusNode());
                        // setState(() {
                        //   isDoB = true;
                        // });

                        // if((DateTime.now().year - dateOfBirth.year > 18) == false){
                        //   setState(() {
                        //     isDoB = true;
                        //   });
                        // }
                        print("Done  11");
                        if(imageFile == null && ((DateTime.now().year - dateOfBirth.year > 18) == false) ){
                          print("imageFile && Date ->> false");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload Img")));
                          setState(() {
                            img = true;
                            isDoB = true;
                          });
                        }else if(imageFile == null &&  ((DateTime.now().year - dateOfBirth.year > 18) == true)){
                          print("imageFile && Date ->> true");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload Img")));
                          setState(() {
                            img = true;
                            isDoB = false;
                          });
                        }

                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 20),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _hobbiesCheckBox() {
    return Row(
      children: [
        Row(
          children: [
            Checkbox(
              value: hobby1,
              onChanged: (bool? value) {
                setState(() {
                  hobby1 = value!;
                  if (hobby1) {
                    hobbiesList.add("Cricket");
                  }
                });
              },
            ),
            Text("Cricket")
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: hobby2,
              onChanged: (bool? value) {
                setState(() {
                  hobby2 = value!;
                  if (hobby2) {
                    hobbiesList.add("Traveling");
                  }
                });
              },
            ),
            Text("Traveling")
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: hobby3,
              onChanged: (bool? value) {
                setState(() {
                  hobby3 = value!;
                  if (hobby3) {
                    hobbiesList.add("Reading");
                  }
                });
              },
            ),
            Text("Reading")
          ],
        )
      ],
    );
  }

  Row _languageCheckBox() {
    return Row(
      children: [
        Row(
          children: [
            Checkbox(
              value: lang1,
              onChanged: (bool? value) {
                setState(() {
                  lang1 = value!;
                  if (lang1) {
                    langList.add("Hindi");
                  }
                });
              },
            ),
            Text("Hindi")
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: lang2,
              onChanged: (bool? value) {
                setState(() {
                  lang2 = value!;
                  if (lang2) {
                    langList.add("English");
                  }
                });
              },
            ),
            Text("English")
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: lang3,
              onChanged: (bool? value) {
                setState(() {
                  lang3 = value!;
                  if (lang3) {
                    langList.add("Gujarati");
                  }
                });
              },
            ),
            Text("Gujarati")
          ],
        )
      ],
    );
  }

  Row _commonRadio(int val, String text) {
    return Row(
      children: [
        Radio(
          onChanged: (int? value) {
            setState(() {
              gender = value!;
              if (gender == 1) {
                genderName = "Male";
              } else if (gender == 2) {
                genderName = "FeMale";
              } else {
                genderName = "Other";
              }
            });
          },
          groupValue: gender,
          value: val,
        ),
        Text(text)
      ],
    );
  }
}
