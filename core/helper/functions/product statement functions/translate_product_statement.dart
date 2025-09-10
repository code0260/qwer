String translateToArProductDealTypeFromString(String dealType) {
  switch (dealType) {
    case 'sell':
      return 'بيع';
    case 'buy':
      return 'شراء';
    case 'sellRefund':
      return 'مرتجع بيع';
    case 'buyRefund':
      return 'مرتجع شراء';
    case 'inventoryAdjustment':
      return 'تسوية جردية';
    case 'transferOut':
      return 'نقل صادر';
    case 'transferIn':
      return 'نقل وارد';
    case 'opening':
      return 'أولي';
    default:
      return dealType; // Fallback
  }
}
