import 'package:flutter/material.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class appBarDetails extends StatelessWidget {
  const appBarDetails({Key? key, required this.gotoFav});
  final bool gotoFav;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      backgroundColor: Color(0xFF117a5d),
      leading: IconButton(
        icon: Icon(
          Intl.getCurrentLocale() == 'ar'
              ? Icons.arrow_forward_ios_outlined
              : Icons.arrow_back_ios_new_outlined,
          color: themeProvider.isDarkMode
              ? Color(0xFF000000)
              : Colors.grey.shade200,
          //color: Colors.grey.shade200,
          size: 30,
        ),
        onPressed: () {
          if (gotoFav) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HiddenDrawer(
                          page: 1,
                        )));
          } else {
            Navigator.pop(context);
          }
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            // Handle notification icon press
          },
          icon: Icon(
            Icons.search,
            size: 30,
            color: themeProvider.isDarkMode
                ? Color(0xFF000000)
                : Colors.grey.shade200,
          ),
        ),
        IconButton(
          onPressed: () {
            // Handle notification icon press
          },
          icon: Icon(
            Icons.filter_list,
            size: 30,
            color: themeProvider.isDarkMode
                ? Color(0xFF000000)
                : Colors.grey.shade200,
          ),
        ),
      ],
    );
  }
}
