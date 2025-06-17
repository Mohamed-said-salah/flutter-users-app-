import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';
import '../../data/models/user_model.dart' as models;

abstract class UserRepository {
  Future<Either<Failure, models.UsersResponse>> getUsers(int page);
  Future<Either<Failure, User>> getUserById(int id);
}
