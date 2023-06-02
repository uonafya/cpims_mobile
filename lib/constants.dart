import 'package:cpims_mobile/screens/caseload/caseload.dart';
import 'package:cpims_mobile/screens/forms/case_record_sheet.dart';
import 'package:cpims_mobile/screens/forms/documents_manager.dart';
import 'package:cpims_mobile/screens/forms/follow_ups.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/organisation_units.dart';
import 'package:cpims_mobile/screens/registry/persons_registry/persons_registry.dart';
// import 'package:cpims_mobile/screens/forms/alternative_family_care.dart';
import 'package:cpims_mobile/screens/forms/case_record_sheet.dart';
import 'package:cpims_mobile/screens/forms/documents_manager.dart';
// import 'package:cpims_mobile/screens/forms/follow_ups.dart';
// import 'package:cpims_mobile/screens/forms/institutional_placement.dart';
// import 'package:cpims_mobile/screens/forms/school_bursary.dart';
// import 'package:cpims_mobile/screens/help_documentation/change_notes.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/organisation_units.dart';
import 'package:cpims_mobile/screens/registry/persons_registry/persons_registry.dart';
// import 'package:cpims_mobile/screens/reports/case_load_report.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

const kPrimaryColor = Color(0xff00acac);
const kTextGrey = Color(0XFF707478);
const kSystemPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 0);

var _ovcActiveOrRegistered = '132,294 / 307,005';

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

List<Map<String, dynamic>> drawerOptions = [
  {
    'title': 'Home',
    'icon': FontAwesomeIcons.house,
    'onTap': () => {
          Get.off(() => const Homepage(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 1000))
        },
  },

  {
    'title': 'Caseload',
    'icon': FontAwesomeIcons.briefcase,
    'children': [
      {
        'title': 'Caseload',
        'onTap': () => {
              Get.off(() => const CaseLoad(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 1000))
            },
      },
      {
        'title': 'Organisational Units',
        'onTap': () => {
              Get.off(() => const OrganisationUnitsRegistry(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 1000))
            },
      },
      {
        'title': 'Persons Registry',
        'onTap': () => {
              Get.off(() => const PersonsRegistry(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 1000))
            },
      }
    ]
  },
  {
    'title': 'Forms',
    'icon': FontAwesomeIcons.fileLines,
    'children': [
      {
        'title': 'Case Record Sheet',
        'onTap': () => {
              Get.off(() => const CaseRecordSheet(),
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 1000))
            },
      },
       {
         'title': 'Follow-ups',
         'onTap': () => {
               Get.off(() => const FollowUps(),
                   transition: Transition.cupertino,
                   duration: const Duration(milliseconds: 1000))
             },
       },
      // {
      //   'title': 'Institutional Placement',
      //   'onTap': () => {
      //         Get.off(() => const InstitutionalPlacement(),
      //             transition: Transition.cupertino,
      //             duration: const Duration(milliseconds: 1000))
      //       },
      // },
      // {
      //   'title': 'Alternative Family Care',
      //   'onTap': () => {
      //         Get.off(() => const AlternativeFamilyCare(),
      //             transition: Transition.cupertino,
      //             duration: const Duration(milliseconds: 1000))
      //       },
      // },
      // {
      //   'title': 'School and Bursary',
      //   'onTap': () => {
      //         Get.off(() => const SchoolBursary(),
      //             transition: Transition.cupertino,
      //             duration: const Duration(milliseconds: 1000))
      //       },
      // },
      // {
      //   'title': 'Follow-ups',
      //   'onTap': () => {
      //         Get.off(() => const FollowUps(),
      //             transition: Transition.cupertino,
      //             duration: const Duration(milliseconds: 1000))
      //       },
      // },
      // {
      //   'title': 'Documents Manager',
      //   'onTap': () => {
      //         Get.off(() => const DocumentsManager(),
      //             transition: Transition.cupertino,
      //             duration: const Duration(milliseconds: 1000))
      //       },
      // },
      {
        'title': 'OVC Care(Comp)',
        'onTap': () => {
              Get.off(() => const DocumentsManager(),
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 1000))
            },
      },
      // {
      //   'title': 'Preventive and Family Support)',
      //   'onTap': () => {},
      // },
      // {
      //   'title': 'PMTCT',
      //   'onTap': () => {},
      // },
      // {
      //   'title': 'DREAMS',
      //   'onTap': () => {},
      // }
    ]
  },
  // {
  //   'title': 'Reports',
  //   'icon': FontAwesomeIcons.fileLines,
  //   'children': [
  //     {
  //       'title': 'Case Load Report',
  //       'onTap': () => {
  //             Get.off(() => const CaseLoadReport(),
  //                 transition: Transition.cupertino,
  //                 duration: const Duration(milliseconds: 1000))
  //           },
  //     },
  //     {
  //       'title': 'KNBS Report',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Institutions Population Returns Report',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Health Report',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Bursary Report',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Ad Hoc Report',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Ad Hoc Pivot Report',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Document Templates',
  //       'onTap': () => {},
  //     },
  //   ]
  // },
  // {
  //   'title': 'Maintenance',
  //   'icon': FontAwesomeIcons.gears,
  //   'children': [
  //     {
  //       'title': 'Reports',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Schools',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Facilities',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Raw data',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'System Settings',
  //       'onTap': () => {},
  //     },
  //   ]
  // },
  // {
  //   'title': 'GIS Module',
  //   'icon': FontAwesomeIcons.mapLocationDot,
  //   'children': [
  //     {
  //       'title': 'Map',
  //       'onTap': () => {},
  //     }
  //   ]
  // },
  // {
  //   'title': 'Gallery',
  //   'icon': FontAwesomeIcons.camera,
  //   'children': [
  //     {
  //       'title': 'Gallery One',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Gallery Two',
  //       'onTap': () => {},
  //     }
  //   ]
  // },
  // {
  //   'title': 'Data Quality',
  //   'icon': FontAwesomeIcons.filter,
  //   'children': [
  //     {
  //       'title': 'Age & Services',
  //       'onTap': () => {},
  //     },
  //     {
  //       'title': 'Age & Case plan',
  //       'onTap': () => {},
  //     },
  //   ]
  // },
  // {
  //   'title': 'Help & Documentation',
  //   'icon': FontAwesomeIcons.briefcaseMedical,
  //   'children': [
  //     {
  //       'title': 'Change Notes',
  //       'onTap': () => {
  //             Get.off(() => const ChangeNotesScreen(),
  //                 transition: Transition.cupertino,
  //                 duration: const Duration(milliseconds: 1000))
  //           },
  //     },
  //     {
  //       'title': 'Documentation',
  //       'onTap': () => {},
  //     }
  //   ]
  // },
  // {
  //   'title': 'OVC Dashboards',
  //   'icon': FontAwesomeIcons.chartLine,
  //   'children': []
  // }
];

List<String> graphTitles = [
  'Case Managenent(Last 21 Days)',
  'IP/LIP Case Load Summary(Last 30 Days)',
  'HIV Status',
  'ART Status',
  'Cacade 90-90-90'
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

const String cpims_api_url = "https://dev.cpims.net/api/";
const String cpimsApiUrl = "https://dev.cpims.net/api/";

const Map<String, String> headers = {"Content-Type": "application/json"};

errorSnackBar(BuildContext context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(message),
    duration: const Duration(seconds: 1),
  ));
}

successSnackBar(BuildContext context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    content: Text(message),
    duration: const Duration(seconds: 1),
  ));
}
