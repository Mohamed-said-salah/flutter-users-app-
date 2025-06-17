import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/get_users.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart' as models;

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, models.UsersResponse>> getUsers(int page) async {
    print('Getting users for page: $page');
    if (await networkInfo.isConnected) {
      try {
        print('Network is connected, fetching from remote source');
        final remoteResponse = await remoteDataSource.getUsers(page);
        print('Successfully fetched users from remote source');

        // Cache the users if it's the first page
        if (page == 1) {
          print('Caching users for first page');
          await localDataSource.cacheUsers(remoteResponse.data);
        }

        return Right(remoteResponse);
      } catch (e) {
        print('Error fetching users from remote source: $e');
        return Left(ServerFailure());
      }
    } else {
      print('Network is not connected, fetching from local source');
      try {
        final localUsers = await localDataSource.getCachedUsers();
        print(
            'Successfully fetched ${localUsers.length} users from local source');
        return Right(const models.UsersResponse(
          data: [],
          page: 1,
          perPage: 0,
          total: 0,
          totalPages: 1,
        ));
      } catch (e) {
        print('Error fetching users from local source: $e');
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(int id) async {
    print('Getting user with ID: $id');
    if (await networkInfo.isConnected) {
      try {
        print('Network is connected, fetching from remote source');
        final remoteUser = await remoteDataSource.getUserById(id);
        final user = _mapToEntity(remoteUser.data);
        print('Successfully fetched user from remote source');

        // Cache the user
        print('Caching user');
        await localDataSource.cacheUser(remoteUser.data);

        return Right(user);
      } catch (e) {
        print('Error fetching user from remote source: $e');
        return Left(ServerFailure());
      }
    } else {
      print('Network is not connected, fetching from local source');
      try {
        final localUser = await localDataSource.getCachedUser(id);
        if (localUser != null) {
          print('Successfully fetched user from local source');
          return Right(_mapToEntity(localUser));
        } else {
          print('User not found in local source');
          return Left(CacheFailure());
        }
      } catch (e) {
        print('Error fetching user from local source: $e');
        return Left(CacheFailure());
      }
    }
  }

  User _mapToEntity(models.UserModel model) {
    return User(
      id: model.id,
      email: model.email,
      firstName: model.firstName,
      lastName: model.lastName,
      avatar: model.avatar,
    );
  }
}
