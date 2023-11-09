import 'package:cpims_mobile/providers/preventive_assesment_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_schooled_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/preventive/preventive_assesment_attendance.dart';
import 'package:cpims_mobile/widgets/custom_dropdown.dart';
import 'package:cpims_mobile/widgets/form_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceForm extends StatefulWidget {
  const AttendanceForm({super.key});

  @override
  State<AttendanceForm> createState() => _AttendanceFormState();
}

class _AttendanceFormState extends State<AttendanceForm> {
  List<String> domains = [
    "Please select",
    "SINOVUYO",
    "CBIM",
    "Family Matters",
    "SMMC",
    "Others"
  ];

  List<String> attendanceList = [
    "Please select",
    ...List.generate(14, (index) => "SESSION ${index + 1}"),
  ];

  String selectedDomain = "Please select";
  String attendance = "Please select";
  String dateOfEvent = "";
  String completedSessions = "";

  void updateForm() {
    final provider =
        Provider.of<PreventiveAssessmentProvider>(context, listen: false);
    final data = PreventiveAttendanceFormModel(
      selectedDomain: selectedDomain,
      attendance: attendance,
      dateOfEvent: dateOfEvent,
      completedSessions: completedSessions,
    );
    provider.updatePreventiveAttendanceFormModel(data);
  }

  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<PreventiveAssessmentProvider>(context)
        .preventiveAttendanceFormModel;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(children: [
        FormSection(
          children: [
            const Text("Domain *"),
            const SizedBox(
              height: 10,
            ),
            CustomDropdown(
                initialValue: formData.selectedDomain,
                items: domains,
                onChanged: (val) {
                  setState(() {
                    selectedDomain = val;
                    updateForm();
                  });
                }),
            const SizedBox(height: 14),
          ],
        ),
        FormSection(
          children: [
            const Text("Attendance *"),
            const SizedBox(
              height: 10,
            ),
            CustomDropdown(
                initialValue: formData.attendance,
                items: attendanceList,
                onChanged: (val) {
                  setState(() {
                    attendance = val;
                    updateForm();
                  });
                }),
            const SizedBox(height: 14),
          ],
        ),
        FormSection(
          children: [
            const Text("Date attended *"),
            const SizedBox(
              height: 10,
            ),
            DateTextField(
              label: formData.dateOfEvent.isNotEmpty
                  ? formData.dateOfEvent
                  : "Date of event",
              enabled: true,
              onDateSelected: (date) {
                setState(() {
                  dateOfEvent = DateFormat("yyyy-MM-dd").format(date!);
                  updateForm();
                });
              },
              identifier: DateTextFieldIdentifier.dateOfAssessment,
            ),
            const SizedBox(height: 14),
          ],
        ),
        FormSection(children: [
          const Text("Completed All Session *"),
          CustomRadioButton(
              isNaAvailable: false,
              option: formData.completedSessions.isNotEmpty
                  ? convertingStringToRadioButtonOptions(
                      formData.completedSessions)
                  : null,
              optionSelected: (val) {
                setState(() {
                  completedSessions = convertingRadioButtonOptionsToString(val);
                  updateForm();
                });
              }),
        ]),
      ]),
    );
  }
}
