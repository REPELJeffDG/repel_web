import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/user_screens/aquardent.dart';
import 'package:repel/user_screens/contactus.dart';
import 'package:repel/user_screens/customertestimonial.dart';
import 'package:repel/user_screens/home.dart';
import 'package:repel/user_screens/interestedpurchase.dart';
import 'package:repel/user_screens/interestedregister.dart';
import 'package:repel/user_screens/myprofile.dart';
import 'package:repel/user_screens/ourteam.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return FirebaseAuth.instance.currentUser == null
        ? DrawerNoAcc()
        : DrawerWithAcc();
  }
}

class DrawerWithAcc extends StatefulWidget {
  const DrawerWithAcc({super.key});

  @override
  State<DrawerWithAcc> createState() => _DrawerWithAccState();
}

class _DrawerWithAccState extends State<DrawerWithAcc> {
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
    return Drawer(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[200],
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bluegreen.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                    child: Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepellogo.png?alt=media&token=f7a0ffa1-eb7b-425e-85f6-830ef76b32e4'))),
              ),
              Container(
                height: 120,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 12, 69, 70),
                ),
                title: Text(
                  'Home',
                  style: GoogleFonts.firaSansCondensed(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 69, 70),
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) => Home())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.groups,
                  color: Color.fromARGB(255, 12, 69, 70),
                ),
                title: Text(
                  'Testimonials',
                  style: GoogleFonts.firaSansCondensed(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 69, 70),
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => CustomerTestimonial())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.electric_bolt_outlined,
                  color: Color.fromARGB(255, 12, 69, 70),
                ),
                title: Text(
                  'AquArdent',
                  style: GoogleFonts.firaSansCondensed(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 69, 70),
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => Aquardent())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.group,
                  color: Color.fromARGB(255, 12, 69, 70),
                ),
                title: Text(
                  'Our Team',
                  style: GoogleFonts.firaSansCondensed(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 69, 70),
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => OurTeam())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person_2,
                  color: Color.fromARGB(255, 12, 69, 70),
                ),
                title: Text(
                  'Profile',
                  style: GoogleFonts.firaSansCondensed(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 69, 70),
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => MyProfile())));
                },
              ),
              ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => InterestedPurchase())));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[300],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      exit ? 'My Purchase' : 'Purchase',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerNoAcc extends StatelessWidget {
  const DrawerNoAcc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[200],
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bluegreen.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                    child: Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepellogo.png?alt=media&token=f7a0ffa1-eb7b-425e-85f6-830ef76b32e4'))),
              ),
              Container(
                height: 120,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 12, 69, 70),
                ),
                title: Text(
                  'Home',
                  style: GoogleFonts.firaSansCondensed(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 69, 70),
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) => Home())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.groups,
                  color: Color.fromARGB(255, 12, 69, 70),
                ),
                title: Text(
                  'Testimonials',
                  style: GoogleFonts.firaSansCondensed(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 69, 70),
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => CustomerTestimonial())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.electric_bolt_outlined,
                  color: Color.fromARGB(255, 12, 69, 70),
                ),
                title: Text(
                  'AquArdent',
                  style: GoogleFonts.firaSansCondensed(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 69, 70),
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => Aquardent())));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.group,
                  color: Color.fromARGB(255, 12, 69, 70),
                ),
                title: Text(
                  'Our Team',
                  style: GoogleFonts.firaSansCondensed(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 69, 70),
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => OurTeam())));
                },
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //this change later
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => InterestedRegister())));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[300],
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          'Interested',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(height: 15),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: ((context) => Home())));
                        ContactDialog contactDialog = ContactDialog();
                        contactDialog.show(context);
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          'Contact Seller',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
