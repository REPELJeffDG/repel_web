import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationDialog {
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
          height: width > 800 ? 440 : 500,
          width: width > 800 ? 550 : 340,
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
                    left: 25, right: 10, bottom: 25, top: 5),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'Location',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.map_outlined,
                                color: Colors.amber,
                                size: 50,
                              )),
                        ],
                      ),
                    ),
                    Container(height: 5),
                    Text(
                      'Our revolutionary aquaculture solution, is now stocked at your local multipurpose cooperative. To those who are interested please go to your local cooperatives and inquire!',
                      style: GoogleFonts.firaSansCondensed(
                        fontSize: 14,
                        color: Color.fromARGB(255, 12, 69, 70),
                      ),
                    ),
                    Container(height: 15),
                    Text(
                      'Western Lingayen Multi Purpose Cooperative',
                      style: GoogleFonts.firaSansCondensed(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 12, 69, 70),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_on,
                              color: Color.fromARGB(255, 12, 69, 70),
                              size: 30,
                            )),
                        Text(
                          '25GR+QFC, National Road, \nLingayen, \n2401 Pangasinan',
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 14,
                            color: Color.fromARGB(255, 12, 69, 70),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.phone,
                                color: Color.fromARGB(255, 12, 69, 70),
                                size: 30)),
                        Text(
                          '09282750664',
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 14,
                            color: Color.fromARGB(255, 12, 69, 70),
                          ),
                        ),
                        Container(
                          width: 120,
                        )
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
