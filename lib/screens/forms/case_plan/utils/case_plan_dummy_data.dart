List<Map<String, dynamic>> casePlanDomainList = [
  {'domainId': '1', 'domainName': 'Schooled'},
  {'domainId': '2', 'domainName': 'Healthy'},
  // Add more domains here
];

List<Map<String, dynamic>> casePlanGoalList = [
  {'goalId': '1', 'domainId': '1', 'goalName': 'Improve literacy rates'},
  {'goalId': '2', 'domainId': '2', 'goalName': 'Reduce disease prevalence'},
  // Add more goals here
];

List<Map<String, dynamic>> casePlanNeedsList = [
  {'needId': '1', 'domainId': '1', 'needName': 'Books and learning materials'},
  {'needId': '2', 'domainId': '2', 'needName': 'Medical facilities'},
  // Add more needs here
];

List<Map<String, dynamic>> casePlanPriorityActionList = [
  {
    'actionId': '1',
    'domainId': '1',
    'actionName': 'Establish community libraries'
  },
  {'actionId': '2', 'domainId': '2', 'actionName': 'Build local clinics'},
  // Add more priority actions here
];

List<Map<String, dynamic>> casePlanServiceList = [
  {'serviceId': '1', 'domainId': '1', 'serviceName': 'Tutoring'},
  {'serviceId': '2', 'domainId': '1', 'serviceName': 'Access to books'},
  {'serviceId': '3', 'domainId': '2', 'serviceName': 'Health checkups'},
  {'serviceId': '4', 'domainId': '2', 'serviceName': 'Treatment'},
  // Add more services here
];

List<Map<String, dynamic>> casePlanPersonsResponsibleList = [
  {'id': '1', 'name': 'CareGiver'},
  {'id': '2', 'name': 'House HOld Member'},
  {'id': '3', 'name': 'CHV'},
  {'id': '4', 'name': 'GOK Agent'},
  // Add more services here
];

List<Map<String, dynamic>> casePlanResultsOptions = [
  {'id': 'AC', 'name': 'Achieved'},
  {'id': 'NA', 'name': 'Not Achieved'},

  // Add more services here
];

List<Map<String, dynamic>> allDomains = [
  {
    "item_id": "DEDU",
    "item_description": "Schooled",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "DHNU",
    "item_description": "Healthy",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "DHES",
    "item_description": "Stable",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "DPRO",
    "item_description": "Safe",
    "item_sub_category": "",
    "the_order": 4
  }
];

List<Map<String, dynamic>> cp_goals_health = [
  {
    "item_id": "GH1HE",
    "item_description":
        "GH 1 HE . Increase diagnosis of HIV infection NB: Known HIV status include (Positive, Negative, test not required)",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "GH2HE",
    "item_description":
        "GH 2 HE. Increase HIV treatment adherence, continuity of treatment and viral suppression NB: Documented viral load results exist in health facility records where caregiver, child, adolescent access care and treatment",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "GH3HE",
    "item_description":
        "GH 3 HE. All adolescents 10-17 years of age in the household have key knowledge about preventing HIV infection",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "GH4HE",
    "item_description":
        "GH 4 HE. Improve development for children <5 years (Particularly HIV exposed and infected infants/young children)",
    "item_sub_category": "",
    "the_order": 4
  }
];

List<Map<String, dynamic>> cp_goals_stable = [
  {
    "item_id": "GH5ST",
    "item_description":
        "GH 5 ST. Increase Caregiver’s Ability to Meet Important Family Need",
    "item_sub_category": "",
    "the_order": 5
  }
];

List<Map<String, dynamic>> cp_goal_school = [
  {
    "item_id": "GH9SC",
    "item_description": "GH 9 SC Increase school attendance and promotion",
    "item_sub_category": "",
    "the_order": 9
  }
];

List<Map<String, dynamic>> cp_goal_safe = [
  {
    "item_id": "GH6SA",
    "item_description":
        "GH 6 SA. Reduced risk of physical, emotional, and psychological injury due to exposure to violence",
    "item_sub_category": "",
    "the_order": 6
  },
  {
    "item_id": "GH7SA",
    "item_description":
        "GH 7 SA. All children and adolescents in the household are under the care of a stable adult caregiver",
    "item_sub_category": "",
    "the_order": 7
  },
  {
    "item_id": "GH8SA",
    "item_description":
        "GH 8 SA. All children <18yrs have legal proof of identity.",
    "item_sub_category": "",
    "the_order": 8
  }
];

