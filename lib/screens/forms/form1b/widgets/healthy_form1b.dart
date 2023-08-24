import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

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
  HealthFormData formData = HealthFormData(selectedServices: [], selectedDate: DateTime.now());

  List<Map> careGiverServices = careGiverHealthServices;
  List<ValueItem> caregiverHealthServiceItems = careGiverHealthServices.map((service) {
    return ValueItem(label: "- ${service['subtitle']}", value: service['title']);
  }).toList();

  List<String> selectedCareGiverServices = [];

  @override
  Widget build(BuildContext context) {
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
            setState(() {
              selectedCareGiverServices = selectedServices.cast<String>().toList();
              formData.selectedServices = selectedServices.cast<String>().toList();
            });
            Fluttertoast.showToast(
              msg: 'Selected services: ${selectedCareGiverServices.join(", ")}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            print('Selected services: ${selectedCareGiverServices.join(", ")}');
          },
          options: caregiverHealthServiceItems,
          maxItems: 13,
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x, // Set the desired border radius value
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
          onDateSelected: (selectedDate) {
            setState(() {
              formData.selectedDate = selectedDate; // Update your selected date in your form data
            });
            // Display a toast message for selected date
            Fluttertoast.showToast(
              msg: 'Selected date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          },
        ),
      ],
    );
  }
}
