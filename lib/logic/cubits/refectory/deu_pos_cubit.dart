import 'package:deu_pos_api/deu_pos_api.dart';
import 'package:deucepte_open/data/repositories/deu_pos_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum DeuPosDetailStatus { initial, loading, success, failure }

class DeuPosDetailState extends Equatable {
  DeuPosDetailState(
      {this.status = DeuPosDetailStatus.initial, BalanceInfo? balanceInfo})
      : balanceInfo = balanceInfo ?? BalanceInfo("", [], false);

  final DeuPosDetailStatus status;
  final BalanceInfo balanceInfo;

  DeuPosDetailState copyWith({
    DeuPosDetailStatus? status,
    BalanceInfo? balanceInfo,
  }) {
    return DeuPosDetailState(
      status: status ?? this.status,
      balanceInfo: balanceInfo ?? this.balanceInfo,
    );
  }

  @override
  List<Object?> get props => [status, balanceInfo];
}

class DeuPosDetailCubit extends Cubit<DeuPosDetailState> {
  DeuPosDetailCubit(this.deuPosRepository)
      : super(DeuPosDetailState(status: DeuPosDetailStatus.initial));

  final DeuPosRepository deuPosRepository;

  Future getDeuPosDetail() async {
    emit(state.copyWith(status: DeuPosDetailStatus.initial));
    try {
      emit(state.copyWith(status: DeuPosDetailStatus.loading));
      final deuPosAccountBalanceInfo =
          await deuPosRepository.getAccountBalance();
      emit(state.copyWith(
          status: DeuPosDetailStatus.success,
          balanceInfo: deuPosAccountBalanceInfo));
    } catch (e) {
      emit(state.copyWith(status: DeuPosDetailStatus.failure));
    }
  }
}
