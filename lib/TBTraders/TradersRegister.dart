import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:toast/toast.dart';
import 'package:traders_builders_partner/TBTraders/TradersCreateAccount.dart';
import 'package:traders_builders_partner/shared/MyFormData.dart';
import 'package:traders_builders_partner/shared/TBAppColors.dart';
import 'package:http/http.dart' as http;
import 'package:traders_builders_partner/shared/TBCustomDropDown.dart';

import '../models/servicesListModel.dart';

class TradersRegister extends StatefulWidget {
  const TradersRegister({Key? key}) : super(key: key);

  @override
  State<TradersRegister> createState() => _TradersRegisterState();
}

class _TradersRegisterState extends State<TradersRegister> {
  final List<String> userTraderTypeItems = [
    'I\'m an Individual',
    'This is a Company',
  ];
  String? userTraderType;
  String numberOfEmployees="0";
  final _formKey = GlobalKey<FormState>();
  List<String> _selectedOptions = [];
  List<ServicesListModel> _options = [];
  bool _isEmployeesNoVisisble = false;
  String company_name = "";
  TextEditingController companyNameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Palette.appPrimaryLight,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Tell us about who you are and what you do",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Who you are",
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 10,),

                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          //Add more decoration as you want here
                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                        ),
                        isExpanded: true,
                        hint: const Text(
                          "Select user type",
                          style: TextStyle(fontSize: 14),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                        buttonHeight: 60,
                        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        items: userTraderTypeItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Ubuntu'
                                ),
                              ),
                            ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select user type.';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            if(value == userTraderTypeItems[1]){
                              _isEmployeesNoVisisble = true;
                            }
                            if(value == userTraderTypeItems[0]){
                              _isEmployeesNoVisisble = false;
                              numberOfEmployees = "1";
                            }
                          });//Do something when changing the item if you want.
                        },
                        onSaved: (value) {
                          userTraderType = value.toString();
                        },
                      ),
                      SizedBox(height: 30,),
                      Visibility(
                        visible: _isEmployeesNoVisisble,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name of the company",
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(),
                                border: InputBorder.none,
                                filled: true,
                                hintText: "Company Name",
                                hintStyle: const TextStyle(
                                    fontStyle: FontStyle.italic
                                ),
                                contentPadding: const EdgeInsets.all(18.0),
                              ),
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the name of the company';
                                }
                                return null;
                              },
                              controller: companyNameController,
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _isEmployeesNoVisisble,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "How many employees do you have",
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(height: 10,),
                            DropdownButtonFormField2(
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: const Text(
                                "Select no. of employees",
                                style: TextStyle(fontSize: 14),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              buttonHeight: 60,
                              buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: ['2','3','4','5']
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Ubuntu'
                                      ),
                                    ),
                                  ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select no. of employees.';
                                }
                              },
                              onChanged: (value) {
                                numberOfEmployees = value.toString();
                              },
                              onSaved: (value) {
                                numberOfEmployees = value.toString();
                              },
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      ),
                      Text(
                        "What you do",
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 10,),
                      FutureBuilder<List<ServicesListModel>>(
                        future: _fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            _options = snapshot.data!;

                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: DropdownButton(
                                  items: _options.map((option) => DropdownMenuItem(
                                    child: Text(option.serviceName),
                                    value: option.serviceId,
                                  )).toList(),
                                  isExpanded: true,
                                  onChanged: (selectedValue) {
                                    setState(() {
                                      if (_selectedOptions.contains(selectedValue)) {
                                        _selectedOptions.remove(selectedValue);
                                      } else {
                                        _selectedOptions.add(selectedValue.toString());
                                        print(_selectedOptions);
                                      }
                                    });
                                  },
                                  value: _selectedOptions.isNotEmpty ? _selectedOptions.last : null,
                                  hint: Text('Select options'),

                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          return CircularProgressIndicator();
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: _selectedOptions.map((id) {
                          final service = _options.firstWhere((service) => service.serviceId == id);
                          return Chip(
                            backgroundColor: Palette.kToDark.shade600,
                            label: Text(service.serviceName),
                            onDeleted: () {
                              setState(() {
                                _selectedOptions.remove(id);
                              });
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Palette.appPrimaryDark,
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                            ),
                            onPressed: (){
                              if(_formKey.currentState!.validate()) {
                                setState(() {
                                  company_name = companyNameController.text.trim();
                                });
                                _formKey.currentState!.save();
                                  if(_selectedOptions.isEmpty == false){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context)=>TradersCreateAccount(myFormData: new MyFormData(isCompanyEmployee: _isEmployeesNoVisisble, companyName: company_name, services: _selectedOptions, noOfEmployees: numberOfEmployees),))
                                    );
                                  }
                                  else {
                                    Toast.show("Please select at least one option in What you do", gravity: Toast.center, duration: Toast.lengthLong);
                                  }
                              }
                            },
                            child: Text(
                              "Next: Personal details",
                              style: TextStyle(
                                  fontFamily: "Ubuntu",
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
  Future<List<ServicesListModel>> _fetchData() async {
    var response = await http.get(Uri.parse('http://mobyottadevelopers.online/traders/servicelist.php'));
    var jsonData = json.decode(response.body);
    List allServices = jsonData;
    return allServices.map((e) => new ServicesListModel.fromJson(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }



  

}
