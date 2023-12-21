import 'package:flutter/material.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ResturantsSection extends StatefulWidget {
  const ResturantsSection({super.key});

  @override
  State<ResturantsSection> createState() => _ResturantsSectionState();
}

class _ResturantsSectionState extends State<ResturantsSection> {
  List<Map> resturants = [
    {
      "id": 1,
      "image": "assets/resturants/rest1.jpeg",
      "name": "Pizza ",
      "description": "description1",
    },
    {
      "id": 2,
      "image": "assets/resturants/rest2.jpeg",
      "name": "image2",
      "description": "description2",
    },
    {
      "id": 3,
      "image": "assets/resturants/rest3.jpeg",
      "name": "image3",
      "description": "description3",
    },
    {
      "id": 4,
      "image": "assets/resturants/rest4.jpeg",
      "name": "image4",
      "description": "description4",
    },
  ];
  late final PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).Resturants,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode
                      ? Color(0xFFffffff)
                      : Color(0xFF000000),
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                S.of(context).view_all,
                style: TextStyle(
                  fontSize: 18.0,
                  color: themeProvider.isDarkMode
                      ? Color(0xFFffffff)
                      : Color(0xFF000000).withOpacity(0.7),
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Column(
          children: [
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (_, index) {
                  final restaurant = resturants[index];
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: Card(
                      margin: EdgeInsets.only(
                        right: 8,
                        left: 4,
                        bottom: 12,
                        top: 8,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)),
                      elevation: 1, // Card elevation (shadow)
                      color: Colors.white,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0),
                            ),
                            child: Image.asset(
                              restaurant["image"],
                              height: 150, // Adjust the height as needed
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ListTile(
                            title: Text(restaurant["name"],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            subtitle: Text(restaurant["description"],
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: resturants.length,
              ),
            )
          ],
        )
      ],
    );
  }
}