List<Map<String, dynamic>> cp_gaps_health = [
  {
    "item_id": "GN11HE",
    "item_description":
        "GN 1.1 HE Child/adolescent has unknown HIV status (0-17)",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "GN12HE",
    "item_description":
        "GN 1.2 HE HIV status of HEI not confirmed at 18 months /one week after cessation of  breastfeeding whichever comes later",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "GN13HE",
    "item_description": "GN 1.3 HE HIV status of the caregiver not known",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "GN21HE",
    "item_description":
        "GN 2.1 HE HIV positive child/adolescent not enrolled on treatment",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "GN22HE",
    "item_description":
        "GN 2.2 HE Child/adolescent on treatment with no documented viral load results",
    "item_sub_category": "",
    "the_order": 5
  },
  {
    "item_id": "GN23HE",
    "item_description":
        "GN 2.3 HE Child/adolescent on treatment with documented viral load results not suppressed",
    "item_sub_category": "",
    "the_order": 6
  },
  {
    "item_id": "GN24HE",
    "item_description":
        "GN 2.4 HE Child/adolescent living with HIV not attending their appointments regularly (past 12 months)",
    "item_sub_category": "",
    "the_order": 7
  },
  {
    "item_id": "GN25HE",
    "item_description":
        "GN 2.5 HE Child/adolescent living with HIV not adhering to medication",
    "item_sub_category": "",
    "the_order": 8
  },
  {
    "item_id": "GN26HE",
    "item_description":
        "GN 2.6 HE HIV positive caregiver not enrolled on treatment",
    "item_sub_category": "",
    "the_order": 9
  },
  {
    "item_id": "GN27HE",
    "item_description":
        "GN 2.7 HE HIV positive caregiver on treatment with no documented viral load results",
    "item_sub_category": "",
    "the_order": 10
  },
  {
    "item_id": "GN28HE",
    "item_description":
        "GN 2.8 HE HIV positive caregiver on treatment with documented viral load results not suppressed",
    "item_sub_category": "",
    "the_order": 11
  },
  {
    "item_id": "GN29HE",
    "item_description":
        "GN 2.9 HE HIV positive caregiver not attending their appointments regularly (past 12 months)",
    "item_sub_category": "",
    "the_order": 12
  },
  {
    "item_id": "GN210H",
    "item_description":
        "GN 2.10 HE  HIV positive caregiver not adhering to medication",
    "item_sub_category": "",
    "the_order": 13
  },
  {
    "item_id": "GN31HE",
    "item_description":
        "GN 3.1 HE Adolescent has inadequate knowledge on HIV prevention",
    "item_sub_category": "",
    "the_order": 14
  },
  {
    "item_id": "GN32HE",
    "item_description": "GN 3.2 HE Unable to describe two HIV infection risks",
    "item_sub_category": "",
    "the_order": 15
  },
  {
    "item_id": "GN33HE",
    "item_description":
        "GN 3.3 HE Unable to describe one example of how to prevent themselves from HIV risk",
    "item_sub_category": "",
    "the_order": 16
  },
  {
    "item_id": "GN34HE",
    "item_description":
        "GN 3.4 HE Unable to correctly describe the location of at least one place where HIV prevention support is available",
    "item_sub_category": "",
    "the_order": 17
  },
  {
    "item_id": "GN41HE",
    "item_description":
        "GN 4.1 HE Child below the age of five including HEI not assessed for malnutrition",
    "item_sub_category": "",
    "the_order": 18
  },
  {
    "item_id": "GN42HE",
    "item_description":
        "GN 4.2 HE Child below the age of five assessed using MUAC and scored yellow/red (<12.5)",
    "item_sub_category": "",
    "the_order": 19
  },
  {
    "item_id": "GN43HE",
    "item_description":
        "GN 4.3 HE Child below five years showed signs of bipedal edema",
    "item_sub_category": "",
    "the_order": 20
  },
  {
    "item_id": "GN44HE",
    "item_description":
        "GN 4.4 HE Clinician confirms that child previously treated for malnutrition has a Z score below <-2",
    "item_sub_category": "",
    "the_order": 21
  },
  {
    "item_id": "GN45HE",
    "item_description":
        "GN 4.5 HE Child below the age of two immunization not on track",
    "item_sub_category": "",
    "the_order": 22
  }
];

