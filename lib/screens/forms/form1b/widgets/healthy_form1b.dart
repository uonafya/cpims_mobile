import 'package:cpims_mobile/providers/form1b_provider.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/custom_toast.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/custom_date_picker.dart';
import '../../../../widgets/custom_forms_date_picker.dart';
import '../model/health_form1b_model.dart';
import '../utils/form1bConstants.dart';

class HealthyForm1b extends StatefulWidget {
  const HealthyForm1b({Key? key}) : super(key: key);

  @override
  State<HealthyForm1b> createState() => _HealthyForm1bState();
}

class _HealthyForm1bState extends State<HealthyForm1b> {

  // HealthFormData formData = HealthFormData(selectedServices: [], selectedDate: DateTime.now());

  List<Map> careGiverServices = careGiverHealthServices;
  List<ValueItem> caregiverHealthServiceItems = careGiverHealthServices.map((service) {
    return ValueItem(label: "- ${service['subtitle']}", value: service['title']);
  }).toList();

  List<ValueItem> selectedCareGiverServices = [];
  List<ValueItem> selectedCareGiverServicesOptions = [];
  DateTime currentlySelectedDate = DateTime.now();



  @override
  Widget build(BuildContext context) {
    Form1bProvider form1bProvider = Provider.of<Form1bProvider>(context);
    selectedCareGiverServicesOptions = form1bProvider.formData.selectedServices;
    currentlySelectedDate = form1bProvider.formData.selectedDate;
    return StepsWrapper(
      title: 'Caregiver health and nutrition status',
      children: [
        const Text(
          'Service(s)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Services(s)',
          onOptionSelected: (selectedServices) {
            selectedCareGiverServices = selectedServices;
            form1bProvider.setSelectedServices(selectedCareGiverServices);
            CustomToastWidget.showToast("hii${form1bProvider.formData.selectedServices}");

          },
          options: caregiverHealthServiceItems,
          maxItems: 13,
          selectedOptions: selectedCareGiverServicesOptions.cast<ValueItem>(),
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x,
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Date of Service(s) / Event',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        CustomFormsDatePicker(
          hintText: 'Select the date',
          selectedDateTime: currentlySelectedDate,
          onDateSelected: (selectedDate) {
            currentlySelectedDate = selectedDate;
            // final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
            // currentlySelectedDate = formattedDate;
            form1bProvider.setSelectedDate(currentlySelectedDate);
            CustomToastWidget.showToast(form1bProvider.formData.selectedDate as String);
          },
        ),
      ],
    );
  }
}
