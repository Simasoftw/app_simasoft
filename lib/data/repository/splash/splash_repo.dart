
import 'package:app_simasoft/core/utils/method.dart';
import 'package:app_simasoft/core/utils/url_container.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/services/api_service.dart';

class SplashRepo {
  ApiClient apiClient;
  SplashRepo({required this.apiClient});

  Future<ResponseModel> validateSession(String token) async {
    Map<String, String> map = {'token': token};
    String url = '${UrlContainer.baseUrl}${UrlContainer.validateToken}';

    ResponseModel model =
    await apiClient.request(url, Method.postMethod, map, passHeader: false);
    return model;
  }


}
