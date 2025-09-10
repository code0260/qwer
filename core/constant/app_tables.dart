class AppTables {
  AppTables._();

  static const String businessTbl = '''
  CREATE TABLE business (
    business_id INTEGER PRIMARY KEY,
    business_name TEXT NOT NULL,
    business_address TEXT NOT NULL,
    business_image TEXT DEFAULT NULL,
    business_approve INTEGER DEFAULT 0,
    business_createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  )
  ''';
  static const String categoriesTbl = '''
  CREATE TABLE categories (
  categories_id INTEGER PRIMARY KEY,
  categories_business_id INTEGER NOT NULL,
  categories_name TEXT NOT NULL,
  categories_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (categories_business_id) REFERENCES business(business_id)
     ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';

  static const String productsTbl = '''
  CREATE TABLE products (
    products_id INTEGER PRIMARY KEY,
    products_business_id INTEGER NOT NULL,
    products_name TEXT NOT NULL,
    products_type TEXT CHECK(products_type IN ('product', 'service')),
    products_description TEXT,
    products_barcode TEXT,
    products_active INTEGER NOT NULL DEFAULT 1,
    products_categories INTEGER NOT NULL,
    products_base_unit_id INTEGER NOT NULL,
    products_profit_percentage INTEGER,
    products_online INTEGER NOT NULL DEFAULT 1,
    products_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (products_business_id) REFERENCES business(business_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (products_base_unit_id) REFERENCES units(units_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE(products_name, products_business_id)
    )
  ''';

  static const String pricesTbl = '''
  CREATE TABLE prices (
    prices_id INTEGER PRIMARY KEY,
    prices_business_id INTEGER NOT NULL,
    prices_products_id INTEGER NOT NULL,
    prices_type TEXT CHECK(prices_type IN ('sell', 'buy')),
    prices_partner_ar TEXT CHECK(prices_partner_ar IN ('سعر1', 'سعر2', 'سعر3', 'سعر4', 'سعر5')),
    prices_partner_en TEXT CHECK(prices_partner_en IN ('price1', 'price2', 'price3', 'price4', 'price5')),
    prices_unit_price TEXT,
    prices_amount_currency_id INTEGER,
    prices_online INTEGER NOT NULL DEFAULT 1,
    prices_createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (prices_business_id) REFERENCES business(business_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (prices_products_id) REFERENCES products(products_id) 
      ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';
  static const String unitsTbl = '''
  CREATE TABLE units (
    units_id INTEGER PRIMARY KEY,
    units_business_id INTEGER,
    units_name TEXT,
    units_conversion_factor Text,
    units_group TEXT,
    units_group_en TEXT NOT NULL,
    units_symbol TEXT,
    units_is_base_unit INTEGER DEFAULT 0,
    units_online INTEGER NOT NULL DEFAULT 1,
    units_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (units_business_id) REFERENCES business(business_id)
      ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';

  static const String placesTbl = '''
  CREATE TABLE places (
    places_id INTEGER PRIMARY KEY,
    places_buildings_id INTEGER NOT NULL,
    places_floor_number INTEGER NOT NULL DEFAULT 1,
    places_room_number TEXT,
    places_shelves_alphabet TEXT,
    places_createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (places_buildings_id) REFERENCES buildings(buildings_id) 
      ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';

  static const String partnersTbl = '''
  CREATE TABLE IF NOT EXISTS partners (
    partners_id INTEGER PRIMARY KEY,
    partners_business_id INTEGER NOT NULL,
    partners_users_id INTEGER DEFAULT NULL,
    partners_type TEXT CHECK(partners_type IN ('individual', 'entity')) DEFAULT NULL,
    partners_name TEXT NOT NULL,
    partners_email TEXT DEFAULT NULL,
    partners_phone TEXT DEFAULT NULL,
    partners_ownership_percentage REAL,
    partners_capital_contribution REAL DEFAULT NULL,
    partners_date_joined DATE,
    partners_role TEXT DEFAULT NULL,
    partners_notes TEXT DEFAULT NULL,
    partners_created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    partners_updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (partners_business_id) REFERENCES business(business_id)
      ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';

  static const String buildingsTbl = '''
  CREATE TABLE buildings (
    buildings_id INTEGER PRIMARY KEY,
    buildings_business_id INTEGER NOT NULL,
    buildings_type TEXT CHECK(buildings_type IN ('shop', 'warehouse')) NOT NULL,
    buildings_name TEXT NOT NULL,
    buildings_latitude TEXT,
    buildings_longitude TEXT,
    FOREIGN KEY (buildings_business_id) REFERENCES business(business_id)
      ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';

  static const String clientsTbl = '''
  CREATE TABLE clients (
    clients_id INTEGER PRIMARY KEY,
    clients_business_id INTEGER NOT NULL,
    clients_name TEXT NOT NULL,
    clients_type TEXT CHECK(clients_type IN ('importer', 'customer','partner')) NOT NULL,
    clients_email TEXT,
    clients_phone_number INTEGER,
    clients_address TEXT,
    clients_online INTEGER DEFAULT 1,
    clients_createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (clients_business_id) REFERENCES business(business_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE(clients_name, clients_business_id)
  )
  ''';

  static const String batchesTable = '''
  CREATE TABLE batches (
    batches_id INTEGER PRIMARY KEY,
    batches_products_id INTEGER NOT NULL,
    batches_invoices_id INTEGER,
    places_id INTEGER,
    batches_active INTEGER NOT NULL DEFAULT 1,
    batches_products_prices_id INTEGER NOT NULL DEFAULT 0,
    batches_product_unit_cost REAL,
    batches_products_buy_price INTEGER,
    batches_expiration_date TIMESTAMP NULL DEFAULT NULL,
    batches_products_total_count REAL NOT NULL DEFAULT 1,
    batches_products_remaining_count REAL NOT NULL DEFAULT 1,
    batches_count_unit_id INTEGER DEFAULT NULL,
    batches_products_currency_id INTEGER NOT NULL,
    batches_importers_id INTEGER,
    batches_createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (batches_products_id) REFERENCES products(products_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (batches_invoices_id) REFERENCES invoices(invoices_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (places_id) REFERENCES places(places_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (batches_count_unit_id) REFERENCES units(units_id) 
      ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';

  static const String debtsTbl = '''
  CREATE TABLE IF NOT EXISTS debts (
    debts_id INTEGER PRIMARY KEY,
    debts_business_id INTEGER NOT NULL,
    debts_invoices_id INTEGER DEFAULT NULL,
    debts_clients_id INTEGER DEFAULT NULL,
    debts_amount_currency_id INTEGER DEFAULT NULL,
    debts_employees_id INTEGER DEFAULT NULL,
    debts_person_name TEXT DEFAULT NULL,
    debts_person_name_type TEXT CHECK(debts_person_name_type IN ('Debit', 'Credit')) DEFAULT NULL,
    debts_state TEXT CHECK(debts_state IN ('paid', 'unpaid', 'partial', 'dead')) NOT NULL,
    debts_total_amount TEXT NOT NULL,
    debts_paid_amount TEXT NOT NULL DEFAULT 0,
    debts_total_amount_in_base TEXT,
    debts_paid_amount_in_base TEXT,
    debts_due_date DATE,
    debts_created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    debts_updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (debts_business_id) REFERENCES business(business_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (debts_invoices_id) REFERENCES invoices(invoices_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (debts_clients_id) REFERENCES clients(clients_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (debts_amount_currency_id) REFERENCES business_currency(business_currency_id) 
      ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';

  static const String invoicesTbl = '''
  CREATE TABLE IF NOT EXISTS invoices (
    invoices_id INTEGER PRIMARY KEY,
    invoices_number TEXT DEFAULT NULL,
    invoices_business_id INTEGER NOT NULL,
    invoices_client_id INTEGER DEFAULT NULL,
    invoices_partner_id INTEGER DEFAULT NULL,
    invoices_amount_currency_id INTEGER DEFAULT NULL,
    invoices_type TEXT CHECK(invoices_type IN ('sell', 'buy', 'buyRefund', 'sellRefund')) NOT NULL,
    invoices_undiscounted_amount TEXT NOT NULL,
    invoices_discounted_amount TEXT NOT NULL,
    invoices_discount_value TEXT DEFAULT NULL,
    invoices_discount_type TEXT DEFAULT NULL,
    invoices_total_tax_amount TEXT NOT NULL DEFAULT 0,
    invoices_shipping_cost TEXT NOT NULL DEFAULT 0,
    invoices_shipping_cost_in_base TEXT,
    invoices_shipping_client_id INTEGER DEFAULT NULL,
    invoices_shipping_currency_id INTEGER DEFAULT NULL,
    invoices_shipping_payment TEXT DEFAULT NULL,
    invoices_payment_status TEXT CHECK(invoices_payment_status IN ('unpaid', 'partial', 'paid')) NOT NULL DEFAULT 'paid',
    invoices_paid_amount TEXT NOT NULL DEFAULT 0,
    invoices_notes TEXT DEFAULT NULL,
    invoices_created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    invoices_original_invoice_id INTEGER DEFAULT NULL,
    invoices_refunded_amount TEXT DEFAULT 0,
    invoices_affect_refund INTEGER NOT NULL DEFAULT 0,
    invoices_applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    invoices_original_invoice_number TEXT DEFAULT NULL,
    invoices_amount_in_base TEXT,
    debts_paid_amount_currency_id INTEGER DEFAULT NULL,
    FOREIGN KEY (invoices_business_id) REFERENCES business(business_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (invoices_client_id) REFERENCES clients(clients_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (invoices_amount_currency_id) REFERENCES business_currency(business_currency_id) 
      ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';

  static const String sellItemTbl = '''
  CREATE TABLE IF NOT EXISTS sell_item (
    sell_item_id INTEGER PRIMARY KEY,
    sell_item_products_id INTEGER NOT NULL,
    sell_item_product_count REAL NOT NULL,
    sell_item_product_tax_amount REAL NOT NULL,
    sell_item_edited_price TEXT,
    sell_item_edited_price_partner_en TEXT,
    sell_item_currency_id INTEGER NOT NULL,
    sell_item_prices_id INTEGER,
    sell_item_product_count_unit_id INTEGER NOT NULL,
    sell_item_product_conversion Text NOT NULL DEFAULT 1,
    sell_item_places_id INTEGER,
    sell_item_invoices_id INTEGER NOT NULL,
    sell_item_created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sell_item_products_id) REFERENCES products(products_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (sell_item_places_id) REFERENCES places(places_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (sell_item_invoices_id) REFERENCES invoices(invoices_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (sell_item_product_count_unit_id) REFERENCES units(units_id) 
      ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';
  static const String taxesTbl = '''
  CREATE TABLE IF NOT EXISTS taxes (
    taxes_id INTEGER PRIMARY KEY,
    taxes_business_id INTEGER NOT NULL,
    taxes_name TEXT NOT NULL,
    taxes_description TEXT,
    taxes_rate TEXT NOT NULL,
    taxes_type TEXT CHECK(taxes_type IN ('vat', 'luxury', 'other')) NOT NULL,
    taxes_is_active BOOLEAN DEFAULT 1,
    taxes_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    taxes_updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (taxes_business_id) REFERENCES business(business_id) 
  )
  ''';

  static const String productTaxesTbl = '''
  CREATE TABLE IF NOT EXISTS product_taxes (
    product_taxes_id INTEGER PRIMARY KEY,
    product_taxes_product_id INTEGER NOT NULL,
    product_taxes_tax_id INTEGER NOT NULL,
    product_taxes_order INTEGER NOT NULL DEFAULT 1,
    product_taxes_application_level TEXT 
      CHECK(product_taxes_application_level IN ('sell', 'buy', 'both')) NOT NULL DEFAULT 'both',
    product_taxes_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_taxes_product_id) REFERENCES products(products_id), 
    FOREIGN KEY (product_taxes_tax_id) REFERENCES taxes(taxes_id) 
  )
  ''';

  static const String currenciesTbl = '''
  CREATE TABLE IF NOT EXISTS currencies (
    currencies_id INTEGER PRIMARY KEY AUTOINCREMENT,
    currencies_code TEXT UNIQUE NOT NULL,
    currencies_code_ar TEXT NOT NULL,
    currencies_symbol TEXT,
    currencies_name_en TEXT,
    currencies_name_ar TEXT,
    currencies_exchange_rate_to_dollar TEXT,
    currencies_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
''';

  static const String businessCurrencyTbl = '''
  CREATE TABLE IF NOT EXISTS business_currency (
    business_currency_id INTEGER PRIMARY KEY AUTOINCREMENT,
    business_currency_business_id INTEGER NOT NULL,
    business_currency_currencies_id INTEGER NOT NULL,
    business_currency_near_factor INTEGER NOT NULL,
    business_currency_is_base INTEGER NOT NULL DEFAULT 0,
    business_currency_manual_exchange TEXT,
    business_currency_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    business_currency_online INTEGER DEFAULT 1,
    FOREIGN KEY (business_currency_business_id) REFERENCES business(business_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (business_currency_currencies_id) REFERENCES currencies(currencies_id)
      ON DELETE CASCADE ON UPDATE CASCADE
  )
  ''';
}
