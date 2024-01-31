import 'package:flutter/material.dart';
import 'package:flutter_project_1st/generated/l10n.dart';

class WhatDoYouWantToEat extends StatelessWidget {
  const WhatDoYouWantToEat({
    super.key,
    required this.containerHeight1,
    required this.containerWidth1,
    required this.containerHeight2,
  });

  final double containerHeight1;
  final double containerWidth1;
  final double containerHeight2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: containerHeight1,
            decoration: BoxDecoration(
              color: const Color(0xFF117a5d).withOpacity(0.7),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                // bottomLeft: Radius.elliptical(40.0, 40.0),
                bottomRight: Radius.circular(5),
                //bottomRight: Radius.elliptical(40.0, 40.0),
              ),
            )),
        Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(30),
              width: containerWidth1,
              height: containerHeight2, // Set the desired height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).what_do_you_want_to_eat,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
