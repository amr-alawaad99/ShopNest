import 'package:dio/dio.dart';
import 'package:shopnest/cache/cache_helper.dart';
import 'package:shopnest/core/api/end_points.dart';

class ApiInterceptors extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["lang"] = "ar";
    options.headers["Content-Type"] = "application/json";
    options.headers["Authorization"] = CacheHelper().getData(key: ApiKey.token);
    super.onRequest(options, handler);
  }
}