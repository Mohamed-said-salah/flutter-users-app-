import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';
import 'usecase.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/user_model.dart' as models;

@injectable
class GetUsers implements UseCase<models.UsersResponse, GetUsersParams> {
  final UserRepository repository;

  GetUsers(this.repository);

  @override
  Future<Either<Failure, models.UsersResponse>> call(
      GetUsersParams params) async {
    return await repository.getUsers(params.page);
  }
}

class GetUsersParams extends Equatable {
  final int page;

  const GetUsersParams({required this.page});

  @override
  List<Object> get props => [page];
}
