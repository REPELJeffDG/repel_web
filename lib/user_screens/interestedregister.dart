import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/components/appBar2.dart';
import 'package:repel/components/drawer2.dart';
import 'package:repel/components/myTexfield.dart';
import 'package:repel/user_screens/emailverification.dart';
import 'package:repel/user_screens/location.dart';

import 'package:repel/user_screens/myprofile.dart';

import 'package:repel/services/firestore.dart';

class InterestedRegister extends StatefulWidget {
  const InterestedRegister({Key? key}) : super(key: key);

  @override
  State<InterestedRegister> createState() => _InterestedRegisterState();
}

class _InterestedRegisterState extends State<InterestedRegister> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar2(),
      drawer: MyDrawer2(),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 3),
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
                                    'REGISTER',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "We're on a mission to empower fisherfolk with innovative aquaculture solutions while preserving the integrity of our water bodies. Join us in revolutionizing the future of fish farming and environmental sustainability.",
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Name',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              registerTextField(
                                  nameController, 'Name', false, false),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email Address',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email address';
                                    } else if (!value.contains('@') ||
                                        !value.contains('.')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                  controller: emailController,
                                ),
                              ),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Birthdate',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              registerTextField(birthdateController,
                                  'Birthdate', false, false),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Address',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              registerTextField(
                                  addressController, 'Addres', false, false),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Password',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              registerTextField(
                                  passwordController, 'Password', true, false),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Confirm Password',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    } else if (confirmPasswordController.text !=
                                        passwordController.text) {
                                      return 'Password do not match';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                  controller: confirmPasswordController,
                                  obscureText: true,
                                ),
                              ),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Phone Number',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              registerTextField(phoneNumController,
                                  'Phone Number', false, false),
                              Container(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await firebaseAuthService.signUpWEPUSER(
                                            emailController.text,
                                            passwordController.text,
                                            nameController.text,
                                            birthdateController.text,
                                            addressController.text,
                                            phoneNumController.text,
                                            false);
                                        // firestoreService.addUser(
                                        //     nameController.text,
                                        //     emailController.text,
                                        //     false);
                                        /* ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Registered Successfully'))); */
                                        nameController.clear();
                                        emailController.clear();
                                        passwordController.clear();
                                        confirmPasswordController.clear();
                                        phoneNumController.clear();
                                        birthdateController.clear();
                                        addressController.clear();
                                        otpController.clear();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EmailVerification()));
                                        // PurchaseDialog.show(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please complete the form')));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber[400],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                            fontSize: 12,
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
                                      LocationDialog.show(context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      child: Text(
                                        'Location',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 20,
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
