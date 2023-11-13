import 'package:cpims_mobile/providers/cpara/unapproved_cpara_database.dart';
import 'package:flutter/material.dart';

class UnnaprovedCparasProvider extends ChangeNotifier {
  List<UnapprovedCparaModel> listOfUnapprovedCparas = [];

  void updateUnapprovedCparas(
      {required List<UnapprovedCparaModel> listOfUnapprovedCparas}) {
    this.listOfUnapprovedCparas = listOfUnapprovedCparas;
    notifyListeners();
  }
}