List<Map<String, dynamic>> cp_gaps_stable = [
  {
    "item_id": "GN51ST",
    "item_description":
        "GN 5.1 ST Caregiver is not able to pay school fees (without selling productive/HH assets and/or project cash transfer support) for the school going children",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "GN52ST",
    "item_description":
        "GN 5.2 ST Caregiver is not able to pay all medical costs (buy prescribed medicine and take care of transport to facility) in the past 6 months for all children the household under the age of 18 without PEPFAR support",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "GN53ST",
    "item_description":
        "GN 5.3 ST Caregiver is not able to pay for legal and other administrative fees related to guardianship, civil registration or inheritance",
    "item_sub_category": "",
    "the_order": 3
  }
];

List<Map<String, dynamic>> cp_gaps_school = [
  {
    "item_id": "GN91SC",
    "item_description":
        "GN 9.1 SC Child (4–5-year-old) not attending ECDE (in cases where there is an ECD center in the area)",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "GN92SC",
    "item_description":
        "GN 9.2 SC School aged children (6-17) not enrolled in school",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "GN93SC",
    "item_description":
        "GN 9.3 SC Out of school OVC aged 15-20 years not engaged in approved economic intervention",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "GN94SC",
    "item_description":
        "GN 9.4 SC Children not attending school regularly (i.e. have missed school for more than five school days in a month).",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "GN95SC",
    "item_description":
        "GN 9.5 SC Children enrolled in school not progressed/graduated from one level to the other in the last school calendar year",
    "item_sub_category": "",
    "the_order": 5
  }
];

List<Map<String, dynamic>> cp_gaps_safe = [
  {
    "item_id": "GN61SA",
    "item_description":
        "GN 6.1 SA Caregiver has experienced violence and has not received post violence services",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "GN62SA",
    "item_description":
        "GN 6.2 SA Child (below 12 yrs) has experienced violence and has not received post violence services",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "GN63SA",
    "item_description":
        "GN 6.3 SA Adolescent (12yrs and above) has experienced violence and has not received post violence services",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "GN71SA",
    "item_description": "GN 7.1 SA Household lacks a stable adult caregiver",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "GN81SA",
    "item_description":
        "GN 8.1 SA Child lacks legal documents (eg. Birth certificate)",
    "item_sub_category": "",
    "the_order": 5
  }
];

List<Map<String, dynamic>> cp_priorities_health = [
  {
    "item_id": "P11HE",
    "item_description": "P 1.1 HE Conduct/refer for HIV risk assessment",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "P12HE",
    "item_description": "P 1.2 HE Escort/refer for HIV testing",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "P13HE",
    "item_description": "P 1.3 HE Escort/refer HEI MBP for confirmatory test",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "P21HE",
    "item_description": "P 2.1 HE Refer/escort for enrollment to treatment",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "P22HE",
    "item_description":
        "P 2.2 HE Refer/escort to clinic for viral load testing",
    "item_sub_category": "",
    "the_order": 5
  },
  {
    "item_id": "P23HE",
    "item_description": "P 2.3 HE Enroll non suppressed into Jua Mtoto Wako",
    "item_sub_category": "",
    "the_order": 6
  },
  {
    "item_id": "P24HE",
    "item_description": "P 2.4 HE Characterize non suppressed",
    "item_sub_category": "",
    "the_order": 7
  },
  {
    "item_id": "P25HE",
    "item_description":
        "P 2.5 HE Provide interventions to address adherence and non-suppression",
    "item_sub_category": "",
    "the_order": 8
  },
  {
    "item_id": "P26HE",
    "item_description": "P 2.6 HE Refer for other health services",
    "item_sub_category": "",
    "the_order": 9
  },
  {
    "item_id": "P31HE",
    "item_description": "P 3.1 HE Refer for DREAMS enrollment",
    "item_sub_category": "",
    "the_order": 10
  },
  {
    "item_id": "P32HE",
    "item_description": "P 3.2 HE Link to adolescent and youth programs",
    "item_sub_category": "",
    "the_order": 11
  },
  {
    "item_id": "P33HE",
    "item_description":
        "P 3.3 HE Provide knowledge on HIV and violence prevention",
    "item_sub_category": "",
    "the_order": 12
  },
  {
    "item_id": "P41HE",
    "item_description": "P 4.1 HE Conduct/refer child for MUAC assessment",
    "item_sub_category": "",
    "the_order": 13
  },
  {
    "item_id": "P42HE",
    "item_description":
        "P 4.2 HE Conduct/refer child for bipedal edema assessment",
    "item_sub_category": "",
    "the_order": 14
  },
  {
    "item_id": "P43HE",
    "item_description":
        "P 4.3 HE Provide/refer child for malnutrition interventions",
    "item_sub_category": "",
    "the_order": 15
  },
  {
    "item_id": "P44HE",
    "item_description":
        "P 4.4 HE Refer child for immunization and growth monitoring",
    "item_sub_category": "",
    "the_order": 16
  },
  {
    "item_id": "P45HE",
    "item_description": "P 4.5 HE Referral for other services for U5s",
    "item_sub_category": "",
    "the_order": 17
  }
];

