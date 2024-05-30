// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/components/appBar.dart';
import 'package:repel/components/drawer.dart';
import 'package:repel/user_screens/home.dart';
import 'package:repel/user_screens/interestedpurchase.dart';
import 'package:repel/user_screens/interestedregister.dart';
import 'contactus.dart';

class Aquardent extends StatelessWidget {
  const Aquardent({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 780 ? AquardentWeb() : AquardentMobile();
  }
}

class AquardentWeb extends StatefulWidget {
  const AquardentWeb({super.key});

  @override
  State<AquardentWeb> createState() => _AquardentWebState();
}

class _AquardentWebState extends State<AquardentWeb> {
  var feederCapacity = '10kg';
  var floatingPlatformSize = '6 ft by 10 ft';
  var waterPumpMaxFlow = '3m3/h';
  var waterPumpVoltage = '12v DC';
  bool hasAcc = FirebaseAuth.instance.currentUser == null ? false : true;

  final List<String> iconsImage = [
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fcm.png?alt=media&token=2e2e312a-5712-4c9a-9051-32c4d79693ed',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fws.png?alt=media&token=c5df0ab5-de64-43a4-bfc3-6455a24b7d52',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Faf.png?alt=media&token=8802d7d9-a834-44f7-8967-8cfa9f402c1b',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fed.png?alt=media&token=3d9d96b7-67d6-49dd-966f-d21b746c416e',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fan.png?alt=media&token=07a2d84b-6ebe-4aa2-8acb-a9a78c7127ef',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fmm.png?alt=media&token=028e4a69-de0d-43a7-a6f9-5ccb63abe21d',
  ];

  int currentIndex = 0;
  final List<String> imagePaths = [
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Ffeeder.png?alt=media&token=e35a7195-8d98-4ba2-aeda-f3b1a902c0ea',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Ffeeder2.jpg?alt=media&token=fb3b8754-4791-44ca-ae79-caf6c4bc05f6',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Ffeeder3.jpg?alt=media&token=300c9dde-184a-44c1-b587-e525e5ae4e1d',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fpvc1.jpg?alt=media&token=a05b4d7f-325c-451b-b9a9-b5e9ce452848',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fpvc2.jpg?alt=media&token=c3f12c16-be73-48ac-92e7-20c3abb0b63d',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fpvc3.jpg?alt=media&token=762232e6-5853-4e58-bc88-d2913f5f7c02',
  ];

  void goToPreviousImage() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  void goToNextImage() {
    setState(() {
      if (currentIndex < iconsImage.length - 1) {
        currentIndex++;
      }
    });
  }

  bool exit = false;
  Future<bool> checkExist(String docID) async {
    bool exist = false;
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('orders').doc(docID).get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      print(e);
      return false;
    }
  }

