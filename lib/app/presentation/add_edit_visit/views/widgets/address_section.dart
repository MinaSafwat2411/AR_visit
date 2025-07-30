import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_big_textfield.dart';
import '../../../../data/models/address_type/address_type_model.dart';
import '../../../../data/models/area/areamodel.dart';
import '../../controllers/add_edit_visit_controller.dart';

class AddressSection extends GetView<AddEditVisitController> {
  const AddressSection({super.key, required this.isDark,required this.lang});

  final bool isDark;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownMenu(
          initialSelection: controller.selectedArea.value,
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: AppColors.boulder)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: AppColors.boulder)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: AppColors.boulder))),
          dropdownMenuEntries: (controller.areas)
              .map((e) => DropdownMenuEntry<AreaModel>(
            value: e,
            label: e.name ?? "",
          ))
              .toList(),
          requestFocusOnTap: true,
          onSelected: (value) {
            controller.onSelectArea(value ?? AreaModel());
          },
          width: double.infinity,
          hintText: controller.selectedArea.value.name ?? 'zone'.tr,
          menuHeight: 300,
          enableSearch: true,
          controller: controller.zoneController,
          enableFilter: true,
          menuStyle: MenuStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        CustomBigTextField(
          border: 12,
          label: 'address'.tr,
          controller: controller.patientAddressController,
          validator: (address) {
            if (address == null || address.isEmpty) {
              return 'addressValidate'.tr;
            }
            return null;
          },
          isDark: isDark,
          observe: false,
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownMenu(
          initialSelection: controller.selectedAddressType.value,
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: AppColors.boulder)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: AppColors.boulder)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: AppColors.boulder))),
          dropdownMenuEntries: (lang == 'en'? controller.addressType:controller.addressTypeAr)
              .map((e) => DropdownMenuEntry<AddressTypeModel>(
            value: e,
            label: e.addressTypeValue ?? "",
          ))
              .toList(),
          requestFocusOnTap: true,
          onSelected: (value) {
            controller.onSelectAddressType(value ?? AddressTypeModel());
          },
          width: double.infinity,
          hintText: controller.selectedAddressType.value.addressTypeValue ?? 'addressType'.tr,
          menuHeight: 300,
          menuStyle: MenuStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        CustomBigTextField(
          border: 12,
          controller: controller.googleLinkController,
          label: 'googleMapsLink'.tr,
          validator: (value) {
            return null;
          },
          isDark: isDark,
          observe: false,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
