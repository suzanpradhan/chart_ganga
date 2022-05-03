import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/profile/models/profile_model.dart';
import 'package:chart_ganga/modules/profile/repos/udpdate_profile_repo.dart';
import 'package:equatable/equatable.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileRepo _updateProfileRepo = UpdateProfileRepo();
  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<UpdateProfileAttempt>(
        (event, emit) => updateProfileEventMapped(event, emit));
  }

  updateProfileEventMapped(
      UpdateProfileAttempt event, Emitter<UpdateProfileState> emit) async {
    try {
      emit(UpdateProfileLoadingState());
      await _updateProfileRepo.updateProfile(profileModel: event.profileModel);
      emit(UpdateProfileSuccessState());
    } catch (e) {
      emit(UpdateProfileFailedState(message: e.toString()));
    }
  }
}
