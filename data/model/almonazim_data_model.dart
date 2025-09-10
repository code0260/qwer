import 'package:almonazim/data/data%20source/locale/store_almonazim_data.dart';
import 'package:equatable/equatable.dart';

class AlmonazimDataModel extends Equatable {
  final String? phoneNumber;
  final String? phoneNumberCountryCode;
  final String? countryCode;
  final String? generalAddress;
  final String? currencyName;
  final String? currencySymbol;
  final String? phoneNumberExampleEntering;
  final String? freeTrialText;
  final bool? liveMode;
  final String? userPricingPlanTitle;
  final String? userPricingPlanBodyOne;
  final String? userPricingPlanOneUserPrice;
  final String? userPricingPlanTwoUserPrice;
  final String? userPricingPlanThreeUserPrice;
  final String? userPricingPlanBodyFive;
  final String? userPricingPlanBodySix;
  final String? userPricingPlanBodySeven;
  final String? userPricingPlanBodyEight;
  final String? freeTrialEndTitle;
  final String? freeTrialEndContent;
  final String? freeTrialAccount;
  final String? freeTrialPeriod;

  const AlmonazimDataModel._({
    this.phoneNumber,
    this.phoneNumberCountryCode,
    this.generalAddress,
    this.currencyName,
    this.currencySymbol,
    this.countryCode,
    this.phoneNumberExampleEntering,
    this.freeTrialText,
    this.liveMode,
    this.userPricingPlanTitle,
    this.userPricingPlanBodyOne,
    this.userPricingPlanOneUserPrice,
    this.userPricingPlanTwoUserPrice,
    this.userPricingPlanThreeUserPrice,
    this.userPricingPlanBodyFive,
    this.userPricingPlanBodySix,
    this.userPricingPlanBodySeven,
    this.userPricingPlanBodyEight,
    this.freeTrialEndTitle,
    this.freeTrialEndContent,
    this.freeTrialAccount,
    this.freeTrialPeriod,
  });

  // Static instance
  static AlmonazimDataModel instance = const AlmonazimDataModel._();

  // Factory constructor to provide the singleton instance
  factory AlmonazimDataModel.init() {
    instance =
        StoreAlmonazimData.getAlmonazimData() ?? const AlmonazimDataModel._();
    return instance;
  }

  AlmonazimDataModel updateInstance({
    String? phoneNumber,
    String? phoneNumberCountryCode,
    String? countryCode,
    String? generalAddress,
    String? currencyName,
    String? currencySymbol,
    String? phoneNumberExampleEntering,
    String? freeTrialText,
    bool? liveMode,
    String? userPricingPlanTitle,
    String? userPricingPlanBodyOne,
    String? userPricingPlanOneUserPrice,
    String? userPricingPlanTwoUserPrice,
    String? userPricingPlanThreeUserPrice,
    String? userPricingPlanBodyFive,
    String? userPricingPlanBodySix,
    String? userPricingPlanBodySeven,
    String? userPricingPlanBodyEight,
    String? freeTrialEndTitle,
    String? freeTrialEndContent,
    String? freeTrialAccount,
    String? freeTrialPeriod,
  }) {
    instance = AlmonazimDataModel._(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberCountryCode:
          phoneNumberCountryCode ?? this.phoneNumberCountryCode,
      countryCode: countryCode ?? this.countryCode,
      generalAddress: generalAddress ?? this.generalAddress,
      currencyName: currencyName ?? this.currencyName,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      phoneNumberExampleEntering:
          phoneNumberExampleEntering ?? this.phoneNumberExampleEntering,
      freeTrialText: freeTrialText ?? this.freeTrialText,
      liveMode: liveMode ?? this.liveMode,
      userPricingPlanTitle: userPricingPlanTitle ?? this.userPricingPlanTitle,
      userPricingPlanBodyOne:
          userPricingPlanBodyOne ?? this.userPricingPlanBodyOne,
      userPricingPlanOneUserPrice:
          userPricingPlanOneUserPrice ?? this.userPricingPlanOneUserPrice,
      userPricingPlanTwoUserPrice:
          userPricingPlanTwoUserPrice ?? this.userPricingPlanTwoUserPrice,
      userPricingPlanThreeUserPrice:
          userPricingPlanThreeUserPrice ?? this.userPricingPlanThreeUserPrice,
      userPricingPlanBodyFive:
          userPricingPlanBodyFive ?? this.userPricingPlanBodyFive,
      userPricingPlanBodySix:
          userPricingPlanBodySix ?? this.userPricingPlanBodySix,
      userPricingPlanBodySeven:
          userPricingPlanBodySeven ?? this.userPricingPlanBodySeven,
      userPricingPlanBodyEight:
          userPricingPlanBodyEight ?? this.userPricingPlanBodyEight,
      freeTrialEndTitle: freeTrialEndTitle ?? this.freeTrialEndTitle,
      freeTrialEndContent: freeTrialEndContent ?? this.freeTrialEndContent,
      freeTrialAccount: freeTrialAccount ?? this.freeTrialAccount,
      freeTrialPeriod: freeTrialPeriod ?? this.freeTrialPeriod,
    );
    return instance;
  }

