// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AuthenticationService extends AuthenticationService {
  _$AuthenticationService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthenticationService;

  @override
  Future<Response<dynamic>> postGoogleLogin(String idToken) {
    final $url = '/login/authorize';
    final $headers = {'Authorization': idToken};
    final $request = Request('POST', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> refreshJWT(String jwt) {
    final $url = '/login/refresh';
    final $headers = {'Authorization': jwt};
    final $request = Request('POST', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
