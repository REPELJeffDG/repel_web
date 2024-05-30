import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/components/appBar.dart';
import 'package:repel/components/drawer.dart';
import 'package:repel/user_screens/aquardent.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return width > 780
        ? HomeWeb(width: width, height: height)
        : HomeMobile(width: width, height: height);
  }
}

class HomeWeb extends StatelessWidget {
  const HomeWeb({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        drawer: width > 780 ? null : MyDrawer(),
        body: Center(
          child: Stack(
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2FmockappWeb.jpg?alt=media&token=04021a85-edce-41ba-baef-0d466d892ef4',
                fit: BoxFit.cover,
                width: width,
                height: height,
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
                    padding: const EdgeInsets.only(top: 50, right: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, top: 10, bottom: 10),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Faquardent.png?alt=media&token=6f178d20-8cee-4437-8035-3304a7e697db',
                            scale: 0.1,
                          ),
                        ),
                        Container(height: 25),
                        Row(
                          children: [
                            Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AquardentWeb()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo[600],
                                ),
                                child: Text(
                                  'Learn More!',
                                  style: GoogleFonts.gidugu(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.white),
                                )),
                            Container(
                              width: 50,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Container(
                                height: 240,
                                width: 120,
                                child: Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fsixicons.png?alt=media&token=b4e2c872-9ebc-479a-a05c-2bdcf6a530d9')),
                            Container(
                              width: 50,
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ));
  }
}

class HomeMobile extends StatelessWidget {
  const HomeMobile({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: width > 780 ? null : MyDrawer(),
      body: Center(
        child: Stack(
          children: [
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fmockappbg.jpg?alt=media&token=b771086e-db2c-40bc-aef7-5a75e308f879',
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 70,
                        width: double.infinity,
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fappbar.png?alt=media&token=29e0f034-d748-472b-9f40-ea525b654f5b',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fholisticbanner.png?alt=media&token=1d9e788c-db43-4b04-9e60-38d6eb4290bd',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Faquardent.png?alt=media&token=6f178d20-8cee-4437-8035-3304a7e697db'),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => AquardentMobile())));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo[600],
                          ),
                          child: Text(
                            'Learn More!',
                            style: GoogleFonts.gidugu(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white),
                          )),
                      Container(
                        width: 50,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                          height: 240,
                          width: 120,
                          child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fsixicons.png?alt=media&token=b4e2c872-9ebc-479a-a05c-2bdcf6a530d9')),
                      Container(
                        width: 50,
                      ),
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
