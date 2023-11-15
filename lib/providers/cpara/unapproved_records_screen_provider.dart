import 'package:cpims_mobile/providers/cpara/unapproved_cpara_database.dart';
import 'package:cpims_mobile/providers/cpara/unapproved_cpara_service.dart';
import 'package:flutter/cupertino.dart';

class UnapprovedRecordsScreenProvider extends ChangeNotifier {
  // Store the list of the unapproved cparas that we are monitoring
  List<UnapprovedCparaModel>? _unapprovedCparas;

  // Sets the list of CPARAs
  set unapprovedCparas(List<UnapprovedCparaModel> cparaModels) {
    _unapprovedCparas = cparaModels;
    notifyListeners();
  }

  // update the list of CPARAs
  void updateUnnapprovedCparas() async{
    final List<UnapprovedCparaModel> cparaRecords = await UnapprovedCparaService
        .getUnapprovedFromDB();
    _unapprovedCparas = cparaRecords;
    notifyListeners();
  }

  List<UnapprovedCparaModel> get unapprovedCparas {
    return _unapprovedCparas ?? [];
  }

  // Remove an item from list of CPARAs
  void removeUnapprovedCpara(UnapprovedCparaModel cparaModel) {
    if (_unapprovedCparas == null) {
      return;
    } else {
      _unapprovedCparas?.remove(cparaModel);
      notifyListeners();
    }
  }
}