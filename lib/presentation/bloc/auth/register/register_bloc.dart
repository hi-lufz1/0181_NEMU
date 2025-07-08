import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nemu_app/data/model/request/auth/register_req_model.dart';
import 'package:nemu_app/data/model/response/auth/register_res_model.dart';
import 'package:nemu_app/data/repository/auth/auth_repository.dart';

import '../../../../data/model/response/auth/register_res_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
 final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    try {
      final response = await authRepository.register(event.reqModel);

      if (response.status == 200) {
        emit(RegisterSuccess(responseModel: response)); 
      } else {
        emit(RegisterFailure(error: response.message ?? "Pendaftaran gagal"));
      }
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }
}
