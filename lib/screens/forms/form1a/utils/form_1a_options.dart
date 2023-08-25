// <<<<<<<<<<< Critical Events >>>>>>>>>>>>>>>>>>>
List<Map> optionsEvents = [
  {
    'event_id': 'OCE1',
    'event_description': 'Child Pregnant',
  },
  {
    'event_id': 'OCE2',
    'event_description': 'Child not Adhering to ARVS',
  },
  {
    'event_id': 'OCE3',
    'event_description': 'Child Malnourished',
  },
  {
    'event_id': 'OCE4',
    'event_description': 'Child HIV status Changed',
  },
  {
    'event_id': 'OCE5',
    'event_description': 'Child acquired opportunistic infection',
  },
  {
    'event_id': 'OCE6',
    'event_description': 'Child missed HIV clinic appointment',
  },
  {
    'event_id': 'OCE7',
    'event_description': 'Child headed household',
  },
];

// <<<<<<<<<<<<< Services >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

List<Map> optionDomains = [
  {
    'domain_id': 'OC1',
    'domain_description': 'Education - (Schooled)',
  },
  {
    'domain_id': 'OC2',
    'domain_description': 'Health and Nutrition - (Healthy)',
  },
  {
    'domain_id': 'OC3',
    'domain_description': 'Economic Strengthening - (Stable)',
  }
];
List<Map> optionSubDomains = [
  {
    'service_id': 'S1',
    'domain_id': 'OC1',
    'service_description': 'Enrolled in ECD'
  },
  {
    'service_id': 'S2',
    'domain_id': 'OC1',
    'service_description':
        'Re-enrolled back to school (including teenage mothers)'
  },
  {
    'service_id': 'S3',
    'domain_id': 'OC1',
    'service_description':
        'Adolescent(15 - 20 yrs) enrolled in an approved HES intervention including VTC'
  },
  {'service_id': 'S4', 'service_description': 'School fees paid'},
  {
    'service_id': 'S5',
    'domain_id': 'OC1',
    'service_description':
        'Complete referral for bursary or other educational support'
  },
  {
    'service_id': 'S7',
    'domain_id': 'OC1',
    'service_description': 'School levies'
  },
  {
    'service_id': 'Sa1',
    'domain_id': 'OC2',
    'service_description': 'Facilitated to obtain HIV test'
  },
  {
    'service_id': 'Sa2',
    'domain_id': 'OC2',
    'service_description': 'Complete a referral for HIV test'
  },
  {
    'service_id': 'Sa3',
    'domain_id': 'OC2',
    'service_description': 'Complete a referral for Early Infact Diagnosis(EID)'
  },
  {
    'service_id': 'Sb1',
    'domain_id': 'OC3',
    'service_description': 'OVC Provided with business support(Startup Kit)'
  },
  {
    'service_id': 'Sb2',
    'domain_id': 'OC3',
    'service_description':
        'OVC completed referral for business support(Startup Kit)'
  },
  {
    'service_id': 'Sb3',
    'domain_id': 'OC3',
    'service_description': 'OVC Linked to saving group'
  },
];
