import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';
import '../entities/forecast_entity.dart';

abstract class ForecastRepository {
  Future<Either<Failure, List<ForecastEntity>>> getForecast(String city);
}
