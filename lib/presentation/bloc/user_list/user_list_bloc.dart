import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_app/data/models/user_model.dart';
import '../../../core/error/failures.dart';
import '../../../domain/usecases/get_users.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUsers getUsers;

  int _currentPage = 1;
  static const int _usersPerPage = 6; // Based on reqres.in API

  UserListBloc({required this.getUsers}) : super(UserListInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<LoadMoreUsers>(_onLoadMoreUsers);
    on<RefreshUsers>(_onRefreshUsers);
  }

  Future<void> _onLoadUsers(
      LoadUsers event, Emitter<UserListState> emit) async {
    if (event.isRefresh) {
      _currentPage = 1;
    }

    emit(UserListLoading());

    final result = await getUsers(GetUsersParams(page: _currentPage));

    result.fold(
      (failure) => emit(UserListError(message: _mapFailureToMessage(failure))),
      (response) {
        final hasReachedMax = _currentPage >= response.totalPages;
        emit(UserListLoaded(
          users: response.data.map((user) => user.toEntity()).toList(),
          hasReachedMax: hasReachedMax,
          isLoadingMore: false,
          currentPage: _currentPage,
          totalPages: response.totalPages,
        ));
        if (!hasReachedMax) {
          _currentPage++;
        }
      },
    );
  }

  Future<void> _onLoadMoreUsers(
      LoadMoreUsers event, Emitter<UserListState> emit) async {
    final currentState = state;
    if (currentState is UserListLoaded &&
        !currentState.hasReachedMax &&
        !currentState.isLoadingMore) {
      emit(currentState.copyWith(isLoadingMore: true));

      final result = await getUsers(GetUsersParams(page: _currentPage));

      result.fold(
        (failure) {
          emit(currentState.copyWith(isLoadingMore: false));
          emit(UserListError(message: _mapFailureToMessage(failure)));
        },
        (response) {
          final hasReachedMax = _currentPage >= response.totalPages;
          final newUsers =
              response.data.map((user) => user.toEntity()).toList();

          // Filter out any duplicate users based on ID
          final existingIds = currentState.users.map((u) => u.id).toSet();
          final uniqueNewUsers =
              newUsers.where((u) => !existingIds.contains(u.id)).toList();

          final allUsers = [...currentState.users, ...uniqueNewUsers];

          emit(UserListLoaded(
            users: allUsers,
            hasReachedMax: hasReachedMax,
            isLoadingMore: false,
            currentPage: _currentPage,
            totalPages: response.totalPages,
          ));

          if (!hasReachedMax) {
            _currentPage++;
          }
        },
      );
    }
  }

  Future<void> _onRefreshUsers(
      RefreshUsers event, Emitter<UserListState> emit) async {
    _currentPage = 1;
    add(const LoadUsers(isRefresh: true));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred. Please try again.';
      case CacheFailure:
        return 'No cached data available. Please check your internet connection.';
      case NetworkFailure:
        return 'Network error. Please check your internet connection.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
