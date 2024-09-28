import 'dart:async';

import '../../Models/form_metadata_model.dart';
import '../metadata_service.dart';



class MetadataManager {
  MetadataManager._privateConstructor();

  static MetadataManager? _instance;

  final Map<String, String> _sex = {};
  final Map<String, String> _yesno = {};
  final Map<String, String> _olmisHealthServices = {};
  final Map<String, String> _form1bitems = {};
  final Map<String, String> _ovcDomain = {};
  final Map<String, String> _casePlanGoalsHealth = {};
  final Map<String, String> _casePlanGoalsStable = {};
  final Map<String, String> _casePlanGoalsSafe = {};
  final Map<String, String> _casePlanGoalsSchool = {};
  final Map<String, String> _yesnona = {};
  final Map<String, String> _casePlanResponsible = {};
  final Map<String, String> _olmisHeServices = {};
  final Map<String, String> _olmisProtectionServices = {};
  final Map<String, String> _olmisEducationServices = {};
  final Map<String, String> _casePlanGapsHealth = {};
  final Map<String, String> _casePlanGapsSafe = {};
  final Map<String, String> _casePlanGapsSchool = {};
  final Map<String, String> _casePlanGapsStable = {};
  final Map<String, String> _casePlanPrioritiesHealth = {};
  final Map<String, String> _casePlanPrioritiesSafe = {};
  final Map<String, String> _casePlanPrioritiesSchool = {};
  final Map<String, String> _casePlanPrioritiesStable = {};
  final Map<String, String> _category = {};
  final Map<String, String> _casePlanServicesSafe = {};
  final Map<String, String> _casePlanServicesSchool = {};
  final Map<String, String> _casePlanServicesStable = {};
  final Map<String, String> _olmisCriticalEvent = {};
  

  Map<String, String> get sex => _sex;
  Map<String, String> get yesno => _yesno;
  Map<String, String> get olmisHealthServices => _olmisHealthServices;
  Map<String, String> get form1bitems => _form1bitems;
  Map<String, String> get ovcDomain => _ovcDomain;
  Map<String, String> get casePlanGoalsHealth => _casePlanGoalsHealth;
  Map<String, String> get casePlanGoalsStable => _casePlanGoalsStable;
  Map<String, String> get casePlanGoalsSafe => _casePlanGoalsSafe;
  Map<String, String> get casePlanGoalsSchool => _casePlanGoalsSchool;
  Map<String, String> get yesnona => _yesnona;
  Map<String, String> get casePlanResponsible => _casePlanResponsible;
  Map<String, String> get olmisHeServices => _olmisHeServices;
  Map<String, String> get olmisProtectionServices => _olmisProtectionServices;
  Map<String, String> get olmisEducationServices => _olmisEducationServices;
  Map<String, String> get casePlanGapsHealth => _casePlanGapsHealth;
  Map<String, String> get casePlanGapsSafe => _casePlanGapsSafe;
  Map<String, String> get casePlanGapsSchool => _casePlanGapsSchool;
  Map<String, String> get casePlanGapsStable => _casePlanGapsStable;
  Map<String, String> get casePlanPrioritiesHealth => _casePlanPrioritiesHealth;
  Map<String, String> get casePlanPrioritiesSafe => _casePlanPrioritiesSafe;
  Map<String, String> get casePlanPrioritiesSchool => _casePlanPrioritiesSchool;
  Map<String, String> get casePlanPrioritiesStable => _casePlanPrioritiesStable;
  Map<String, String> get category => _category;
  Map<String, String> get casePlanServicesSafe => _casePlanServicesSafe;
  Map<String, String> get casePlanServicesSchool => _casePlanServicesSchool;
  Map<String, String> get casePlanServicesStable => _casePlanServicesStable;
  Map<String, String> get olmisCriticalEvent => _olmisCriticalEvent;
 

