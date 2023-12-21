import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1st/Notificationpage/CustomAlertConten.dart';
import 'package:flutter_project_1st/accountpaage/appBarProfile.dart';

import 'package:flutter_project_1st/categorise/furniturepage/furniture_details.dart';
import 'package:flutter_project_1st/categorise/slidespage/softcopy/widgets/PdfPreviewScreen.dart';
import 'package:flutter_project_1st/chatpage/userchatpage.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/payment/payment.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class otherUserAccountPage extends StatefulWidget {
  otherUserAccountPage({
    super.key,
    required this.userRegisterID,
    required this.flagReserved,
    required this.flagReservedResult,
    required this.desicion,
    required this.itemTitle,
    required this.itemId,
    required this.goNotification,
    required this.price,
  });
  final String userRegisterID;
  bool flagReserved;
  bool flagReservedResult;
  bool desicion;
  final String itemTitle;
  final String itemId;
  final bool goNotification;
  final String price;

  @override
  State<otherUserAccountPage> createState() => _otherUserAccountPageState();
}

class _otherUserAccountPageState extends State<otherUserAccountPage> {
  final double coverHeight = 240;
  final double profileHeight = 144;
  String Fname = '';
  String Lname = '';
  String Major = '';
  String About = '';
  String Profileimage = '';
  String registerid = '';
  int selectedIconIndex = -1;
  Color colorIcon = Colors.black54;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final registerID = userData.registerID;
      registerid = registerID;

