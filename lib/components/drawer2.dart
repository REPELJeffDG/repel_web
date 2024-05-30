import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/user_screens/aquardent.dart';
import 'package:repel/user_screens/contactus.dart';
import 'package:repel/user_screens/customertestimonial.dart';
import 'package:repel/user_screens/home.dart';
import 'package:repel/user_screens/interestedlogin.dart';
import 'package:repel/user_screens/interestedpurchase.dart';
import 'package:repel/user_screens/myprofile.dart';
import 'package:repel/user_screens/ourteam.dart';

class MyDrawer2 extends StatelessWidget {
  const MyDrawer2({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return FirebaseAuth.instance.currentUser == null
        ? DrawerNoAcc2()
        : DrawerWithAcc2();
  }
}

class DrawerWithAcc2 extends StatelessWidget {
  const DrawerWithAcc2({super.key});

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
                      'Purchase',
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

class DrawerNoAcc2 extends StatelessWidget {
  const DrawerNoAcc2({
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
                    Container(height: 15),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => InterestedLogin())));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text('Already have an account?',
                            style: GoogleFonts.firaSansCondensed(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                              fontSize: 14,
                            )),
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
