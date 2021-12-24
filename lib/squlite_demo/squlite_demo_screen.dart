import 'package:flutter/material.dart';
import 'package:flutter_demo/squlite_demo/datebase_helper_demo.dart';
import 'package:form_field_validator/form_field_validator.dart';




class DesignPage extends StatefulWidget {


  // const DesignPage({Key? key}) : super(key: key);

  @override
  _DesignPageState createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {

  final dbHelper = DataBaseManager.instance;

  final List<GoldModel> selectGoldItems = [
    // GoldModel('0', "Please Select Item"),
    GoldModel('1', "Bangles"),
    GoldModel('2', "Bangles Rings"),
    GoldModel('3', "Bracelet"),
    GoldModel('4', "Chain"),
    GoldModel('5', "Gold Bars"),
    GoldModel('6', "Gold Coins"),
    GoldModel('7', "Gold Earrings"),
    GoldModel('8', "Gold Jewellery"),
    GoldModel('9', "Rings"),
  ];

  String? selectedItem;

  List<TextEditingController> controller =
  List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// DropdownButton

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton(
                  items: selectGoldItems
                      .map((e) => DropdownMenuItem(
                    child: Text(e.item!),
                    value: e.id!,
                  ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedItem = value;
                    });
                  },
                  value: selectedItem,
                  hint: const Text("Please Select Item"),
                  // alignment: Alignment.center,
                  isDense: false,
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              /// Quantity
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,validator: MultiValidator([RequiredValidator(errorText: "Input value")]),
                  controller: controller[0],
                  decoration: InputDecoration(
                      hintText: "Quantity",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),

              /// Pocket

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,validator: MultiValidator([RequiredValidator(errorText: "Input value")]),
                  controller: controller[1],
                  decoration: InputDecoration(
                      hintText: "Pocket",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),

              /// Gross Weight

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,validator: MultiValidator([RequiredValidator(errorText: "Input value")]),
                  controller: controller[2],
                  decoration: InputDecoration(
                      hintText: "Gross Weight",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),

              /// Deduction Quantity

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,validator: MultiValidator([RequiredValidator(errorText: "Input value")]),
                  decoration: InputDecoration(
                      hintText: "Deduction Quantity : 0",
                      enabled: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),

              /// Deduction Weight

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(controller: controller[2],validator: MultiValidator([RequiredValidator(errorText: "Input value")]),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: controller[2].text.isEmpty ? "Deduction Weight":"${controller[2].text}",

                      enabled: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),

              /// Net Weight

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(controller: controller[3],
                  keyboardType: TextInputType.number,validator: MultiValidator([RequiredValidator(errorText: "Input value")]),
                  decoration: InputDecoration(enabled: false,
                      hintText: "Net Weight",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),

              /// Risk Class

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,validator: MultiValidator([RequiredValidator(errorText: "Input value")]),
                  decoration: InputDecoration(
                      hintText: "Risk Class",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),

              /// Submit Button

              Center(
                  child:
                  TextButton(onPressed: () {
                    _insert();
                  }, child: const Text("Submit"))),
              SizedBox(height: 10,),
              Center(
                  child:
                  TextButton(onPressed: () {
                    _getData();
                  }, child: const Text("Get Data"))),
              SizedBox(height: 10,),
              Center(
                  child:
                  TextButton(onPressed: () {
                    _deleteData();
                  }, child: const Text("Delete Data"))),
              SizedBox(height: 10,),
              Center(
                  child:
                  TextButton(onPressed: () {
                    _deleteAllDate();
                  }, child: const Text("All Delete Data"))),
              Center(
                  child:
                  TextButton(onPressed: () {
                    _selectName();
                  }, child: const Text("Select Name Data"))),
            ],
          )
        ],
      ),
    );
  }


  void _insert() async {

    var data = DataModel(selectedItem, controller[0].text, controller[1].text, controller[2].text, controller[2].text, controller[3].text);


    final id = await dbHelper.insert(data);
    print('inserted row id: $id');
  }

 void _getData() async {
    final id = (await dbHelper.queryAllRows());
 //   final id = (await dbHelper.queryAllRows())[0]['pocket'];
    print('_getData id: $id');
   print('query all rows:');
    id.forEach(print);
  //  id.where((element) => element = )

   // void _query() async {
   //   final allRows = await dbHelper.queryAllRows();
   //   print('query all rows:');
   //   allRows.forEach(print);
   // }
  }

void _deleteData() async {
    final id = await dbHelper.delete(1);
    print('Delete id: $id');
  }

void _deleteAllDate() async {
    final id = await dbHelper.deleteAllData();
    print('Delete id: $id');
  }
void _selectName() async {
    final id = await dbHelper.SelectName();
    print('_selectName: $id');
  }

}



class GoldModel {
  String? id;
  String? item;

  GoldModel(this.id, this.item);
}

class DataModel {
  String? itemName;
  String? quantity;
  String? pocket;
  String? grossWeight;
  String? deductionWeight;
  String? riskClass;

  DataModel(this.itemName, this.quantity, this.pocket, this.grossWeight,
      this.deductionWeight, this.riskClass);
}