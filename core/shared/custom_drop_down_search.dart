import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/constant/app_design_endpoint.dart';
import 'package:almonazim/generated/l10n.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class CustomDropDownSearch extends StatefulWidget {
  final String title;
  final String? initialValue;
  final List<SelectedListItem> data;
  final bool enableMultipleSelection;
  final Widget? additionalWidget;
  final dynamic Function(List<SelectedListItem>) selectedItems;
  final String Function(SelectedListItem) selectedName;
  const CustomDropDownSearch(
      {super.key,
      required this.title,
      required this.selectedName,
      this.additionalWidget,
      required this.data,
      this.enableMultipleSelection = false,
      required this.selectedItems,
      this.initialValue});
  @override
  State<CustomDropDownSearch> createState() => _CustomDropDownSearchState();
}

class _CustomDropDownSearchState extends State<CustomDropDownSearch> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isMobile = AppDesignEndpoint.isMobile(context);
    if (widget.initialValue != null && nameController.text.isEmpty) {
      nameController.text = widget.initialValue!;
    }
    return Align(
      alignment: isMobile ? Alignment.center : Alignment.topRight,
      child: SizedBox(
        width: isMobile ? null : MediaQuery.of(context).size.width / 2,
        child: TextFormField(
          cursorColor: AppColor.primaryColor,
          onTap: () {
            showDropDown();
          },
          keyboardType: TextInputType.none,
          readOnly: true,
          controller: nameController,
          decoration: InputDecoration(
              // color
              filled: true,
              fillColor: AppColor.whiteBlackSame,
              hintText: nameController.text == ""
                  ? widget.title
                  : nameController.text,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: Text(nameController.text == ""
                  ? widget.title
                  : nameController.text),
              suffixIcon: IconButton(
                  onPressed: () {
                    showDropDown();
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColor.whiteMainReverse,
                  )),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
              )),
        ),
      ),
    );
  }

  void showDropDown() {
    DropDownState(
      shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      dropDown: DropDown(
        searchCursorColor: AppColor.primaryColor,
        searchHintText: "بحث",
        isDismissible: true,
        bottomSheetTitle: Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const Spacer(),
            if (widget.additionalWidget != null) widget.additionalWidget!
          ],
        ),
        submitButtonChild: Text(
          S.of(context).onboarding_done,
        ),
        clearButtonChild: const Text("مسح"),
        selectAllTextButtonChild: const Text('اختيار الكل'),
        deSelectAllTextButtonChild: const Text('عدم اختيار الكل'),
        data: List.generate(
          widget.data.length,
          (index) =>
              SelectedListItem(data: widget.selectedName(widget.data[index])),
        ),
        onSelected: (selectedItems) {
          List<SelectedListItem<dynamic>> i = [];
          for (final d in widget.data) {
            for (final item in selectedItems) {
              if (widget.selectedName(d) == item.data) {
                i.add(d);
              }
            }
          }
          widget.selectedItems.call(i);
          nameController.text = selectedItems[0].data;
        },
        enableMultipleSelection: widget.enableMultipleSelection,
      ),
    ).showModal(context);
  }
}