List<Map<String, dynamic>> cp_priorities_stable = [
  {
    "item_id": "P51ST",
    "item_description":
        "P 5.1 ST Provide Social Assistance: Linkages to GOK and other social safety nets",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "P52ST",
    "item_description":
        "P 5.2 ST Provide consumption support (Emergency fund/Cash transfer)",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "P53ST",
    "item_description": "P 5.3 ST Productive Asset support (Goats, Poultry)",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "P54ST",
    "item_description":
        "P 5.4 ST Provide Income Growth Support (enroll in saving groups, link HH to formal financial institutions like banks etc, small business support/IGA seed capital, Business grants, startup capital, business boos)",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "P55ST",
    "item_description":
        "P 5.5 ST Capacity building/provision of information on saving groups, financial literacy, business skills, entrepreneurship, Agribusiness",
    "item_sub_category": "",
    "the_order": 5
  },
  {
    "item_id": "P16ST",
    "item_description":
        "P 1.6 ST Provide adolescent (17 years and out of school) with market driven livelihood skills/support",
    "item_sub_category": "",
    "the_order": 6
  },
  {
    "item_id": "P17ST",
    "item_description": "P 1.7 ST Enrolment in Health Insurance Plan",
    "item_sub_category": "",
    "the_order": 7
  }
];

List<Map<String, dynamic>> cp_priorities_school = [
  {
    "item_id": "P91SC",
    "item_description":
        "P 9.1 SC Enroll child in School (ECD/primary for late enrolment)",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "P92SC",
    "item_description": "P 9.2 SC Re-enrol child/adolescent to school",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "P93SC",
    "item_description":
        "P 9.3 SC Enroll adolescent for an approved HES intervention",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "P94SC",
    "item_description":
        "P 9.4 SC Refer/ link child for education support (i.e., presidential bursary fund, CDF)",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "P95SC",
    "item_description":
        "P 9.5 SC Provide education support (school fees, school levies, scholastic materials, school uniform.",
    "item_sub_category": "",
    "the_order": 5
  },
  {
    "item_id": "P96SC",
    "item_description":
        "P 9.6 SC Provide/Refer for provision of sanitary towels",
    "item_sub_category": "",
    "the_order": 6
  },
  {
    "item_id": "P97SC",
    "item_description":
        "P 9.7 SC Caregiver support (tracks child's school attendance and progress & offer assistance with homework",
    "item_sub_category": "",
    "the_order": 7
  }
];

List<Map<String, dynamic>> cp_priorities_safe = [
  {
    "item_id": "P61SA",
    "item_description":
        "P 6.1 SA Provision of structured psychosocial and family related conflict mitigation and family relationships support",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "P62SA",
    "item_description":
        "P 6.2 SA Provision or linkage for child protection and post violence related services",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "P63SA",
    "item_description":
        "P 6.3 SA Provide interventions aimed at preventing HIV and SGBV",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "P71SA",
    "item_description": "P 7.1 SA Link OVC to a stable adult caregiver",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "P81SA",
    "item_description": "P 8.1 SA Support child to acquire legal documents.",
    "item_sub_category": "",
    "the_order": 5
  }
];

