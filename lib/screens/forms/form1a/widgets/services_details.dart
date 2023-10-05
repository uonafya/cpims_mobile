import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/form1a_provider.dart';
import 'package:cpims_mobile/screens/forms/form1a/form1A_history.dart';
import 'package:cpims_mobile/screens/forms/form1a/utils/form_1a_options.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_forms_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

class ServicesDetails extends StatefulWidget {
  const ServicesDetails({Key? key}) : super(key: key);

  @override
  State<ServicesDetails> createState() => _ServicesDetailsState();
}

class _ServicesDetailsState extends State<ServicesDetails> {
  // Domain
  List<ValueItem> listOfDomains = optionDomains.map((domain) {
    return ValueItem(
        label: "${domain['domain_description']}",
        value: "${domain['domain_id']}");
  }).toList();

  List<ValueItem> selectedDomain = [];
  List<ValueItem> selectedDomainOptions = [];

  // Subdomain
  // List<ValueItem> listOfSubDomains = optionSubDomains.map((subdomain) {
  //   return ValueItem(
  //       label: "${subdomain['service_description']}",
  //       value: "${subdomain['service_id']}");
  // }).toList();

  List<ValueItem> listOfSubDomains = optionSubDomains.map((subdomain) {
    return ValueItem(
        label: "${subdomain['service_description']}",
        value: "${subdomain['service_id']}");
  }).toList();

  List<ValueItem> selectedService = [];
  List<ValueItem> selectedSubDomainOptions = [];

  DateTime currentServiceSelectedDate = DateTime.now();

  List<ValueItem> filteredSubdomains({required String domainId}) {
    List<Map> filtered = optionSubDomains
        .where((element) => element["domain_id"] == domainId)
        .toList();

    List<ValueItem> listOfFilteredSubDomains = filtered.map((subdomain) {
      return ValueItem(
          label: "${subdomain['service_description']}",
          value: "${subdomain['service_id']}");
    }).toList();

    return listOfFilteredSubDomains;
  }

  String domainValue = "";
  @override
  Widget build(BuildContext context) {
    listOfSubDomains = filteredSubdomains(domainId: domainValue);
    Form1AProvider form1aProvider = Provider.of<Form1AProvider>(context);
    selectedDomainOptions = form1aProvider.serviceFormData.selectedDomain;
    selectedSubDomainOptions = form1aProvider.serviceFormData.selectedService;
    currentServiceSelectedDate =
        form1aProvider.serviceFormData.selectedEventDate;

    return StepsWrapper(
      title: 'Services',
      children: [
        const Text(
          'Domain*',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Select the Domains',
          onOptionSelected: (selectedDomain) {
            domainValue = selectedDomain.last.value ?? domainValue;
            selectedDomainOptions = selectedDomain;
            form1aProvider.setSelectedDomain(selectedDomain);
          },
          options: listOfDomains,
          maxItems: 13,
          selectedOptions: selectedDomainOptions.cast<ValueItem>(),
          selectionType: SelectionType.single,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x, // Set the desired border radius value
        ),
        const SizedBox(height: 10),
        const Text(
          'Service(s)*',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select the Services',
          onOptionSelected: (selectedService) {
            selectedSubDomainOptions = selectedService;
            form1aProvider.setSelectedSubDomain(selectedService);
            form1aProvider.submitServicesData();
          },
          options: listOfSubDomains,
          maxItems: 35,
          selectedOptions: selectedSubDomainOptions.cast<ValueItem>(),
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x, // Set the desired border radius value
        ),
        const SizedBox(height: 10),
        const Text(
          'Date Service Recorded*',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        CustomFormsDatePicker(
            hintText: 'Select the date',
            selectedDateTime: currentServiceSelectedDate,
            onDateSelected: (selectedEventDate) {
              currentServiceSelectedDate = selectedEventDate;
              form1aProvider.setServiceSelectedDate(currentServiceSelectedDate);
            }),
        const SizedBox(
          height: 15,
        ),
        // CustomButton(
        //   text: 'Add',
        //   color: kTextGrey,
        //   onTap: () {
        //     form1aProvider.submitServicesData();
        //   },
        // ),
        // const SizedBox(
        //   height: 5,
        // ),
        CustomButton(text: 'Form1A Past Assessment(s)',
        onTap: (){
          setState(() {
            // context
            //     .read<Form1AProvider>()
            //     .updateCaseLoadModel(widget.caseLoadModel);
            Get.to(() => HistoryForm1A());
          });
        },),
      ],
    );
  }
}