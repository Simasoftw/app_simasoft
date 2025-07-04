import 'dart:async';

import 'package:app_simasoft/core/utils/url_container.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../repository/device_user.repository.dart';

class HttpDeviceUserService extends DeviceUserRepository {

  @override
  Future saveInfoDeviceUser(String token) async {
    print("llego en saveInfoDeviceUser service");
    String url = '${UrlContainer.baseUrl}${UrlContainer.deviceClientEndPoint}';

    try {
      if(token.isEmpty){
        return [];
      }

      final response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body:  jsonEncode({"token" : token})
      );

      final body = jsonDecode(response.body);
      print("token ${response.body}");

      final List<dynamic> jsonDataList = body["data"] as List<dynamic>;



      return jsonDataList;

    }
    catch (error) {
      print("error service ${error}");
      return error;
    }
  }

  @override
  Future sendNotificationToDeviceUser() {
    // TODO: implement sendNotificationToDeviceUser
    throw UnimplementedError();
  }
}