List<Map<String, dynamic>> cp_services_health = [
  {
    "item_id": "CP11HE",
    "item_description": "CP 1.1 HE Facilitate to obtain HIV test",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "CP12 HE",
    "item_description": "CP 1.2 HE Complete a referral for HIV test",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "CP13HE",
    "item_description":
        "CP 1.3 HE Complete a referral for Early Infant Diagnosis (EID)",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "CP14HE",
    "item_description":
        "CP 1.4 HE Facilitate to obtain Early Infant Diagnosis (EID)",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "CP21HE",
    "item_description":
        "CP 2.1 HE Complete a referral for enrollment to care and treatment",
    "item_sub_category": "",
    "the_order": 5
  },
  {
    "item_id": "CP22HE",
    "item_description":
        "CP 2.2 HE Complete referral/facilitated to access viral load testing services",
    "item_sub_category": "",
    "the_order": 6
  },
  {
    "item_id": "CP23HE",
    "item_description":
        "CP 2.3 HE Facilitate/provided with transport to clinic appointment",
    "item_sub_category": "",
    "the_order": 7
  },
  {
    "item_id": "CP24HE",
    "item_description": "CP 2.4 HE Provide with appointment reminder messages",
    "item_sub_category": "",
    "the_order": 8
  },
  {
    "item_id": "CP25HE",
    "item_description":
        "CP 2.5 HE Provide with age-appropriate counseling and HIV disclosure support",
    "item_sub_category": "",
    "the_order": 9
  },
  {
    "item_id": "CP26HE",
    "item_description":
        "CP 2.6 HE Provide with age-appropriate HIV treatment literacy (for CLHIV)",
    "item_sub_category": "",
    "the_order": 10
  },
  {
    "item_id": "CP27HE",
    "item_description":
        "CP 2.7 HE Complete a referral for HIV related opportunistic infection treatment and care",
    "item_sub_category": "",
    "the_order": 11
  },
  {
    "item_id": "CP28HE",
    "item_description": "CP 2.8 HE Link to age appropriate OTZ club",
    "item_sub_category": "",
    "the_order": 12
  },
  {
    "item_id": "CP29HE",
    "item_description": "CP 2.9 HE Link to a structured PLHA support group",
    "item_sub_category": "",
    "the_order": 13
  },
  {
    "item_id": "CP210HE",
    "item_description":
        "CP 2.10 HE Provide with HIV adherence support (wristwatch, pill box, treatment buddy, EAC, DWI, Counseling, MDT)",
    "item_sub_category": "",
    "the_order": 14
  },
  {
    "item_id": "CP211HE",
    "item_description":
        "CP 2.11 HE Complete a referral for or facilitated to obtain routine/ emergency healthcare",
    "item_sub_category": "",
    "the_order": 15
  },
  {
    "item_id": "CP212HE",
    "item_description":
        "CP 2.12 HE Provide with age-appropriate health and nutrition messages",
    "item_sub_category": "",
    "the_order": 16
  },
  {
    "item_id": "CP213HE",
    "item_description":
        "CP 2.13 HE Complete a referral for or facilitated to obtain STI treatment",
    "item_sub_category": "",
    "the_order": 17
  },
  {
    "item_id": "CP31HE",
    "item_description":
        "CP 3.1 HE Complete a referral to obtain age-appropriate HIV prevention support including PrEP, condoms and/or VMMC",
    "item_sub_category": "",
    "the_order": 18
  },
  {
    "item_id": "CP32HE",
    "item_description":
        "CP 3.2 HE Provide with HIV and Violence prevention evidence interventions sessions",
    "item_sub_category": "",
    "the_order": 19
  },
  {
    "item_id": "CP32HE",
    "item_description":
        "CP 3.2 HE Complete a referral for or was facilitated to obtain age-appropriate women’s health counseling and/or products, including condoms",
    "item_sub_category": "",
    "the_order": 20
  },
  {
    "item_id": "CP41HE",
    "item_description":
        "CP 4.1 HE Complete referral for MUAC assessment and bipedal edema",
    "item_sub_category": "",
    "the_order": 21
  },
  {
    "item_id": "CP42HE",
    "item_description":
        "CP 4.2 HE Provide with supplementary or therapeutic food",
    "item_sub_category": "",
    "the_order": 22
  },
  {
    "item_id": "CP43HE",
    "item_description":
        "CP 4.3 HE Complete referral for/facilitated to obtain nutrition, growth, and developmental monitoring services",
    "item_sub_category": "",
    "the_order": 23
  },
  {
    "item_id": "CP44HE",
    "item_description":
        "CP 4.4 HE Complete a referral for/facilitated to obtain immunization",
    "item_sub_category": "",
    "the_order": 24
  },
  {
    "item_id": "CP45HE",
    "item_description":
        "CP 4.5 HE Complete referral /provided with Insecticide Treated Mosquito net (ITN)",
    "item_sub_category": "",
    "the_order": 25
  },
  {
    "item_id": "CP46HE",
    "item_description":
        "CP 4.6 HE Complete referral/facilitated to obtain perinatal care including PMTCT",
    "item_sub_category": "",
    "the_order": 26
  },
  {
    "item_id": "CP47HE",
    "item_description":
        "CP 4.7 HE Provide with hygiene counseling and WASH messaging",
    "item_sub_category": "",
    "the_order": 27
  }
];

