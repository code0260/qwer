// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShippingInputModel {
  int? invoicesShippingClientId; // New property
  double invoicesShippingCost;
  double? invoicesShippingCostInBase;
  int? invoicesShippingCurrencyId; // New property
  String? shippingPayment;
  ShippingInputModel({
    this.invoicesShippingClientId,
    this.shippingPayment = 'paid',
    this.invoicesShippingCost = 0,
    this.invoicesShippingCostInBase,
    this.invoicesShippingCurrencyId,
  });
}
