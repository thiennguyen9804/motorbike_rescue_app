class NetworkConstant {
  static const BASE_URL = 'http://192.168.1.65:8181/';
  static const SIGN_UP = '${BASE_URL}users/register';
  static const SIGN_IN = '${BASE_URL}auth/login';
  static String routingUrl(String polylines) =>
      'https://router.project-osrm.org/route/v1/driving/polyline($polylines)';
}
