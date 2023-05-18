import 'dart:convert';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:toast/toast.dart';
import 'package:traders_builders_partner/TBTraders/TraderLogin.dart';
import 'package:traders_builders_partner/shared/TBAppColors.dart';
import 'dart:io' as Io;

import '../shared/MyFormData.dart';

class TradersCreateAccount extends StatefulWidget {
  final MyFormData myFormData;

  TradersCreateAccount({required this.myFormData});

  @override
  _TradersCreateAccountState createState() => _TradersCreateAccountState();
}

class _TradersCreateAccountState extends State<TradersCreateAccount> {
  List<GlobalKey<FormState>> formKeys = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> emailControllers = [];
  List<TextEditingController> phoneControllers = [];
  List<TextEditingController> passwordControllers = [];
  List<TextEditingController> addressControllers = [];
  List<TextEditingController> postalCodeControllers = [];
  List<File?> images = [];
  List<String?> imagesBase64 = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < int.parse(widget.myFormData.noOfEmployees); i++) {
      formKeys.add(GlobalKey<FormState>());
      nameControllers.add(TextEditingController());
      emailControllers.add(TextEditingController());
      phoneControllers.add(TextEditingController());
      passwordControllers.add(TextEditingController());
      addressControllers.add(TextEditingController());
      postalCodeControllers.add(TextEditingController());
      images.add(null);
      imagesBase64.add('');
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < int.parse(widget.myFormData.noOfEmployees); i++) {
      nameControllers[i].dispose();
      emailControllers[i].dispose();
      phoneControllers[i].dispose();
      addressControllers[i].dispose();
      postalCodeControllers[i].dispose();
    }
    super.dispose();
  }

  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Traders'),
      ),
      body: ListView.builder(
        itemCount: int.parse(widget.myFormData.noOfEmployees),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKeys[index],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trader ${index + 1}',
                    style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          final image = await ImagePicker().getImage(source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              images[index] = File(image.path);
                              imagesBase64[index] = imageTobase64Convert(image.path);
                            });
                          }
                        },
                        child: Text('Add Photo'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKeys[index].currentState!.validate()) {
                            formKeys[index].currentState!.save();
                          }
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  images[index] != null
                      ? Image.file(images[index]!,height: 150,)
                      : Container(),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nameControllers[index],
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(),
                        border: InputBorder.none,
                        filled: true,
                        hintText: "Name",
                        hintStyle: const TextStyle(
                            fontStyle: FontStyle.italic
                        ),
                        contentPadding: const EdgeInsets.all(18.0),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailControllers[index],
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(),
                        border: InputBorder.none,
                        filled: true,
                        hintText: "Email",
                        hintStyle: const TextStyle(
                            fontStyle: FontStyle.italic
                        ),
                        contentPadding: const EdgeInsets.all(18.0),
                      ),
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: phoneControllers[index],
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(),
                        border: InputBorder.none,
                        filled: true,
                        hintText: "Phone",
                        hintStyle: const TextStyle(
                            fontStyle: FontStyle.italic
                        ),
                        contentPadding: const EdgeInsets.all(18.0),
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordControllers[index],
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(),
                        border: InputBorder.none,
                        filled: true,
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            fontStyle: FontStyle.italic
                        ),
                        contentPadding: const EdgeInsets.all(18.0),
                      ),

                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: addressControllers[index],
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(),
                        border: InputBorder.none,
                        filled: true,
                        hintText: "Address",
                        hintStyle: const TextStyle(
                            fontStyle: FontStyle.italic
                        ),
                        contentPadding: const EdgeInsets.all(18.0),
                      ),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Address is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: postalCodeControllers[index],
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(),
                          border: InputBorder.none,
                          filled: true,
                          hintText: "Postal Code",
                          hintStyle: const TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                          contentPadding: const EdgeInsets.all(18.0),
                        ),
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.done,
                        maxLength: 8,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                        }),
                  ),

                  Divider(),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          submitForms();
        },
        backgroundColor: Palette.appPrimaryDark,
        icon: FaIcon(FontAwesomeIcons.save, color: Colors.white,),
        label: Text("SAVE DETAILS",style: TextStyle(color: Colors.white, fontSize: 14),),
      ),
    );
  }

  String imageTobase64Convert(String path){
    final bytes = Io.File(path);
    String img64 = base64Encode(bytes.readAsBytesSync());
    final mimetype=lookupMimeType(path);
    return "data:"+mimetype.toString()+";base64,"+img64;
  }

  void submitForms() async {
    bool allValid = true;
    for (int i = 0; i < int.parse(widget.myFormData.noOfEmployees); i++) {
      if (!formKeys[i].currentState!.validate()) {
        allValid = false;
      }
    }
    if (allValid) {
      List<Map<String, dynamic>> employees = [];
      for (int i = 0; i < int.parse(widget.myFormData.noOfEmployees); i++) {
        employees.add({
          "name": nameControllers[i].text,
          "email": emailControllers[i].text,
          "phone": phoneControllers[i].text,
          "address": addressControllers[i].text,
          "postal_code": postalCodeControllers[i].text,
          "photo": imagesBase64[i],
          "password": passwordControllers[i].text,
          "services": widget.myFormData.services,
        });
      }

      Map<String, dynamic> jsonData = {
        "is_company_employee": widget.myFormData.isCompanyEmployee,
        "company_name": widget.myFormData.companyName,
        "traders": employees,
      };


      String jsonString = json.encode(jsonData);

      var url=Uri.parse("http://mobyottadevelopers.online/traders/addtraders.php");
      var response=await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          encoding: Encoding.getByName("utf-8"),
          body:jsonString
      );
      var data=json.decode(response.body);

      if(response.statusCode==200){
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Success'),
            content: Text('Account created successfully, you can login now'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => TraderLogin()));
                },
              ),
            ],
          ),
        );
      }

    }
  }
}

