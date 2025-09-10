import 'package:almonazim/core/constant/app_enums.dart'; // Assuming UserPowers is in this file or similar

String? translateToEnUserPowers(UserPowers? power) {
  switch (power) {
    case UserPowers.sellInvoices:
      return "Sell Invoices";
    case UserPowers.buyInvoices:
      return "Buy Invoices";
    case UserPowers.revenues:
      return "Revenues";
    case UserPowers.expenses:
      return "Exegeses";
    case UserPowers.debts:
      return "Debts";
    case UserPowers.cash:
      return "Cash";
    case UserPowers.employees:
      return "Employees";
    default:
      return null;
  }
}

String? translateToArUserPowers(UserPowers? power) {
  switch (power) {
    case UserPowers.sellInvoices:
      return "فواتير البيع";
    case UserPowers.buyInvoices:
      return "فواتير الشراء";
    case UserPowers.revenues:
      return "إيرادات";
    case UserPowers.expenses:
      return "مصروفات";
    case UserPowers.debts:
      return "ديون";
    case UserPowers.cash:
      return "نقدية";
    case UserPowers.employees:
      return "موظفين";
    default:
      return null;
  }
}

String? translateToEnUserPowersFromString(String? powerString) {
  switch (powerString) {
    case "فواتير البيع":
      return "Sell Invoices";
    case "فواتير الشراء":
      return "Buy Invoices";
    case "إيرادات":
      return "Revenues";
    case "مصروفات":
      return "Exegeses";
    case "ديون":
      return "Debts";
    case "نقدية":
      return "Cash";
    case "موظفين":
      return "Employees";
    default:
      return null;
  }
}

String? translateToArUserPowersFromString(String? powerString) {
  switch (powerString) {
    case "Sell Invoices":
      return "فواتير البيع";
    case "Buy Invoices":
      return "فواتير الشراء";
    case "Revenues":
      return "إيرادات";
    case "Exegeses":
      return "مصروفات";
    case "Debts":
      return "ديون";
    case "Cash":
      return "نقدية";
    case "Employees":
      return "موظفين";
    default:
      return null;
  }
}
