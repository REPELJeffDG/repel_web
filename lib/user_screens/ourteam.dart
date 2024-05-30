import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repel/components/appBar.dart';
import 'package:repel/components/drawer.dart';
//import 'package:url_launcher/url_launcher.dart';

class OurTeam extends StatefulWidget {
  static const String name = "ourteam";
  const OurTeam({Key? key}) : super(key: key);

  @override
  State<OurTeam> createState() => _OurTeamState();
}

class _OurTeamState extends State<OurTeam> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepellogo3d.gif?alt=media&token=b7655764-c3ab-4d20-952a-1948c4343230',
              fit: BoxFit.cover,
              width: double.infinity,
              height: width > 780 ? 500 : 230,
            ),
          ])),
          SliverList(
              delegate: SliverChildListDelegate([
            Stack(
              children: [
                Container(height: 45),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fbgg.jpg?alt=media&token=61211789-3142-4bce-ab78-0106ac65e4c8',
                  fit: BoxFit.cover,
                  width: width,
                  height: width > 780 ? 500 : 630,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: width > 780
                      ? Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepelstandalone.png?alt=media&token=116a9a8b-f614-4a41-aa73-740908c4d233',
                          height: 500,
                          opacity: AlwaysStoppedAnimation(0.1),
                        )
                      : null,
                ),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 120,
                          width: 132,
                          child: GestureDetector(
                            child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fjojo.png?alt=media&token=b548db0e-5ad4-40b3-9ec8-6dfa77ed8b1b'),
                            onTap: () {},
                          ),
                        ),
                        Container(width: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'OUR TEAM',
                              style: GoogleFonts.firaSansCondensed(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                                fontSize: 22,
                              ),
                            ),
                            Container(
                                height: 90,
                                width: 270,
                                child: Image.asset('assets/repelw.png')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 17,
                    children: [
                      Container(
                        height: 120,
                        width: 132,
                        child: GestureDetector(
                          child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fjordan.png?alt=media&token=73173b0b-dacf-41c8-8236-d9ad3ca2f8ae'),
                          onTap: () async {},
                        ),
                      ),
                      Container(
                        height: 120,
                        width: 132,
                        child: GestureDetector(
                          child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fjeffdg.png?alt=media&token=01872a04-2eb3-4c13-afa9-2cb157c184bf'),
                          onTap: () {},
                        ),
                      ),
                      Container(
                        height: 120,
                        width: 132,
                        child: GestureDetector(
                          child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fnava.png?alt=media&token=ede851e7-47e2-4ef1-a663-a88fb4167a5e'),
                          onTap: () {},
                        ),
                      ),
                      Container(
                        height: 120,
                        width: 132,
                        child: GestureDetector(
                          child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fjeffs.png?alt=media&token=b6d734f6-8049-4e71-ab4f-778ab38935c8'),
                          onTap: () {},
                        ),
                      ),
                      Container(
                        height: 120,
                        width: 132,
                        child: GestureDetector(
                          child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Faira.png?alt=media&token=374fe9b2-201a-4b89-8e2a-f23947a44301'),
                          onTap: () {},
                        ),
                      ),
                      Container(
                        height: 120,
                        width: 132,
                        child: GestureDetector(
                          child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Feune.png?alt=media&token=8171c0c5-e989-4e84-9c6a-d7dd8af465de'),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
                  ),
                  width > 900
                      ? visionmissionWeb(context)
                      : visionmissionMobile(context),
                ]),
              ],
            )
          ]))
        ],
      ),
    );
  }

  Widget visionmissionMobile(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'VISION',
          style: GoogleFonts.firaSansCondensed(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.justify,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'By 2028, Our vision is to harness the power of innovation and technology in providing aquaculture solutions to support our local fish farmers in their fishponds and improve the fish economy in our country.',
            style: GoogleFonts.firaSansCondensed(
              color: Colors.white,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(height: 20),
        Text(
          'MISSION',
          style: GoogleFonts.firaSansCondensed(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.justify,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Empowering local fish farmers through innovative aquaculture solutions. Our mission is to leverage cutting-edge technology and sustainable practices to enhance productivity, profitability, and environmental stewardship in fishpond operations, ensuring a thriving future for both our farmers and aquatic ecosystems.',
            style: GoogleFonts.firaSansCondensed(
              color: Colors.white,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget visionmissionWeb(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'VISION',
              style: GoogleFonts.firaSansCondensed(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: 400,
                child: Text(
                  'By 2028, Our vision is to harness the power of innovation and technology in providing aquaculture solutions to support our local fish farmers in their fishponds and improve the fish economy in our country.',
                  style: GoogleFonts.firaSansCondensed(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        Container(width: 50),
        Column(
          children: [
            Text(
              'MISSION',
              style: GoogleFonts.firaSansCondensed(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: 400,
                child: Text(
                  'Empowering local fish farmers through innovative aquaculture solutions. Our mission is to leverage cutting-edge technology and sustainable practices to enhance productivity, profitability, and environmental stewardship in fishpond operations, ensuring a thriving future for both our farmers and aquatic ecosystems.',
                  style: GoogleFonts.firaSansCondensed(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
