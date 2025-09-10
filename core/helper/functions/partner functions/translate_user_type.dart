String? translateToEnUserType(String userType) {
  switch (userType) {
    case "مشرف":
      return "admin";
    case "موظف":
      return "employee";
    default:
      return null;
  }
}

String? translateToArUserType(String userType) {
  switch (userType) {
    case "admin":
      return "مشرف";
    case "employee":
      return "موظف";
    default:
      return null;
  }
}
