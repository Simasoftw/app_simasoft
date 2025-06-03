
import 'package:app_simasoft/core/utils/method.dart';
import 'package:app_simasoft/core/utils/url_container.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/services/api_service.dart';

class RequetsRepo {
  ApiClient apiClient;

  RequetsRepo({required this.apiClient});

  Future<ResponseModel> payrollAdvance(String amount, String bankName) async {
    Map<String, String> map = {
      'bankName': "NEQUI",
      'amount': amount,
      "id": "3",
      "companyId": "1"
    };

    String url = '${UrlContainer.baseUrl}${UrlContainer.loanApplications}';

    ResponseModel model =
        await apiClient.request(url, Method.postMethod, map, passHeader: false);
    return model;
  }


}
