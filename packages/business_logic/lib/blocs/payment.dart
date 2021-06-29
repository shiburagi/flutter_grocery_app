import 'package:bloc/bloc.dart';
import 'package:business_logic/business_logic.dart';

class PaymentBloc extends Cubit<PaymentState> {
  PaymentBloc() : super(PaymentState());

  Future<List<PaymentOption>> retrieveOptions() async {
    final data = await PaymemtRepo.instance.getOptions();
    if (state.seletedPayment == null)
      emit(state.copyWith(options: data, seletedPayment: data[0]));
    else
      emit(state.copyWith(options: data));

    return data;
  }

  setPayment(PaymentOption option) {
    emit(state.copyWith(seletedPayment: option));
  }
}

class PaymentState {
  final List<PaymentOption>? options;
  final PaymentOption? seletedPayment;

  PaymentState({this.options, this.seletedPayment});

  PaymentState copyWith({
    List<PaymentOption>? options,
    PaymentOption? seletedPayment,
  }) =>
      PaymentState(
          options: options ?? this.options,
          seletedPayment: seletedPayment ?? this.seletedPayment);
}
