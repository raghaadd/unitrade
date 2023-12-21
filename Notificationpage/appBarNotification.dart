import 'package:flutter/material.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class appBarNotification extends StatelessWidget {
  const appBarNotification({Key? key, required this.title,required this.fromUserprofiel});
  final String title;
  final bool fromUserprofiel;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      backgroundColor: Color(0xFF117a5d),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: themeProvider.isDarkMode
              ? Color(0xFF000000)
              : Colors.grey.shade200,
          size: 30,
        ),
        onPressed: () {
          if (fromUserprofiel) {
            print("inside fromUserprofiel in appbar");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HiddenDrawer(
                        page: 0,
                      )),
            );
          } else {
            Navigator.pop(context);
          }
        },
      ),
      title: Text(
        this.title,
        style: TextStyle(
            color: themeProvider.isDarkMode ? Color(0xFF000000) : Colors.white,
            fontSize: 25),
      ),
    );
  }
}
