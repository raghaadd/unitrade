import 'package:flutter/material.dart';
import 'package:flutter_project_1st/log_sign_forgot/loginpage.dart';

class websiteHomePage extends StatefulWidget {
  const websiteHomePage({super.key});

  @override
  State<websiteHomePage> createState() => _websiteHomePageState();
}

class _websiteHomePageState extends State<websiteHomePage> {
  GlobalKey servicesKey = GlobalKey();
  GlobalKey contactUsKey = GlobalKey();
  GlobalKey MainKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    double containerHieght = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF117a5d).withOpacity(0.7),
          leading: Image(
            image: AssetImage(
              'assets/deal_icon.png',
            ),
            color: Colors.white,
          ),
          title: Text(
            "U N I T R A D E",
            style: TextStyle(
                color: Color(0xFFffffff),
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => scrollToSection(MainKey),
                child: Text(
                  "Main",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                )),
            TextButton(
                onPressed: () => scrollToSection(servicesKey),
                child: Text(
                  "Services",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                )),
            TextButton(
                onPressed: () => scrollToSection(contactUsKey),
                child: Text(
                  "Contact Us",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => login()));
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: containerWidth * 0.3,
                  height: containerHieght * 0.75,
                  child: Image.asset('assets/website.jpg'),
                ),
                Column(
                  children: [
                    Container(
                      key: MainKey,
                      width: 480,
                      color: Colors.white,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w300,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Welcome",
                                style: TextStyle(color: Color(0xFF117a5d))),
                            TextSpan(
                                text:
                                    " to UniTrade for university students to sell items.",
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 20), // Spacing between the text and buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Store Button
                        ElevatedButton.icon(
                          icon: Image.asset('assets/app_store_icon.png',
                              height:
                                  40), // Replace with your App Store icon asset
                          label: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Available on",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                              SizedBox(height: 2),
                              Text("App Store",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28, // Set the font size to 28
                                      fontWeight: FontWeight.w300)),
                            ],
                          ),
                          onPressed: () {
                            // Add your onPressed functionality here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF469d89),
                            elevation: 7,
                            shadowColor: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10), // Spacing between buttons
                        // Google Play Button
                        ElevatedButton.icon(
                          icon: Image.asset('assets/google_play_icon.png',
                              height:
                                  40), // Replace with your Google Play icon asset
                          label: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Available on",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                              SizedBox(height: 2),
                              Text("Google Play",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28, // Set the font size to 28
                                      fontWeight: FontWeight.w300)),
                            ],
                          ),
                          onPressed: () {
                            // Add your onPressed functionality here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF469d89),
                            elevation: 7,
                            shadowColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 40,
              key: servicesKey,
              width: containerWidth,
              color: Color(0xFF117a5d).withOpacity(0.7),
              child: Center(
                child: Text(
                  "Services",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: containerWidth * 0.3,
                    height: containerHieght * 0.78,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Color(0xFF117a5d).withOpacity(0.6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              //SizedBox(height: 80),
                              Text('Welcome to',
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)),
                              Text('UniTrade.',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              SizedBox(height: 40),
                              Image(
                                  image: AssetImage(
                                      'assets/pages/page1_remove.png'),
                                  height: 200,
                                  width: 200),
                              SizedBox(height: 20),
                              Text(
                                'UniTrade offers a unique marketplace for university students to exchange unwanted items, fostering a vibrant and beneficial community within the university.',
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFFffffff)),
                                textAlign:
                                    TextAlign.center, // Center-align the text
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                Container(
                  width: containerWidth * 0.3,
                  height: containerHieght * 0.78,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(0xFF117a5d).withOpacity(0.6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('What You Can Do in',
                          style: TextStyle(fontSize: 35, color: Colors.white)),
                      Text('UniTrade?',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(height: 40),
                      Image(
                          image: AssetImage('assets/pages/page2_remove.png'),
                          height: 200,
                          width: 200),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Students can utilize UniTrade to either list their items for sale or explore the platform to purchase products they need.',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFFffffff)),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    width: containerWidth * 0.3,
                    height: containerHieght * 0.78,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Color(0xFF117a5d).withOpacity(0.6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Features in',
                            style:
                                TextStyle(fontSize: 35, color: Colors.white)),
                        Text('UniTrade.',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(height: 40),
                        Image(
                            image: AssetImage('assets/pages/page3_remove.png'),
                            height: 200,
                            width: 200),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Key features of UniTrade include the ability to chat with sellers, alongside a range of services designed to enhance the overall student experience.',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFFffffff)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 40,
              key: contactUsKey,
              width: containerWidth,
              color: Color(0xFF117a5d).withOpacity(0.7),
              child: Center(
                child: Text(
                  "Contact us",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0),
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(20),
              width: containerWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //SizedBox(height: 10),
                  Column(
                    children: [
                      Icon(
                        Icons.email,
                        color: Color(0xFF117a5d),
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Unitrade926@gmail.com",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  Column(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Color(0xFF117a5d),
                        size: 40,
                      ),
                      SizedBox(height: 8), // spacing between icon and text
                      Text(
                        "+97254168650",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]),
        ));
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: Duration(seconds: 1));
    }
  }
}