  List<String> get sexNames => _sex.keys.toList();
  List<String> get yesnoNames => _yesno.keys.toList();
  List<String> get olmisHealthServicesNames => _olmisHealthServices.keys.toList();
  List<String> get form1bitemsNames => _form1bitems.keys.toList();
  List<String> get ovcDomainNames => _ovcDomain.keys.toList();
  List<String> get casePlanGoalsHealthNames => _casePlanGoalsHealth.keys.toList();
  List<String> get casePlanGoalsStableNames => _casePlanGoalsStable.keys.toList();
  List<String> get casePlanGoalsSafeNames => _casePlanGoalsSafe.keys.toList();
  List<String> get casePlanGoalsSchoolNames => _casePlanGoalsSchool.keys.toList();
  List<String> get yesnonaNames => _yesnona.keys.toList();
  List<String> get casePlanResponsibleNames => _casePlanResponsible.keys.toList();
  List<String> get olmisHeServicesNames => _olmisHeServices.keys.toList();
  List<String> get olmisProtectionServicesNames => _olmisProtectionServices.keys.toList();
  List<String> get olmisEducationServicesNames => _olmisEducationServices.keys.toList();
  List<String> get casePlanGapsHealthNames => _casePlanGapsHealth.keys.toList();
  List<String> get casePlanGapsSafeNames => _casePlanGapsSafe.keys.toList();
  List<String> get casePlanGapsSchoolNames => _casePlanGapsSchool.keys.toList();
  List<String> get casePlanGapsStableNames => _casePlanGapsStable.keys.toList();
  List<String> get categoryNames => _category.keys.toList();
  List<String> get casePlanPrioritiesHealthNames => _casePlanPrioritiesHealth.keys.toList();
  List<String> get casePlanPrioritiesSafeNames => _casePlanPrioritiesSafe.keys.toList();
  List<String> get casePlanPrioritiesSchoolNames => _casePlanPrioritiesSchool.keys.toList();
  List<String> get casePlanPrioritiesStableNames => _casePlanPrioritiesStable.keys.toList();
  List<String> get casePlanServicesSafeNames => _casePlanServicesSafe.keys.toList();
  List<String> get casePlanServicesSchoolNames => _casePlanServicesSchool.keys.toList();
  List<String> get casePlanServicesStableNames => _casePlanServicesStable.keys.toList();
  List<String> get olmisCriticalEventNames => _olmisCriticalEvent.keys.toList();
   
 

  static MetadataManager getInstance() {
    if (_instance != null) {
      return _instance!;
    }

    _instance = MetadataManager._privateConstructor();

    return _instance!;
  }

  Future<void> loadMetaData() async {
    _loadSexMetaData();
    _loadYesNoMetaData();
    _loadOlmisHealthServicesMetaData();
    _loadForm1bItemsMetaData();
    _loadovcDomainMetaData();
    _loadCasePlanGoalsHealthMetaData();
    _loadCasePlanGoalsStableMetaData();
    _loadCasePlanGoalsSafeMetaData();
    _loadCasePlanGoalsSchoolMetadata();
    _loadYesNoNaMetaData();
    _loadCasePlanResponsibleMetaData();
    _loadOlmisHeServicesMetaData();
    _loadOlmisProtectionServicesMetaData();
    _loadOlmisEducationServicesMetaData();   
    _loadCasePlanGapsHealthMetaData(); 
    _loadCasePlanGapsSafeMetaData(); 
    _loadCasePlanGapsSchoolMetaData(); 
    _loadCasePlanGapsStableMetaData(); 
    _loadCasePlanPrioritiesHealthMetaData(); 
    _loadCasePlanPrioritiesSafeMetaData(); 
    _loadCasePlanPrioritiesSchoolMetaData(); 
    _loadCasePlanPrioritiesStableMetaData(); 
    _loadCasePlanMetaData();
    _loadCasePlanServicesSafeMetaData();
    _loadCasePlanServicesSchoolMetaData();
    _loadCasePlanServicesStableMetaData();
    _loadOlmisCriticalEventMetaData();
    
  }

