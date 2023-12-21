import 'package:flutter/material.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class DetailsItem extends StatelessWidget {
  final BoxConstraints constraints;
  const DetailsItem({
    super.key,
    required this.constraints,
    required this.item,
  });
  final Map item;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      width: constraints.maxHeight,
      height: 350,
      color: themeProvider.isDarkMode
          ? Color(0xFF000000).withOpacity(0.3)
          : Color(0xFFf0eff5),
      //color: Color(0xFFf0eff5),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 10,
            ),
            Text(
              S.of(context).Details,
              style: TextStyle(
                color: themeProvider.isDarkMode
                    ? Color(0xFFffffff)
                    : Color(0xFF000000),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: Color(0xFFc0edda),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    S.of(context).price,
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? const Color.fromARGB(255, 58, 58, 58)
                          : Color(0xFF000000),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Text(
                    item["price"] + "₪",
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? const Color.fromARGB(255, 58, 58, 58)
                          : Color(0xFF000000),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: Color(0xFFc0edda),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    S.of(context).Status,
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? const Color.fromARGB(255, 58, 58, 58)
                          : Color(0xFF000000),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Text(
                    item["status"],
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? const Color.fromARGB(255, 58, 58, 58)
                          : Color(0xFF000000),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              S.of(context).Description,
              style: TextStyle(
                color: themeProvider.isDarkMode
                    ? Color(0xFFffffff)
                    : Color(0xFF000000),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              item["description"].isEmpty ? "-" : item["description"],
              style: TextStyle(
                //color: Color(0xFF000000),
                fontSize: 14,
                color: themeProvider.isDarkMode
                    ? Color(0xFFffffff)
                    : Color(0xFF000000),
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 25,
            ),
          ]),
        ),
      ),
    );
  }
}
