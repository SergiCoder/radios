import 'package:radio_stations/features/radio/domain/domain.dart';
import 'package:radio_stations/features/shared/domain/entitites/radio_station.dart';

/// Use case for retrieving all radio station list items
///
/// This use case is responsible for retrieving all radio station list items
/// from the local cache. It handles the business logic for fetching and error
/// handling during retrieval.
class GetRadioStationListUseCase {
  /// Creates a new instance of [GetRadioStationListUseCase]
  ///
  /// [radioStationRepository] is the repository used for retrieving radio
  /// station list items
  const GetRadioStationListUseCase({
    required RadioStationRepository radioStationRepository,
  }) : _radioStationRepository = radioStationRepository;

  /// The repository used for retrieving radio station list items
  final RadioStationRepository _radioStationRepository;

  /// Retrieves all radio station list items
  ///
  /// [filter] is an optional filter to apply to the results.
  /// Returns a list of [RadioStation] objects representing all stations in
  /// the local cache that match the filter criteria.
  ///
  /// Throws a [RadioStationDataFailure] if station retrieval fails
  Future<List<RadioStation>> execute([RadioStationFilter? filter]) async {
    try {
      return await _radioStationRepository.getAllStations(filter);
    } catch (e) {
      throw RadioStationDataFailure('Failed to get radio stations: $e');
    }
  }

  /// Gets the list of available countries
  ///
  /// Returns a sorted list of unique country names from all stations.
  /// Throws a [RadioStationDataFailure] if retrieval fails.
  Future<List<String>> getAvailableCountries() async {
    try {
      return await _radioStationRepository.getAvailableCountries();
    } catch (e) {
      throw RadioStationDataFailure('Failed to get available countries: $e');
    }
  }
}
