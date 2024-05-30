import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/components/appBar.dart';
import 'package:repel/components/drawer.dart';
import 'package:repel/services/firestore.dart';
import 'package:repel/user_screens/testimonialForm.dart';

class Customer extends StatelessWidget {
  const Customer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomerTestimonial();
  }
}

class Item {
  final String testimony;
  final String tname;

  Item({required this.testimony, required this.tname});
}

class CustomerTestimonial extends StatefulWidget {
  const CustomerTestimonial({Key? key}) : super(key: key);

  @override
  State<CustomerTestimonial> createState() => _CustomerTestimonialState();
}

class _CustomerTestimonialState extends State<CustomerTestimonial> {
  FirestoreService firestoreService = FirestoreService();
  int currentIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();

  void goToPreviousItem() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        _scrollToItem(currentIndex);
      }
    });
  }

  void goToNextItem() {
    setState(() {
      if (currentIndex < items.length - 1) {
        currentIndex++;
        _scrollToItem(currentIndex);
      }
    });
  }

  void _scrollToItem(int index) {
    _scrollController.animateTo(
      index * 160.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  final List<Item> items = [
    Item(
      testimony:
          'The product is phenomenal, it does the work and it is amazing!',
      tname: 'Jojo',
    ),
    Item(
      testimony:
          'The product is phenomenal, it does the work and it is amazing!',
      tname: 'Jeff',
    ),
    Item(
      testimony:
          'The product is phenomenal, it does the work and it is amazing!',
      tname: 'Salva',
    ),
    Item(
      testimony:
          'The product is phenomenal, it does the work and it is amazing!',
      tname: 'Araya',
    ),
    Item(
      testimony:
          'The product is phenomenal, it does the work and it is amazing!',
      tname: 'Euny',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: Center(
        child: Stack(
          children: [
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fconcrete.png?alt=media&token=d563705a-f551-47c0-b4d1-382f92558df5',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 69, left: 69, top: 15),
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Faquardent.png?alt=media&token=6f178d20-8cee-4437-8035-3304a7e697db',
                      width: width > 780 ? 500 : null,
                      height: width > 780 ? 150 : null,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 300),
                        child: Text(
                          'TESTIMONIALS',
                          style: GoogleFonts.firaSansCondensed(
                              fontWeight: FontWeight.bold,
                              fontSize: width > 780 ? 40 : 22,
                              color: Color(0xFF315C7A)),
                        ),
                      ),
                      Container(
                        width: 40,
                      ),
                    ],
                  ),
                  Container(
                    height: width > 780 ? 220 : 180,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: firestoreService.getTestimonialsStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List testimonials = snapshot.data!.docs;
                            return Container(
                              width: double.infinity,
                              height: 520,
                              child: ListView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: testimonials.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // DocumentSnapshot doc = testimonials[index];
                                  // String docID = doc.id;
                                  String name = testimonials[index]['name'];
                                  String message =
                                      testimonials[index]['testimony'];
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Card(
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              '"',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40,
                                                  color: Colors.amber),
                                            ),
                                          ),
                                          Container(
                                            width: width > 780 ? 250 : 150,
                                            height: width > 780 ? 220 : 180,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 30,
                                                      left:
                                                          width > 780 ? 50 : 10,
                                                      right:
                                                          width > 780 ? 50 : 10,
                                                      bottom: 20),
                                                  child: Text(
                                                    message,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5,
                                                      left: width > 780
                                                          ? 180
                                                          : 80,
                                                      right: 2,
                                                      bottom: 5),
                                                  child: Text(
                                                    name,
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF0C4546))),
                              ],
                            );
                          }
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(width: 50),
                      OutlinedButton(
                        onPressed: () {
                          TestimonialDialog testimonialDialog =
                              TestimonialDialog();
                          testimonialDialog.show(context);
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            'Submit a Testimony',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 12, top: 3),
                        child: Card(
                          color: const Color.fromARGB(194, 255, 193, 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: goToPreviousItem,
                                  icon: Icon(Icons.arrow_back_ios)),
                              IconButton(
                                  onPressed: goToNextItem,
                                  icon: Icon(Icons.arrow_forward_ios)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('TARGET CUSTOMERS',
                            style: GoogleFonts.firaSansCondensed(
                                fontWeight: FontWeight.bold,
                                fontSize: width > 780 ? 40 : 22,
                                color: Color(0xFF315C7A))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                width: width > 780 ? 300 : 230,
                                height: 150,
                                child: Stack(
                                  children: [
                                    width > 780
                                        ? Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Ffishpondowners.jpg?alt=media&token=471b2a43-7ccb-428a-8899-813392032b3f',
                                            fit: BoxFit.cover,
                                            width: 300,
                                            isAntiAlias: true,
                                            opacity:
                                                AlwaysStoppedAnimation(0.2),
                                          )
                                        : Container(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, left: 10, right: 10),
                                          child: Center(
                                            child: Text(
                                              'Fishpond Owners',
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.0,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 2,
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          child: Text(
                                            'A fishpond owner, owns or manages a pond or lake where fish are raised or cultivated. They could operate and raise fish or lease out their fishpond to fish cultivators.',
                                            textAlign: TextAlign.justify,
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              fontSize: width > 780 ? 14 : 13.0,
                                              color: Color.fromARGB(
                                                  228, 12, 69, 70),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(width: width > 780 ? 40 : null),
                            Card(
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                width: width > 780 ? 300 : 230,
                                height: 150,
                                child: Stack(
                                  children: [
                                    width > 780
                                        ? Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Ffishcultivators.jpg?alt=media&token=ffd0d5ef-2366-4aa7-aad9-715b4b88d5d2',
                                            fit: BoxFit.cover,
                                            width: 300,
                                            isAntiAlias: true,
                                            opacity:
                                                AlwaysStoppedAnimation(0.2),
                                          )
                                        : Container(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, left: 10, right: 10),
                                          child: Center(
                                            child: Text(
                                              'Fish Cultivators',
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.0,
                                                color: Color.fromARGB(
                                                    255, 12, 69, 70),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 2,
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          child: Text(
                                            'A fish cultivator is someone who is involved in breeding, and raising fish. They are responsible in the whole process of fish production.',
                                            textAlign: TextAlign.justify,
                                            style:
                                                GoogleFonts.firaSansCondensed(
                                              fontSize: width > 780 ? 14 : 13.0,
                                              color: Color.fromARGB(
                                                  228, 12, 69, 70),
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
                      ],
                    ),
                  ),
                  Container(
                    height: 28,
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(55))),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fbgg.jpg?alt=media&token=61211789-3142-4bce-ab78-0106ac65e4c8',
                          height: 300,
                          width: width,
                          isAntiAlias: true,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'In partnership with',
                                style: GoogleFonts.firaSansCondensed(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Card(
                                  child: Container(
                                      height: 100,
                                      width: 220,
                                      child: Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fmctbi.png?alt=media&token=65ed98d5-e5e9-40d9-8015-499cd825a92c',
                                        fit: BoxFit.fill,
                                      ))),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
