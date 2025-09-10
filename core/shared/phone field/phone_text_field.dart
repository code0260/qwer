import 'package:almonazim/core/helper/functions/valid_input_function.dart';
import 'package:almonazim/core/shared/custom_text_field.dart';
import 'package:almonazim/core/shared/phone%20field/country_phones.dart';
import 'package:almonazim/core/shared/phone%20field/country_picker_dialog.dart';
import 'package:flutter/material.dart';

class PhoneTextField extends StatefulWidget {
  const PhoneTextField(
      {super.key,
      this.onCountryChanged,
      this.onChanged,
      this.initialValue,
      this.isOptional = false,
      this.initialCountryCode});
  final ValueChanged<Country>? onCountryChanged;
  final ValueChanged<String>? onChanged;
  final bool isOptional;
  final String? initialValue;
  final String? initialCountryCode;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  late Country _selectedCountry;

  late String number;

  String? validatorMessage;
  @override
  void initState() {
    super.initState();
    number = widget.initialValue ?? '';
    // parse initial value
    _selectedCountry = countries.firstWhere(
        (country) => number.startsWith(country.fullCountryCode),
        orElse: () => countries.first);

    // if (widget.autovalidateMode == AutovalidateMode.always) {
    //   final initialPhoneNumber = PhoneNumber(
    //     countryISOCode: _selectedCountry.code,
    //     countryCode: '+${_selectedCountry.dialCode}',
    //     number: widget.initialValue ?? '',
    //   );

    //   final value = widget.validator?.call(initialPhoneNumber);

    //   if (value is String) {
    //     validatorMessage = value;
    //   } else {
    //     (value as Future).then((msg) {
    //       validatorMessage = msg;
    //     });
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      isPhoneNumber: true,
      keyboardType: TextInputType.number,
      textDirection: TextDirection.ltr,
      onChanged: (number) {
        widget.onChanged?.call((_selectedCountry.dialCode) + number);
      },
      validator: (value) {
        return validInput(value!.trim(), 5, 20, 'phone',
            canBeEmpty: widget.isOptional);
      },
      hintText: "أدخل رقم الهاتف",
      label: "رقم الهاتف" " ${widget.isOptional ? "(اختياري)" : ""}",
      suffix: _buildFlagsButton(),
      controller: TextEditingController(),
    );
  }

  Future<void> _changeCountry(BuildContext context) async {
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => CountryPickerDialog(
          languageCode: 'ar',
          // style: widget.pickerDialogStyle,
          filteredCountries: countries,
          searchText: 'البحث عن الدولة',
          countryList: countries,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            _selectedCountry = country;
            widget.onCountryChanged?.call(country);
            setState(() {});
          },
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  Container _buildFlagsButton() {
    return Container(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          _changeCountry(context);
        },
        child: Padding(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 4,
              ),
              FittedBox(
                child: Text(
                  '+${_selectedCountry.dialCode}',
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  _selectedCountry.flag,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
