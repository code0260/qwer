import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/partner%20models/add_partner_model.dart';
import 'package:almonazim/data/model/partner%20models/partner_input_model.dart';
import 'package:almonazim/data/model/partner%20models/partner_model.dart';
import 'package:dartz/dartz.dart';

abstract class PartnerRepo {
  Future<Either<Failure, List<PartnerModel>>> getPartners();
  Future<Either<Failure, void>> editPartner(
      PartnerInputModel partnerInputModel);
  Future<Either<Failure, void>> importUsers(String filePath);
  Future<Either<Failure, void>> importPartners(String filePath);

  Future<Either<Failure, void>> addPartner(AddPartnerModel addPartnerModel);
}
