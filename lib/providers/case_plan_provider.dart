import 'package:flutter/cupertino.dart';

import '../screens/forms/case_plan/utils/case_plan_dummy_data.dart';

class CasePlanProvider extends ChangeNotifier {

  List csDomainList = casePlanDomainList;
  List csGoalList = casePlanGoalList;
  List csNeedsList = casePlanNeedsList;
  List csPriorityActionList = casePlanPriorityActionList;
  List csServicesList = casePlanServiceList;

  List csPersonsResponsibleList = casePlanPersonsResponsibleList;
  List csResultsList = casePlanResultsOptions;


}
