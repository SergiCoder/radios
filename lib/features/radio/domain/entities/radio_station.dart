import 'package:flutter/foundation.dart';
import 'package:radio_stations/core/utils/validators.dart';
import 'package:radio_stations/features/radio/domain/enums/radio_tag.dart';

/// Represents a radio station in the domain layer
///
/// This class encapsulates all the essential information about a radio station,
/// including its identification, streaming details, and metadata. It provides
/// validation to ensure data integrity and consistency.
///
/// The class is immutable and uses a factory constructor to ensure that only
/// valid instances can be created. All fields are required and validated
/// before the instance is created.
@immutable
class RadioStation {
  /// Private constructor to enforce creation through factory method
  ///
  /// All parameters are required to ensure a complete radio station entity.
  /// This constructor is private to enforce the use of the factory method
  /// which includes validation.
  const RadioStation._({
    required this.uuid,
    required this.name,
    required this.url,
    required this.homepage,
    required this.favicon,
    required this.tags,
    required this.language,
    required this.country,
    this.favorite = false,
  });

  /// Creates a new radio station with validation
  ///
  /// Returns null if any of the validation checks fail. This factory method
  /// ensures that only valid radio stations can be created.
  ///
  /// Parameters:
  /// - [uuid]: Unique identifier for the station
  /// - [name]: Display name of the station
  /// - [url]: Direct streaming URL
  /// - [homepage]: Station's website URL
  /// - [favicon]: URL to the station's icon
  /// - [tags]: List of categorization tags
  /// - [language]: Primary broadcast language
  /// - [country]: Country of operation
  /// - [favorite]: Whether this station is marked as a favorite
  static RadioStation? create({
    required String uuid,
    required String name,
    required String url,
    required String homepage,
    required String favicon,
    required List<RadioTag> tags,
    required String language,
    required String country,
    bool favorite = false,
  }) {
    final station = RadioStation._(
      uuid: uuid,
      name: name,
      url: url,
      homepage: homepage,
      favicon: favicon,
      tags: tags,
      language: language,
      country: country,
      favorite: favorite,
    );

    return station.isValid() ? station : null;
  }

  /// Unique identifier for the station
  ///
  /// Must be a valid UUID in the format: 8-4-4-4-12 hexadecimal digits.
  /// This identifier is used to uniquely identify the radio station
  /// across the application.
  final String uuid;

  /// Name of the radio station
  ///
  /// Cannot be empty and is used for display purposes.
  /// This is the primary identifier shown to users.
  final String name;

  /// Stream URL
  ///
  /// Direct URL to the station's audio stream. Must be a valid URL.
  /// This is the primary URL used for streaming the station's content.
  final String url;

  /// Station's website
  ///
  /// URL to the station's homepage. Must be a valid URL.
  /// This is the main website URL for the radio station.
  final String homepage;

  /// Station's favicon URL
  ///
  /// URL to the station's icon or logo. Must be a valid URL.
  /// This is used for displaying the station's visual identity.
  final String favicon;

  /// List of tags categorizing the station
  ///
  /// Used for filtering and categorization. Cannot be empty.
  /// These tags help users find stations based on their interests.
  final List<RadioTag> tags;

  /// Primary language of the station
  ///
  /// The main language used for broadcasting. Cannot be empty.
  /// This helps users find stations in their preferred language.
  final String language;

  /// Country where the station is based
  ///
  /// The country of operation. Cannot be empty.
  /// This helps users find stations from specific countries.
  final String country;

  /// Whether this station is marked as a favorite
  ///
  /// Indicates if the user has marked this station as a favorite.
  /// Defaults to false for new stations.
  final bool favorite;

  /// Validates all fields of the radio station
  ///
  /// Returns true if all validations pass, false otherwise.
  /// This method performs the following validations:
  /// - UUID format validation
  /// - URL format validation for stream URL
  /// - URL format validation for homepage (if not empty)
  /// - URL format validation for favicon (if not empty)
  bool validate() {
    // Validate UUID
    if (!Validators.isValidUuid(uuid)) {
      return false;
    }

    // Validate stream URL
    if (!Validators.isValidUrl(url)) {
      return false;
    }

    // Validate homepage URL if not empty
    if (homepage.isNotEmpty && !Validators.isValidUrl(homepage)) {
      return false;
    }

    // Validate favicon URL if not empty
    if (favicon.isNotEmpty && !Validators.isValidUrl(favicon)) {
      return false;
    }

    return true;
  }

  /// Checks if all fields are valid
  ///
  /// Returns true if the station passes all validation checks.
  /// This is a convenience method that calls [validate()].
  bool isValid() => validate();

  /// Compares this radio station with another object for equality
  ///
  /// Returns true if the other object is a [RadioStation] with identical
  /// field values. This ensures that two radio stations with the same
  /// properties are considered equal.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioStation &&
        other.uuid == uuid &&
        other.name == name &&
        other.url == url &&
        other.homepage == homepage &&
        other.favicon == favicon &&
        other.tags == tags &&
        other.language == language &&
        other.country == country &&
        other.favorite == favorite;
  }

  /// Generates a hash code for this radio station
  ///
  /// The hash code is based on all fields of the radio station.
  /// This ensures that equal objects have equal hash codes, which is
  /// important for proper functioning in collections like [Set] and [Map].
  @override
  int get hashCode {
    return Object.hash(
      uuid,
      name,
      url,
      homepage,
      favicon,
      Object.hashAll(tags),
      language,
      country,
      favorite,
    );
  }

  /// Returns a string representation of this radio station
  ///
  /// The string includes all fields of the radio station in a format
  /// suitable for debugging and logging purposes. This is particularly
  /// useful when printing radio stations to logs or during development.
  @override
  String toString() {
    return 'RadioStation('
        'uuid: $uuid, '
        'name: $name, '
        'url: $url, '
        'homepage: $homepage, '
        'favicon: $favicon, '
        'tags: $tags, '
        'language: $language, '
        'country: $country, '
        'favorite: $favorite)';
  }
}
