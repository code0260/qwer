import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnClientType(ClientType? type) {
  switch (type) {
    case ClientType.importer:
      return "importer";
    case ClientType.customer:
      return "customer";
    default:
      return null;
  }
}

ClientType? translateClientTypeFromAr(String? type) {
  switch (type) {
    case 'مورد':
      return ClientType.importer;
    case 'زبون':
      return ClientType.customer;
    default:
      return null;
  }
}

String? translateToArClientType(ClientType? type) {
  switch (type) {
    case ClientType.importer:
      return "مورد";
    case ClientType.customer:
      return "زبون";
    default:
      return null;
  }
}

String? translateToEnClientTypeFromString(String? type) {
  switch (type) {
    case "مورد":
      return "importer";
    case "زبون":
      return "customer";
    default:
      return null;
  }
}

String? translateToArClientTypeFromString(String? type) {
  switch (type) {
    case "importer":
      return "مورد";
    case "customer":
      return "زبون";
    default:
      return null;
  }
}
