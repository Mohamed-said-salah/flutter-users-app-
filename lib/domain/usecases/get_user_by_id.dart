import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';
import 'usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserById implements UseCase<User, GetUserByIdParams> {
  final UserRepository repository;

  GetUserById(this.repository);

  @override
  Future<Either<Failure, User>> call(GetUserByIdParams params) async {
    return await repository.getUserById(params.id);
  }
}

class GetUserByIdParams extends Equatable {
  final int id;

  const GetUserByIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
