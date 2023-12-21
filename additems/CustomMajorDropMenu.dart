import 'package:flutter/material.dart';

class MajorDropDown extends StatefulWidget {
  final double containerWidth;
  final double containerHeight;
  final int selectedRadio;
  final Function(int) onMajorSelected;

  const MajorDropDown(
      {Key? key,
      required this.containerWidth,
      required this.containerHeight,
      required this.selectedRadio,
      required this.onMajorSelected})
      : super(key: key);

  @override
  _MajorDropDownState createState() => _MajorDropDownState();
}

class _MajorDropDownState extends State<MajorDropDown> {
  bool isExpanded = false;
  int selectedRadio = 0;

  // Mapping of faculties to majors
  Map<int, List<String>> facultyMajors = {
    1: [
      '1.Animal Production & Animal Health',
      '2.Nutrition and Food Technology',
      '3.Plant Production and Protection',
      '4.Veterinary Medicine Department'
    ],
    2: [
      '1.Accounting',
      '2.Business Administration',
      '3.Department of Print and Electronic Journalism',
      '4.Economics',
      '5.Financial & Banking Sciences',
      '6.Geography and Geomatics',
      '7.Major Psychology Minor Psychological Counseling',
      '8.Marketing',
      '9.Public Relations'
    ],
    3: [
      '1.Computer Engineering',
      '2.Architectural Engineering',
      '3.Building Engineering',
      '4.Civil Engineering',
      '5.Electrical Engineering',
      '6.Industrial Engineering',
      '7.Information and Computer Science',
      '8.Mecatronics Engineering',
      '9.Mechanical Engineering',
      '10.Telecommunication Engineering',
      '10.Urban Planning Engineering'
    ],
    4: [
      '1.Ceramic Art',
      '2.Musicology',
      '3.Graphic Design',
      '4.painting and photography',
      '5.Game design program',
      '6.Interior Design',
      '7.Therapeutic expressive art',
      '8.Fashion design'
    ],
    5: [
      '1.Physical Education - Training',
      '2.Physical Education -Methods of Teaching',
      '3.Lower Preparatory',
      '4.Kindergartens',
      '5.Upper Prepartory -Teacher in English Language',
      '6.Upper Preparatory - Teacher in Arabic Language',
      '7.Upper Preparatory - Teacher in Social Studies',
      '8.Upper Preparatory- Teacher in Technology',
      '9.Upper Preparatory- Teacher in Mathematics',
      '10.Upper Preparatory- Teacher in Sciences',
      '11.Teaching Preparation Diploma'
    ],
    6: ['1.Law', '2.Law & International Relation', '3.Political Science'],
    7: [
      '1.Biomedical Sciences',
      '2.Medicine',
      '3.Dentistry and Dental Surgery',
      '4.Applied and Allied Medical Sciences',
      '5.Pharmacy',
      '6.Nursing and Midwifery'
    ],
    8: [
      '1.Biology and Biotechnology',
      '2.Mathematics',
      '3.Physics',
      '4.Chemistry'
    ],
    9: [
      '1.Department of Fiqih & Legistlation',
      '2.Department of Sharia & Islamic Banks',
      '3.Department of Osoul Aldeen'
    ],
  };

  List<String> majors = [];

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
                    const Icon(
                      Icons.card_membership,
                      size: 30,
                      color: Color(0xFF117a5d),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Select Major",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: widget.containerWidth * 0.46,
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
              const SizedBox(
                height: 15,
              ),
              if (isExpanded)
                Column(
                  children: buildRadioList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildRadioList() {
    majors = facultyMajors[widget.selectedRadio] ?? [];
    return majors.map(
      (major) {
        final parts = major.split('.'); // Split the major string
        final number = parts[0]; // Get the number
        final majorName = parts[1]; // Get the major name
        int intValue = int.parse(number);

        return RadioListTile(
          title: Text(majorName),
          value: intValue, // Use the major as the value
          groupValue: selectedRadio,
          onChanged: (newValue) {
            setState(() {
              selectedRadio =
                  newValue as int; // Update the selectedRadio with the major
              widget.onMajorSelected(selectedRadio);
              print("MajorSelected: $selectedRadio");
            });
          },
        );
      },
    ).toList();
  }
}
