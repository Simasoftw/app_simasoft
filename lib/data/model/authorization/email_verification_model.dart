class EmailVerificationModel {
  EmailVerificationModel(
      {required int code,
      required String status,
      required String colorRedirectUrl,
        required String message,
      Data? data}) {
    _status = status;
    _message = message;
    _colorRedirectUrl = colorRedirectUrl;
    _data = data;
  }

  EmailVerificationModel.fromJson(dynamic json) {
    _code = json['code'] ?? 0;
    _colorRedirectUrl = json['colorRedirect_url'] ?? '';
    _status = json['status'] ?? 'null status';
    _message = json["message"] ?? "Ha ocurrido un error";
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  late int _code;
  late String _status;
  late String _colorRedirectUrl;
  late String _message;
  Data? _data;

  int get code => _code;
  String get status => _status;
  String get colorRedirectUrl => _colorRedirectUrl;
  String get message => _message;
  Data? get data => _data;

  void setCode(int code) {
    _code = code;
  }
}

class Data {
  String? email;
  String? token;

  Data({this.email, this.token});
  Data.fromJson(dynamic json) {
    if (json['email'] != null) {
      email = json['email'];
    } else {
      email = null;
    }
    if (json['code'] != null) {
      token = json['code'].toString();
    } else {
      token = null;
    }
  }
}
