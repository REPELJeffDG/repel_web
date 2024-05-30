import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:repel/components/appBar.dart';
import 'package:repel/components/drawer.dart';
import 'package:repel/components/myTexfield.dart';
import 'package:repel/components/proof_view.dart';

import 'package:repel/user_screens/home.dart';
import 'package:repel/user_screens/paymentdetails.dart';
import 'package:repel/services/firestore.dart';

class InterestedPurchase extends StatefulWidget {
  const InterestedPurchase({Key? key}) : super(key: key);

  @override
  State<InterestedPurchase> createState() => _InterestedPurchaseState();
}

class _InterestedPurchaseState extends State<InterestedPurchase> {
  FirestoreService firestoreService = FirestoreService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? _selectedInstallment = 'One Time Payment';
  final TextEditingController paymentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool readOnly = false;

  NumberFormat numFormat = NumberFormat('###,###,###,###', 'en_US');
  double amountPay = 45000;
  double amount = 0;

  String? docID;

  String? fileName;
  UploadTask? uploadtask;
  Uint8List? fileBytes;
  String fileLink = 'null';
  XFile? img;

  String? fileName2;
  UploadTask? uploadtask2;
  Uint8List? fileBytes2;
  String fileLink2 = 'null';
  XFile? img2;

  String? fileName3;
  UploadTask? uploadtask3;
  Uint8List? fileBytes3;
  String fileLink3 = 'null';
  XFile? img3;

  String? fileName4;
  UploadTask? uploadtask4;
  Uint8List? fileBytes4;
  String fileLink4 = 'null';
  XFile? img4;

  String? fileName5;
  UploadTask? uploadtask5;
  Uint8List? fileBytes5;
  String fileLink5 = 'null';
  XFile? img5;

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

