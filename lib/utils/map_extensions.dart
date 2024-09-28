

import 'package:multi_dropdown/models/value_item.dart';

extension MapToValueItemList on Map<String, String> {
  List<ValueItem<String>> toValueItemList() {
    return entries.map((entry) {
      return ValueItem<String>(
        label: entry.value, // Map value becomes the label
        value: entry.key,   // Map key becomes the value
      );
    }).toList();
  }
}