      if (registerID != null) {
        print("inside initializeData");
        print(widget.userRegisterID);
        await fetchProfileInfo(widget.userRegisterID);
        await fetchuserItems(widget.userRegisterID);
        await fetchuserSlides(widget.userRegisterID);
      } else {
        // Handle the case where registerID is null
        print('RegisterID is null.');
      }
    } catch (error) {
      // Handle errors
      print('Error initializing data: $error');
    }
  }

  int decision = 0;

  Future<void> addDecision({
    required String iditem,
    required int decision,
    required String itemRequester,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addDecision');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'iditem': iditem,
          'decision': decision.toString(),
          'itemRequester': itemRequester
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Reserved successfully');
        setState(() {
          widget.flagReserved = false;
        });
      } else if (response.statusCode == 400) {
        print("400 error");
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Reserved Alert',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomAlertContent(
                      alertText:
                          "This item already reserved for another person"),
                  SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close Dialog
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF117a5d),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> fetchProfileInfo(String registerID) async {
    print("inside fetchProfileInfo");
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/profileInfo/$registerID');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          final firstItem = jsonResponse.first;
          print('First Item: $firstItem');

          final fname = firstItem['Fname'];
          final lname = firstItem['Lname'];
          final major = firstItem['major'];
          final about = firstItem['about'];
          final profileimage = firstItem['profileimage'];

          setState(() {
            Fname = fname;
            Lname = lname;
            Major = major != null ? major.toString() : 'Student Major';
            About = about != null
                ? about.toString()
                : 'Write any additinaol information';
            Profileimage = profileimage ?? '';
            ;
          });
        } else {
          // Handle unexpected response format
          print('Invalid response format');
        }
      } else {
        // Handle errors or server response based on status code
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  List<Map> items = [];
  Future<void> fetchuserItems(String registerID) async {
    print("inside fetchProfileInfo");
    final ipAddress = await getLocalIPv4Address();
    final response = await http
        .get(Uri.parse('http://$ipAddress:3000/userItems/$registerID'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        items = data.map((item) {
          return {
            "id": item["iditem"],
            "image": item["image"],
            "title": item["title"],
            "price": item["price"],
            "category": item["CategoryName"],
            "Date": item["date"],
            "phoneNumber": item["phoneNumber"],
            "status": item["status"],
            "description": item["description"],
            "Fname": item["Fname"],
            "Lname": item["Lname"],
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load furniture items');
    }
  }

  List<Map> slides = [];
  Future<void> fetchuserSlides(String registerID) async {
    print("inside fetchProfileInfo");
    final ipAddress = await getLocalIPv4Address();
    final response = await http
        .get(Uri.parse('http://$ipAddress:3000/userSlides/$registerID'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        slides = data.map((slide) {
          return {
            "id": slide["iditem"],
            "image": slide["image"],
            "title": slide["title"],
            "price": slide["price"],
            "category": slide["CategoryName"],
            "Date": slide["date"],
            "phoneNumber": slide["phoneNumber"],
            "status": slide["status"],
            "description": slide["description"],
            "Fname": slide["Fname"],
            "Lname": slide["Lname"],
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load furniture items');
    }
  }

  // List<Map<String, dynamic>> _founditems = [];

  Future<bool> checkFavorite(int itemId) async {
    final ipAddress = await getLocalIPv4Address();
    print(ipAddress);
    final apiUrl = 'http://$ipAddress:3000/checkFavorite/$itemId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['isFavorite'];
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Handle exceptions
      print('Exception: $error');
      return false;
    }
  }

  Future<void> deleteitems({
    required String iditem,
    required int index,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/delteitem');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'iditem': iditem,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        setState(() {
          setState(() {
            items.removeAt(index); // Remove the item from the list
          });
        });
        print('Deleted successful');
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  void _launchURL(String pdfFilePath) async {
    try {
      await OpenFile.open(pdfFilePath);
    } catch (e) {
      print('Error opening file: $e');
    }
  }

  Future<void> addReview({
    required String original_userID,
    required String review_userID,
    required String review,
    required String comment,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addReview');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'original_userID': original_userID,
          'review_userID': review_userID,
          'review': review,
          'comment': comment,
        },
      );

      if (response.statusCode == 200) {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> addSeeNotification({
    required String iditem,
    required int seeNotif,
    required String itemReqester,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addSeeNotif');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'iditem': iditem,
          'seeNotification': seeNotif.toString(),
          'itemRequester': itemReqester
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Reserved successfully');
      } else if (response.statusCode == 400) {
        print("400 error");
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double containerWidth = MediaQuery.of(context).size.width;
    double containerHeight = MediaQuery.of(context).size.height;
    final top = coverHeight - profileHeight / 0.78;
    final userData = Provider.of<UserData>(context, listen: false);
    final String review_userID = userData.registerID;
    print("hiii");
    return Scaffold(
        backgroundColor:
            themeProvider.isDarkMode ? Colors.black26 : Color(0xFFffffff),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: appBarProfile(goNotification: widget.goNotification),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print("indie on tap");
                  },
                  child: Container(
                    height: containerHeight * 0.14,
                    width: double.infinity,
                    color: const Color(0xFF117a5d),
                    //child: buildCoverImage(),
                  ),
                ),
                Positioned(
                  top: top,
                  left: 15,
                  child: GestureDetector(
                    onTap: () {
                      print("hi");
                    },
                    child: Positioned(
                      child: buildProfileImage(),
                    ),
                  ),
                ),
              ],
            ),
            //buildTop(containerWidth, containerHeight, context),
            buildContenet(
                containerWidth, containerHeight, themeProvider, review_userID),
            buildReservation(),
            buildReservationResult(review_userID),
            //buildTable(),
            buildMyProduct(themeProvider),
            buildSoftSlides(themeProvider),
          ],
        ));
  }

  Widget buildCoverImage() => Container(
        width: double.infinity,
        height: coverHeight,
        decoration: BoxDecoration(
          color: Color(0xFFc0edda),
          image: DecorationImage(
            image: AssetImage("assets/backgroundimage_profile.png"),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget buildContenet(double containerWidth, double containerHeight,
          themeProvider, String review_userID) =>
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 12, bottom: 8, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: containerHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Fname + " " + Lname,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode
                            ? Color(0xFFffffff)
                            : Color(0xFF000000),
                      ),
                    ),
                    Text(
                      Major,
                      style: TextStyle(
                        fontSize: 18,
                        color: themeProvider.isDarkMode
                            ? Color(0xFFffffff)
                            : Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 50),
                GestureDetector(
                  onTap: () {
                    show(review_userID);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.reviews_rounded,
                        size: 25,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserChatPage(
                                  receiverFname: Fname,
                                  receiverLname: Lname,
                                  receiverId: widget.userRegisterID,
                                  senderId: registerid,
                                  gotoChat: false,
                                )));
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        size: 25,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 0.13 * containerWidth,
              child: Divider(
                thickness: 2,
                color: themeProvider.isDarkMode
                    ? Color(0xFFffffff)
                    : Colors.black54,
              ),
            ),
            buildAbout(themeProvider),
          ],
        ),
      );

  Widget buildAbout(themeProvider) => Container(
        // padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            About,
            style: TextStyle(
              fontSize: 18,
              height: 1.4,
              color:
                  themeProvider.isDarkMode ? Color(0xFFffffff) : Colors.black54,
            ),
          ),
        ]),
      );

  Widget buildProfileImage() {
    return CircleAvatar(
      radius: profileHeight / 2.5,
      backgroundColor: Colors.grey.shade300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (Profileimage.isEmpty)
            Icon(
              Icons.person,
              size: 100,
              color: Colors.white,
            ),
          if (Profileimage.isNotEmpty)
            ClipOval(
              child: Image.file(
                File(Profileimage),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
        ],
      ),
    );
  }

  buildReservation() {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 10, bottom: 10, right: 12),
      child: Visibility(
        visible: widget.flagReserved,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF117a5d).withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Fname + S.of(context).request_your_item + widget.itemTitle,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      decision = 1;
                      print(decision);
                      await addDecision(
                          decision: decision,
                          iditem: widget.itemId.toString(),
                          itemRequester: widget.userRegisterID);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 45, right: 45),
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      S.of(context).Accept,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      decision = 0;
                      print(decision);
                      await addDecision(
                          decision: decision,
                          iditem: widget.itemId.toString(),
                          itemRequester: widget.userRegisterID);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 45, right: 45),
                      primary: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      S.of(context).Decline,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  buildReservationResult(review_userID) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 10, bottom: 10, right: 12),
      child: Visibility(
        visible: widget.flagReservedResult,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF117a5d).withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      Fname +
                          (widget.desicion
                              ? ", accepted your reserved request for " +
                                  widget.itemTitle +
                                  "."
                              : ", apologize because " +
                                  widget.itemTitle +
                                  " was assigned to someone else."),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (widget.desicion) {
                        print("inside payment");
                        print(widget.price);
                        print(widget.itemTitle);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                      price: widget.price,
                                      itemname: widget.itemTitle,
                                      itemId: widget.itemId,
                                      RegisterID: widget.userRegisterID,
                                    )));
                      } else {
                        await addSeeNotification(
                            seeNotif: 1,
                            iditem: widget.itemId.toString(),
                            itemReqester: review_userID);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HiddenDrawer(
                                    page: 0,
                                  )),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 45, right: 45),
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      widget.desicion ? "Payment" : "Ok",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMyProduct(themeProvider) => Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).Items,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: themeProvider.isDarkMode
                            ? Color(0xFFffffff)
                            : Colors.black,
                      ),
                    ),
                    Text(
                      S.of(context).see_all,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: themeProvider.isDarkMode
                            ? Color(0xFFffffff)
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              items.isEmpty
                  ? Center(
                      child: Text(
                        S.of(context).Message_No_item,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: themeProvider.isDarkMode
                              ? Color(0xFFffffff)
                              : Colors.black,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.73,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            print("hii");
                            print(items);
                            // final isFavorite =
                            //     await checkFavorite(items[index]['iditem']);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FurnitureDetails(
                                      itemId: items[index]['id'],
                                      Furnitures: items,
                                      isFavorite: false,
                                      isReserved: false,
                                      showNavBar: true,
                                      gotoFav: false,
                                    )));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      // color: Color(0xFF117a5d).withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        File(
                                          items[index]['image'],
                                        ),
                                        fit: BoxFit.cover,
                                        height: 160,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                items[index]['title'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: themeProvider.isDarkMode
                                      ? Color(0xFFffffff)
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                '₪${items[index]['price']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: themeProvider.isDarkMode
                                      ? Color(0xFFffffff)
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      );

  Widget buildSoftSlides(themeProvider) => Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).softcopy_slides,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: themeProvider.isDarkMode
                            ? Color(0xFFffffff)
                            : Colors.black,
                      ),
                    ),
                    Text(
                      S.of(context).see_all,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: themeProvider.isDarkMode
                            ? Color(0xFFffffff)
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              slides.isEmpty
                  ? Center(
                      child: Text(
                        S.of(context).Message_No_item,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: themeProvider.isDarkMode
                              ? Color(0xFFffffff)
                              : Colors.black,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.73,
                      ),
                      itemCount: slides.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        20.0), // Adjust the radius as needed
                                    topRight: Radius.circular(20.0),
                                  ),
                                  child: Container(
                                    color: themeProvider.isDarkMode
                                        ? Colors.black87
                                        : Color(0xFFffffff),
                                    //color: Colors.white,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 18),
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.preview,
                                              size: 25,
                                              color: themeProvider.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            title: Text(
                                              S.of(context).Preview,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: themeProvider.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfPreviewScreen(
                                                            pdfFilePath:
                                                                slides[index]
                                                                    ['image']),
                                                  ));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.download,
                                              size: 25,
                                              color: themeProvider.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            title: Text(
                                              S.of(context).Download,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: themeProvider.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              print("path");
                                              print(slides[index]['image']);
                                              _launchURL(
                                                  slides[index]['image']);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      // color: Color(0xFF117a5d).withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        "assets/pdf.png",
                                        fit: BoxFit.cover,
                                        height: 160,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                slides[index]['title'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: themeProvider.isDarkMode
                                      ? Color(0xFFffffff)
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                '₪${slides[index]['price']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: themeProvider.isDarkMode
                                      ? Color(0xFFffffff)
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      );

  void show(String review_userID) {
    TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            child: Stack(
              children: [
                Container(
                  width: 340,
                  height: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    //padding: EdgeInsets.all(0.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog.
                      },
                    ),
                  ),
                ),
                Positioned(
                    top: 45,
                    left: 20,
                    child: Text(
                      "Give Review",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    )),
                Positioned(
                    top: 75,
                    left: 20,
                    child: Text(
                      "Give your review based on real-life experiences",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )),
                Positioned(
                  top: 120,
                  left: 20,
                  child: Row(
                    children: [
                      buildIconButton(
                          Icons.sentiment_very_dissatisfied, 0, setState),
                      buildIconButton(
                          Icons.sentiment_dissatisfied, 1, setState),
                      buildIconButton(Icons.sentiment_neutral, 2, setState),
                      buildIconButton(Icons.sentiment_satisfied, 3, setState),
                      buildIconButton(
                          Icons.sentiment_very_satisfied, 4, setState),
                    ],
                  ),
                ),
                Positioned(
                    top: 210,
                    left: 20,
                    child: Text(
                      "Do you have any other comments?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    )),
                Positioned(
                  top: 240,
                  left: 20,
                  child: Container(
                    width: 300, // Adjusted width based on your design
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Color(0xFF117a5d)), // Set border color to green
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: commentController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: "Type your comment here...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 390,
                    left: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 140,
                          decoration: BoxDecoration(
                            color:
                                Color(0xFF117a5d), // Set green background color
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF117a5d).withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);

                              // Close the keyboard
                              FocusScope.of(context).unfocus();
                              int review = selectedIconIndex + 1;
                              String comment = commentController.text;
                              await addReview(
                                  original_userID: widget.userRegisterID,
                                  review_userID: review_userID,
                                  review: review.toString(),
                                  comment: comment);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors
                                  .transparent, // Set transparent background
                              elevation: 0, // Remove elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Send",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 140,
                          decoration: BoxDecoration(
                            color:
                                Color(0xFFffffff), // Set green background color
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Color(0xFF117a5d), width: 1),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors
                                  .transparent, // Set transparent background
                              elevation: 0, // Remove elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Color(0xFF117a5d),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          );
        });
      },
    );
  }

  IconButton buildIconButton(IconData icon, int index, StateSetter setState) {
    return IconButton(
      icon: GestureDetector(
        onTap: () {
          setState(() {
            selectedIconIndex = index;
            colorIcon =
                selectedIconIndex == index ? Color(0xFFFFD700) : Colors.black54;
          });
        },
        child: Icon(
          icon,
          size: 40,
          color: selectedIconIndex == index ? colorIcon : Colors.black54,
        ),
      ),
      onPressed: () {},
    );
  }
}
