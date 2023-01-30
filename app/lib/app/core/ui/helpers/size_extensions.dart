import 'package:flutter/cupertino.dart';

extension SizeExtensions on BuildContext {
  double get screenWidht => MediaQuery.of(this).size.width;

  double get screnHeight => MediaQuery.of(this).size.height;


  double percentWidht(double percent) =>MediaQuery.of(this).size.width * percent;
  double percemtHeight(double percent) =>MediaQuery.of(this).size.height * percent;



}
