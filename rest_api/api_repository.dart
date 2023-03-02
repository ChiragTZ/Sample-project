import 'package:dio/dio.dart';

final title = "ApiRepo";

class ApiRepo {
  Future<Response> getCommon() async {
    String url = BASE_URL + apiCommonDetails;
    return await apiUtils.post(
      url: url,
      data: {"token": AppGlobal.getJTWToken()},
    );
  }

  Future<Response> login(data) async {
    String url = BASE_URL + apiLogin;
    return await apiUtils.post(
      url: url,
      data: data,
    );
  }

  Future<Response> logout() async {
    String url = BASE_URL + apiLogout;
    return await apiUtils.post(
      url: url,
      options: Options(headers: apiUtils.getSecureHeader()),
    );
  }


}
