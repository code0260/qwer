import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/data/model/debouncer_model.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField(
      {super.key,
      required this.hintText,
      required this.searchController,
      required this.onPressed,
      this.additionalIcon,
      this.fillColor,
      this.additionalIconPressed,
      this.onFocusChanged});
  final String hintText;
  final IconData? additionalIcon;
  final void Function(bool)? onFocusChanged;
  final TextEditingController searchController;
  final void Function() onPressed;
  final void Function()? additionalIconPressed;
  final Color? fillColor;
  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool isStartSearching = false;
  final FocusNode _myFocusNode = FocusNode();
  // Initialize the debouncer with a 500ms delay.
  final _debouncer = DebouncerModel(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _myFocusNode,
      controller: widget.searchController,
      cursorColor: AppColor.primaryColor,
      onChanged: (value) {
        // Run the debouncer. The onPressed function will only be called
        // after the user stops typing for 500ms.
        _debouncer.run(() {
          widget.onPressed.call();
        });

        // The existing logic for changing the icon color
        if (value.isNotEmpty) {
          setState(() {
            isStartSearching = true;
          });
        } else {
          setState(() {
            isStartSearching = false;
          });
        }
      },
      // // Remove onFieldSubmitted as the debouncer handles the logic.
      onFieldSubmitted: (value) {
        widget.onPressed.call();
      },
      autofocus: true,
      decoration: InputDecoration(
        fillColor: widget.fillColor ?? AppColor.whiteBlackSame,
        contentPadding:
            const EdgeInsets.only(bottom: 5.0, top: 5.0, right: 15.0, left: 15),
        filled: true,
        hintText: widget.hintText,
        suffixIcon: IconButton(
          padding: const EdgeInsets.only(left: 12, right: 10),
          onPressed: widget.onPressed,
          icon: Icon(
            Icons.search,
            color: isStartSearching ? AppColor.whiteMainReverse : null,
          ),
        ),
        suffix: widget.additionalIcon == null
            ? null
            : IconButton(
                padding: const EdgeInsets.only(left: 12, right: 10),
                onPressed: widget.additionalIconPressed,
                icon: Icon(
                  widget.additionalIcon,
                  color: isStartSearching ? AppColor.whiteMainReverse : null,
                ),
              ),
        prefixIcon: IconButton(
          padding: const EdgeInsets.only(left: 12, right: 10),
          onPressed: () {
            widget.searchController.clear();
          },
          icon: Icon(
            Icons.close,
            color: isStartSearching ? AppColor.whiteMainReverse : null,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(25))),
      ),
    );
  }

  @override
  void initState() {
    if (widget.onFocusChanged != null) {
      _myFocusNode.addListener(
        focusListenerChanged,
      );
    }
    super.initState();
  }

  void focusListenerChanged() {
    widget.onFocusChanged!(_myFocusNode.hasFocus);
  }

  @override
  void dispose() {
    if (widget.onFocusChanged != null) {
      _myFocusNode.removeListener(
        focusListenerChanged,
      );
      _myFocusNode.dispose();
    }
    // Cancel any pending timers to prevent memory leaks.
    _debouncer.timer?.cancel();
    super.dispose();
  }
}
