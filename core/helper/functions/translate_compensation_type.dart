String translateToArabicCompensationType(String compensationType) {
  switch (compensationType) {
    case 'bonuses':
      return 'مكافأة';
    case 'deductions':
      return 'خصم';
    default:
      return 'غير معروف';
  }
}

String translateToEnglishCompensationType(String compensationType) {
  switch (compensationType) {
    case 'مكافأة':
      return 'bonuses';
    case 'خصم':
      return 'deductions';
    default:
      return 'غير معروف';
  }
}
