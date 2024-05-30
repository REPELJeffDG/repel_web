import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:repel/components/textstyles.dart';
import 'package:repel/user_screens/aquardent.dart';
import 'package:repel/user_screens/contactus.dart';
import 'package:repel/user_screens/customertestimonial.dart';
import 'package:repel/user_screens/home.dart';
import 'package:repel/user_screens/interestedpurchase.dart';
import 'package:repel/user_screens/interestedregister.dart';
import 'package:repel/user_screens/myprofile.dart';
import 'package:repel/user_screens/ourteam.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 780
        ? FirebaseAuth.instance.currentUser == null
            ? AppBarNoAcc()
            : AppBarWithAcc()
        : AppBar(
            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
                  fit: BoxFit.cover,
                ),
              ],
            ),
            actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepel.png?alt=media&token=f5c682e7-c340-407c-a315-ede9b367d898'),
                ),
              ]);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AppBarWithAcc extends StatefulWidget {
  const AppBarWithAcc({super.key});

  @override
  State<AppBarWithAcc> createState() => _AppBarWithAccState();
}

class _AppBarWithAccState extends State<AppBarWithAcc> {
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
    return AppBar(
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
            fit: BoxFit.cover,
          ),
        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(
          'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepel.png?alt=media&token=f5c682e7-c340-407c-a315-ede9b367d898',
        ),
      ),
      leadingWidth: 200,
      actions: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Home()));
                },
                child: Text('Home', style: getNavStyle(context))),
            Container(width: 30),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomerTestimonial()));
                },
                child: Text('Testimonials', style: getNavStyle(context))),
            Container(width: 30),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Aquardent()));
                },
                child: Text('Aquardent', style: getNavStyle(context))),
            Container(width: 30),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => OurTeam()));
                },
                child: Text('OurTeam', style: getNavStyle(context))),
            Container(width: 30),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyProfile()));
                },
                child: Text('Profile', style: getNavStyle(context))),
            Container(width: 30),
            ElevatedButton(
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
            Container(width: 30),
          ],
        ),
      ],
    );
  }
}

class AppBarNoAcc extends StatelessWidget {
  const AppBarNoAcc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
            fit: BoxFit.cover,
          ),
        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(
          'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepel.png?alt=media&token=f5c682e7-c340-407c-a315-ede9b367d898',
        ),
      ),
      leadingWidth: 200,
      actions: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Home()));
                },
                child: Text('Home', style: getNavStyle(context))),
            Container(width: 30),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomerTestimonial()));
                },
                child: Text('Testimonials', style: getNavStyle(context))),
            Container(width: 30),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Aquardent()));
                },
                child: Text('Aquardent', style: getNavStyle(context))),
            Container(width: 30),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => OurTeam()));
                },
                child: Text('OurTeam', style: getNavStyle(context))),
            Container(width: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => InterestedRegister())));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[300],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Interested',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(width: 15),
            OutlinedButton(
              onPressed: () {
                //this change this later
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) => Home())));
                ContactDialog contactDialog = ContactDialog();
                contactDialog.show(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Contact Seller',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(width: 30),
          ],
        ),
      ],
    );
  }
}
