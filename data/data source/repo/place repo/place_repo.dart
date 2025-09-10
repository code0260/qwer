import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/place%20models/building_model.dart';
import 'package:almonazim/data/model/place%20models/floor_model.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/place%20models/room_model.dart';
import 'package:almonazim/data/model/place%20models/shelve_model.dart';

abstract class PlaceRepo {
  Future<Either<Failure, int>> addPlace(PlaceModel placeModel);
  Future<Either<Failure, int>> getPlaceId(PlaceModel placeModel);
  Future<Either<Failure, List<BuildingModel>>> getBuildings();
  Future<Either<Failure, List<FloorModel>>> getFloors(PlaceModel placeModel);
  Future<Either<Failure, void>> getBuildingsAndPlaces();

  Future<Either<Failure, List<RoomModel>>> getRooms(PlaceModel placeModel);
  Future<Either<Failure, List<ShelveModel>>> getShelves(PlaceModel placeModel);
  Future<Either<Failure, void>> importBuildings(String filePath);
}
