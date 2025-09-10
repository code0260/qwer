String? translateToEnPaymentState(String state) {
  if (state == 'غير مدفوع') {
    return "unpaid";
  } else if (state == 'مدفوع جزئياً') {
    return "partial";
  } else if (state == "مدفوع") {
    return "paid";
  } else {
    return null;
  }
}

String? translateToArPaymentState(String? state) {
  if (state == "unpaid") {
    return 'غير مدفوع';
  } else if (state == "partial") {
    return 'مدفوع جزئياً';
  } else if (state == "paid") {
    return "مدفوع";
  } else {
    return null;
  }
}
