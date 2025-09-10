import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnPartnerType(PartnerType? type) {
  switch (type) {
    case PartnerType.individual:
      return "individual";
    case PartnerType.entity:
      return "entity";
    default:
      return null;
  }
}

String? translateToArPartnerType(PartnerType? type) {
  switch (type) {
    case PartnerType.individual:
      return "فرد";
    case PartnerType.entity:
      return "مؤسسة";
    default:
      return null;
  }
}

String? translateToEnPartnerTypeFromString(String? type) {
  switch (type) {
    case "فرد":
      return "individual";
    case "مؤسسة":
      return "entity";
    default:
      return null;
  }
}

String? translateToArPartnerTypeFromString(String? type) {
  switch (type) {
    case "individual":
      return "فرد";
    case "entity":
      return "مؤسسة";
    default:
      return null;
  }
}
