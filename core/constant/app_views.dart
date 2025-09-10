class AppViews {
  AppViews._();

  static const String mySellProductsView = '''
  CREATE VIEW IF NOT EXISTS my_sell_products AS
  SELECT p.products_id,
    p.products_business_id,
    p.products_name,
    p.products_type,
    p.products_description,
    p.products_barcode,
    p.products_active,
    p.products_categories,
    p.products_base_unit_id,
    p.products_profit_percentage,
    u.units_name AS units_base_name,
    u.units_conversion_factor,
    u.units_group,
    u.units_group_en,
    u.units_symbol,
    u.units_is_base_unit
  FROM products p
  INNER JOIN units u ON u.units_id = p.products_base_unit_id
  ''';
  static const String myBuyProductsView = '''
  CREATE VIEW IF NOT EXISTS my_buy_products AS
  SELECT p.products_id,
    p.products_business_id,
    p.products_name,
    p.products_type,
    p.products_description,
    p.products_barcode,
    p.products_active,
    p.products_categories,
    p.products_base_unit_id,
    p.products_profit_percentage,
    u.units_name AS units_base_name,
    u.units_conversion_factor,
    u.units_group,
    u.units_group_en,
    u.units_symbol,
    u.units_is_base_unit,
    b.*
  FROM products p
  INNER JOIN units u ON u.units_id = p.products_base_unit_id
  LEFT JOIN batches b ON b.batches_products_id = p.products_id AND b.batches_invoices_id IS NULL
  ''';

  static const String buildingsWithPlacesView = '''
  CREATE VIEW IF NOT EXISTS buildings_with_places AS
  SELECT 
  b.*,
  p.*
  FROM buildings b
  INNER JOIN places p ON b.buildings_id = p.places_buildings_id
  ''';

  static const String myBatchesView = '''
  CREATE VIEW IF NOT EXISTS my_batches AS
  SELECT 
    b.batches_id,
    b.batches_products_id,
    b.batches_invoices_id,
    b.batches_active,
    b.batches_products_prices_id,
    b.batches_product_unit_cost,
    b.batches_expiration_date,
    b.batches_products_total_count,
    b.batches_products_remaining_count,
    b.batches_count_unit_id,
    b.batches_importers_id,
    b.batches_createdAt,
    u.units_id,
    u.units_name,
    u.units_conversion_factor,
    u.units_group,
    u.units_group_en,
    u.units_symbol,
    u.units_is_base_unit,
    u.units_business_id
  FROM 
    batches b
  INNER JOIN 
    units u ON u.units_id = b.batches_count_unit_id
  ''';

  static const String myInvoicesView = '''
  CREATE VIEW IF NOT EXISTS my_invoices AS
  SELECT 
    invoices.*,
    c.clients_name,
    c.clients_id,
    p.partners_id,
    p.partners_name,
    debts.*
  FROM invoices
    LEFT JOIN debts ON debts.debts_invoices_id = invoices.invoices_id
    LEFT JOIN clients c ON c.clients_id = invoices.invoices_client_id
    LEFT JOIN partners p ON p.partners_id = invoices.invoices_partner_id
  ''';

  static const String sellItemView = '''
  CREATE VIEW IF NOT EXISTS sell_item_view AS
  SELECT 
    s.*,
    p.places_name,
    pr.products_name,
    pr.products_description,
    pr.products_barcode,
    pr.products_active,
    pr.products_categories,
    pr.products_base_unit_id
  FROM sell_item s
  INNER JOIN places p ON s.sell_item_places_id = p.places_id
  INNER JOIN products pr ON s.sell_item_products_id = pr.products_id
''';

  static const String productTaxesView = '''
  CREATE VIEW IF NOT EXISTS product_taxes_view AS
  SELECT *
  FROM product_taxes
  LEFT JOIN taxes ON taxes.taxes_id = product_taxes.product_taxes_tax_id
  LEFT JOIN products ON products.products_id = product_taxes.product_taxes_product_id
  ''';

  static const String currencyView = '''
  CREATE VIEW IF NOT EXISTS currency_view AS
  SELECT 
      *
  FROM currencies
  INNER JOIN business_currency 
      ON business_currency.business_currency_currencies_id = currencies.currencies_id
  ''';
}
