import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/services/firestore.dart';

class TestimonialDialog {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController msgController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _contentBox(context),
        );
      },
    );
  }

  Widget _contentBox(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: 640,
          width: width > 800 ? 600 : 400,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 25, top: 5),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Testimony',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ),
                        Container(height: 15),
                        Text(
                          "We're all ears and excited to hear from you. Just fire away using the testimony form below.",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 13,
                            color: Color.fromARGB(255, 12, 69, 70),
                          ),
                        ),
                        Container(height: 10),
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
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          controller: nameController,
                        ),
                        Container(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Message',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 12, 69, 70),
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter message';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          maxLength: null,
                          maxLines: 5,
                          controller: msgController,
                        ),
                        Container(height: 15),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Testimonial sent')));
                                //DATABASE PART
                                firestoreService.addTestimonial(
                                    nameController.text, msgController.text);

                                nameController.clear();
                                msgController.clear();
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please complete the form')));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[400],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                'Send',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
