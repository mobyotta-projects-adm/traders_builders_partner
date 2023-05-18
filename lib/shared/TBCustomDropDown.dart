import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TBCustomDropDown extends StatefulWidget {

  @override
  _TBCustomDropDownState createState() => _TBCustomDropDownState();
}

class _TBCustomDropDownState extends State<TBCustomDropDown> {
  String _selectedItem = "";
  List<Map<String, String>> _services = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    fetchData().then((services) {
      setState(() {
        _loading = false;
        _services = services;
      });
    });
  }

  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedItem,
            items: _services.map((Map<String, String> service) {
              return DropdownMenuItem<String>(
                value: service['id'],
                child: Text(service['name'].toString()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => _selectedItem = value!);

            },
          ),
        ),
      );
    }
  }
}

Future<List<Map<String, String>>> fetchData() async {
  final response = await http.get(Uri.parse('https://traders.anaskhansays.co.in/servicelist.php'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data);
    final services = data as List;
    return services.map((service) => { 'id': service['service_id'].toString(), 'name': service['service_name'].toString() }).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
