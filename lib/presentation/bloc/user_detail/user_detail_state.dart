import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final User user;

  const UserDetailLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserDetailError extends UserDetailState {
  final String message;

  const UserDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

