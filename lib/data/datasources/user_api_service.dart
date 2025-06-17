import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_model.dart';

part 'user_api_service.g.dart';

@injectable
@RestApi()
abstract class UserApiService {
  @factoryMethod
  factory UserApiService(Dio dio,
      {String? baseUrl, ParseErrorLogger? errorLogger}) = _UserApiService;

  @GET('users')
  Future<UsersResponse> getUsers(
    @Query('page') int page,
  );

  @GET('users/{id}')
  Future<SingleUserResponse> getUserById(
    @Path('id') int id,
  );
}
