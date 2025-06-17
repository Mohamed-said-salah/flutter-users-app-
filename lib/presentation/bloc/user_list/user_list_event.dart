import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserListEvent {
  final bool isRefresh;

  const LoadUsers({this.isRefresh = false});

  @override
  List<Object> get props => [isRefresh];
}

class LoadMoreUsers extends UserListEvent {}

class RefreshUsers extends UserListEvent {}
