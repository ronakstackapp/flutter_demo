import 'dart:io';

class FormModel{

  String? userName;
  String? email;
  String? number;
  DateTime? dob;
  String? gender;
  List<String>? hobby;
  List<String>? lang;
  String? address;
  File? image;


  FormModel({
    this.userName,
    this.email,
    this.number,
    this.dob,
    this.gender,
    this.address,
    this.hobby,
    this.lang,
    this.image
  });


}