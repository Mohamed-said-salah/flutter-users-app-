import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/user_model.dart';
import 'user_api_service.dart';

abstract class UserRemoteDataSource {
  Future<UsersResponse> getUsers(int page);
  Future<SingleUserResponse> getUserById(int id);
}

@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final UserApiService apiService;

  UserRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UsersResponse> getUsers(int page) async {
    try {
      print('Fetching users for page: $page');
      final response = await apiService.getUsers(page);
      print('Successfully fetched users: ${response.data.length} users');
      return response;
    } on DioException catch (e) {
      print('DioError in getUsers:');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('Response: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');
      throw _handleDioError(e);
    } catch (e) {
      print('Unexpected error in getUsers: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<SingleUserResponse> getUserById(int id) async {
    try {
      print('Fetching user with ID: $id');
      final response = await apiService.getUserById(id);
      print('Successfully fetched user: ${response.data.id}');
      return response;
    } on DioException catch (e) {
      print('DioError in getUserById:');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('Response: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');
      throw _handleDioError(e);
    } catch (e) {
      print('Unexpected error in getUserById: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
            'Connection timeout. Please check your internet connection and try again.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data?['error'] ?? 'Unknown server error';
        return Exception('Server error (${statusCode ?? 'unknown'}): $message');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled. Please try again.');
      case DioExceptionType.connectionError:
        return Exception(
            'No internet connection. Please check your network settings and try again.');
      default:
        return Exception('An unexpected error occurred: ${error.message}');
    }
  }
}
