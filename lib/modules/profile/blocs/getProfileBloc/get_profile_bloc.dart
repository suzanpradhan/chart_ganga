import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/profile/models/profile_model.dart';
import 'package:equatable/equatable.dart';

import '../../repos/udpdate_profile_repo.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  UpdateProfileRepo _updateProfileRepo = UpdateProfileRepo();
  GetProfileBloc() : super(GetProfileInitial()) {
    on<GetProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetProfileAttempt>((event, emit) => getProfileEventMapped(event, emit));
  }

  getProfileEventMapped(
      GetProfileAttempt event, Emitter<GetProfileState> emit) async {
    try {
      emit(GetProfileLoadingState());
      ProfileModel profileModel = await _updateProfileRepo.getProfile();
      emit(GetProfileSuccessState(profileModel: profileModel));
    } catch (e) {
      emit(GetProfileFailedState(message: e.toString()));
    }
  }
}
