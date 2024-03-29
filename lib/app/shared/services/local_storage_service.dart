import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rock_n_roll_forecast/app/shared/helpers/print_helper.dart';
import 'package:rock_n_roll_forecast/app/shared/helpers/text_helper.dart';
import 'package:rock_n_roll_forecast/app/shared/services/hive_service.dart';

import '../errors/exceptions.dart';
import '../errors/failure.dart';
import '../utilities/constants.dart';

abstract class LocalStorageService {
  Future<void> cacheRequest(
    String boxName,
    dynamic data,
    String? city,
  );
  Future<dynamic> getRequest(
    String boxName,
    String? city,
  );
}

class LocalStorageServiceImpl implements LocalStorageService {
  final HiveService hiveService;
  const LocalStorageServiceImpl(this.hiveService);

  @override
  Future<void> cacheRequest(
    String boxName,
    dynamic data,
    String? city,
  ) async {
    final storage = await hiveService.openBox(boxName);

    try {
      debugPrint("Storing weathers for offline...");
      storage.put(city, data);
      debugPrint("Weathers stored in offline cache!");
    } on HiveError catch (e) {
      debugPrint("Hive error occurred: $e");
      throw HiveException(Failure(e.toString()));
    } on CacheException catch (e) {
      debugPrint("Cache error occurred: $e");
      rethrow;
    } on Exception catch (e) {
      debugPrint("Unexpected error occurred: $e");
      throw UnexpectedException(Failure(e.toString()));
    } finally {
      try {
        await storage.close();
        debugPrint("Forecasts box closed!");
      } catch (e) {
        debugPrint("Error closing weathers box: $e");
      }
    }
  }

  @override
  Future<dynamic> getRequest(
    String boxName,
    String? city,
  ) async {
    final storage = await hiveService.openBox(boxName);

    try {
      final hasLocation = storage.containsKey(city);

      if (hasLocation) {
        securePrint("Gathering resources...");
        final response = await storage.get(city);
        debugPrint("Response from service - $response");
        return response;
      } else {
        debugPrint("$city's $boxName are not found offline!");
        throw CacheException(Failure(Constants.offlineError));
      }
    } on HiveError catch (e) {
      debugPrint("Hive error occurred: $e");
      throw HiveException(Failure(e.toString()));
    } on CacheException catch (e) {
      debugPrint("Cache error occurred: $e");
      rethrow;
    } on Exception catch (e) {
      debugPrint("Unexpected error occurred: $e");
      throw UnexpectedException(Failure(e.toString()));
    } finally {
      try {
        await storage.close();
        debugPrint("${TextHelper.capitalizeLetter(boxName)} box closed!");
      } catch (e) {
        debugPrint("Error closing $boxName box: $e");
      }
    }
  }
}
