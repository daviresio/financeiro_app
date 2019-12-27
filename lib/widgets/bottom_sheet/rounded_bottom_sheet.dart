import 'package:flutter/material.dart';

Widget roundedBottomSheet(Widget child, {double height: 0.5}) {
  return FractionallySizedBox(
      heightFactor: height,
      child:Container(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Material(
                color: Colors.white,
                child: child,
              ),
            ),
          ),
      )
        );
      }