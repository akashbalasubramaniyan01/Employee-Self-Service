class Loginmodel {
  Loginmodel({
    required this.status,
    required this.message,
    required this.jwt,
    required this.data,
  });
  late final bool status;
  late final String message;
  late final String jwt;
  late final Data data;

  Loginmodel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    jwt = json['jwt'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['jwt'] = jwt;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.usrid,
    required this.name,
    required this.email,
    required this.role,
    required this.head,
  });
  late final String usrid;
  late final String name;
  late final String email;
  late final String role;
  late final String head;

  Data.fromJson(Map<String, dynamic> json){
    usrid = json['usrid']??"";
    name = json['name']??"";
    email = json['email']??"";
    role = json['role']??"";
    head = json['head']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['usrid'] = usrid;
    _data['name'] = name;
    _data['email'] = email;
    _data['role'] = role;
    _data['head'] = head;
    return _data;
  }
}