  Future<void> _loadSexMetaData() async {
    List<Metadata> sexMetadata = await MetadataService.getMetadata(MetadataTypes.sexId);
    _sex.clear();
    _sex.addAll({for (var e in sexMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadYesNoMetaData() async {
    List<Metadata> yesNoMetadata = await MetadataService.getMetadata(MetadataTypes.yesNo);
    _yesno.clear();
    _yesno.addAll({for (var e in yesNoMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadOlmisHealthServicesMetaData() async {
    List<Metadata> olmisHealthServicesMetadata =
        await MetadataService.getMetadata(MetadataTypes.olmisHealthServices);
    _olmisHealthServices.clear();
    _olmisHealthServices.addAll({for (var e in olmisHealthServicesMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadForm1bItemsMetaData() async {
    List<Metadata> form1bItemsMetadata =
        await MetadataService.getMetadata(MetadataTypes.form1bItems);
    _form1bitems.clear();
    _form1bitems.addAll({for (var e in form1bItemsMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadovcDomainMetaData() async {
    List<Metadata> ovcDomainMetadata = await MetadataService.getMetadata(MetadataTypes.ovcDomain);
    _ovcDomain.clear();
    _ovcDomain.addAll({for (var e in ovcDomainMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanGoalsHealthMetaData() async {
    List<Metadata> casePlanGoalsHealthMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanGoalsHealth);
    _casePlanGoalsHealth.clear();
    _casePlanGoalsHealth.addAll({for (var e in casePlanGoalsHealthMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanGoalsStableMetaData() async {
    List<Metadata> casePlanGoalsStableMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanGoalsStable);
    _casePlanGoalsStable.clear();
    _casePlanGoalsStable.addAll({for (var e in casePlanGoalsStableMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanGoalsSafeMetaData() async {
    List<Metadata> casePlanGoalsSafeMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanGoalsSafe);
    _casePlanGoalsSafe.clear();
    _casePlanGoalsSafe.addAll({for (var e in casePlanGoalsSafeMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanGoalsSchoolMetadata() async {
    List<Metadata> casePlanGoalsSchoolMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanGoalsSchool);
    _casePlanGoalsSchool.clear();
    _casePlanGoalsSchool.addAll({for (var e in casePlanGoalsSchoolMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadYesNoNaMetaData() async {
    List<Metadata> yesNoNaMetadata = await MetadataService.getMetadata(MetadataTypes.yesNona);
    _yesnona.clear();
    _yesnona.addAll({for (var e in yesNoNaMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanResponsibleMetaData() async {
    List<Metadata> casePlanResponsibleMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanResponsible);
    _casePlanResponsible.clear();
    _casePlanResponsible.addAll({for (var e in casePlanResponsibleMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadOlmisHeServicesMetaData() async {
    List<Metadata> olmisHeServicesMetadata =
        await MetadataService.getMetadata(MetadataTypes.olmisHeServices);
    _olmisHeServices.clear();
    _olmisHeServices.addAll({for (var e in olmisHeServicesMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadOlmisProtectionServicesMetaData() async {
    List<Metadata> olmisProtectionServicesMetadata =
        await MetadataService.getMetadata(MetadataTypes.olmisProtectionServices);
    _olmisProtectionServices.clear();
    _olmisProtectionServices.addAll({for (var e in olmisProtectionServicesMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadOlmisEducationServicesMetaData() async {
    List<Metadata> olmisEducationServicesMetadata =
        await MetadataService.getMetadata(MetadataTypes.olmisEducationServices);
    _olmisEducationServices.clear();
    _olmisEducationServices.addAll({for (var e in olmisEducationServicesMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanGapsHealthMetaData() async {
    List<Metadata> casePlanGapsHealthMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanGapsHealth);
    _casePlanGapsHealth.clear();
    _casePlanGapsHealth.addAll({for (var e in casePlanGapsHealthMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanGapsSafeMetaData() async {
    List<Metadata> casePlanGapsSafeMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanGapsSafe);
    _casePlanGapsSafe.clear();
    _casePlanGapsSafe.addAll({for (var e in casePlanGapsSafeMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanGapsSchoolMetaData() async {
    List<Metadata> casePlanGapsSchoolMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanGapsSchool);
    _casePlanGapsSchool.clear();
    _casePlanGapsSchool.addAll({for (var e in casePlanGapsSchoolMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanGapsStableMetaData() async {
    List<Metadata> casePlanGapsStableMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanGapsStable);
    _casePlanGapsStable.clear();
    _casePlanGapsStable.addAll({for (var e in casePlanGapsStableMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanPrioritiesHealthMetaData() async {
    List<Metadata> casePlanPrioritiesHealthMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanPrioritiesHealth);
    _casePlanPrioritiesHealth.clear();
    _casePlanPrioritiesHealth.addAll({for (var e in casePlanPrioritiesHealthMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanPrioritiesSafeMetaData() async {
    List<Metadata> casePlanPrioritiesSafeMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanPrioritiesSafe);
    _casePlanPrioritiesSafe.clear();
    _casePlanPrioritiesSafe.addAll({for (var e in casePlanPrioritiesSafeMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanPrioritiesSchoolMetaData() async {
    List<Metadata> casePlanPrioritiesSchoolMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanPrioritiesSchool);
    _casePlanPrioritiesSchool.clear();
    _casePlanPrioritiesSchool.addAll({for (var e in casePlanPrioritiesSchoolMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanPrioritiesStableMetaData() async {
    List<Metadata> casePlanPrioritiesStableMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanPrioritiesStable);
    _casePlanPrioritiesStable.clear();
    _casePlanPrioritiesStable.addAll({for (var e in casePlanPrioritiesStableMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanMetaData() async {
    List<Metadata> casePlanMetadata = await MetadataService.getMetadata(MetadataTypes.casePlan);
    _category.clear();
    _category.addAll({for (var e in casePlanMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanServicesSafeMetaData() async {
    List<Metadata> casePlanServicesSafeMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanServicesSafe);
    _casePlanServicesSafe.clear();
    _casePlanServicesSafe.addAll({for (var e in casePlanServicesSafeMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanServicesSchoolMetaData() async {
    List<Metadata> casePlanServicesSchoolMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanServicesSchool);
    _casePlanServicesSchool.clear();
    _casePlanServicesSchool.addAll({for (var e in casePlanServicesSchoolMetadata) e.itemId: e.itemDescription });
  }

  Future<void> _loadCasePlanServicesStableMetaData() async {
    List<Metadata> casePlanServicesStableMetadata =
        await MetadataService.getMetadata(MetadataTypes.casePlanServicesStable);
    _casePlanServicesStable.clear();
    _casePlanServicesStable.addAll({for (var e in casePlanServicesStableMetadata) e.itemId: e.itemDescription });
  }  

  Future<void> _loadOlmisCriticalEventMetaData() async {
    List<Metadata> olmisCriticalEventMetadata =
        await MetadataService.getMetadata(MetadataTypes.olmisCriticalEvent);
    _olmisCriticalEvent.clear();
    _olmisCriticalEvent.addAll({for (var e in olmisCriticalEventMetadata) e.itemId: e.itemDescription });
  }

  String getSexValue(String key) {
    return _sex[key] ?? key;
  }

  String getYesNoValue(String key) {
    return _yesno[key] ?? key;
  }

  String getOlmisHealthServicesValue(String key) {
    return _olmisHealthServices[key] ?? key;
  }

  String getForm1bItemsValue(String key) {
    return _form1bitems[key] ?? key;
  }

  String getOvcDomainValue(String key) {
    return _ovcDomain[key] ?? key;
  }

  String getCasePlanGoalsHealthValue(String key) {
    return _casePlanGoalsHealth[key] ?? key;
  }

  String getCasePlanGoalsStableValue(String key) {
    return _casePlanGoalsStable[key] ?? key;
  }

  String getCasePlanGoalsSafeValue(String key) {
    return _casePlanGoalsSafe[key] ?? key;
  }

  String getCasePlanGoalsSchoolValue(String key) {
    return _casePlanGoalsSchool[key] ?? key;
  }

  String getYesNoNaValue(String key) {
    return _yesnona[key] ?? key;
  }

  String getCasePlanResponsibleValue(String key) {
    return _casePlanResponsible[key] ?? key;
  }

  String getOlmisHeServicesValue(String key) {
    return _olmisHeServices[key] ?? key;
  }

  String getOlmisProtectionServicesValue(String key) {
    return _olmisProtectionServices[key] ?? key;
  }

  String getOlmisEducationServicesValue(String key) {
    return _olmisEducationServices[key] ?? key;
  }

  String getCasePlanGapsHealthValue(String key) {
    return _casePlanGapsHealth[key] ?? key;
  }

  String getCasePlanGapsSafeValue(String key) {
    return _casePlanGapsSafe[key] ?? key;
  }

  String getCasePlanGapsSchoolValue(String key) {
    return _casePlanGapsSchool[key] ?? key;
  }

  String getCasePlanGapsStableValue(String key) {
    return _casePlanGapsStable[key] ?? key;
  }

  String getCasePlanPrioritiesHealthValue(String key) {
    return _casePlanPrioritiesHealth[key] ?? key;
  }

  String getCasePlanPrioritiesSafeValue(String key) {
    return _casePlanPrioritiesSafe[key] ?? key;
  }

  String getCasePlanPrioritiesSchoolValue(String key) {
    return _casePlanPrioritiesSchool[key] ?? key;
  }

  String getCasePlanPrioritiesStableValue(String key) {
    return _casePlanPrioritiesStable[key] ?? key;
  }

  String getCategoryValue(String key) {
    return _category[key] ?? key;
  }

  String getCasePlanServicesSafeValue(String key) {
    return _casePlanServicesSafe[key] ?? key;
  }

  String getCasePlanServicesSchoolValue(String key) {
    return _casePlanServicesSchool[key] ?? key;
  }

  String getCasePlanServicesStableValue(String key) {
    return _casePlanServicesStable[key] ?? key;
  }

  String getOlmisCriticalEventValue(String key) {
    return _olmisCriticalEvent[key] ?? key;
  }
  
}
