import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/failures.dart';
import '../../../domain/usecases/get_user_by_id.dart';
import 'user_detail_event.dart';
import 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUserById getUserById;

  UserDetailBloc({required this.getUserById}) : super(UserDetailInitial()) {
    on<LoadUserDetail>(_onLoadUserDetail);
  }

  Future<void> _onLoadUserDetail(LoadUserDetail event, Emitter<UserDetailState> emit) async {
    emit(UserDetailLoading());
    
    final result = await getUserById(GetUserByIdParams(id: event.userId));
    
    result.fold(
      (failure) => emit(UserDetailError(message: _mapFailureToMessage(failure))),
      (user) => emit(UserDetailLoaded(user: user)),
    );
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

