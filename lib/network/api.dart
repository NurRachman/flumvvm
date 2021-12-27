import 'package:dio/dio.dart';
import 'package:flumvvm/util/constants.dart';
import 'package:flutter/material.dart';

Dio api() {
  var options = BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: 60000,
    receiveTimeout: 72000,
  );
  Dio dio = Dio(options);

  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
    debugPrint('[API] Request --> ${options.data.toString()}'); 
    return handler.next(options);
  }, onResponse: (response, handler) {
    debugPrint(
      '[API] Response --> ${response.toString()}',
    );

    return handler.next(response);
  }, onError: (DioError e, handler) {
    debugPrint(
      '[API] Error --> ${e.toString()}\n[${e.requestOptions.uri.toString()}]',
    );
    return handler.next(e);
  }));

  return dio;
}
