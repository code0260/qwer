import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_buildings.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_places.dart';
import 'package:almonazim/data/data%20source/locale/store_default_building.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/place%20repo/place_repo.dart';
import 'package:almonazim/data/model/place%20models/building_model.dart';
import 'package:almonazim/data/model/place%20models/floor_model.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/place%20models/room_model.dart';
import 'package:almonazim/data/model/place%20models/shelve_model.dart';
import 'package:dartz/dartz.dart';

class PlaceRepoImpl implements PlaceRepo {
  final ApiService apiService;

  PlaceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<BuildingModel>>> getBuildings() async {
    if (placesModel.buildings.isEmpty) {
      final result = await apiService.get(
        url: AppLinks.getBuildingsLink,
      );

      return result.fold(
        (failure) => left(failure),
        (response) {
          final List<BuildingModel> buildings = response["data"]
              .map<BuildingModel>(
                  (building) => BuildingModel.fromJson(building))
              .toList();

          placesModel.buildings.clear();
          placesModel.buildings.addAll(buildings);
          return right(buildings);
        },
      );
    } else {
      return right(placesModel.buildings);
    }
  }

  @override
  Future<Either<Failure, void>> getBuildingsAndPlaces() async {
    final result = await apiService.get(
      url: AppLinks.getBuildingsAndPlacesLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) async {
        //& buildings & places
        List<int> buildingIds = [];
        List<int> placeIds = [];

        for (final item in response["data"]) {
          buildingIds.add(item['buildings_id']);
          placeIds.add(item['places_id']);
          await StoreBuildings.updateBuildingData(
              BuildingModel.fromJson(item).toMap());
          await StorePlaces.updatePlaceData(PlaceModel.fromJson(item).toMap());
        }
        await StoreBuildings.deleteBuildingsViaIdList(buildingIds);
        await StorePlaces.deletePlacesViaIdList(placeIds);
        if (buildingIds.length == 1) {
          StoreDefaultBuilding.setDefaultBuilding(
              InvoiceType.sell.name, buildingIds[0].toString());
          StoreDefaultBuilding.setDefaultBuilding(
              InvoiceType.buy.name, buildingIds[0].toString());
        }

        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, List<FloorModel>>> getFloors(
      PlaceModel placeModel) async {
    final requestData = {
      "buildings_id": placeModel.placesBuildingsId,
    };

    final result = await apiService.post(
      url: AppLinks.getFloorsLink,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        final List<FloorModel> floors = response["data"]
            .map<FloorModel>((floor) => FloorModel.fromJson(floor))
            .toList();

        placesModel.floors.clear();
        placesModel.floors.addAll(floors);
        return right(floors);
      },
    );
  }

  @override
  Future<Either<Failure, List<RoomModel>>> getRooms(
      PlaceModel placeModel) async {
    final requestData = {
      "floor_number": placeModel.placesFloorNumber,
      "buildings_id": placeModel.placesBuildingsId,
    };

    final result = await apiService.post(
      url: AppLinks.getRoomsLink,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        final List<RoomModel> rooms = response["data"]
            .map<RoomModel>((room) => RoomModel.fromJson(room))
            .toList();

        placesModel.rooms.clear();
        placesModel.rooms.addAll(rooms);
        return right(rooms);
      },
    );
  }

  @override
  Future<Either<Failure, List<ShelveModel>>> getShelves(
      PlaceModel placeModel) async {
    final requestData = {
      "room_name": placeModel.placesRoomName,
      "floor_number": placeModel.placesFloorNumber,
      "buildings_id": placeModel.placesBuildingsId,
    };

    final result = await apiService.post(
      url: AppLinks.getShelvesLink,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        final List<ShelveModel> shelves = response["data"]
            .map<ShelveModel>((shelve) => ShelveModel.fromJson(shelve))
            .toList();

        placesModel.shelves.clear();
        placesModel.shelves.addAll(shelves);
        return right(shelves);
      },
    );
  }

  @override
  Future<Either<Failure, int>> getPlaceId(PlaceModel placeModel) async {
    final result = await apiService.post(
      url: AppLinks.getPlaceIdLink,
      formDataIsEnabled: false,
      data: placeModel.toJson(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) => right(response["data"][0]["places_id"]),
    );
  }

  @override
  Future<Either<Failure, int>> addPlace(PlaceModel placeModel) async {
    final result = await apiService.post(
      url: AppLinks.addPlaceLink,
      formDataIsEnabled: false,
      data: placeModel.toJson(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) => right((response["data"]! as String).toInt()),
    );
  }

  @override
  Future<Either<Failure, void>> importBuildings(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importBuildingsLink,
        requestName: "buildings_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("6");
        return right(null);
      },
    );
  }
}
