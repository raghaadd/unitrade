import 'package:flutter/material.dart';
import 'package:flutter_project_1st/adminPage/users/addStudent.dart';
import 'package:flutter_project_1st/adminPage/users/model/user.dart';
import 'package:flutter_project_1st/adminPage/users/responsive.dart';
import 'package:flutter_project_1st/adminPage/users/update_student.dart';
import 'package:flutter_project_1st/adminPage/users/utils/utils.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});
  static const String id = "Student table";

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  late List<User> users;
  late List<User> filteredUsers;
  TextEditingController searchController = TextEditingController();

  bool sortAscending = true;
  String selectedSortProperty = 'firstName';
  bool isMenuOpen = false;
  @override
  void initState() {
    super.initState();

    this.users = [];
    this.filteredUsers = [];
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    // Use http package to make a GET request to your Node.js server
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/students');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final List<dynamic> data = jsonDecode(response.body);
      print('Fetched Data: $data');
      setState(() {
        // Convert the JSON data to a List<User>
        filteredUsers = data.map((json) => User.fromJson(json)).toList();
        print('filteredUsers Data: $filteredUsers');
        users = List.of(filteredUsers); // Update 'users' as well
        print('Usersssssss Data: $users');
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception or handle the error
      print('Failed to fetch users: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    const defaultPadding = 16.0;
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: SideMenu(),
      // appBar: AppBar(
      //   leading: buildPopupMenuButton(context),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            buildPopupMenuButton(context),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 7),
                                child: buildDataTable(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDataTable() {
    final columns = [
      'first Name',
      'Last Name',
      'E-mail',
      'phone NO.',
      'ID',
      '',
    ];
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(filteredUsers),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      if (column == 'Edit') {
        return DataColumn(label: Text(column));
      }
      return DataColumn(label: Text(column));
    }).toList();
  }

  void deleteSelectedUser(User user) async {
    final selectedUserID = user.ID;

    final ipAddress = await getLocalIPv4Address();
    final deleteUrl =
        Uri.parse('http://$ipAddress:3000/students/$selectedUserID');

    setState(() {
      users.remove(user);
      filteredUsers.remove(user);
    });

    final response = await http.delete(
      deleteUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Handle success
      print('User deleted successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student deleted successfully'),
          duration: Duration(seconds: 5),
        ),
      );
    } else {
      // Handle error
      print('Failed to delete user: ${response.statusCode}');
    }
  }

  List<DataRow> getRows(List<User> users) => users.map((User user) {
        final cells = [
          // user.isSelected,
          user.firstName,
          user.LastName,
          user.email,
          user.phoneNO,
          user.ID
        ];
        return DataRow(
          cells: [
            ...Utils.modelBuilder(cells, (index, cell) {
              // Handle other columns
              return DataCell(Text('$cell'));
            }),
            DataCell(Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateStudentScreen(user: user),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteSelectedUser(user);
                  },
                ),
              ],
            )),
          ],
        );
      }).toList();

  void filterUsers(String query) {
    setState(() {
      if (query.isNotEmpty) {
        // Use where() to filter users based on the search query
        filteredUsers = users.where((user) {
          return user.firstName.toLowerCase().contains(query.toLowerCase()) ||
              user.LastName.toLowerCase().contains(query.toLowerCase()) ||
              user.email.toLowerCase().contains(query.toLowerCase()) ||
              user.phoneNO.toString().toLowerCase().contains(query) ||
              user.ID.toString().toLowerCase().contains(query);
        }).toList();
      } else {
        // If the query is empty, show all users
        filteredUsers = List.of(users);
      }
    });
  }

  void sortUsers() {
    setState(() {
      // Sort the 'users' list based on the selected property
      users.sort((a, b) {
        if (selectedSortProperty == 'firstName') {
          final compareValue = a.firstName.compareTo(b.firstName);
          return sortAscending ? compareValue : -compareValue;
        } else if (selectedSortProperty == 'ID') {
          final compareValue = a.ID.compareTo(b.ID);
          return sortAscending ? compareValue : -compareValue;
        }

        // Handle additional sorting properties here

        return 0; // Default case, should not happen
      });

      // Print debug information
      print('Sorted Users: $users');

      // Update 'filteredUsers' as well
      filteredUsers = List.of(users);

      // Toggle the sorting order for the next time
      sortAscending = !sortAscending;
    });
  }

  Padding buildPopupMenuButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Users Information",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              showPopupMenu(context);
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black,
              size: 30,
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              // Add more styling as required
            ),
          )
        ],
      ),
    );
  }

  void showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      color: Colors.white,
      position: RelativeRect.fromLTRB(50, 120, 40, 0),
      items: [
        PopupMenuItem<String>(
          value: 'add_student',
          child: Text('Add Student'),
        ),
        PopupMenuItem<String>(
          value: 'sort_by_id',
          child: Text('Sort by ID'),
        ),
        PopupMenuItem<String>(
          value: 'sort_by_first_name',
          child: Text('Sort by First Name'),
        ),
      ],
    ).then((value) {
      handleMenuSelection(context, value);
    });
  }

  void handleMenuSelection(BuildContext context, String? value) {
    if (value == 'add_student') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => addStudentScreen()),
      );
    } else if (value == 'sort_by_id') {
      setState(() {
        selectedSortProperty = 'ID';
        sortUsers();
      });
    } else if (value == 'sort_by_first_name') {
      setState(() {
        selectedSortProperty = 'firstName';
        sortUsers();
      });
    }
  }
}

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchField({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultPadding = 16.0;
    return Container(
      constraints: BoxConstraints(maxWidth: 200),
      child: TextField(
        controller: controller,
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: "Search",
          fillColor: Colors.white,
          filled: true,
          // border: OutlineInputBorder(
          //   borderSide: BorderSide.none,
          //   borderRadius: const BorderRadius.all(Radius.circular(10)),
          // ),
          suffixIcon: InkWell(
            onTap: () {
              // Trigger search when the suffix icon is tapped
              onSearch(controller.text);
            },
            child: Container(
              padding: EdgeInsets.all(defaultPadding * 0.75),
              margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: SvgPicture.asset(
                "assets/icons/Search.svg",
                color: Color(0xFF17573b),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
