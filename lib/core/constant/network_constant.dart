class ServerNetworkConstant {
  static const _IP = '192.168.1.134';
  static const _PORT = '3000';
  static const _VER = 'v1';
  static const BASE_HTTP_URL = 'http://${_IP}:${_PORT}/api/${_VER}/';
  static const SIGN_UP = '${BASE_HTTP_URL}auth/email/register';
  static const SIGN_IN = '${BASE_HTTP_URL}auth/email/login';
  static String routingUrl(String polylines) =>
      'https://router.project-osrm.org/route/v1/driving/polyline($polylines)?steps=true';
  static const TOKENS = '${BASE_HTTP_URL}auth/refresh';
  static const DEVICES_SCAN = '${BASE_HTTP_URL}devices/scan';
  static const BASE_SOCKET_URL = 'ws://${_IP}:${_PORT}';
}

class AdminNetworkConstant {}