  factory AlmonazimDataModel.fromJson(Map<String, dynamic> json) =>
      instance.updateInstance(
        phoneNumber: json['phone_number'] as String?,
        phoneNumberCountryCode: json['phone_number_country_code'] as String?,
        generalAddress: json['general_address'] as String?,
        countryCode: json['country_code'] as String?,
        currencyName: json['currency_name'] as String?,
        currencySymbol: json['currency_symbol'] as String?,
        phoneNumberExampleEntering:
            json['phone_number_example_entering'] as String?,
        freeTrialText: json['free_trial_text'] as String?,
        liveMode: json['live_mode'] as bool?,
        userPricingPlanTitle: json['user_pricing_plan_title'] as String?,
        userPricingPlanBodyOne: json['user_pricing_plan_body_one'] as String?,
        userPricingPlanOneUserPrice:
            json['user_pricing_plan_one_user_price'] as String?,
        userPricingPlanTwoUserPrice:
            json['user_pricing_plan_two_user_price'] as String?,
        userPricingPlanThreeUserPrice:
            json['user_pricing_plan_three_user_price'] as String?,
        userPricingPlanBodyFive: json['user_pricing_plan_body_five'] as String?,
        userPricingPlanBodySix: json['user_pricing_plan_body_six'] as String?,
        userPricingPlanBodySeven:
            json['user_pricing_plan_body_seven'] as String?,
        userPricingPlanBodyEight:
            json['user_pricing_plan_body_eight'] as String?,
        freeTrialEndTitle: json['free_trial_end_title'] as String?,
        freeTrialEndContent: json['free_trial_end_content'] as String?,
        freeTrialAccount: json['free_trial_account'] as String?,
        freeTrialPeriod: json['free_trial_period'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'phone_number': phoneNumber,
        'phone_number_country_code': phoneNumberCountryCode,
        'country_code': countryCode,
        'general_address': generalAddress,
        'currency_name': currencyName,
        'currency_symbol': currencySymbol,
        'phone_number_example_entering': phoneNumberExampleEntering,
        'free_trial_text': freeTrialText,
        'live_mode': liveMode,
        'user_pricing_plan_title': userPricingPlanTitle,
        'user_pricing_plan_body_one': userPricingPlanBodyOne,
        'user_pricing_plan_one_user_price': userPricingPlanOneUserPrice,
        'user_pricing_plan_two_user_price': userPricingPlanTwoUserPrice,
        'user_pricing_plan_three_user_price': userPricingPlanThreeUserPrice,
        'user_pricing_plan_body_five': userPricingPlanBodyFive,
        'user_pricing_plan_body_six': userPricingPlanBodySix,
        'user_pricing_plan_body_seven': userPricingPlanBodySeven,
        'user_pricing_plan_body_eight': userPricingPlanBodyEight,
        'free_trial_end_title': freeTrialEndTitle,
        'free_trial_end_content': freeTrialEndContent,
        'free_trial_account': freeTrialAccount,
        'free_trial_period': freeTrialPeriod,
      };

  AlmonazimDataModel copyWith({
    String? phoneNumber,
    String? phoneNumberCountryCode,
    String? countryCode,
    String? generalAddress,
    String? currencyName,
    String? currencySymbol,
    String? phoneNumberExampleEntering,
    String? freeTrialText,
    bool? liveMode,
    String? userPricingPlanTitle,
    String? userPricingPlanBodyOne,
    String? userPricingPlanOneUserPrice,
    String? userPricingPlanTwoUserPrice,
    String? userPricingPlanThreeUserPrice,
    String? userPricingPlanBodyFive,
    String? userPricingPlanBodySix,
    String? userPricingPlanBodySeven,
    String? userPricingPlanBodyEight,
    String? freeTrialEndTitle,
    String? freeTrialEndContent,
    String? freeTrialAccount,
    String? freeTrialPeriod,
  }) {
    return AlmonazimDataModel._(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberCountryCode:
          phoneNumberCountryCode ?? this.phoneNumberCountryCode,
      countryCode: countryCode ?? this.countryCode,
      generalAddress: generalAddress ?? this.generalAddress,
      currencyName: currencyName ?? this.currencyName,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      phoneNumberExampleEntering:
          phoneNumberExampleEntering ?? this.phoneNumberExampleEntering,
      freeTrialText: freeTrialText ?? this.freeTrialText,
      liveMode: liveMode ?? this.liveMode,
      userPricingPlanTitle: userPricingPlanTitle ?? this.userPricingPlanTitle,
      userPricingPlanBodyOne:
          userPricingPlanBodyOne ?? this.userPricingPlanBodyOne,
      userPricingPlanOneUserPrice:
          userPricingPlanOneUserPrice ?? this.userPricingPlanOneUserPrice,
      userPricingPlanTwoUserPrice:
          userPricingPlanTwoUserPrice ?? this.userPricingPlanTwoUserPrice,
      userPricingPlanThreeUserPrice:
          userPricingPlanThreeUserPrice ?? this.userPricingPlanThreeUserPrice,
      userPricingPlanBodyFive:
          userPricingPlanBodyFive ?? this.userPricingPlanBodyFive,
      userPricingPlanBodySix:
          userPricingPlanBodySix ?? this.userPricingPlanBodySix,
      userPricingPlanBodySeven:
          userPricingPlanBodySeven ?? this.userPricingPlanBodySeven,
      userPricingPlanBodyEight:
          userPricingPlanBodyEight ?? this.userPricingPlanBodyEight,
      freeTrialEndTitle: freeTrialEndTitle ?? this.freeTrialEndTitle,
      freeTrialEndContent: freeTrialEndContent ?? this.freeTrialEndContent,
      freeTrialAccount: freeTrialAccount ?? this.freeTrialAccount,
      freeTrialPeriod: freeTrialPeriod ?? this.freeTrialPeriod,
    );
  }

  @override
  List<Object?> get props {
    return [
      phoneNumber,
      phoneNumberCountryCode,
      countryCode,
      generalAddress,
      currencyName,
      currencySymbol,
      phoneNumberExampleEntering,
      freeTrialText,
      liveMode,
      userPricingPlanTitle,
      userPricingPlanBodyOne,
      userPricingPlanOneUserPrice,
      userPricingPlanTwoUserPrice,
      userPricingPlanThreeUserPrice,
      userPricingPlanBodyFive,
      userPricingPlanBodySix,
      userPricingPlanBodySeven,
      userPricingPlanBodyEight,
      freeTrialEndTitle,
      freeTrialEndContent,
      freeTrialAccount,
      freeTrialPeriod,
    ];
  }

  @override
  String toString() {
    return 'AlmonazimDataModel(\n'
        '  phoneNumber: $phoneNumber,\n'
        '  phoneNumberCountryCode: $phoneNumberCountryCode,\n'
        '  generalAddress: $generalAddress,\n'
        '  currencyName: $currencyName,\n'
        '  currencySymbol: $currencySymbol,\n'
        '  phoneNumberExampleEntering: $phoneNumberExampleEntering,\n'
        '  freeTrialText: $freeTrialText,\n'
        '  liveMode: $liveMode,\n'
        '  userPricingPlanTitle: $userPricingPlanTitle,\n'
        '  userPricingPlanBodyOne: $userPricingPlanBodyOne,\n'
        '  userPricingPlanOneUserPrice: $userPricingPlanOneUserPrice,\n'
        '  userPricingPlanTwoUserPrice: $userPricingPlanTwoUserPrice,\n'
        '  userPricingPlanThreeUserPrice: $userPricingPlanThreeUserPrice,\n'
        '  userPricingPlanBodyFive: $userPricingPlanBodyFive,\n'
        '  userPricingPlanBodySix: $userPricingPlanBodySix,\n'
        '  userPricingPlanBodySeven: $userPricingPlanBodySeven,\n'
        '  userPricingPlanBodyEight: $userPricingPlanBodyEight,\n'
        '  freeTrialEndTitle: $freeTrialEndTitle,\n'
        '  freeTrialEndContent: $freeTrialEndContent,\n'
        '  freeTrialAccount: $freeTrialAccount,\n'
        '  freeTrialPeriod: $freeTrialPeriod,\n'
        ')';
  }
}
