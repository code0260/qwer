class InvoicePdfSettingsModel {
  final bool
      showTotalBalanceForClient; // Show client's total balance at the end
  final bool showSignatureArea; // Reserve space for a signature
  final bool showCompanyLogo; // Include logo at top
  final bool showTitle; // Include logo at top
  final bool showClientDetails; // Show client's details (name, phone, etc.)
  final bool showProductUnits; // Display product units (e.g., KG, PCS)
  final bool showProductCodes; // Show product IDs or barcodes
  final bool showInvoiceNotes; // Display invoice notes or payment terms
  final bool showDateTime; // Show invoice date & time in the header or footer
  final bool showCreatorName; // Indicate who created the invoice
  final String?
      customTitle; // Allow custom invoice title (e.g., "Delivery Note")
  final String? footerNote; // Add a footer note such as "Thank you!"
  final String?
      currencySymbol; // Optionally override the default currency symbol

  // Additional settings for more fine-tuning:
  final String pageOrientation; // "portrait" or "landscape"
  final double fontSize; // Base font size (in points)
  final Map<String, double>
      pageMargins; // Margins: keys: top, bottom, left, right
  final String
      headerBackgroundColor; // e.g., "FF003366" (ARGB or hex without '#' prefix)
  final String? customHeader; // Additional custom header text
  final String? customFooter; // Additional custom footer text

  const InvoicePdfSettingsModel({
    this.showTotalBalanceForClient = true,
    this.showSignatureArea = true,
    this.showCompanyLogo = true,
    this.showClientDetails = true,
    this.showTitle = true,
    this.showProductUnits = true,
    this.showProductCodes = false,
    this.showInvoiceNotes = true,
    this.showDateTime = true,
    this.showCreatorName = true,
    this.customTitle,
    this.footerNote,
    this.currencySymbol,
    this.pageOrientation = "portrait",
    this.fontSize = 10.0,
    this.pageMargins = const {
      "top": 20.0,
      "bottom": 20.0,
      "left": 15.0,
      "right": 15.0
    },
    this.headerBackgroundColor = "FF003366",
    this.customHeader,
    this.customFooter,
  });

  factory InvoicePdfSettingsModel.fromJson(Map<String, dynamic> json) {
    return InvoicePdfSettingsModel(
      showTotalBalanceForClient: json['showTotalBalanceForClient'] ?? true,
      showSignatureArea: json['showSignatureArea'] ?? true,
      showCompanyLogo: json['showCompanyLogo'] ?? true,
      showTitle: json['showTitle'] ?? true,
      showClientDetails: json['showClientDetails'] ?? true,
      showProductUnits: json['showProductUnits'] ?? true,
      showProductCodes: json['showProductCodes'] ?? false,
      showInvoiceNotes: json['showInvoiceNotes'] ?? true,
      showDateTime: json['showDateTime'] ?? true,
      showCreatorName: json['showCreatorName'] ?? true,
      customTitle: json['customTitle'],
      footerNote: json['footerNote'],
      currencySymbol: json['currencySymbol'],
      pageOrientation: json['pageOrientation'] ?? "portrait",
      fontSize: (json['fontSize'] ?? 10.0).toDouble(),
      pageMargins: json['pageMargins'] != null
          ? Map<String, double>.from(json['pageMargins'])
          : const {"top": 20.0, "bottom": 20.0, "left": 15.0, "right": 15.0},
      headerBackgroundColor: json['headerBackgroundColor'] ?? "FF003366",
      customHeader: json['customHeader'],
      customFooter: json['customFooter'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showTotalBalanceForClient': showTotalBalanceForClient,
      'showSignatureArea': showSignatureArea,
      'showCompanyLogo': showCompanyLogo,
      'showTitle': showTitle,
      'showClientDetails': showClientDetails,
      'showProductUnits': showProductUnits,
      'showProductCodes': showProductCodes,
      'showInvoiceNotes': showInvoiceNotes,
      'showDateTime': showDateTime,
      'showCreatorName': showCreatorName,
      'customTitle': customTitle,
      'footerNote': footerNote,
      'currencySymbol': currencySymbol,
      'pageOrientation': pageOrientation,
      'fontSize': fontSize,
      'pageMargins': pageMargins,
      'headerBackgroundColor': headerBackgroundColor,
      'customHeader': customHeader,
      'customFooter': customFooter,
    };
  }

  InvoicePdfSettingsModel copyWith({
    bool? showTotalBalanceForClient,
    bool? showSignatureArea,
    bool? showCompanyLogo,
    bool? showClientDetails,
    bool? showProductUnits,
    bool? showProductCodes,
    bool? showInvoiceNotes,
    bool? showDateTime,
    bool? showTitle,
    bool? showCreatorName,
    String? customTitle,
    String? footerNote,
    String? currencySymbol,
    String? pageOrientation,
    double? fontSize,
    Map<String, double>? pageMargins,
    String? headerBackgroundColor,
    String? customHeader,
    String? customFooter,
  }) {
    return InvoicePdfSettingsModel(
      showTotalBalanceForClient:
          showTotalBalanceForClient ?? this.showTotalBalanceForClient,
      showSignatureArea: showSignatureArea ?? this.showSignatureArea,
      showCompanyLogo: showCompanyLogo ?? this.showCompanyLogo,
      showTitle: showTitle ?? this.showTitle,
      showClientDetails: showClientDetails ?? this.showClientDetails,
      showProductUnits: showProductUnits ?? this.showProductUnits,
      showProductCodes: showProductCodes ?? this.showProductCodes,
      showInvoiceNotes: showInvoiceNotes ?? this.showInvoiceNotes,
      showDateTime: showDateTime ?? this.showDateTime,
      showCreatorName: showCreatorName ?? this.showCreatorName,
      customTitle: customTitle ?? this.customTitle,
      footerNote: footerNote ?? this.footerNote,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      pageOrientation: pageOrientation ?? this.pageOrientation,
      fontSize: fontSize ?? this.fontSize,
      pageMargins: pageMargins ?? this.pageMargins,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      customHeader: customHeader ?? this.customHeader,
      customFooter: customFooter ?? this.customFooter,
    );
  }
}
