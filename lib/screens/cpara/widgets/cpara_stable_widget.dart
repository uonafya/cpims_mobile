import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:flutter/material.dart';

class CparaStableWidget extends StatefulWidget {
  const CparaStableWidget({super.key});

  @override
  State<CparaStableWidget> createState() => _CparaStableWidgetState();
}

class _CparaStableWidgetState extends State<CparaStableWidget> {
  RadioButtonOptions? selected;
  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: 'CPARA stable widget',
      children: [
//         CustomRadioButton(isNaAvailable: true, optionSelected: (value){
// setState(() {
//   selected = value;
// });
//         })
      ],
    );
  }
}