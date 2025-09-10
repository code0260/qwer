import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/shared/search_text_field.dart';
import 'package:almonazim/view/widget/products/add_product_sheet.dart';
import 'package:flutter/material.dart';

class SearchCartTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController searchController;
  final void Function() onPressed;
  const SearchCartTextField({
    super.key,
    required this.hintText,
    required this.searchController,
    required this.onPressed,
  });

  @override
  State<SearchCartTextField> createState() => _SearchCartTextFieldState();
}

class _SearchCartTextFieldState extends State<SearchCartTextField> {
  Future<void> addProduct(BuildContext context) async {
    var addProductSheet = AddProductSheet(
      defaultName: widget.searchController.text,
    );

    String? value = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return addProductSheet;
      },
    );
    if (value != null) {
      setState(() {
        widget.searchController.text = value;
        widget.onPressed.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: SearchTextField(
                fillColor: AppColor.backgroundWhiteBlackSame,
                hintText: widget.hintText,
                searchController: widget.searchController,
                onPressed: widget.onPressed)),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            addProduct(context);
          },
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
}
