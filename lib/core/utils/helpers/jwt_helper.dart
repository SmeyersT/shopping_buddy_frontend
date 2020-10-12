import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:shopping_buddy_frontend/app/data/services/authentication_service.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';

class JWTHelper {
  final AuthenticationService _authenticationService =
  serviceLocator.get<AuthenticationService>();

  refreshJwtToken(String jwt) async {
    Map<String, dynamic> jsonPayload = _splitAndDecodeJWT(jwt);
    final int exp = jsonPayload['exp'];
    final int secondsFromEpochNow =
    (DateTime.now().millisecondsSinceEpoch / 1000).round();
    print("${(secondsFromEpochNow-exp)*-1} seconds (${(((secondsFromEpochNow-exp)*-1)/60/60/24).round()} days) untill token expires");
    if (secondsFromEpochNow >= exp) {
      return "expired";
    } else if (secondsFromEpochNow + 86400 >= exp) {
      Response response = await _authenticationService.refreshJWT(jwt);
      return response.bodyString;
    }
  }

  Map<String, dynamic> _splitAndDecodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }
    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
