enum InvoiceType { sell, buy, sellRefund, buyRefund, all }

enum Activity { active, inactive }

enum ClientType { importer, customer }

enum UnitGroup { other, weight, volume, length, area, general }

enum PriceType { buy, sell }

//offer enums:
enum OfferDomainType { one, multiple, all, category }

enum OffersConditionsType { bogo, bundle, volume, normal }

enum OfferKey { coupon, referAFriend, employee, any }

enum OfferDiscountType { percentage, fixed }

enum OfferVolumeMinimumType { price, count }

// transaction enums:
enum TransactionLinePartnerType { employee, client, partner }

enum TransactionReferenceNumberType {
  invoice,
  salarySlip,
  debt,
  expense,
  revenue,
  transaction,
  withdrawal,
  deposit
}

// asset enums:
enum AssetCategory { vehicles, buildings, land, equipment }

enum AssetStatus {
  active,
  disposed,
  sold,
  retired,
}

enum DepreciationMethod {
  straightLine,
  decliningBalance,
  sumOfYearsDigits,
  unitsOfProduction,
}

enum TransactionPartnerType {
  employee,
  client,
  asset,
}

enum ExpenseType { done, prepaid, due, all }

enum RevenueType { done, prepaid, due, all }

enum PartnerType { individual, entity }

enum WithdrawalType { goods, cash }

enum BuildingType { shop, warehouse }

enum UserType { admin, employee }

enum ProductType { product, service }

enum ClientDealType {
  invoice,
  refund,
  payCash,
  payDebt,
  createDebt,
  invoiceShipping,
  refundShipping
}

enum CashDealType {
  payCash,
  receiveDebt,
  payDebt,
  createDebt,
  variant,
  expense,
  revenue,
  withdrawal,
  deposit
}

enum TaxType { vat, luxury, other }

enum ProductTaxApplicationLevel { buy, sell, both }

enum EditCountReason { theft, damage, errorRecord }

enum EditCashReason { theft, damage, errorRecord, lost }

enum RentType { expense, revenue }

enum PeriodType {
  day,
  week,
  month,
  last30Days,
  year,
}

enum ReportFileType { xlsx, pdf }

enum PricesPartner { price1, price2, price3, price4, price5 }

enum DebtState { paid, unpaid, partial, dead, forgiven }

enum AddDebtFrom { cash, capital }

enum MovementDirection { to, from }

enum NotificationPriority { critical, high, medium, low }

enum UserPowers {
  buyInvoices,
  sellInvoices,
  expenses,
  revenues,
  debts,
  cash,
  employees
}

enum ProductStatementType {
  sell,
  sellRefund,
  buy,
  buyRefund,
  transferOut,
  transferIn,
  inventoryAdjustment,
  opening
}

enum PrinterConnectionType { bluetooth, usb }
