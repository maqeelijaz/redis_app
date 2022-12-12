import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:redis/Model/EmployeeModel.dart';

class RedisService {
  Future<List<EmployeeModel>> get getdatafromapi async {
    return await http
        .get(Uri(
            scheme: 'https',
            host: 'dummy.restapiexample.com',
            port: null,
            path: 'api/v1/employees'))
        .then((value) {
      var temp = jsonDecode(value.body)['data'];
      return parsedata(temp);
    });
  }

  Future<List<EmployeeModel>> get getdatafromredis async {
    return await http.get(
      Uri(scheme: 'http', host: 'localhost', port: 3000, path: 'redis/getData'),
      headers: {'Content-Type': 'application/json'},
    ).then((value) {
      var temp = jsonDecode(value.body);
      return parsedata(temp);
    });
  }

  List<EmployeeModel> parsedata(data) {
    return data
        .cast<Map<String, dynamic>>()
        .map<EmployeeModel>((e) => EmployeeModel.fromJson(e))
        .toList();
  }

  Future<List<EmployeeModel>> get storedatatoRedis async {
    return await getdatafromapi.then((List<EmployeeModel> value) async {
      return await savedatatoredis(value).then((temp) {
        return value;
      });
    });
  }

  Future savedatatoredis(List<EmployeeModel> value) async {
    return await http.post(
        Uri(
            scheme: 'http',
            host: 'localhost',
            port: 3000,
            path: 'redis/setData'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'data': value}));
  }
}
