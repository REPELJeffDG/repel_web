import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repel/components/appBar.dart';
import 'package:repel/components/drawer.dart';
import 'package:repel/components/myTexfield.dart';

import 'package:repel/user_screens/paymentdetails.dart';
import 'package:repel/services/firestore.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({Key? key}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  FirestoreService firestoreService = FirestoreService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? _selectedInstallment = 'One Time Payment';
  final TextEditingController paymentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String amount = '45,000';

  String? fileName;
  UploadTask? uploadtask;
  Uint8List? fileBytes;
  String? fileLink;
  XFile? img;

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
                                  nameController, 'full name', false, false),
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
                                  addressController, 'address', false, false),
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
                                      _selectedInstallment = value;
                                      amount = value == '5 Months'
                                          ? '9,500.00'
                                          : '45,000.00';
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
                                    hintText: 'Gcash',
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
                                    'Php $amount',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                                  ),
                                ],
                              ),
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
                                  onTap: selectFile,
                                  child: Card(
                                    color: Colors.grey[400],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.upload_file,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
                                          ),
                                          fileName == null
                                              ? Text(
                                                  'Upload a file here',
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
                              if (amount == '9,500.00')
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
                                      onTap: selectFile,
                                      child: Card(
                                        color: Colors.grey[400],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.upload_file,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                              fileName == null
                                                  ? Text(
                                                      'Upload a file here',
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
                                                      fileName!,
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
                                      onTap: selectFile,
                                      child: Card(
                                        color: Colors.grey[400],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.upload_file,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                              fileName == null
                                                  ? Text(
                                                      'Upload a file here',
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
                                                      fileName!,
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
                                      onTap: selectFile,
                                      child: Card(
                                        color: Colors.grey[400],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.upload_file,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                              fileName == null
                                                  ? Text(
                                                      'Upload a file here',
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
                                                      fileName!,
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
                                      onTap: selectFile,
                                      child: Card(
                                        color: Colors.grey[400],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.upload_file,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                              fileName == null
                                                  ? Text(
                                                      'Upload a file here',
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
                                                      fileName!,
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
                                ]),
                              Container(
                                height: 30,
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
        fileName = image.name;
      });
    } else {
      print('error getting image');
    }
  }

  Future uploadFile() async {
    //CV
    if (img != null) {
      final ref = FirebaseStorage.instance.ref('payment_proof/$fileName');
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
