import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nemu_app/data/model/request/auth/login_req_model.dart';
import 'package:nemu_app/data/model/response/auth/login_res_model.dart';
import 'package:nemu_app/data/repository/auth/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    final response = await authRepository.login(event.reqModel);

    if (response.status == 200 && response.token != null) {
      emit(LoginSuccess(responseModel: response));
    } else {
      emit(LoginFailure(responseModel: response));
    }
  }
}
