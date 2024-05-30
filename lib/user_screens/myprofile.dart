import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:repel/components/appBar.dart';

import 'package:repel/components/drawer.dart';
import 'package:repel/components/myTexfield.dart';
import 'package:repel/main.dart';
import 'package:repel/services/firestore.dart';
import 'package:repel/user_screens/interestedpurchase.dart';
import 'package:repel/user_screens/splashscreen.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String? date;
  String id = FirebaseAuth.instance.currentUser!.uid;
  String? name;
  String? birthdate;
  String? address;
  String? amount;
  String? paymentMethod;
  String? status;
  String installment = '5 Months';
  List fileLinkList = [];
  List paidList = [];

  NumberFormat numFormat = NumberFormat('###,###,###,###', 'en_US');

  Future<bool> checkExist(String docID) async {
    bool exist = false;
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('orders').doc(docID).get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      print("WHYYYY $e");
      // If any error
      return false;
    }
  }

  Future<void> loadData() async {
    bool exist = await checkExist(FirebaseAuth.instance.currentUser!.uid);
    if (exist) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      final docRef =
          db.collection("orders").doc(FirebaseAuth.instance.currentUser!.uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          setState(() {
            fileLinkList.add(data['fileLink']);
            fileLinkList.add(data['fileLink2']);
            fileLinkList.add(data['fileLink3']);
            fileLinkList.add(data['fileLink4']);
            fileLinkList.add(data['fileLink5']);
            paidList.add(data['paid']);
            paidList.add(data['paid2']);
            paidList.add(data['paid3']);
            paidList.add(data['paid4']);
            paidList.add(data['paid5']);
            amount = "Php ${numFormat.format(data['amount'])}";
            paymentMethod = data['payment_method'];
            status = data['status'];
            installment = data['installment'];
            date = formatTime(data['date']).toString();
          });
          print(fileLinkList);
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } else {
      fileLinkList.add(null);
      fileLinkList.add(null);
      fileLinkList.add(null);
      fileLinkList.add(null);
      fileLinkList.add(null);
      paidList.add(false);
      paidList.add(false);
      paidList.add(false);
      paidList.add(false);
      paidList.add(false);
      amount = "N/A";
      paymentMethod = "N/A";
      status = "N/A";
      installment = "N/A";
      date = "N/A";
    }
    print('DATA 1 has been loaded');
  }

  Future<bool> checkExist2(String docID) async {
    bool exist = false;
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('users').doc(docID).get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      print("WHYYYY2 $e");
      return false;
    }
  }

  Future<void> loadData2() async {
    bool exist = await checkExist2(FirebaseAuth.instance.currentUser!.uid);
    if (exist) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      final docRef =
          db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;

          setState(() {
            name = data['name'];
            birthdate = data['birthdate'];
            address = data['address'];
            id = data['id'];
          });
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
    print('DATA 2 has been loaded');
  }

  formatTime(Timestamp timeStamp) {
    DateTime dateTime = timeStamp.toDate();
    return DateFormat('MM/dd/yy').format(dateTime);
  }

  @override
  void initState() {
    print(' id: ${FirebaseAuth.instance.currentUser!.uid}');
    // TODO: implement initState
    super.initState();
    loadData();
    loadData2();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return address == null
        ? Center(
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ))
        : width > 780
            ? MyProfileWeb(
                width: width,
                height: height,
                date: date!,
                id: id,
                name: name!,
                birthdate: birthdate!,
                address: address!,
                amount: amount!,
                paymentMethod: paymentMethod!,
                status: status!,
                paidList: paidList,
                fileLinkList: fileLinkList,
                installment: installment,
              )
            : MyProfileMobile(
                width: width,
                height: height,
                date: date!,
                id: id,
                name: name!,
                birthdate: birthdate!,
                address: address!,
                amount: amount!,
                paymentMethod: paymentMethod!,
                status: status!,
                paidList: paidList,
                fileLinkList: fileLinkList,
                installment: installment,
              );
  }
}

class MyProfileWeb extends StatefulWidget {
  MyProfileWeb(
      {super.key,
      required this.width,
      required this.height,
      required this.date,
      required this.id,
      required this.name,
      required this.birthdate,
      required this.address,
      required this.amount,
      required this.paymentMethod,
      required this.status,
      required this.paidList,
      required this.fileLinkList,
      required this.installment});

