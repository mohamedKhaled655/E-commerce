import 'package:dio/dio.dart';

import '../../features/payment/data/repo/api_constance.dart';

class ApiServices{
  final _baseUrl="https://student.valuxapps.com/api/";
  final Dio _dio;

  ApiServices(this._dio);

  Future <Map<String,dynamic>>get({required String endPoint,String lang="en",String ?token})async{
      _dio.options.headers={
     "Content-Type":"application/json",
     "lang":lang,
     "Authorization":token??'',
   };
    var response=await _dio.get(
      "$_baseUrl$endPoint",
      queryParameters: _dio.options.headers
      );
    return  response.data;
  }

   Future <Map<String,dynamic>>post({required String endPoint,Map<String,dynamic>? query, Map<String,dynamic>? body,String? token,String lang="en",})async{
    _dio.options.headers={
     "Content-Type":"application/json",
     "lang":lang,
     "Authorization":token,
    // "token":token,
   };
    
    var response=await _dio.post("$_baseUrl$endPoint",queryParameters: query,data: body);
    return response.data;
  }

  Future <Map<String,dynamic>>remove({required String endPoint,Map<String,dynamic>? query, Map<String,dynamic>? body,String? token,String lang="en",})async{
    _dio.options.headers={
     "Content-Type":"application/json",
     "lang":lang,
     "Authorization":token,
    // "token":token,
   };
    
    var response=await _dio.delete("$_baseUrl$endPoint",queryParameters: query,data: body);
    return response.data;
  }

  Future <Map<String,dynamic>>put({required String endPoint,Map<String,dynamic>? query, Map<String,dynamic>? body,String? token,String lang="en",})async{
    _dio.options.headers={
     "Content-Type":"application/json",
     "lang":lang,
     "Authorization":token,
    // "token":token,
   };
    
    var response=await _dio.put("$_baseUrl$endPoint",queryParameters: query,data: body);
    return response.data;
  }

  Future <Map<String,dynamic>>postPayment({required String endPoint,Map<String,dynamic>? query, Map<String,dynamic>? body,String? token,String lang="en",})async{
    _dio.options.headers={
     "Content-Type":"application/json",
     "lang":lang,
     "Authorization":token,
    // "token":token,
   };
    
    var response=await _dio.post("${ApiContest.baseUrl}$endPoint",queryParameters: query,data: body);
    return response.data;
  }


}