class NetworkConstant {
  static const _IP = '192.168.1.164';
  static const _PORT = '3001';
  static const BASE_URL = 'http://${_IP}:${_PORT}/api/v1/';
  static const SIGN_UP = '${BASE_URL}auth/email/register';
  static const SIGN_IN = '${BASE_URL}auth/email/login';
  static String routingUrl(String polylines) =>
      'https://router.project-osrm.org/route/v1/driving/polyline($polylines)?steps=true';
  static const TOKENS = '${BASE_URL}auth/refresh';
}
