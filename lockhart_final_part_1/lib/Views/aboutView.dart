import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(0.15 * screenWidth, 80, 0.15 * screenWidth, 0),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'This app is a collection of monsters, friends, and items you find throughout Hyrule in The Legend of Zelda: Breath of the Wild. The application was designed by me, but the information was made available by gadhagod on Github. Thank you to them and you for taking a look at this application.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 40),
              Text(
                'Developed by River Lockhart for CMSC 2204',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
