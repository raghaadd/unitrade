import 'package:flutter/material.dart';
import 'package:flutter_project_1st/adminPage/report/reportClass.dart';
import 'package:flutter_project_1st/adminPage/report/reportDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_project_1st/ipaddress.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({super.key});

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  List<Report> reports = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      await fetchItemDetails();
    } catch (error) {
      // Provide more meaningful error handling or logging
      print('Error initializing data: $error');
    }
  }

  Future<void> fetchItemDetails() async {
    final ipAddress = await getLocalIPv4Address();
    final itemUrl = Uri.parse('http://$ipAddress:3000/reportAdmin');
    print("Inside fetchhh******************************");

    try {
      final response = await http.get(itemUrl);
      if (response.statusCode == 200) {
        final List<dynamic> itemDataList = jsonDecode(response.body);

        for (final itemData in itemDataList) {
          final report = Report.fromJson({
            'idreport': itemData['idreport'],
            'reportcomment': itemData['reportcomment'],
            'itemId': itemData['itemId'],
            'registerID': itemData['registerID'],
            'title': itemData['title'],
            'phoneNumber': itemData['phoneNumber'],
            'image': itemData['image'],
            'description': itemData['description'],
            'price': itemData['price'],
          });

          setState(() {
            reports.add(report);
          });
        }
      } else {
        print('Failed to fetch item details: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching item details: $error');
    }
  }

  Future<void> DeleteItems({
    required String iditem,
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
        print('items deleted successfully');
        setState(() {});
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
    double containerWidth = MediaQuery.of(context).size.width * 0.98;
    double containerHeight = MediaQuery.of(context).size.height * 0.4;
    //final report;
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return Container(
          margin: EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(20.0),
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
              image: NetworkImage('${report.image}'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 55,
                child: CustomReportTile(report: report),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white.withOpacity(0.9),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.dst,
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black87,
                        size: 30,
                      ),
                      onPressed: () {
                        _showOptionsBottomSheet(context, index, report.itemId);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOptionsBottomSheet(BuildContext context, int index, int itemId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.details),
              title: Text('Details'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ReportDetailsPage(report: reports[index]),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _showDeleteConfirmationDialog(context, index, itemId);
              },
            ),
          ],
        );
      },
    );
  }

  void deleteReport(int itemId) async {
    final ipAddress = await getLocalIPv4Address();
    final deleteUrl = Uri.parse('http://$ipAddress:3000/report/$itemId');

    try {
      final response = await http.delete(deleteUrl);

      if (response.statusCode == 200) {
        // Report deleted successfully
        // You can navigate back or show a success message
        Navigator.pop(context); // Navigate back to the previous screen
        // Optionally, show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Failed to delete the report
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete report: ${response.statusCode}'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      // Handle error
    }
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, int index, int iditem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Report',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
          ),
          content: Text(
            'Are you sure you want to delete this report?',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () async {
                // deleteReport(reports[index].itemId);
                Navigator.pop(context);
                print(iditem.toString());
                await DeleteItems(iditem: iditem.toString());
                // setState(() {
                //   itemArray.removeAt(index);
                // });
              },
              child: Text(
                'Delete',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomReportTile extends StatelessWidget {
  final Report report;

  const CustomReportTile({required this.report});

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.98;
    return Container(
      // color:Colors.white.withOpacity(0.9),
      width: containerWidth * 0.95,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withOpacity(0.9),
      ),
      child: Center(
        child: ListTile(
          // title: Text('Report ID: ${report.idreport}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text('Report #: ${report.idreport ?? 'N/A'}'),
              Text(
                'Item ID: ${report.itemId}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                'Item Name: ${report.title ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              Text(
                'Description: ${report.description ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                'Price: ${report.price ?? 'N/A'}' + " ₪",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                'Report Comment: ${report.reportcomment ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                'Student ID: ${report.registerID ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              Text(
                'Student PhoneNO.: ${report.phoneNumber ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
