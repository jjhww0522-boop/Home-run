import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

/// Nominatim (OpenStreetMap) 기반 Geocoding 서비스
class GeocodingService {
  final Dio _dio;

  GeocodingService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'https://nominatim.openstreetmap.org',
              headers: {
                'User-Agent': 'HomeRunApp/1.0',
                'Accept-Language': 'ko',
              },
            ));

  /// 좌표로 주소 검색 (Reverse Geocoding)
  Future<AddressInfo?> getAddressFromCoordinates(LatLng position) async {
    try {
      final response = await _dio.get(
        '/reverse',
        queryParameters: {
          'format': 'json',
          'lat': position.latitude,
          'lon': position.longitude,
          'zoom': 18,
          'addressdetails': 1,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return AddressInfo.fromNominatim(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 주소로 좌표 검색 (Forward Geocoding)
  Future<List<SearchResult>> searchAddress(String query) async {
    try {
      final response = await _dio.get(
        '/search',
        queryParameters: {
          'format': 'json',
          'q': query,
          'countrycodes': 'kr',
          'limit': 10,
          'addressdetails': 1,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> results = response.data;
        return results.map((e) => SearchResult.fromNominatim(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

/// 주소 정보 모델
class AddressInfo {
  final String displayName;
  final String? city;
  final String? district;
  final String? neighbourhood;
  final String? road;
  final String? houseNumber;
  final LatLng position;

  AddressInfo({
    required this.displayName,
    this.city,
    this.district,
    this.neighbourhood,
    this.road,
    this.houseNumber,
    required this.position,
  });

  factory AddressInfo.fromNominatim(Map<String, dynamic> json) {
    final address = json['address'] as Map<String, dynamic>? ?? {};
    return AddressInfo(
      displayName: json['display_name'] ?? '',
      city: address['city'] ?? address['town'] ?? address['village'],
      district: address['city_district'] ??
          address['borough'] ??
          address['suburb'] ??
          address['county'],
      neighbourhood: address['neighbourhood'] ?? address['quarter'],
      road: address['road'],
      houseNumber: address['house_number'],
      position: LatLng(
        double.parse(json['lat'].toString()),
        double.parse(json['lon'].toString()),
      ),
    );
  }

  /// 간략한 주소 반환
  String get shortAddress {
    final parts = <String>[];
    if (city != null) parts.add(city!);
    if (district != null) parts.add(district!);
    if (neighbourhood != null) parts.add(neighbourhood!);
    return parts.join(' ');
  }
}

/// 검색 결과 모델
class SearchResult {
  final String displayName;
  final String type;
  final LatLng position;

  SearchResult({
    required this.displayName,
    required this.type,
    required this.position,
  });

  factory SearchResult.fromNominatim(Map<String, dynamic> json) {
    return SearchResult(
      displayName: json['display_name'] ?? '',
      type: json['type'] ?? '',
      position: LatLng(
        double.parse(json['lat'].toString()),
        double.parse(json['lon'].toString()),
      ),
    );
  }
}
