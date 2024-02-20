class IpDetails {
  // late final String status;
  late final String country;
  // late final String countryCode;
  // late final String region;
  late final String regionName;
  late final String city;
  late final String zip;
  // late final double lat;
  // late final double lon;
  late final String timezone;
  late final String isp;
  // late final String org;
  // late final String as;
  late final String query;
  IpDetails({
    // required this.status,
    required this.country,
    // required this.countryCode,
    // required this.region,
    required this.regionName,
    required this.city,
    required this.zip,
    // required this.lat,
    // required this.lon,
    required this.timezone,
    required this.isp,
    // required this.org,
    // required this.as,
    required this.query,
  });

  IpDetails.fromJson(Map<String, dynamic> json) {
    // status = json['status'];
    country = json['country'] ?? '';
    // countryCode = json['countryCode'];
    // region = json['region'];
    regionName = json['regionName'] ?? '';
    city = json['city'] ?? '';
    zip = json['zip'] ?? '----';
    // lat = json['lat'];
    // lon = json['lon'];
    timezone = json['timezone'] ?? 'Unknown';
    isp = json['isp'] ?? 'Unknown';
    // org = json['org'];
    // as = json['as'];
    query = json['query'] ?? 'Not Available';
  }
}
