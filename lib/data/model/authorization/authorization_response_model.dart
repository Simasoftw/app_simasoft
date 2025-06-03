class AuthorizationResponseModel {
  AuthorizationResponseModel({
    String? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  AuthorizationResponseModel.fromJson(dynamic json) {
    _status = json['status'].toString();
    _message = json["message"];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _status;
  String? _message;
  Data? _data;

  String? get status => _status;
  String? get message => _message;
  Data? get data => _data;
}

class Data {
  Data({
    String? actionId,
    String? online,
  }) {
    _actionId = actionId;
    _online = online;
  }

  Data.fromJson(dynamic json) {
    _actionId = json['action_id'] != null ? json['action_id'].toString() : '';
    _online = json['online'] != null ? json['online'].toString() : 'false';
  }
  String? _actionId;
  String? _online;

  String? get actionId => _actionId;
  String? get online => _online;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action_id'] = _actionId;
    return map;
  }
}
