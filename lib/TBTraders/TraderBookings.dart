import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traders_builders_partner/TBTraders/TBViewBooking.dart';
import 'package:traders_builders_partner/TBTraders/TraderProfile.dart';
import '../models/BookingDetails.dart';
import '../models/traderdetails.dart';
import '../shared/TBAppColors.dart';
import 'package:http/http.dart' as http;

import '../shared/constants.dart';

String logedInusername="";
String logedInuseremail="";
int logedInuserid=0;
String logedInuserPhoto="";
class TraderBookings extends StatefulWidget {
  const TraderBookings({Key? key}) : super(key: key);

  @override
  State<TraderBookings> createState() => _TraderBookingsState();
}


class _TraderBookingsState extends State<TraderBookings> {


  @override
  void initState() {
    super.initState();
    getUserPrefrences().whenComplete(() => _fetchBookings());

  }

  List<BookingDetails> _bookings = [];


  Future<void> _fetchBookings() async {
    String url =
        'http://mobyottadevelopers.online/traders/traderBookings.php?trader_id=${logedInuserid}';
    // print(url);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)["data"];
      List<BookingDetails> bookings =
      data.map((booking) => BookingDetails.fromJson(booking)).toList();
      setState(() {
        _bookings = bookings;
      });
    } else {
      print("Failed to load bookings.");
    }
  }


  Future getUserPrefrences() async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String traderDetailsJson=sharedPreferences.getString("traderDetails").toString();
    final TraderDetails traderDetails = TraderDetails.fromJson(jsonDecode(traderDetailsJson));
    String username=traderDetails.name;
    String useremail=traderDetails.email;
    int userid=traderDetails.id;
    String photopath = "http://mobyottadevelopers.online/traders/"+traderDetails.photo;
    // print(photopath);
    setState(() {
      logedInuseremail=useremail;
      logedInusername=username;
      logedInuserid=userid;
      logedInuserPhoto=photopath;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appPrimaryLight,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 58, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, $logedInusername",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Ubuntu',
                                  color: Colors.black
                                ),
                              ),
                              SizedBox(height: 3,),
                              Text(
                                "$logedInuseremail",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                  color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            child: CircleAvatar(
                              child: FaIcon(
                                FontAwesomeIcons.solidBell,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              backgroundColor: Palette.appPrimaryDark,
                              radius: 20.0,
                            ),
                            onTap: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: CircleAvatar(
                              child: FaIcon(
                                FontAwesomeIcons.solidUser,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              backgroundColor: Palette.appPrimaryDark,
                              radius: 20.0,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TraderProfile()));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Text(
                        "My Diary: Bookings",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.arrowRightLong,color: Colors.black,),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: _bookings.length == 0 ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/nodatafound.png',height: 80,),
                SizedBox(height: 20,),
                Text(
                  'You don\'t have any bookings right now',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
    ) : ListView.builder(
                itemCount: _bookings.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 5, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Booking #${_bookings[index].bookingCode}",
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Spacer(),
                                    Chip(
                                      label: Text(
                                        "${_bookings[index].bookingStatus}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      backgroundColor: _bookings[index].bookingStatus ==
                                          TBPConstants.TBP_STATUS_PENDING
                                          ? Colors.yellow.shade300
                                          : _bookings[index].bookingStatus ==
                                          TBPConstants.TBP_STATUS_ACCEPTED
                                          ? Colors.green
                                          : _bookings[index].bookingStatus ==
                                          TBPConstants.TBP_STATUS_CANCELLED
                                          ? Colors.redAccent
                                          : _bookings[index].bookingStatus ==
                                          TBPConstants.TBP_STATUS_QOUTED
                                          ? Colors.purple
                                          : _bookings[index].bookingStatus ==
                                          TBPConstants.TBP_STATUS_ONGOING
                                          ? Colors.blueAccent
                                          : _bookings[index].bookingStatus ==
                                          TBPConstants
                                              .TBP_STATUS_COMPLETED
                                          ? Colors.orange
                                          : Colors.purple,
                                    )
                                  ],
                                ),
                                Text(
                                  "Description: ${_bookings[index].description}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Address: ${_bookings[index].addressLineOne} ${_bookings[index].addressLineTwo}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.blueGrey),
                                ),
                                Text(
                                  "${_bookings[index].city}, ${_bookings[index].postalCode}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.blueGrey),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${_bookings[index].creationDatetime}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.blueGrey),
                                    ),
                                    Spacer(),
                                    FaIcon(FontAwesomeIcons.arrowRightLong),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>TBViewBooking(bookingId: _bookings[index].bookingId, bookingDetails: _bookings[index],))
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
