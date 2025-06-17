import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadUserDetail extends UserDetailEvent {
  final int userId;

  const LoadUserDetail({required this.userId});

  @override
  List<Object> get props => [userId];
}

