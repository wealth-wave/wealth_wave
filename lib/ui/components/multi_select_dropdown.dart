import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

Widget getMultiSelectDropdown(
    {required MultiSelectController controller,
    required List<ValueItem> options}) {
  return MultiSelectDropDown(
    controller: controller,
    onOptionSelected: (options) {},
    options: options,
    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
    dropdownHeight: 300,
    optionTextStyle: const TextStyle(fontSize: 16),
    selectedOptionIcon: const Icon(Icons.check_circle),
    selectionType: SelectionType.multi,
  );
}
