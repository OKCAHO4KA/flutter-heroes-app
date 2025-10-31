import 'package:dio/dio.dart';
import 'package:prueba_jun/common_widgets/snackbar_widget.dart';
import 'package:prueba_jun/constants/enum.dart';
import 'package:prueba_jun/features/main/entity/heroe_model.dart';

class ApiService {
  static Future<HeroeModel> fetchListHeroes({
    String name = '',
    String status = '',
    required int currentPage,
  }) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        "https://rickandmortyapi.com/api/character/",
        queryParameters: {
          "page": currentPage,
          if (name.isNotEmpty) 'name': name,
          if (status.isNotEmpty && status != Status.ALL.name) 'status': status,
        },
      );
      return response.data != null || response.statusCode != 400
          ? HeroeModel.fromJson(response.data)
          : throw Exception(response.data["error"]);
    } on DioException catch (e) {
      String errorMessage = 'Произошла ошибка';

      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 404:
            errorMessage = 'Ресурс не найден';
            break;
          case 401:
            errorMessage = 'Требуется авторизация';
            break;
          case 403:
            errorMessage = 'Доступ запрещён';
            break;
          case 500:
            errorMessage = 'Серверная ошибка';
            break;
          default:
            errorMessage = 'Ошибка ${e.response?.statusCode}';
        }
        if (e.response?.data is Map) {
          final data = e.response!.data as Map;
          if (data.containsKey('error')) {
            errorMessage = data['error'].toString();
          } else if (data.containsKey('message')) {
            errorMessage = data['message'].toString();
          } else if (data.containsKey('detail')) {
            errorMessage = data['detail'].toString();
          }
        } else if (e.response?.data != null) {
          errorMessage = e.response!.data.toString();
        }
      } else {
        errorMessage = 'Нет соединения с сервером';
      }

      UsefulMethods().showSnackBar(
        message: 'Ошибка',
        type: SnackBarType.error,
        textContent: errorMessage,
      );

      throw Exception(errorMessage);
    }
  }

  static Future<Heroe> fetchHeroeById(int id) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        "https://rickandmortyapi.com/api/character/$id",
      );
      return response.data != null || response.statusCode != 400
          ? Heroe.fromJson(response.data)
          : throw Exception(response.data["error"]);
    } on DioException catch (e) {
      String errorMessage = 'Произошла ошибка';

      if (e.response?.data is Map) {
        final data = e.response!.data as Map;
        if (data.containsKey('error')) {
          errorMessage = data['error'].toString();
        } else if (data.containsKey('message')) {
          errorMessage = data['message'].toString();
        } else if (data.containsKey('detail')) {
          errorMessage = data['detail'].toString();
        }
      } else if (e.response?.data != null) {
        errorMessage = e.response!.data.toString();
      } else {
        errorMessage = 'Нет соединения с сервером';
      }

      UsefulMethods().showSnackBar(
        message: 'Ошибка',
        type: SnackBarType.error,
        textContent: errorMessage,
      );

      throw Exception(errorMessage);
    }
  }
}