  final double width;
  final double height;
  String date;
  String id;
  String name;
  String birthdate;
  String address;
  String amount;
  String paymentMethod;
  String status;
  List paidList;
  List fileLinkList;
  String installment;

  @override
  State<MyProfileWeb> createState() => _MyProfileWebState();
}

class _MyProfileWebState extends State<MyProfileWeb> {
  bool isEditMode = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      nameController.text = widget.name;
      birthController.text = widget.birthdate;
      addressController.text = widget.address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: Center(
          child: Stack(
            children: [
              Opacity(
                opacity: .6,
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2FmockappWeb.jpg?alt=media&token=04021a85-edce-41ba-baef-0d466d892ef4',
                  fit: BoxFit.cover,
                  width: widget.width,
                  height: widget.height,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fholisticbanner.png?alt=media&token=1d9e788c-db43-4b04-9e60-38d6eb4290bd',
                          fit: BoxFit.contain,
                          height: 200,
                          width: 400,
                        ),
                      ),
                    ],
                  )),
                  Expanded(child: Column()),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 20, right: 20),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Date: ${widget.date}',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Status',
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.status,
                                                style: GoogleFonts
                                                    .firaSansCondensed(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 12, 69, 70),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Paid',
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child:
                                                widget.installment == '5 Months'
                                                    ? paidChecks(
                                                        widget.paidList,
                                                        widget.width)
                                                    : Icon(
                                                        widget.paidList[0]
                                                            ? Icons
                                                                .check_circle_outline_sharp
                                                            : Icons
                                                                .remove_circle_outline_sharp,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255, 12, 69, 70),
                                                      ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Payment Proof',
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                            ),
                                          ),
                                          OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            InterestedPurchase()));
                                              },
                                              child: Text(
                                                'View Proof',
                                                style: GoogleFonts
                                                    .firaSansCondensed(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 12, 69, 70),
                                                ),
                                              ))
                                        ],
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                  ),
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
                                  profileTextField(nameController, 'Name',
                                      false, !isEditMode),
                                  Container(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Birth Date',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  profileTextField(birthController,
                                      'Birth Date', false, !isEditMode),
                                  Container(
                                    height: 10,
                                  ),
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
                                  profileTextField(addressController, 'Address',
                                      false, !isEditMode),
                                  Container(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Amount',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 12, 69, 70),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.amount,
                                          style: GoogleFonts.firaSansCondensed(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
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
                                  Container(
                                    color: Colors.grey[200],
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.paymentMethod,
                                          style: GoogleFonts.firaSansCondensed(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 12, 69, 70),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(height: 40),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isEditMode
                                                  ? isEditMode = false
                                                  : isEditMode = true;
                                            });
                                            if (!isEditMode) {
                                              FirestoreService
                                                  firestoreService =
                                                  FirestoreService();
                                              firestoreService.updateProfile(
                                                  widget.id,
                                                  nameController.text,
                                                  birthController.text,
                                                  addressController.text);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Save Changes')));
                                            }
                                          },
                                          child: Text(
                                            isEditMode ? 'Save' : 'Edit',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _signOut(context);
                                          },
                                          child: Text(
                                            'Logout',
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )))
                ],
              )
            ],
          ),
        ));
  }
}

class MyProfileMobile extends StatefulWidget {
  MyProfileMobile(
      {super.key,
      required this.width,
      required this.height,
      required this.date,
      required this.id,
      required this.name,
      required this.birthdate,
      required this.address,
      required this.amount,
      required this.paymentMethod,
      required this.status,
      required this.paidList,
      required this.fileLinkList,
      required this.installment});

  final double width;
  final double height;
  String date;
  String id;
  String name;
  String birthdate;
  String address;
  String amount;
  String paymentMethod;
  String status;
  List paidList;
  List fileLinkList;
  String installment;

  @override
  State<MyProfileMobile> createState() => _MyProfileMobileState();
}

