import 'package:almonazim/core/helper/functions/currency functions/convert_amount_to_base.dart';
import 'package:almonazim/data/model/client models/client_balance_model.dart';
import 'package:almonazim/data/model/client models/client_model.dart';
import 'package:almonazim/data/model/client models/get_client_model.dart';
import 'package:almonazim/data/model/debt models/debt_model.dart';

/// Prepares a GetClientModel from a list of DebtModel,
/// grouping by currency and summing net amounts.
GetClientModel prepareSummaryClientBalanceFromDebt(List<DebtModel> debts) {
  if (debts.isEmpty) {
    throw ArgumentError('debts list cannot be empty');
  }

  // 1) group net amounts by currency
  final Map<int, double> netByCurrency = {};
  for (var d in debts) {
    final currencyId = d.debtsAmountCurrencyId!;
    final net = (d.debtsTotalAmount ?? 0) - (d.debtsPaidAmount ?? 0);
    if (d.debtsPersonNameType == "Credit") {
      netByCurrency[currencyId] = (netByCurrency[currencyId] ?? 0) - net;
    } else {
      netByCurrency[currencyId] = (netByCurrency[currencyId] ?? 0) + net;
    }
  }

  // 2) build balances + compute total in base
  double totalBalanceInBase = 0;
  final balances = <ClientBalanceModel>[];

  netByCurrency.forEach((currencyId, sumNet) {
    // convert this currency sum to base
    final inBase = convertAmountToBase(sumNet, currencyId);
    totalBalanceInBase += inBase;

    balances.add(ClientBalanceModel(
        clientsBalanceCurrencyId: currencyId, clientsBalanceCurrent: sumNet));
  });

  // 3) assemble clientModel (take clientId from first debt)
  final clientModel = ClientModel(clientsId: debts.first.debtsClientsId!);

  return GetClientModel(
    clientModel: clientModel,
    balances: balances,
    totalBalance: totalBalanceInBase,
  );
}
