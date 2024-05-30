import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/user_screens/interestedpurchase.dart';

class PurchaseDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _contentBox(context),
        );
      },
    );
  }

  static Widget _contentBox(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: 370,
          width: width > 800 ? 550 : 400,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 25, top: 5),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'Purchase',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) =>
                                        InterestedPurchase())));
                              },
                              icon: Icon(
                                Icons.payment_rounded,
                                color: Colors.amber,
                                size: 50,
                              )),
                        ],
                      ),
                    ),
                    Container(height: 5),
                    Text(
                      "Congratulations on registering! Get ready to take your aquaculture management to the next level. Complete your registration by purchasing our innovative product through our easy-to-use purchasing form. Let's start maximizing your fishpond's potential together!",
                      style: GoogleFonts.firaSansCondensed(
                        fontSize: 14,
                        color: Color.fromARGB(255, 12, 69, 70),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Container(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => InterestedPurchase())));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[400],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2, vertical: 2),
                            child: Text(
                              'Purchase',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
