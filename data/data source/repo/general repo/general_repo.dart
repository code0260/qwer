import 'package:almonazim/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class GeneralRepo {
  Future<Either<Failure, void>> getOfflineData();
  Future<Either<Failure, String>> getLatestVersion();
  Future<Either<Failure, void>> doneImportData();
}
