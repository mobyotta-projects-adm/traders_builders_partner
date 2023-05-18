import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traders_builders_partner/TBTraders/TraderBookings.dart';
import 'package:traders_builders_partner/models/BookingDetails.dart';
import 'package:traders_builders_partner/shared/constants.dart';
import 'package:http/http.dart' as http;
import '../models/traderdetails.dart';
import '../shared/TBAppColors.dart';

int logedInuserid = 0;

class TBViewBooking extends StatefulWidget {
  const TBViewBooking(
      {Key? key, required this.bookingId, required this.bookingDetails})
      : super(key: key);

  final String bookingId;
  final BookingDetails bookingDetails;

  @override
  State<TBViewBooking> createState() => _TBViewBookingState();
}

class _TBViewBookingState extends State<TBViewBooking> {
  @override
  void initState() {
    super.initState();
    getUserPrefrences();
  }

  bool _isLoading = false;

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
      body: _isLoading == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Booking #${widget.bookingDetails.bookingCode}",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        Spacer(),
                        Chip(
                          label: Text(
                            "${widget.bookingDetails.bookingStatus}",
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: widget
                                      .bookingDetails.bookingStatus ==
                                  TBPConstants.TBP_STATUS_PENDING
                              ? Colors.yellow.shade300
                              : widget.bookingDetails.bookingStatus ==
                                      TBPConstants.TBP_STATUS_ACCEPTED
                                  ? Colors.green
                                  : widget.bookingDetails.bookingStatus ==
                                          TBPConstants.TBP_STATUS_CANCELLED
                                      ? Colors.redAccent
                                      : widget.bookingDetails.bookingStatus ==
                                              TBPConstants.TBP_STATUS_QOUTED
                                          ? Colors.purple
                                          : widget.bookingDetails
                                                      .bookingStatus ==
                                                  TBPConstants
                                                      .TBP_STATUS_ONGOING
                                              ? Colors.blueAccent
                                              : widget.bookingDetails
                                                          .bookingStatus ==
                                                      TBPConstants
                                                          .TBP_STATUS_COMPLETED
                                                  ? Colors.orange
                                                  : Colors.purple,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description: ${widget.bookingDetails.description}",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Address: ${widget.bookingDetails.addressLineOne} ${widget.bookingDetails.addressLineTwo}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                          color: Colors.blueGrey),
                    ),
                    Text(
                      "${widget.bookingDetails.city}, ${widget.bookingDetails.postalCode}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                          color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Duration",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          "From: ${widget.bookingDetails.dateFrom}",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Ubuntu',
                              color: Colors.blueGrey),
                        ),
                        Spacer(),
                        Text(
                          "To: ${widget.bookingDetails.dateTo}",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Ubuntu',
                              color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Contact",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Phone: ${widget.bookingDetails.customerPhone}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                          color: Colors.blueGrey),
                    ),
                    Text(
                      "Email: ${widget.bookingDetails.customerEmail}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                          color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        // Show Accept and Decline buttons if booking status is Pending
                        widget.bookingDetails.bookingStatus ==
                                TBPConstants.TBP_STATUS_PENDING
                            ? Center(
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 16)),
                                      onPressed: () {
                                        // Handle Accept button press
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        updateBookingStatus(
                                            TBPConstants.TBP_STATUS_ACCEPTED);
                                      },
                                      child: Text('Accept'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 16)),
                                      onPressed: () {
                                        // Handle Decline button press
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        updateBookingStatus(
                                            TBPConstants.TBP_STATUS_CANCELLED);
                                      },
                                      child: Text('Decline'),
                                    ),
                                  ],
                                ),
                              )
                            : widget.bookingDetails.bookingStatus ==
                                    TBPConstants.TBP_STATUS_ACCEPTED
                                ? Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Palette.appPrimaryDark,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 16)),
                                      onPressed: () {
                                        // Handle Accept button pres

                                      },
                                      child: Text('Send Quote',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.white),),
                                    ),
                                  )
                                : Divider()
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> updateBookingStatus(String bookingStatus) async {
    final url = Uri.parse(
        'http://mobyottadevelopers.online/traders/acceptDeclineRequest.php');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = {
      "status_change_flag": bookingStatus,
      "trader_id": logedInuserid.toString(),
      "booking_id": widget.bookingDetails.bookingId.toString()
    };

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Update " + data['status']),
            content: Text(data['message']),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TraderBookings()));
                },
              ),
            ],
          ),
        );
      } else {
        final errorMessage = data['message'];
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    } else {
      print('HTTP request failed with status code: ${response.statusCode}');
    }
  }
}
