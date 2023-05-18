import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traders_builders_partner/TBTraders/TraderLogin.dart';
import '../models/traderdetails.dart';
import '../shared/TBAppColors.dart';

String logedInusername="";
String logedInuseremail="";
int logedInuserid=0;
String logedInuserPhoto="";

class TraderProfile extends StatefulWidget {
  const TraderProfile({Key? key}) : super(key: key);

  @override
  State<TraderProfile> createState() => _TraderProfileState();
}

class _TraderProfileState extends State<TraderProfile> {
  @override
  void initState() {
    super.initState();
    getUserPrefrences();
  }

  Future getUserPrefrences() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String traderDetailsJson =
    sharedPreferences.getString("traderDetails").toString();
    final TraderDetails traderDetails =
    TraderDetails.fromJson(jsonDecode(traderDetailsJson));
    String username = traderDetails.name;
    String useremail = traderDetails.email;
    int userid = traderDetails.id;
    String photopath =
        "http://mobyottadevelopers.online/traders/" + traderDetails.photo;
    print(photopath);
    setState(() {
      logedInuseremail = useremail;
      logedInusername = username;
      logedInuserid = userid;
      logedInuserPhoto = photopath;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Change background color
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, // set color of back button
        ),
      ),
      backgroundColor: Palette.appPrimaryLight,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              logedInuserPhoto,
                            ),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  logedInuserPhoto,
                                  fit: BoxFit.cover,
                                  height: 45,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                logedInusername.toString().split(" ").first.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                logedInuseremail.toString(),
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            child: FaIcon(FontAwesomeIcons.signOut),
                            onTap: () async {
                              logout();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                      SizedBox(height: 10,),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          GestureDetector(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 46,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Palette.appSecondaryDark
                                  ),
                                  child: FaIcon(FontAwesomeIcons.person,color: Colors.black,),
                                  alignment: Alignment.center,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Spacer(),
                                FaIcon(FontAwesomeIcons.chevronRight,size: 16,)

                              ],
                            ),
                            onTap: (){},
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 46,
                                  width: 46,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Palette.appSecondaryDark
                                  ),
                                  child: FaIcon(FontAwesomeIcons.gear,color: Colors.black,),
                                  alignment: Alignment.center,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  "Settings",
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Spacer(),
                                FaIcon(FontAwesomeIcons.chevronRight,size: 16,)

                              ],
                            ),
                            onTap: (){},
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 46,
                                width: 46,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Palette.appSecondaryDark
                                ),
                                child: FaIcon(FontAwesomeIcons.question,color: Colors.black,),
                                alignment: Alignment.center,
                              ),
                              SizedBox(width: 20,),
                              Text(
                                "About the app",
                                style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Spacer(),
                              FaIcon(FontAwesomeIcons.chevronRight,size: 16,)

                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 46,
                                width: 46,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Palette.appSecondaryDark
                                ),
                                child: FaIcon(FontAwesomeIcons.headset,color: Colors.black,),
                                alignment: Alignment.center,
                              ),
                              SizedBox(width: 20,),
                              Text(
                                "Help & Support",
                                style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Spacer(),
                              FaIcon(FontAwesomeIcons.chevronRight,size: 16,)

                            ],
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=>TraderLogin())
    );
  }

}
