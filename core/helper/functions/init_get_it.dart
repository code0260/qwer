import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/api/app_interceptors.dart';
import 'package:almonazim/core/services/print_service.dart';
// Assets & Rent
import 'package:almonazim/data/data source/repo/assets repo/asset_repo_imp.dart';
// Auth & Core
import 'package:almonazim/data/data source/repo/auth repo/auth_repo_imp.dart';
import 'package:almonazim/data/data source/repo/bought repo/bought_repo_imp.dart';
// Business & Clients
import 'package:almonazim/data/data source/repo/business repo/business_repo_imp.dart';
import 'package:almonazim/data/data source/repo/cash repo/cash_repo_imp.dart';
// Categories & Products
import 'package:almonazim/data/data source/repo/categories repo/categories_repo_imp.dart';
import 'package:almonazim/data/data source/repo/clients repo/client_repo_imp.dart';
import 'package:almonazim/data/data source/repo/compensation repo/compensation_repo_imp.dart';
import 'package:almonazim/data/data source/repo/currency repo/currency_repo_imp.dart';
import 'package:almonazim/data/data source/repo/debt payment repo/debt_payment_repo_imp.dart';
// Financials
import 'package:almonazim/data/data source/repo/debts repo/debts_repo_imp.dart';
import 'package:almonazim/data/data source/repo/deposit repo/deposit_repo_imp.dart';
// Salaries & HR
import 'package:almonazim/data/data source/repo/employees repo/employees_repo_imp.dart';
// Expenses & Revenues
import 'package:almonazim/data/data source/repo/expenses repo/expenses_repo_imp.dart';
// Misc
import 'package:almonazim/data/data source/repo/favorite repo/favorite_repo_impl.dart';
import 'package:almonazim/data/data source/repo/feedback repo/feedback_repo_imp.dart';
import 'package:almonazim/data/data source/repo/general repo/general_repo_imp.dart';
import 'package:almonazim/data/data source/repo/inventory repo/inventory_repo_imp.dart';
// Invoices & Transactions
import 'package:almonazim/data/data source/repo/invoice repo/invoice_repo_imp.dart';
import 'package:almonazim/data/data source/repo/partners repo/partner_repo_imp.dart';
import 'package:almonazim/data/data source/repo/place repo/place_repo_imp.dart';
// Pricing & Inventory
import 'package:almonazim/data/data source/repo/prices repo/prices_repo_imp.dart';
import 'package:almonazim/data/data source/repo/product movement repo/product_movement_repo_imp.dart';
import 'package:almonazim/data/data source/repo/product place repo/product_place_repo_imp.dart';
import 'package:almonazim/data/data source/repo/product repo/product_repo_imp.dart';
import 'package:almonazim/data/data source/repo/product taxes repo/product_taxes_repo_imp.dart';
import 'package:almonazim/data/data source/repo/rent repo/rent_repo_imp.dart';
// Reports
import 'package:almonazim/data/data source/repo/report repos/cash report repos/cash account statment repo/cash_account_statment_repo_imp.dart';
import 'package:almonazim/data/data source/repo/report repos/expenses report repos/expenses chart repo/expenses_chart_repo_imp.dart';
import 'package:almonazim/data/data source/repo/report repos/income statement report repo/income_statement_repo_impl.dart';
import 'package:almonazim/data/data source/repo/report repos/inventory report repo/inventory_report_repo_impl.dart';
import 'package:almonazim/data/data source/repo/report repos/product repos/top dealing repo/top_dealing_repo_imp.dart';
import 'package:almonazim/data/data source/repo/report repos/profit report repo/profit_repo_impl.dart';
import 'package:almonazim/data/data source/repo/report repos/revenues report repos/revenues chart repo/revenues_chart_repo_imp.dart';
import 'package:almonazim/data/data source/repo/report repos/sales report repo/salse_report_repo_imp.dart';
import 'package:almonazim/data/data source/repo/revenues repo/revenues_repo_imp.dart';
import 'package:almonazim/data/data source/repo/salaries repo/salaries_repo_imp.dart';
import 'package:almonazim/data/data source/repo/salary slips repo/salary_slips_repo_imp.dart';
// Sales & Purchase
import 'package:almonazim/data/data source/repo/sells repo/sells_repo_imp.dart';
import 'package:almonazim/data/data source/repo/taxes repo/taxes_repo_imp.dart';
import 'package:almonazim/data/data source/repo/transaction repo/transaction_repo_imp.dart';
import 'package:almonazim/data/data source/repo/trial balance repo/trial_balance_repo_imp.dart';
import 'package:almonazim/data/data source/repo/unite repo/unite_repo_imp.dart';
import 'package:almonazim/data/data source/repo/vacations repo/vacations_repo_imp.dart';
import 'package:almonazim/data/data source/repo/withdrawal repo/withdrawal_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/accounts%20repo/account_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/ai%20repos/chat%20ai%20repo/chat_ai_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/inventory%20adjustment%20repo/inventory_adjustment_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/notifications%20repo/notification_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/offer%20repo/apply%20offer%20repo/apply_offer_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/offer%20repo/offer%20repo/offer_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/refund%20repo/refund_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/client%20report%20repos/client%20report%20repo/client_report_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/product%20report%20repos/product%20account%20statment%20repo/product_statment_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/settings%20repo/settings_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/user%20devices%20repo/user_devices_repo_imp.dart';
import 'package:almonazim/data/data%20source/repo/user%20repo/user_repo_imp.dart';
import 'package:almonazim/data/model/auth models/token_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initGetIt() {
  // Core services
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton(LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true));

  getIt.registerSingleton<TokenModel>(TokenModel());
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton(AppInterceptors(
    dio: getIt.get<Dio>(),
  ));
  getIt.registerSingleton<ApiService>(ApiService(dio: getIt.get<Dio>()));

  // Authentication
  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(getIt.get<ApiService>()));

  // print
  getIt.registerSingleton<PrinterService>(PrinterService());

  // Business Logic
  getIt.registerSingleton<BusinessRepoImpl>(
      BusinessRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<UserRepoImpl>(UserRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<UserDeviceRepoImpl>(
      UserDeviceRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<PartnerRepoImpl>(
      PartnerRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ClientRepoImpl>(
      ClientRepoImpl(getIt.get<ApiService>()));

  // Products & Categories
  getIt.registerSingleton<CategoriesRepoImpl>(
      CategoriesRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ProductsRepoImpl>(
      ProductsRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ProductPlaceRepoImpl>(
      ProductPlaceRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ProductMovementRepoImpl>(
      ProductMovementRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ProductTaxesRepoImpl>(
      ProductTaxesRepoImpl(getIt.get<ApiService>()));

  // Inventory
  getIt.registerSingleton<InventoryRepoImpl>(
      InventoryRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<InventoryAdjustmentRepoImpl>(
      InventoryAdjustmentRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<PricesRepoImpl>(
      PricesRepoImpl(getIt.get<ApiService>()));

  // Financial
  getIt
      .registerSingleton<DebtsRepoImpl>(DebtsRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<DebtPaymentRepoImpl>(
      DebtPaymentRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<CashRepoImpl>(CashRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<WithdrawalRepoImpl>(
      WithdrawalRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<DepositRepoImpl>(
      DepositRepoImpl(getIt.get<ApiService>()));

  // Invoices & Transactions
  getIt.registerSingleton<InvoiceRepoImpl>(
      InvoiceRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<TransactionRepoImpl>(
      TransactionRepoImpl(getIt.get<ApiService>()));

  // Human Resources
  getIt.registerSingleton<EmployeesRepoImpl>(
      EmployeesRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<SalarySlipRepoImpl>(
      SalarySlipRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<SalariesRepoImpl>(
      SalariesRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<VacationsRepoImpl>(
      VacationsRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<CompensationRepoImpl>(
      CompensationRepoImpl(getIt.get<ApiService>()));

  // Assets and Rentals
  getIt
      .registerSingleton<AssetRepoImpl>(AssetRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<RentRepoImpl>(RentRepoImpl(getIt.get<ApiService>()));

  // Expenses & Revenues
  getIt.registerSingleton<ExpensesRepoImpl>(
      ExpensesRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<RevenuesRepoImpl>(
      RevenuesRepoImpl(getIt.get<ApiService>()));

  // Sales & Purchases
  getIt
      .registerSingleton<SellsRepoImpl>(SellsRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<BoughtRepoImpl>(
      BoughtRepoImpl(getIt.get<ApiService>()));

  // unit
  getIt.registerSingleton<UnitRepoImpl>(UnitRepoImpl(getIt.get<ApiService>()));

  // offer
  getIt.registerSingleton<OfferRepoImp>(OfferRepoImp(getIt.get<ApiService>()));
  getIt.registerSingleton<ApplyOfferImp>(
      ApplyOfferImp(getIt.get<UnitRepoImpl>()));

  // refund
  getIt.registerSingleton<RefundRepoImpl>(
      RefundRepoImpl(getIt.get<ApiService>()));

  // Miscellaneous
  getIt.registerSingleton<FavoriteRepoImpl>(
      FavoriteRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<SearchProductRepoImpl>(
      SearchProductRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<GeneralRepoImpl>(
      GeneralRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<FeedbackRepoImpl>(
      FeedbackRepoImpl(getIt.get<ApiService>()));
  getIt
      .registerSingleton<TaxesRepoImpl>(TaxesRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<CurrencyRepoImpl>(
      CurrencyRepoImpl(getIt.get<ApiService>()));
  getIt
      .registerSingleton<PlaceRepoImpl>(PlaceRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<AccountRepoImpl>(
      AccountRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<TrialBalanceRepoImpl>(
      TrialBalanceRepoImpl(getIt.get<ApiService>()));

  // Reports
  getIt.registerSingleton<CashAccountStatementRepoImpl>(
      CashAccountStatementRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ClientReportRepoImpl>(
      ClientReportRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<InventoryReportRepoImpl>(
      InventoryReportRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ExpensesChartRepoImpl>(
      ExpensesChartRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<SalesReportRepoImpl>(
      SalesReportRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<IncomeStatementRepoImpl>(
      IncomeStatementRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<TopDealingRepoImpl>(
      TopDealingRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<RevenuesChartRepoImpl>(
      RevenuesChartRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ProfitRepoImpl>(
      ProfitRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ProductStatementRepoImpl>(
      ProductStatementRepoImpl(getIt.get<ApiService>()));

  // notification
  getIt.registerSingleton<NotificationRepoImpl>(
      NotificationRepoImpl(getIt.get<ApiService>()));
  // setting
  getIt.registerSingleton<SettingsRepoImpl>(
      SettingsRepoImpl(getIt.get<ApiService>()));
  // setting
  getIt.registerSingleton<ChatAIRepoImpl>(
      ChatAIRepoImpl(getIt.get<ApiService>()));
}
