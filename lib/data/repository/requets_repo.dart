
import 'package:app_simasoft/core/utils/method.dart';
import 'package:app_simasoft/core/utils/url_container.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/services/api_service.dart';

class RequetsRepo {
  ApiClient apiClient;

  RequetsRepo({required this.apiClient});

  Future payrollAdvance(double amount, String bankName) async {

    Map<String, dynamic> map = {
      'bankName': bankName,
      'amount': amount.toString(),
      'companyId': "1",
      'requestType': "PAYROLL_ADVANCE",
      'clientId' : "3"
    };

    String url =  "http://192.168.1.17:3000/api/loanApplications/create"; //'${UrlContainer.baseUrl}${UrlContainer.loanApplications}';

    try {
      ResponseModel model =
      await apiClient.request(url, Method.postMethod, map, passHeader: false);

      return model;
    } catch (e) {
      ResponseModel responseModel = ResponseModel(
        false,
        "Error en la petición",
        500,
        '{"data":"ok"}',
      );
      return responseModel;
    }
  }


}
