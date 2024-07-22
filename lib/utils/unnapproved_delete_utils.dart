import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../screens/forms/graduation_monitoring/unapproved/unapproved_graduation_form.dart';
import '../screens/homepage/provider/stats_provider.dart';
import '../services/unapproved_data_service.dart';

Future<void> deleteUnapprovedGraduationForm(BuildContext context, String id, List<UnApprovedGraduationFormModel> unnapprovedGraduationData) async {
  debugPrint("Deleting Graduation Form with id $id");
  bool success = await UnapprovedDataService.deleteUnapprovedgraduation(id);
  if (success) {
    unnapprovedGraduationData.removeWhere((element) => element.formUuid == id);
    Provider.of<StatsProvider>(context, listen: false).updateUnapprovedFormStats();
  }
}

