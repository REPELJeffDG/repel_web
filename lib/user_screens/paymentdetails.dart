import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentDetailsDialog {
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
    return Stack(
      children: [
        Container(
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
          child: SingleChildScrollView(
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
                      left: 25, right: 10, bottom: 25, top: 5),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              'Payment Details',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 12, 69, 70),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.payment_rounded,
                                  color: Colors.amber,
                                  size: 30,
                                )),
                          ],
                        ),
                      ),
                      Text(
                        "Accomplish your payment on these accounts:",
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 14,
                          color: Color.fromARGB(255, 12, 69, 70),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Container(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Service',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Account Number',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'GCash',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                          Spacer(),
                          Text(
                            '0976 150 8552',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Pay Maya',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                          Spacer(),
                          Text(
                            '0976 150 8552',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'LandBank',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                          Spacer(),
                          Text(
                            'SA 2446 2283 97',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 350,
                  width: 350,
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fgcash.jpg?alt=media&token=584ef1a4-7aff-4095-88aa-e9fc62ae9347'),
                ),
                Container(
                  height: 350,
                  width: 350,
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fmaya.png?alt=media&token=c4e3ac8f-2150-49af-838e-ac38ee8b3b90'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
