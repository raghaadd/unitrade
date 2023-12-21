import 'package:flutter/material.dart';

class CategoryDropDown extends StatefulWidget {
  final double containerHeight;
  final double containerWidth;

  final Function(int) onCategorySelected;

  const CategoryDropDown({
    Key? key,
    required this.containerHeight,
    required this.containerWidth,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  int selectedRadio = 0;
  //late int _selectedRadio;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    //_selectedRadio = widget.selectedRadio;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        width: widget.containerWidth * 1.5,
        height: isExpanded
            ? widget.containerHeight * 1.3
            : widget.containerHeight * 0.3,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        duration: Duration(milliseconds: 300),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 18,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.category_sharp,
                      size: 30,
                      color: Color(0xFF117a5d),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: widget.containerWidth * 0.6,
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 30,
                      color: Color(0xFF117a5d),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (isExpanded) ...[
                buildRadioListTile('Slides', 1),
                buildRadioListTile('Electronic', 2),
                buildRadioListTile('Electricals', 3),
                buildRadioListTile('Furniture', 4),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRadioListTile(String title, int value) {
    return RadioListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade800,
        ),
      ),
      value: value,
      groupValue: selectedRadio,
      onChanged: (newValue) {
        setState(() {
          selectedRadio = newValue as int;
          widget.onCategorySelected(selectedRadio);
          print("Selected Radio: $selectedRadio");
        });
      },
    );
  }
}
