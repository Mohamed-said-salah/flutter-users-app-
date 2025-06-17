import 'package:equatable/equatable.dart';
import 'package:flutter_users_app/domain/entities/user.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<User> users;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int currentPage;
  final int totalPages;

  const UserListLoaded({
    required this.users,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    required this.currentPage,
    required this.totalPages,
  });

  UserListLoaded copyWith({
    List<User>? users,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? currentPage,
    int? totalPages,
  }) {
    return UserListLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props =>
      [users, hasReachedMax, isLoadingMore, currentPage, totalPages];
}

class UserListError extends UserListState {
  final String message;

  const UserListError({required this.message});

  @override
  List<Object> get props => [message];
}