  Future<void> loadData() async {
    bool exist = await checkExist(FirebaseAuth.instance.currentUser!.uid);
    if (exist) {
      docID = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore db = FirebaseFirestore.instance;
      final docRef =
          db.collection("orders").doc(FirebaseAuth.instance.currentUser!.uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;

          // 'orderID': 0,
          // 'name': name,
          // 'location': address,
          // 'payment_method': payment,
          // 'amount': amount,
          // 'status': status,
          // 'fileLink': fileLink,
          // 'paid': paid,
          // 'date': Timestamp.now(),

          nameController.text = data['name'];
          addressController.text = data['location'];
          paymentController.text = data['payment_method'];
          fileLink = data['fileLink'];
          fileLink2 = data['fileLink2'];
          fileLink3 = data['fileLink3'];
          fileLink4 = data['fileLink4'];
          fileLink5 = data['fileLink5'];
          _selectedInstallment = data['installment'];
          amount = data['amount'];
          readOnly = true;
          setState(() {});
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  //final _formKey = GlobalKey<FormState>();
  bool isSignIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
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
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 3),
                              child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fpurchasebanner.png?alt=media&token=b3e640f9-b854-4e50-b7da-dad7b4224153',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Container(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Column(
                            children: [
                              Container(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Full Name',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              registerTextField(
                                  nameController, 'full name', false, readOnly),
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
                              registerTextField(addressController, 'address',
                                  false, readOnly),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Installment',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                  ),
                                  value: _selectedInstallment,
                                  onChanged: (value) {
                                    setState(() {
                                      if (!readOnly) {
                                        _selectedInstallment = value;
                                        amountPay =
                                            value == '5 Months' ? 9500 : 45000;
                                      }
                                    });
                                  },
                                  items: [
                                    'One Time Payment',
                                    '5 Months',
                                  ].map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(height: 20),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Payment Method',
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
                                  readOnly: readOnly,
                                  controller: paymentController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    labelStyle: GoogleFonts.firaSansCondensed(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    hintText: 'Online',
                                  ),
                                ),
                              ),
                              Container(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 10,
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        PaymentDetailsDialog.show(context);
                                      },
                                      child: Text(
                                        'View Payment Details',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 12, 69, 70),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(height: 20),
                              Container(
                                height: 3,
                                width: 600,
                                color: Color.fromARGB(255, 12, 69, 70),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'TOTAL',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    _selectedInstallment == '5 Months'
                                        ? 'Php 9,500'
                                        : 'Php 45,000',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                                  ),
                                ],
                              ),
                              _selectedInstallment == '5 Months'
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('To pay for 5 months',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 12, 69, 70),
                                            ))
                                      ],
                                    )
                                  : Container(),
                              Container(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'First Proof of Payment',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (readOnly) {
                                      ProofDialog.show(context, fileLink);
                                    } else {
                                      await selectFile();
                                      setState(() {
                                        _selectedInstallment == '5 Months'
                                            ? amount = 9500
                                            : amount = 45000;
                                      });
                                    }
                                  },
                                  child: Card(
                                    color: fileLink == 'null'
                                        ? Colors.grey[400]
                                        : Color(0xFF61b891),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: selectFile,
                                            child: Icon(
                                              Icons.upload_file,
                                              color: Color.fromARGB(
                                                  255, 12, 69, 70),
                                            ),
                                          ),
                                          fileName == null
                                              ? Text(
                                                  fileLink == 'null'
                                                      ? 'Upload a file here'
                                                      : 'View File',
                                                  style: GoogleFonts
                                                      .firaSansCondensed(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 12, 69, 70),
                                                  ),
                                                )
                                              : Text(
                                                  fileName!,
                                                  style: GoogleFonts
                                                      .firaSansCondensed(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 12, 69, 70),
                                                  ),
                                                ),
                                          Spacer(),
                                          fileName == null
                                              ? Text(
                                                  'JPG, PNG, PDG',
                                                  style: GoogleFonts
                                                      .firaSansCondensed(
                                                    fontSize: 11,
                                                    color: Color.fromARGB(
                                                        255, 12, 69, 70),
                                                  ),
                                                )
                                              : Text('')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(height: 10),
                              if (_selectedInstallment == '5 Months')
                                Column(children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Second Proof of Payment',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (fileLink2 != 'null') {
                                          ProofDialog.show(context, fileLink2);
                                        } else {
                                          await selectFile2();
                                          setState(() {
                                            amount += 9500;
                                          });
                                        }
                                      },
                                      child: Card(
                                        color: fileLink2 == 'null'
                                            ? Colors.grey[400]
                                            : Color(0xFF61b891),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: selectFile2,
                                                child: Icon(
                                                  Icons.upload_file,
                                                  color: Color.fromARGB(
                                                      255, 12, 69, 70),
                                                ),
                                              ),
                                              fileName2 == null
                                                  ? Text(
                                                      fileLink2 == 'null'
                                                          ? 'Upload a file here'
                                                          : 'View File',
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    )
                                                  : Text(
                                                      fileName2!,
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    ),
                                              Spacer(),
                                              fileName2 == null
                                                  ? Text(
                                                      'JPG, PNG, PDG',
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 11,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    )
                                                  : Text('')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(height: 10),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Third Proof of Payment',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (fileLink3 != 'null') {
                                          ProofDialog.show(context, fileLink3);
                                        } else {
                                          await selectFile3();
                                          setState(() {
                                            amount += 9500;
                                          });
                                        }
                                      },
                                      child: Card(
                                        color: fileLink3 == 'null'
                                            ? Colors.grey[400]
                                            : Color(0xFF61b891),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: selectFile3,
                                                child: Icon(
                                                  Icons.upload_file,
                                                  color: Color.fromARGB(
                                                      255, 12, 69, 70),
                                                ),
                                              ),
                                              fileName3 == null
                                                  ? Text(
                                                      fileLink3 == 'null'
                                                          ? 'Upload a file here'
                                                          : 'View File',
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    )
                                                  : Text(
                                                      fileName3!,
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    ),
                                              Spacer(),
                                              fileName3 == null
                                                  ? Text(
                                                      'JPG, PNG, PDG',
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 11,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    )
                                                  : Text('')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(height: 10),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Fourth Proof of Payment',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (fileLink4 != 'null') {
                                          ProofDialog.show(context, fileLink4);
                                        } else {
                                          await selectFile4();
                                          setState(() {
                                            amount += 9500;
                                          });
                                        }
                                      },
                                      child: Card(
                                        color: fileLink4 == 'null'
                                            ? Colors.grey[400]
                                            : Color(0xFF61b891),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: selectFile4,
                                                child: Icon(
                                                  Icons.upload_file,
                                                  color: Color.fromARGB(
                                                      255, 12, 69, 70),
                                                ),
                                              ),
                                              fileName4 == null
                                                  ? Text(
                                                      fileLink4 == 'null'
                                                          ? 'Upload a file here'
                                                          : 'View File',
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    )
                                                  : Text(
                                                      fileName4!,
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    ),
                                              Spacer(),
                                              fileName4 == null
                                                  ? Text(
                                                      'JPG, PNG, PDG',
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 11,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    )
                                                  : Text('')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(height: 10),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Fifth Proof of Payment',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (fileLink5 != 'null') {
                                          ProofDialog.show(context, fileLink5);
                                        } else {
                                          await selectFile5();
                                          setState(() {
                                            amount += 9500;
                                          });
                                        }
                                      },
                                      child: Card(
                                        color: fileLink5 == 'null'
                                            ? Colors.grey[400]
                                            : Color(0xFF61b891),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: selectFile5,
                                                child: Icon(
                                                  Icons.upload_file,
                                                  color: Color.fromARGB(
                                                      255, 12, 69, 70),
                                                ),
                                              ),
                                              fileName5 == null
                                                  ? Text(
                                                      fileLink5 == 'null'
                                                          ? 'Upload a file here'
                                                          : 'View File',
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    )
                                                  : Text(
                                                      fileName5!,
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    ),
                                              Spacer(),
                                              fileName5 == null
                                                  ? Text(
                                                      'JPG, PNG, PDG',
                                                      style: GoogleFonts
                                                          .firaSansCondensed(
                                                        fontSize: 11,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                                    )
                                                  : Text('')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              Container(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        print('VALID');
                                        setState(() {
                                          isSignIn = true;
                                        });
                                        // await uploadFile();
                                        await firestoreService.addOrders(
                                            nameController.text,
                                            addressController.text,
                                            paymentController.text,
                                            _selectedInstallment!,
                                            amount,
                                            'Pending',
                                            fileLink,
                                            fileLink2,
                                            fileLink3,
                                            fileLink4,
                                            fileLink5,
                                            false);
                                        print('yo');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Purchased Successfully')));
                                        nameController.clear();
                                        addressController.clear();
                                        paymentController.clear();
                                        setState(() {
                                          isSignIn = false;
                                          fileName = null;
                                        });
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Home()));
                                      } else {
                                        print('INVALID');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please complete the form')));
                                        setState(() {
                                          isSignIn = false;
                                          fileName = null;
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(250, 45),
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Color(0xFFDCB03B),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      child: isSignIn
                                          ? CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            )
                                          : Text(
                                              readOnly ? 'Save' : 'Purchase',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF0C4546),
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

  Future selectFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // FilePickerResult? result = await FilePicker.platform
    //     .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    if (image != null) {
      setState(() {
        img = image;
        fileName = FirebaseAuth.instance.currentUser!.uid;
      });
      final ref = FirebaseStorage.instance.ref('payment_proof/${fileName}.jpg');
      if (!kIsWeb) {
        await ref.putFile(File(img!.path)).then((p0) async {
          print(await p0.ref.getDownloadURL());
          fileLink = await p0.ref.getDownloadURL();
        });
      } else {
        await ref.putData(await img!.readAsBytes()).then((p0) async {
          print(await p0.ref.getDownloadURL());
          fileLink = await p0.ref.getDownloadURL();
        });
      }
      setState(() {});
    } else {
      print('error getting image');
      fileLink = 'null';
    }
  }

  Future selectFile2() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // FilePickerResult? result = await FilePicker.platform
    //     .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    try {
      if (image != null) {
        setState(() {
          img2 = image;
          fileName2 = FirebaseAuth.instance.currentUser!.uid;
        });
        final ref =
            FirebaseStorage.instance.ref('payment_proof/${fileName}.jpg1');
        if (!kIsWeb) {
          await ref.putFile(File(img2!.path)).then((p0) async {
            print(await p0.ref.getDownloadURL());
            fileLink2 = await p0.ref.getDownloadURL();
          });
        } else {
          await ref.putData(await img2!.readAsBytes()).then((p0) async {
            print(await p0.ref.getDownloadURL());
            fileLink2 = await p0.ref.getDownloadURL();
          });
        }
        setState(() {});
      } else {
        print('error getting image');
        fileLink2 = 'null';
      }
    } catch (e) {
      print('image ERROR: $e');
    }
  }

  Future selectFile3() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // FilePickerResult? result = await FilePicker.platform
    //     .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    if (image != null) {
      setState(() {
        img3 = image;
        fileName3 = FirebaseAuth.instance.currentUser!.uid;
      });
      final ref =
          FirebaseStorage.instance.ref('payment_proof/${fileName}.jpg2');
      if (!kIsWeb) {
        await ref.putFile(File(img3!.path)).then((p0) async {
          print(await p0.ref.getDownloadURL());
          fileLink3 = await p0.ref.getDownloadURL();
        });
      } else {
        await ref.putData(await img3!.readAsBytes()).then((p0) async {
          print(await p0.ref.getDownloadURL());
          fileLink3 = await p0.ref.getDownloadURL();
        });
      }
      setState(() {});
    } else {
      print('error getting image');
      fileLink3 = 'null';
    }
  }

  Future selectFile4() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // FilePickerResult? result = await FilePicker.platform
    //     .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    if (image != null) {
      setState(() {
        img4 = image;
        fileName4 = FirebaseAuth.instance.currentUser!.uid;
      });
      final ref =
          FirebaseStorage.instance.ref('payment_proof/${fileName}.jpg3');
      if (!kIsWeb) {
        await ref.putFile(File(img4!.path)).then((p0) async {
          print(await p0.ref.getDownloadURL());
          fileLink4 = await p0.ref.getDownloadURL();
        });
      } else {
        await ref.putData(await img4!.readAsBytes()).then((p0) async {
          print(await p0.ref.getDownloadURL());
          fileLink4 = await p0.ref.getDownloadURL();
        });
      }
      setState(() {});
    } else {
      print('error getting image');
      fileLink4 = 'null';
    }
  }

  Future selectFile5() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // FilePickerResult? result = await FilePicker.platform
    //     .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    if (image != null) {
      setState(() {
        img5 = image;
        fileName5 = FirebaseAuth.instance.currentUser!.uid;
      });
      final ref =
          FirebaseStorage.instance.ref('payment_proof/${fileName}.jpg4');
      if (!kIsWeb) {
        await ref.putFile(File(img5!.path)).then((p0) async {
          print(await p0.ref.getDownloadURL());
          fileLink5 = await p0.ref.getDownloadURL();
        });
      } else {
        await ref.putData(await img5!.readAsBytes()).then((p0) async {
          print(await p0.ref.getDownloadURL());
          fileLink5 = await p0.ref.getDownloadURL();
        });
      }
      setState(() {});
    } else {
      print('error getting image');
      fileLink5 = 'null';
    }
  }

  Future uploadFile() async {
    //CV
    if (img != null) {
      final ref =
          FirebaseStorage.instance.ref('payment_proof/${fileName}.jpg5');
      if (!kIsWeb) {
        await ref.putFile(File(img!.path)).then((p0) async {
          print(await p0.ref.getDownloadURL());
          fileLink = await p0.ref.getDownloadURL();
        });
      } else {
        await ref.putData(await img!.readAsBytes()).then((p0) async {
          print(await p0.ref.getDownloadURL());
          fileLink = await p0.ref.getDownloadURL();
        });
      }
      setState(() {});
    } else {
      fileLink = 'null';
    }
  }
}
