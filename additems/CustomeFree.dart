import 'package:flutter/material.dart';
import 'package:flutter_project_1st/additems/CustomPrice_tx.dart';

class FreeDropDown extends StatefulWidget {
  final double containerHeight;
  final double containerWidth;
  final Function(int) freecheckBox;
  final Function(String) priceController;
  final TextEditingController itempriceController;
  const FreeDropDown({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.freecheckBox,
    required this.priceController,
    required this.itempriceController,
  });

  @override
  State<FreeDropDown> createState() => _FreeDropDownState();
}

class _FreeDropDownState extends State<FreeDropDown> {
  bool isExpanded = false;
  //int selectedRadio = 0;
  final TextEditingController _priceController = TextEditingController();

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
            ? widget.containerHeight * 0.65
            : widget.containerHeight * 0.3,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              blurRadius: 3, // Blur radius
              offset: Offset(0, 1), // Offset
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
                      Icons.monetization_on,
                      size: 30,
                      color: Color(0xFF117a5d),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Not Free",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: widget.containerWidth * 0.566,
                    ),
                    Checkbox(
                      value: isExpanded,
                      onChanged: (value) {
                        setState(() {
                          isExpanded = value!;
                          widget.freecheckBox(1);
                          widget
                              .priceController(widget.itempriceController.text);
                        });
                      },
                      activeColor: Color(0xFF117a5d),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (isExpanded) ...[
                PriceTextField(
                  controller: widget.itempriceController,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
