import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/report%20models/sells%20reports%20models/sell_graph_model.dart';
import 'package:almonazim/data/model/sells%20models/sells_info_input_model.dart';
import 'package:dartz/dartz.dart';

abstract class SalesReportRepo {
  Future<Either<Failure, List<SellsGraphModel>>> getSellsGraph(
      SellsInfoInputModel sellsInfoInputModel);
}
