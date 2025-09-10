String translateToArabicSalaryCycle(String salaryCycle) {
  switch (salaryCycle) {
    case 'annually':
      return 'سنوياً';
    case 'monthly':
      return 'شهرياً';
    case 'weekly':
      return 'أسبوعياً';
    case 'daily':
      return 'يومياً';
    case 'hourly':
      return 'ساعياً';
    default:
      return 'غير معروف';
  }
}

String translateToEnglishSalaryCycle(String salaryCycle) {
  switch (salaryCycle) {
    case 'سنوياً':
      return 'annually';
    case 'شهرياً':
      return 'monthly';
    case 'أسبوعياً':
      return 'weekly';
    case 'يومياً':
      return 'daily';
    case 'ساعياً':
      return 'hourly';
    default:
      return 'unknown';
  }
}
