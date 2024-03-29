part of cloud_firestore_rest;

class _Util {
  static dateTimeToJson(DateTime? dateTime) =>
      dateTime?.toUtc().toIso8601String();

  static dateTimeFromJson(String? json) =>
      json != null ? DateTime.parse(json) : null;

  /// Encode
  /// Create a geohash from latitude and longitude
  /// that is 'number of chars' long
  static String encode(
    var latitude,
    var longitude, {
    int numberOfChars = 9,
    bool auto = false,
  }) {
    assert(latitude is double || latitude is String);
    assert(longitude is double || longitude is String);
    if (auto) {
      assert(
        latitude is String && longitude is String,
        'string notation required for auto precision.',
      );
      int decSigFigsLat = latitude.split('.')[1].length;
      int decSigFigsLon = longitude.split('.')[1].length;
      int numberOfSigFigs = max(decSigFigsLat, decSigFigsLon);

      final sigfigHashLength = [0, 5, 7, 8, 11, 12, 13, 15, 16, 17, 18];
      numberOfChars = sigfigHashLength[numberOfSigFigs];
    }

    var chars = [], bits = 0, bitsTotal = 0, hashValue = 0;
    double maxLat = 90, minLat = -90, maxLon = 180, minLon = -180, mid;

    while (chars.length < numberOfChars) {
      if (bitsTotal % 2 == 0) {
        mid = (maxLon + minLon) / 2;
        if (longitude > mid) {
          hashValue = (hashValue << 1) + 1;
          minLon = mid;
        } else {
          hashValue = (hashValue << 1) + 0;
          maxLon = mid;
        }
      } else {
        mid = (maxLat + minLat) / 2;
        if (latitude > mid) {
          hashValue = (hashValue << 1) + 1;
          minLat = mid;
        } else {
          hashValue = (hashValue << 1) + 0;
          maxLat = mid;
        }
      }

      bits++;
      bitsTotal++;
      if (bits == 5) {
        final base32Codes = '0123456789bcdefghjkmnpqrstuvwxyz';
        var code = base32Codes[hashValue];
        chars.add(code);
        bits = 0;
        hashValue = 0;
      }
    }

    return chars.join();
  }

  ///
  /// Decode Bounding box
  ///
  /// Decode a hashString into a bound box that matches it.
  /// Data returned in a List [minLat, minLon, maxLat, maxLon]
  static List<double> decodeBbox(String hashString) {
    var isLon = true;
    double maxLat = 90, minLat = -90, maxLon = 180, minLon = -180, mid;

    int? hashValue = 0;
    for (var i = 0, l = hashString.length; i < l; i++) {
      var code = hashString[i].toLowerCase();
      final base32Codes = '0123456789bcdefghjkmnpqrstuvwxyz';
      Map<String, int> base32CodesDic = new Map();
      for (var i = 0; i < base32Codes.length; i++) {
        base32CodesDic.putIfAbsent(base32Codes[i], () => i);
      }
      hashValue = base32CodesDic[code];

      for (var bits = 4; bits >= 0; bits--) {
        var bit = (hashValue! >> bits) & 1;
        if (isLon) {
          mid = (maxLon + minLon) / 2;
          if (bit == 1) {
            minLon = mid;
          } else {
            maxLon = mid;
          }
        } else {
          mid = (maxLat + minLat) / 2;
          if (bit == 1) {
            minLat = mid;
          } else {
            maxLat = mid;
          }
        }
        isLon = !isLon;
      }
    }
    return [minLat, minLon, maxLat, maxLon];
  }

  ///
  /// Decode a [hashString] into a pair of latitude and longitude.
  /// A map is returned with keys 'latitude', 'longitude','latitudeError','longitudeError'
  static Map<String, double> decode(String hashString) {
    List<double> bbox = decodeBbox(hashString);
    double lat = (bbox[0] + bbox[2]) / 2;
    double lon = (bbox[1] + bbox[3]) / 2;
    double latErr = bbox[2] - lat;
    double lonErr = bbox[3] - lon;
    return {
      'latitude': lat,
      'longitude': lon,
      'latitudeError': latErr,
      'longitudeError': lonErr,
    };
  }

