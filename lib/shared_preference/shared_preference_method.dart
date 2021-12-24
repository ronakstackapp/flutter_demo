import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {


  static saveStr(String message) async {
    print("saveStr -->>> $message");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('name', message);
  }

  static  Future<String?> readPrefStr(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static saveModel(String key,String data)async{
    final SharedPreferences pref =await SharedPreferences.getInstance();
   return pref.setString(key, data);
  }

  static  modelRead(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }





 // static getStringValue() async {
 //    SharedPreferences myPrefs = await SharedPreferences.getInstance();
 //    String pref = myPrefs.getString('name') ?? "";
 //    return pref ;
 //  }

}