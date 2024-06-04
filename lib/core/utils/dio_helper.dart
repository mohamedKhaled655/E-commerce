import 'package:dio/dio.dart';


class DioHelper{
  static late Dio dio;

  static init(){
    dio=Dio(
      BaseOptions(
       // baseUrl: 'https://student.valuxapps.com/api/',
       //baseUrl: 'http://2bc2-156-209-152-213.ngrok.io/user/login',
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
        //  "Content-Type":"application/json",

        }
      ),


    );
  }
 static Future<Response>get(
      {
        required String url,
         Map<String,dynamic>? query,
        String lang='en',
        String? token,
      }
      )async{
   dio.options.headers={
     "Content-Type":"application/json",
    // "lang":lang,
     "Authorization":token??'',
     "token":token,
   };
    return await dio.get(url,queryParameters: query);
  }





static Future <Response>post(
  {
  required String url,
    Map<String,dynamic>?query,
    required Map<String,dynamic>data,
    //String lang="en",
    String ?token,
}
    )async{
   dio.options.headers={
     "Content-Type":"application/json",
    // "lang":lang,
     //"Authorization":token,
     "token":token,
   };


    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
}


  static Future <Response>putData(
      {
        required String url,
        Map<String,dynamic>?query,
        required Map<String,dynamic>data,
        //String lang="en",
        String ?token,
      }
      )async{
    dio.options.headers={
      "Content-Type":"application/json",

     // "lang":lang,
      //"Authorization":token,
      "token":token,
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

}