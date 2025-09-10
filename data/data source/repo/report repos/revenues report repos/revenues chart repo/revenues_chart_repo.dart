import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/report%20models/revenues%20report%20models/revenue_pie_chart_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:dartz/dartz.dart';

abstract class RevenuesChartRepo {
  Future<Either<Failure, List<RevenuePieChartModel>>> getRevenuePieChart(
      RevenueInputModel revenueInputModel);
}
