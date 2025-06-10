
import 'package:app_simasoft/core/utils/method.dart';
import 'package:app_simasoft/core/utils/url_container.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/services/api_service.dart';

class RequetsRepo {
  ApiClient apiClient;

  RequetsRepo({required this.apiClient});

  Future<ResponseModel> payrollAdvance(String amount, String bankName, int userId, int companyId, String typeRequest) async {

    double parsedAmount = double.parse(amount.replaceAll(",", ""));

    Map<String, dynamic> map = {
      'bankName': "NEQUI",
      'amount': parsedAmount, 
      'type': typeRequest,
      "companyId": companyId,
      "clientId": userId
    };

    String url = '${UrlContainer.baseUrl}${UrlContainer.loanApplications}';

    ResponseModel model =
        await apiClient.request(url, Method.postMethod, map, passHeader: false);
    return model;
  }


}
