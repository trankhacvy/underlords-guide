// import 'package:dio/dio.dart';
// import 'package:UnderlordsGuru/config/Env.dart';
// import 'package:UnderlordsGuru/utility/log/DioLogger.dart';

// class APIProvider {
//   static const String TAG = 'APIProvider';

//   static const String _baseUrl = 'https://itunes.apple.com/hk';
//   static const String _TOP_FREE_APP_API =
//       '/rss/topfreeapplications/limit=%d/json';
//   static const String _TOP_FEATURE_APP_API =
//       '/rss/topgrossingapplications/limit=%d/json';
//   static const String _APP_DETAIL_API = '/lookup/json';

//   Dio _dio;

//   APIProvider() {
//     BaseOptions dioOptions = BaseOptions(connectTimeout: 1000)
//       ..baseUrl = APIProvider._baseUrl;

//     _dio = Dio(dioOptions);

//     if (EnvType.DEVELOPMENT == Env.value.environmentType ||
//         EnvType.STAGING == Env.value.environmentType) {
//       _dio.interceptors
//           .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
//         DioLogger.onSend(TAG, options);
//         return options;
//       }, onResponse: (Response response) {
//         DioLogger.onSuccess(TAG, response);
//         return response;
//       }, onError: (DioError error) {
//         DioLogger.onError(TAG, error);
//         return error;
//       }));
//     }
//   }
// }
