String getPaymentState(String state) {
  if (state == "paid") {
    return "مدفوع";
  } else if (state == "unpaid") {
    return "غير مدفوع";
  } else {
    return "مدفوع جزئياً";
  }
}
