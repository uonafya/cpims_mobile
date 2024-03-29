import 'package:android_id/android_id.dart';
import 'package:cpims_mobile/providers/auth_provider.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/screens/ovc_care/ovc_care_screen.dart';
import 'package:cpims_mobile/screens/unapproved_records/unapproved_records_screen.dart';
import 'package:cpims_mobile/services/caseload_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

const kPrimaryColor = Color(0xff00acac);
const kTextGrey = Color(0XFF707478);
const kSystemPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 0);

var _ovcActiveOrRegistered = '132,294 / 307,005';
const syncName = "Sync";
bool isSynching = false;
bool _correct = true;
dynamic snackBar;
List<Map<String, dynamic>> homeCardsTitles = [
  {
    'title': 'OVC-ACTIVE/EVER REGISTERED',
    'value': _ovcActiveOrRegistered,
    'icon': FontAwesomeIcons.person,
    'color': kPrimaryColor,
    's_color': const Color(0xff0E6668),
  },
  {
    'title': 'CAREGIVERS/GUARDIANS',
    'value': '171,142',
    'icon': FontAwesomeIcons.peopleGroup,
    'color': const Color(0xff348FE2),
    's_color': const Color(0xff1F5788),
  },
  {
    'title': 'WORKFORCE MEMBERS',
    'value': '487',
    'icon': Icons.people,
    'color': const Color(0xff727DB6),
    's_color': const Color(0xff454A6D),
  },
  {
    'title': 'ORG UNITS/CBOs',
    'value': '36',
    'icon': FontAwesomeIcons.landmark,
    'color': const Color(0xff49B6D5),
    's_color': const Color(0xff2C6E80),
  },
  {
    'title': 'HOUSEHOLDS',
    'value': '0',
    'icon': FontAwesomeIcons.house,
    'color': const Color(0xffFE5C57),
    's_color': const Color(0xff9A3734),
  }
];

