import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traders_builders_partner/TBTraders/TraderBookings.dart';
import '../models/traderdetails.dart';
import '../shared/TBAppColors.dart';

class TraderLogin extends StatefulWidget {
  const TraderLogin({Key? key}) : super(key: key);

  @override
  State<TraderLogin> createState() => _TraderLoginState();
}

class _TraderLoginState extends State<TraderLogin> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final traderDetails = await loginUser(email, password);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=>TraderBookings())
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Palette.appPrimaryDark
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Hey Tradey - Partner",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              "Panyi and Thompson Ltd.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset("assets/loginpageicon.png", height: 200,),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                        'Login',
                      style: TextStyle(
                          fontFamily: "Ubuntu",
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Palette.appPrimaryDark,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/forgotPassword');
                  },
                  child: const Text('Forgot Password?'),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/registration');
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Get started now',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
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
      ),
    );
  }

  Future<TraderDetails> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://mobyottadevelopers.online/traders/logintrader.php'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final message = jsonData['message'];
      final status = jsonData['status'];

      if (status == 'success') {
        final data = jsonData['data'];
        final traderId = data['trader_id'] != null ? int.tryParse(data['trader_id'].toString()) : null;
        final name = data['name'] != null ? data['name'].toString() : null;
        final email = data['email'] != null ? data['email'].toString() : null;
        final address = data['address'] != null ? data['address'].toString() : null;
        final postalCode = data['postal_code'] != null ? data['postal_code'].toString() : null;
        final photo = data['photo'] != null ? data['photo'].toString() : null;
        final serviceNames = data['service_names'] != null ? data['service_names'].toString() : null;
        final traderDetails = TraderDetails(
          id: traderId!,
          name: name!,
          email: email!,
          address: address!,
          postalCode: postalCode!,
          photo: photo!,
          serviceNames: (serviceNames as String).split(','),
        );

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('traderDetails', jsonEncode(traderDetails.toMap()));
        prefs.setInt('trader_id', traderId);

        return traderDetails;
      } else {
        throw Exception(message);
      }
    } else {
      throw Exception('Failed to connect to server.');
    }
  }
}