List<Map<String, dynamic>> cp_services_stable = [
  {
    "item_id": "CP511S",
    "item_description":
        "CP 5.11 ST Link to internship and or job opportunities",
    "item_sub_category": "",
    "the_order": 11
  },
  {
    "item_id": "CP51ST",
    "item_description":
        "CP 5.1 ST Link to GOK and other social safety nets (OVC, Elderly or Disability cash transfers)",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "CP52ST",
    "item_description": "CP 5.2 ST Provide Emergency/cash transfer",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "CP53ST",
    "item_description":
        "CP 5.3 ST Provide or complete referral for business support (startup kit/business boost)",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "CP54ST",
    "item_description":
        "CP 5.4 ST Provide or complete referral for productive assets)",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "CP55ST",
    "item_description": "CP 5.5 ST Enroll to saving groups (VSLA/SILC)",
    "item_sub_category": "",
    "the_order": 5
  },
  {
    "item_id": "CP56ST",
    "item_description": "CP 5.6 ST Link to financial institutions",
    "item_sub_category": "",
    "the_order": 6
  },
  {
    "item_id": "CP57ST",
    "item_description":
        "CP 5.7 ST Provide or complete referral for Financial literacy training to CG and adolescent",
    "item_sub_category": "",
    "the_order": 7
  },
  {
    "item_id": "CP58ST",
    "item_description":
        "CP 5.8 ST Provide or complete referral for Entrepreneurship training",
    "item_sub_category": "",
    "the_order": 8
  },
  {
    "item_id": "CP59ST",
    "item_description":
        "CP 5.9 ST Provide or complete referral for Agribusiness skills training",
    "item_sub_category": "",
    "the_order": 9
  },
  {
    "item_id": "CP510S",
    "item_description":
        "CP 5.10 ST Provide or complete referral for vocational training/ apprenticeship",
    "item_sub_category": "",
    "the_order": 10
  },
  {
    "item_id": "CP512S",
    "item_description":
        "CP 5.12 ST Enroll or complete referral for health insurance plan ( e.g. NHIF, UHC)",
    "item_sub_category": "",
    "the_order": 12
  },
  {
    "item_id": "CP513S",
    "item_description":
        "CP 5.13 ST Provided with or referred for legal and other administrative fees support related to guardianship, civil registration or inheritance",
    "item_sub_category": "",
    "the_order": 13
  }
];

List<Map<String, dynamic>> cp_services_school = [
  {
    "item_id": "CP91SC",
    "item_description": "CP 9.1 SC Enroll in ECD",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "CP92SC",
    "item_description":
        "CP 9.2 SC Re-enrol child back to school (including teenage mothers)",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "CP93SC",
    "item_description":
        "CP 9.3 SC Enroll Adolescent (15-20 yrs) in an approved HES intervention including VTC",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "CP94SC",
    "item_description":
        "CP 9.4 SC Provide school fees or complete referral for bursary or other educational support",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "CP95SC",
    "item_description":
        "CP 9.5 SC Complete referral for or provide school levies support",
    "item_sub_category": "",
    "the_order": 5
  },
  {
    "item_id": "CP96SC",
    "item_description":
        "CP 9.6 SC Complete referral for or provide scholastic materials",
    "item_sub_category": "",
    "the_order": 6
  },
  {
    "item_id": "CP97SC",
    "item_description": "CP 9.7 SC Provide school uniform support",
    "item_sub_category": "",
    "the_order": 7
  },
  {
    "item_id": "CP98SC",
    "item_description":
        "CP 9.8 SC Complete referral for or provide sanitary towels to adolescent girls",
    "item_sub_category": "",
    "the_order": 8
  },
  {
    "item_id": "CP99SC",
    "item_description": "CP 9.9 SC Provide assistance with homework",
    "item_sub_category": "",
    "the_order": 9
  },
  {
    "item_id": "CP910S",
    "item_description": "CP 9.10 SC Monitor child progression in school",
    "item_sub_category": "",
    "the_order": 10
  }
];

