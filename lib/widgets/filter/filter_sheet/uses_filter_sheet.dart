import 'package:flutter/material.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

import 'filter_sheet.dart';

class UsesFilterSheet{
  void toFilterSheet(BuildContext context, FilterSheet filterSheet, Function(double, int, List<PlaceCategory>) closeCallback) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return filterSheet;

      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(Tween<Offset>(
            begin: const Offset(0, -1.0),
            end: Offset.zero,
          )),
          child: child,
        );
      },
    ).whenComplete((){
      closeCallback(
          filterSheet.controller.sliderValue,
          filterSheet.controller.minimumRating,
          filterSheet.controller.chosenCategories
      );
    });
  }
}