List drawerOptions(BuildContext context) {
  return [
    {
      'title': 'Home',
      'icon': FontAwesomeIcons.house,
      'onTap': () => {
            Get.off(() => const Homepage(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 1000))
          },
      'children': []
    },
    {
      'title': 'Caseload',
      'icon': FontAwesomeIcons.briefcase,
      'children': [],
      'onTap': () => {
            Get.off(() => const OVCCareScreen(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 1000))
          },

      // 'children': [
      //   {
      //     'title': 'Caseload',
      //     'onTap': () => {
      //           Get.off(() => const CaseLoad(),
      //               transition: Transition.fadeIn,
      //               duration: const Duration(milliseconds: 1000))
      //         },
      //   },
      //   {
      //     'title': 'Organisational Units',
      //     'onTap': () => {
      //           Get.off(() => const OrganisationUnitsRegistry(),
      //               transition: Transition.fadeIn,
      //               duration: const Duration(milliseconds: 1000))
      //         },
      //   },
      //   {
      //     'title': 'Persons Registry',
      //     'onTap': () => {
      //           Get.off(() => const PersonsRegistry(),
      //               transition: Transition.fadeIn,
      //               duration: const Duration(milliseconds: 1000))
      //         },
      //   }
      // ]
    },
    // {
    //   'title': 'Forms',
    //   'icon': FontAwesomeIcons.fileLines,
    //   'children': [
    //     {
    //       'title': 'Case Record Sheet',
    //       'onTap': () => {
    //             Get.off(() => const CaseRecordSheet(),
    //                 transition: Transition.cupertino,
    //                 duration: const Duration(milliseconds: 1000))
    //           },
    //     },
    //     {
    //       'title': 'Follow-ups',
    //       'onTap': () => {
    //             Get.off(() => const FollowUps(),
    //                 transition: Transition.cupertino,
    //                 duration: const Duration(milliseconds: 1000))
    //           },
    //     },
    //     {
    //       'title': 'OVC Care(Comp)',
    //       'onTap': () => {
    //             Get.off(() => const OVCCareScreen(),
    //                 transition: Transition.cupertino,
    //                 duration: const Duration(milliseconds: 1000))
    //           },
    //     },
    //   ]
    // },
    {
      'title': syncName,
      'icon': FontAwesomeIcons.rotate,
      'onTap': () async {
        Get.back();
        try {
          const _androidIdPlugin = AndroidId();
          final String? androidId = await _androidIdPlugin.getId();
          CaseLoadService()
              .updateCaseLoadData(context: context, deviceID: androidId!);
          // syncWorkflows();
          snackBar = SnackBar(
            content: const Text(
              'Syncing in progress ...',
              style: TextStyle(color: Colors.green),
            ),
            duration:
                const Duration(seconds: 5), // Duration to display the Snackbar
            action: SnackBarAction(
              textColor: Colors.red,
              label: 'Close',
              onPressed: () {
                Get.back();
                // Action to perform when the "Close" button is pressed
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(Duration(seconds: 4));

          snackBar = SnackBar(
            content: const Text(
              'Sync completed successfully',
              style: TextStyle(color: Colors.green),
            ),
            duration:
                const Duration(seconds: 1), // Duration to display the Snackbar
            action: SnackBarAction(
              textColor: Colors.red,
              label: 'Close',
              onPressed: () {
                Get.back();
                // Action to perform when the "Close" button is pressed
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } catch (e) {
          snackBar = SnackBar(
            content: Text(
              'An error occured $e ...',
              style: TextStyle(color: Colors.red),
            ),
            duration:
                const Duration(seconds: 2), // Duration to display the Snackbar
            action: SnackBarAction(
              textColor: Colors.red,
              label: 'Close',
              onPressed: () {
                Get.back();
                // Action to perform when the "Close" button is pressed
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      'children': []
    },
    {
      'title': 'Log Out',
      'icon': FontAwesomeIcons.arrowRightFromBracket,
      'onTap': () => {
            Provider.of<AuthProvider>(context, listen: false).logOut(context),
          },
      'children': []
    },
    {
      'title': 'Unapproved',
      'icon': FontAwesomeIcons.hackerNews,
      'onTap': () => {
            Get.to(() => const UnapprovedRecordsScreens()),
          },
      'children': []
    },
  ];
}

//function to return device id
Future<String> getDeviceId() async {
  const _androidIdPlugin = AndroidId();
  final String? androidId = await _androidIdPlugin.getId();
  return androidId!;
}

List<String> graphTitles = [
  'Case Managenent(Last 21 Days)',
  'IP/LIP Case Load Summary(Last 30 Days)',
  'HIV Status',
  'ART Status',
  'Cacade 90-90-90'
];
List<Map<String, dynamic>> form1AStepper = [
  {
    'title': 'Services',
    'subtitle': 'Services Details',
    'onTap': () => {},
  },
  {
    'title': 'Critical Event(s)',
    'subtitle': 'Critical events details',
    'onTap': () {}
  }
];

List<Map<String, dynamic>> organisationRegistryStepper = [
  {
    'title': 'About the Organisation',
    'subtitle': 'Name and registation date',
    'onTap': () {}
  },
  {
    'title': 'Organisation Type',
    'subtitle': 'Organisation type and registration details',
    'onTap': () => {},
  },
  {
    'title': 'Location',
    'subtitle': 'Where located and/or providing services',
    'onTap': () => {},
  },
  {
    'title': 'Contact',
    'subtitle': 'Organisation unit contact details',
    'onTap': () => {},
  },
];

List<Map<String, dynamic>> personRegistryStepper = [
  {
    'title': 'Identification',
    'subtitle': 'Person\'s identification details',
    'onTap': () {}
  },
  {
    'title': 'Contact Details',
    'subtitle': 'Person\'s contact information',
    'onTap': () => {},
  },
  {
    'title': 'Location',
    'subtitle': 'Living and working in details',
    'onTap': () => {},
  },
  {
    'title': 'Caregiver/Siblings',
    'subtitle': 'Child\'s caregiver(s) and sibling(s) details',
    'onTap': () => {},
  },
  {
    'title': 'Organisation Unit',
    'subtitle': 'Units attached to persons',
    'onTap': () => {},
  },
];

const String cpimsApiUrl = "https://ovc.childprotection.uonbi.ac.ke/";
// const String cpimsApiUrl = "https://dev.cpims.net/";

const Map<String, String> headers = {"Content-Type": "application/json"};

void errorSnackBar(BuildContext context, String message,
    {Duration duration = const Duration(seconds: 8)}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(message),
    duration: duration,
  ));
}

class AppVersionUtil {
  static String appVersion = '1.1.2';
  static String buildNumber = '1';
  static String appName = 'CPIMS Mobile';
  static String packageName = 'com.healthitkenya.cpims';

  static String getAppVersion() {
    return appVersion;
  }

  static String getBuildNumber() {
    return buildNumber;
  }

  static String getAppName() {
    return appName;
  }

  static String getPackageName() {
    return packageName;
  }
}

successSnackBar(BuildContext context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    content: Text(message),
    duration: const Duration(seconds: 1),
  ));
}

// case plan stepper data
List<Map<String, dynamic>> cparaStepperData = [
  {'title': 'Details', 'subtitle': 'CPARA Base Details', 'onTap': () {}},
  {
    'title': 'Healthy',
    'subtitle': '',
    'onTap': () => {},
  },
  {
    'title': 'Stable',
    'subtitle': '',
    'onTap': () => {},
  },
  {
    'title': 'Safe',
    'subtitle': '',
    'onTap': () => {},
  },
  {
    'title': 'Schooled',
    'subtitle': '',
    'onTap': () => {},
  }
];

List<Map<String, dynamic>> unapprovedItems = [
  {
    'title': 'Form 1A',
    'childID': '12340',
    'eventType': 'SERVICES',
    'details': 'OVCCare',
    'date': '2021-09-01',
    'onTap': () => {},
    'color': Colors.red,
    's_color': const Color(0xff9A3734),
  },
  {
    'title': 'Form 1A',
    'childID': '67768',
    'eventType': 'CRITICAL EVENTS',
    'details': 'OVCCare',
    'date': '2021-09-30',
    'onTap': () => {},
    'color': Colors.red,
    's_color': const Color(0xff9A3734),
  },
  {
    'title': 'Form 1B',
    'childID': '07761',
    'eventType': 'SERVICES',
    'details': 'OVCCare',
    'date': '2021-09-30',
    'onTap': () => {},
    'color': Colors.red,
    's_color': const Color(0xff9A3734),
  },
  {
    'title': 'Form 1B',
    'childID': '87761',
    'eventType': 'CRITICAL EVENTS',
    'details': 'OVCCare',
    'date': '2021-09-30',
    'onTap': () => {},
    'color': Colors.red,
    's_color': const Color(0xff9A3734),
  },
  {
    'title': 'CPARA',
    'caregiverName': 'John Wekesa',
    'caregiverID': '734627',
    'date': '2021-09-30',
    'onTap': () => {},
    'color': Colors.red,
    's_color': const Color(0xff9A3734),
  },
  {
    'title': 'CPARA',
    'caregiverName': 'Odhiambo Nelson',
    'caregiverID': 'O7234627',
    'date': '2021-09-30',
    'onTap': () => {},
    'color': Colors.red,
    's_color': const Color(0xff9A3734),
  },
  {
    'title': 'CPT',
    'childID': '87761',
    'eventType': 'SERVICES',
    'details': 'OVCCare',
    'date': '2021-09-30',
    'onTap': () => {},
    'color': Colors.red,
    's_color': const Color(0xff9A3734),
  },
  {
    'title': 'CPT',
    'childID': '57761',
    'eventType': 'CRITICAL EVENTS',
    'details': 'OVCCare',
    'date': '2021-09-30',
    'onTap': () => {},
    'color': Colors.red,
    's_color': const Color(0xff9A3734),
  },
];