class _MyProfileMobileState extends State<MyProfileMobile> {
  bool isEditMode = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<bool> checkExist2(String docID) async {
    bool exist = false;
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('users').doc(docID).get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      print("WHYYYY2 $e");
      return false;
    }
  }

  Future<void> loadData2() async {
    bool exist = await checkExist2(FirebaseAuth.instance.currentUser!.uid);
    if (exist) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      final docRef =
          db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          nameController.text = data['name'];
          birthController.text = data['birthdate'];
          addressController.text = data['address'];
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
    loadData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: widget.width > 780 ? null : MyDrawer(),
      body: Center(
        child: Stack(
          children: [
            Opacity(
              opacity: .6,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fmockappbg.jpg?alt=media&token=b771086e-db2c-40bc-aef7-5a75e308f879',
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Date: ${widget.date}',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 12, 69, 70),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Status',
                                style: GoogleFonts.firaSansCondensed(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 12, 69, 70),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.status,
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Paid',
                                style: GoogleFonts.firaSansCondensed(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 12, 69, 70),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: widget.installment == '5 Months'
                                  ? paidChecks(widget.paidList, widget.width)
                                  : Icon(
                                      widget.paidList[0]
                                          ? Icons.check_circle_outline_sharp
                                          : Icons.remove_circle_outline_sharp,
                                      size: 35,
                                      color: Color.fromARGB(255, 12, 69, 70),
                                    ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Payment Proof',
                                style: GoogleFonts.firaSansCondensed(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 12, 69, 70),
                                ),
                              ),
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InterestedPurchase()));
                                },
                                child: Text(
                                  'View Proof',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 12, 69, 70),
                                  ),
                                ))
                          ],
                        ),
                        Container(
                          width: 10,
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
                    ),
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
                    profileTextField(
                        nameController, 'Name', false, !isEditMode),
                    Container(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Birth Date',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 69, 70),
                        ),
                      ),
                    ),
                    profileTextField(
                        birthController, 'Birth Date', false, !isEditMode),
                    Container(
                      height: 10,
                    ),
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
                    profileTextField(
                        addressController, 'Address', false, !isEditMode),
                    Container(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Amount',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 69, 70),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.amount,
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 18,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
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
                    Container(
                      color: Colors.grey[200],
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.paymentMethod,
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 18,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isEditMode
                                    ? isEditMode = false
                                    : isEditMode = true;
                              });
                              if (!isEditMode) {
                                FirestoreService firestoreService =
                                    FirestoreService();
                                firestoreService.updateProfile(
                                    widget.id,
                                    nameController.text,
                                    birthController.text,
                                    addressController.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Save Changes')));
                              }
                            },
                            child: Text(
                              isEditMode ? 'Save' : 'Edit',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              _signOut(context);
                            },
                            child: Text(
                              'Logout',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  // Restart.restartApp();
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
}

Widget paidChecks(List paidList, var width) {
  return paidList.isEmpty
      ? CircularProgressIndicator()
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              paidList[0]
                  ? Icons.check_circle_outline_sharp
                  : Icons.remove_circle_outline_sharp,
              size: width > 780 ? 18 : 25,
              color: Color.fromARGB(255, 12, 69, 70),
            ),
            Icon(
              paidList[1]
                  ? Icons.check_circle_outline_sharp
                  : Icons.remove_circle_outline_sharp,
              size: width > 780 ? 18 : 25,
              color: Color.fromARGB(255, 12, 69, 70),
            ),
            Icon(
              paidList[2]
                  ? Icons.check_circle_outline_sharp
                  : Icons.remove_circle_outline_sharp,
              size: width > 780 ? 18 : 25,
              color: Color.fromARGB(255, 12, 69, 70),
            ),
            Icon(
              paidList[3]
                  ? Icons.check_circle_outline_sharp
                  : Icons.remove_circle_outline_sharp,
              size: width > 780 ? 18 : 25,
              color: Color.fromARGB(255, 12, 69, 70),
            ),
            Icon(
              paidList[4]
                  ? Icons.check_circle_outline_sharp
                  : Icons.remove_circle_outline_sharp,
              size: width > 780 ? 18 : 25,
              color: Color.fromARGB(255, 12, 69, 70),
            ),
          ],
        );
}
