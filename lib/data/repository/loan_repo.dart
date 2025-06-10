import 'dart:convert';

import 'package:app_simasoft/core/utils/method.dart';
import 'package:app_simasoft/core/utils/url_container.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/services/api_service.dart';
import 'package:http/http.dart' as http;

class LoanRepo {
    ApiClient apiClient;

  LoanRepo({required this.apiClient});

 Future<ResponseModel> loanFilterByClient() async {
 
    String url = '${UrlContainer.baseUrl}${UrlContainer.loanFilterEndPoint}'; 

    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return model;
  }
}