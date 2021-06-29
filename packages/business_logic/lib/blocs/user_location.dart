import 'package:bloc/bloc.dart';
import 'package:business_logic/business_logic.dart';

class UserLocationBloc extends Cubit<UserLocationState> {
  UserLocationBloc() : super(UserLocationState());

  setAddress(UserAddress address) {
    emit(state.copyWith(address: address));
  }
}

class UserLocationState {
  final UserAddress? address;

  UserLocationState({this.address});

  UserLocationState copyWith({
    UserAddress? address,
  }) =>
      UserLocationState(address: address ?? this.address);
}
