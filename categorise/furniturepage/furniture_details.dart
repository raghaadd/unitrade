import 'package:flutter/material.dart';
import 'package:flutter_project_1st/categorise/DetailsItem.dart';
import 'package:flutter_project_1st/categorise/GreenCircles.dart';
import 'package:flutter_project_1st/categorise/appbar_details.dart';
import 'package:flutter_project_1st/categorise/bottomNavigationbar.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class FurnitureDetails extends StatefulWidget {
  const FurnitureDetails(
      {Key? key,
      required this.itemId,
      required this.Furnitures,
      required this.isFavorite,
      required this.isReserved,
      required this.showNavBar,
      required this.gotoFav})
      : super(key: key);
  final int itemId;
  final List<Map> Furnitures;
  final bool isFavorite;
  final bool isReserved;
  final bool showNavBar;
  final bool gotoFav;
  @override
  State<FurnitureDetails> createState() => _FurnitureDetailsState();
}

class _FurnitureDetailsState extends State<FurnitureDetails> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final item = widget.Furnitures.firstWhere(
        (Furniture) => Furniture["id"] == widget.itemId);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarDetails(gotoFav: widget.gotoFav),
      ),
      backgroundColor: themeProvider.isDarkMode
          ? Color.fromARGB(255, 37, 37, 37).withOpacity(0.3)
          : Color(0xFFffffff),
      // backgroundColor: Color(0xFFffffff),
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return Container(
            child: Column(
              children: [
                GreenCricles(item: item),
                DetailsItem(constraints: constraints, item: item),
                Visibility(
                  visible: widget
                      .showNavBar, // Set this flag based on your condition
                  child: BottomNav(
                    itemId: widget.itemId,
                    isFavorite: widget.isFavorite,
                    isReserved: widget.isReserved,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      //bottomNavigationBar: BottomNav(itemId: widget.itemId,isFavorite: widget.isFavorite),
    );
  }
}
