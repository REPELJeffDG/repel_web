import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/user_screens/home.dart';
import 'package:repel/user_screens/myprofile.dart';

import 'package:repel/services/firestore.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Timer? _timer;
  var accountVerified = false;
  var user;

  @override
  void initState() {
    super.initState();
    firebaseAuthService.sendEmailVerification();
    _timer = Timer.periodic(Duration(milliseconds: 500), (Timer t) {
      firebaseAuthService.isEmailVerified().then((isVerified) {
        if (isVerified) {
          print('Email is verified');
          setState(() {
            accountVerified = true;
          });
          _timer?.cancel();
        } else {
          print('Email is not verified');
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fconcrete.png?alt=media&token=d563705a-f551-47c0-b4d1-382f92558df5',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              height: 70,
              width: double.infinity,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    width: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 30, bottom: 40),
                              child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fholisticbanner.png?alt=media&token=1d9e788c-db43-4b04-9e60-38d6eb4290bd',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Container(height: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyProfile()),
                                    );
                                  },
                                  child: Text(
                                    'Email Verification',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Please check your email and click the link to verify, if there's no verification email sent please click resend!",
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Container(height: 4),
                              accountVerified
                                  ? ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Home()));
                                      },
                                      child: Text(
                                        'Go to Home',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        firebaseAuthService
                                            .sendEmailVerification();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Verification email sent')));
                                      },
                                      child: Text(
                                        'Resend',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