  ///
  /// Neighbor
  ///
  /// Find neighbor of a geohash string in certain direction.
  /// Direction is a two-element array, i.e. [1,0] means north, [-1,-1] means southwest.
  ///
  /// direction [lat, lon], i.e.
  /// [1,0] - north
  /// [1,1] - northeast
  static String neighbor(String hashString, var direction) {
    var lonLat = decode(hashString);
    var neighborLat =
        lonLat['latitude']! + direction[0] * lonLat['latitudeError'] * 2;
    var neighborLon =
        lonLat['longitude']! + direction[1] * lonLat['longitudeError'] * 2;
    return encode(neighborLat, neighborLon, numberOfChars: hashString.length);
  }

  ///
  /// Neighbors
  /// Returns all neighbors' hashstrings clockwise from north around to northwest
  /// 7 0 1
  /// 6 X 2
  /// 5 4 3
  static List<String> neighbors(String hashString) {
    int hashStringLength = hashString.length;
    var lonlat = decode(hashString);
    double? lat = lonlat['latitude'];
    double? lon = lonlat['longitude'];
    double latErr = lonlat['latitudeError']! * 2;
    double lonErr = lonlat['longitudeError']! * 2;

    var neighborLat, neighborLon;

    String encodeNeighbor(neighborLatDir, neighborLonDir) {
      neighborLat = lat! + neighborLatDir * latErr;
      neighborLon = lon! + neighborLonDir * lonErr;
      return encode(neighborLat, neighborLon, numberOfChars: hashStringLength);
    }

    var neighborHashList = [
      encodeNeighbor(1, 0),
      encodeNeighbor(1, 1),
      encodeNeighbor(0, 1),
      encodeNeighbor(-1, 1),
      encodeNeighbor(-1, 0),
      encodeNeighbor(-1, -1),
      encodeNeighbor(0, -1),
      encodeNeighbor(1, -1)
    ];

    return neighborHashList;
  }

  static int setPrecision(double km) {
    /*
      * 1	≤ 5,000km	×	5,000km
      * 2	≤ 1,250km	×	625km
      * 3	≤ 156km	×	156km
      * 4	≤ 39.1km	×	19.5km
      * 5	≤ 4.89km	×	4.89km
      * 6	≤ 1.22km	×	0.61km
      * 7	≤ 153m	×	153m
      * 8	≤ 38.2m	×	19.1m
      * 9	≤ 4.77m	×	4.77m
      *
     */

    if (km <= 0.00477)
      return 9;
    else if (km <= 0.0382)
      return 8;
    else if (km <= 0.153)
      return 7;
    else if (km <= 1.22)
      return 6;
    else if (km <= 4.89)
      return 5;
    else if (km <= 39.1)
      return 4;
    else if (km <= 156)
      return 3;
    else if (km <= 1250)
      return 2;
    else
      return 1;
  }

  static const double MAX_SUPPORTED_RADIUS = 8587;

  // Length of a degree latitude at the equator
  static const double METERS_PER_DEGREE_LATITUDE = 110574;

  // The equatorial circumference of the earth in meters
  static const double EARTH_MERIDIONAL_CIRCUMFERENCE = 40007860;

  // The equatorial radius of the earth in meters
  static const double EARTH_EQ_RADIUS = 6378137;

  // The meridional radius of the earth in meters
  static const double EARTH_POLAR_RADIUS = 6357852.3;

  /* The following value assumes a polar radius of
     * r_p = 6356752.3
     * and an equatorial radius of
     * r_e = 6378137
     * The value is calculated as e2 == (r_e^2 - r_p^2)/(r_e^2)
     * Use exact value to avoid rounding errors
     */
  static const double EARTH_E2 = 0.00669447819799;

  // Cutoff for floating point calculations
  static const double EPSILON = 1e-12;

  static double calcDistance(GeoPoint point1, GeoPoint point2) {
    // Earth's mean radius in meters
    final double radius = (EARTH_EQ_RADIUS + EARTH_POLAR_RADIUS) / 2;
    double latDelta = (point1.latitude - point2.latitude).toRadians();
    double lonDelta = (point1.longitude - point2.longitude).toRadians();

    double a = (sin(latDelta / 2) * sin(latDelta / 2)) +
        (cos(point1.latitude.toRadians()) *
            cos(point2.latitude.toRadians()) *
            sin(lonDelta / 2) *
            sin(lonDelta / 2));
    double distance = radius * 2 * atan2(sqrt(a), sqrt(1 - a)) / 1000;
    return double.parse(distance.toStringAsFixed(3));
  }
}

extension RadianConversion on double {
  double toRadians() => this * (pi / 180);
}