  load() async {
    exit = await checkExist(FirebaseAuth.instance.currentUser!.uid);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: Center(
        child: Stack(
          children: [
            Container(
              color: Color(0xFFCECECE),
              width: double.infinity,
              height: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Flightbluegreen.png?alt=media&token=a69610e4-c58b-4a47-a7b4-3081ab69c9f9',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 25),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 700,
                                      height: 500,
                                      child: Image.network(
                                        '${imagePaths[currentIndex]}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 240, left: 10, right: 10),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: goToPreviousImage,
                                              icon: Icon(
                                                  Icons.arrow_back_ios_new)),
                                          Spacer(),
                                          IconButton(
                                              onPressed: goToNextImage,
                                              icon: Icon(
                                                  Icons.arrow_forward_ios)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: 40,
                                                  child: Image.asset(
                                                      'assets/aquardentw.png')),
                                              Text(
                                                'Located in Lingayen, Pangasinan',
                                                style: GoogleFonts
                                                    .firaSansCondensed(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      232, 255, 255, 255),
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Php 45,000',
                                                style: GoogleFonts
                                                    .firaSansCondensed(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 23,
                                                ),
                                              ),
                                              Text(
                                                'Php 3,750 / month',
                                                style: GoogleFonts
                                                    .firaSansCondensed(
                                                  color: const Color.fromARGB(
                                                      234, 255, 255, 255),
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Container(
                                        height: 100,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: iconsImage.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Image.network(
                                                '${iconsImage[index]}',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.fill,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '      ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Aquardent is an IoT-enabled automatic fish feeder with an early fish kill alert system and mitigation. By integrating a sun source and devices into the system our mobile and web application will provide accurate and precise data on water quality parameters enabling fish cultivators to monitor and optimize their fishponds.',
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'DETAILS',
                                          style: GoogleFonts.firaSansCondensed(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Feeder Capacity',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '$feederCapacity',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 3),
                                      child: Container(
                                        height: 2,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Floating Platform Size',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '$floatingPlatformSize',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 3),
                                      child: Container(
                                        height: 2,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Water Pump Max Flow',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '$waterPumpMaxFlow',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 3),
                                      child: Container(
                                        height: 2,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Water Pum Voltage',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '$waterPumpVoltage',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 3),
                                      child: Container(
                                        height: 2,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              hasAcc
                                                  ? Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              InterestedPurchase())))
                                                  : Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              InterestedRegister())));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.amber[300],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Text(
                                                hasAcc
                                                    ? exit
                                                        ? 'MY PURCHASE'
                                                        : 'PURCHASE'
                                                    : 'INTERESTED',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 5,
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          Home())));
                                              ContactDialog contactDialog =
                                                  ContactDialog();
                                              contactDialog.show(context);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Text(
                                                'Contact Seller',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AquardentMobile extends StatefulWidget {
  const AquardentMobile({Key? key}) : super(key: key);

  @override
  State<AquardentMobile> createState() => _AquardentMobileState();
}

class _AquardentMobileState extends State<AquardentMobile> {
  var feederCapacity = '10kg';
  var floatingPlatformSize = '6 ft by 10 ft';
  var waterPumpMaxFlow = '3m3/h';
  var waterPumpVoltage = '12v DC';
  bool hasAcc = FirebaseAuth.instance.currentUser == null ? false : true;

  final List<String> iconsImage = [
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fcm.png?alt=media&token=2e2e312a-5712-4c9a-9051-32c4d79693ed',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fws.png?alt=media&token=c5df0ab5-de64-43a4-bfc3-6455a24b7d52',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Faf.png?alt=media&token=8802d7d9-a834-44f7-8967-8cfa9f402c1b',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fed.png?alt=media&token=3d9d96b7-67d6-49dd-966f-d21b746c416e',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fan.png?alt=media&token=07a2d84b-6ebe-4aa2-8acb-a9a78c7127ef',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fmm.png?alt=media&token=028e4a69-de0d-43a7-a6f9-5ccb63abe21d',
  ];

  int currentIndex = 0;
  final List<String> imagePaths = [
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Ffeeder.png?alt=media&token=e35a7195-8d98-4ba2-aeda-f3b1a902c0ea',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Ffeeder2.jpg?alt=media&token=fb3b8754-4791-44ca-ae79-caf6c4bc05f6',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Ffeeder3.jpg?alt=media&token=300c9dde-184a-44c1-b587-e525e5ae4e1d',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fpvc1.jpg?alt=media&token=a05b4d7f-325c-451b-b9a9-b5e9ce452848',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fpvc2.jpg?alt=media&token=c3f12c16-be73-48ac-92e7-20c3abb0b63d',
    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fpvc3.jpg?alt=media&token=762232e6-5853-4e58-bc88-d2913f5f7c02',
  ];

  void goToPreviousImage() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  void goToNextImage() {
    setState(() {
      if (currentIndex < iconsImage.length - 1) {
        currentIndex++;
      }
    });
  }

  bool exit = false;
  Future<bool> checkExist(String docID) async {
    bool exist = false;
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('orders').doc(docID).get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      print(e);
      return false;
    }
  }

  Future<void> load() async {
    exit = await checkExist(FirebaseAuth.instance.currentUser!.uid);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.grey[400],
            ),
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  goToPreviousImage();
                } else {
                  goToNextImage();
                }
              },
              child: Container(
                child: Image.network(
                  '${imagePaths[currentIndex]}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 230,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: goToPreviousImage,
                      icon: Icon(Icons.arrow_back_ios_new)),
                  Spacer(),
                  IconButton(
                      onPressed: goToNextImage,
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 230.0),
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Flightbluegreen.png?alt=media&token=a69610e4-c58b-4a47-a7b4-3081ab69c9f9',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 250.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 40,
                                child: Image.asset('assets/aquardentw.png')),
                            Text(
                              'Located in Lingayen, Pangasinan',
                              style: GoogleFonts.firaSansCondensed(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(232, 255, 255, 255),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Php 45,000',
                              style: GoogleFonts.firaSansCondensed(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                            Text(
                              'Php 3,750 / month',
                              style: GoogleFonts.firaSansCondensed(
                                color: const Color.fromARGB(234, 255, 255, 255),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: iconsImage.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.network(
                            '${iconsImage[index]}',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '      ',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          TextSpan(
                            text:
                                'Aquardent is an IoT-enabled automatic fish feeder with an early fish kill alert system and mitigation. By integrating a sun source and devices into the system our mobile and web application will provide accurate and precise data on water quality parameters enabling fish cultivators to monitor and optimize their fishponds.',
                            style: GoogleFonts.firaSansCondensed(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'DETAILS',
                        style: GoogleFonts.firaSansCondensed(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          'Feeder Capacity',
                          style: GoogleFonts.firaSansCondensed(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '$feederCapacity',
                          style: GoogleFonts.firaSansCondensed(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          'Floating Platform Size',
                          style: GoogleFonts.firaSansCondensed(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '$floatingPlatformSize',
                          style: GoogleFonts.firaSansCondensed(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          'Water Pump Max Flow',
                          style: GoogleFonts.firaSansCondensed(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '$waterPumpMaxFlow',
                          style: GoogleFonts.firaSansCondensed(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          'Water Pum Voltage',
                          style: GoogleFonts.firaSansCondensed(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '$waterPumpVoltage',
                          style: GoogleFonts.firaSansCondensed(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => InterestedRegister())));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[300],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              hasAcc
                                  ? exit
                                      ? 'MY PURCHASE'
                                      : 'PURCHASE'
                                  : 'INTERESTED',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: 5,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => Home())));
                            ContactDialog contactDialog = ContactDialog();
                            contactDialog.show(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              'Contact Seller',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                  )
                ]),
              ),
            ),
          ],
        ));
  }
}