List<Map<String, dynamic>> cp_services_safe = [
  {
    "item_id": "CP61SA",
    "item_description":
        "CP 6.1 SA Conduct structured family group conferencing to prevent occurrence/ reoccurrence of child abuse, exploitation or neglect",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "CP62SA",
    "item_description":
        "CP 6.2 SA Provide structured psycho-social support related to family conflict mitigation and family relationships",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "CP63SA",
    "item_description":
        "CP 6.3 SA Complete a referral for or facilitate to obtain post-violence medical care",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "CP64SA",
    "item_description":
        "CP 6.4 SA File report of suspected abuse to child protection office, police or other local authority",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "CP65SA",
    "item_description": "CP 6.5 SA Refer for emergency shelter/care facility",
    "item_sub_category": "",
    "the_order": 5
  },
  {
    "item_id": "CP66SA",
    "item_description":
        "CP 6.6 SA Engage/complete referral of adolescent structured safe spaces intervention",
    "item_sub_category": "",
    "the_order": 6
  },
  {
    "item_id": "CP67SA",
    "item_description":
        "CP 6.7 SA Facilitate or complete referral for participation in evidenced-based intervention on preventing HIV and sexual violence",
    "item_sub_category": "",
    "the_order": 7
  },
  {
    "item_id": "CP68SA",
    "item_description":
        "CP 6.8 SA Support caregiver to access structured psycho- social support related to family conflict mitigation and family relationships",
    "item_sub_category": "",
    "the_order": 8
  },
  {
    "item_id": "CP69SA",
    "item_description":
        "CP 6.9 SA Enroll or complete referral of caregiver for a structured, HIV-sensitive, evidence-based early childhood intervention with a trained provider",
    "item_sub_category": "",
    "the_order": 9
  },
  {
    "item_id": "CP610S",
    "item_description":
        "CP 6.10 SA Enroll caregiver for an evidence-based parenting intervention to prevent and reduce violence and/or sexual risk of their children",
    "item_sub_category": "",
    "the_order": 10
  },
  {
    "item_id": "CP611S",
    "item_description":
        "CP 6.11 SA Provide or complete referral for legal assistance (e.g., attorney fees, transport, etc.) related to cases of maltreatment, GBV, trafficking, exploitation",
    "item_sub_category": "",
    "the_order": 11
  },
  {
    "item_id": "CP71SA",
    "item_description":
        "CP 7.1 SA Provide or complete referral for emergency shelter/care facility or kinship care placement and monitoring for children",
    "item_sub_category": "",
    "the_order": 12
  },
  {
    "item_id": "CP81SA",
    "item_description":
        "CP 8.1 SA Facilitate/complete referral for acquisition of Birth certificate",
    "item_sub_category": "",
    "the_order": 13
  }
];

List<Map<String, dynamic>> cp_responsible = [
  {
    "item_id": "RCGH",
    "item_description": "Caregiver",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "RHHM",
    "item_description": "House Hold Member",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "RCHV",
    "item_description": "Case Worker",
    "item_sub_category": "",
    "the_order": 3
  },
  {
    "item_id": "RNGO",
    "item_description": "NGO",
    "item_sub_category": "",
    "the_order": 4
  },
  {
    "item_id": "RDCS",
    "item_description": "DCS",
    "item_sub_category": "",
    "the_order": 5
  }
];

// TODO cp result here
List<Map<String, dynamic>> cp_result = [
  {
    "item_id": "CP",
    "item_description": "Completed",
    "item_sub_category": "",
    "the_order": 1
  },
  {
    "item_id": "IP",
    "item_description": "In Progress",
    "item_sub_category": "",
    "the_order": 2
  },
  {
    "item_id": "NA",
    "item_description": "Not Applicable",
    "item_sub_category": "",
    "the_order": 3
  }
];
