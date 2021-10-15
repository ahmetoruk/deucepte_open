import 'package:deu_refectory_meals_api/deu_refectory_meals_api.dart';
import 'package:deucepte_open/data/repositories/deu_refectory_meals_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum DeuRefectoryDetailStatus { initial, loading, success, failure }

class DeuRefectoryDetailState extends Equatable {
  DeuRefectoryDetailState(
      {this.status = DeuRefectoryDetailStatus.initial,
      List<RefectoryDay>? refectoryDays})
      : refectoryDays = refectoryDays ?? [];

  final DeuRefectoryDetailStatus status;
  final List<RefectoryDay> refectoryDays;

  DeuRefectoryDetailState copyWith({
    DeuRefectoryDetailStatus? status,
    List<RefectoryDay>? refectoryDays,
  }) {
    return DeuRefectoryDetailState(
      status: status ?? this.status,
      refectoryDays: refectoryDays ?? this.refectoryDays,
    );
  }

  @override
  List<Object?> get props => [status, refectoryDays];
}

class DeuRefectoryDetailCubit extends Cubit<DeuRefectoryDetailState> {
  DeuRefectoryDetailCubit(this.refectoryMealsRepository)
      : super(
            DeuRefectoryDetailState(status: DeuRefectoryDetailStatus.initial));

  final DeuRefectoryMealsRepository refectoryMealsRepository;

  Future getRefectoryDays([bool cache = false]) async {
    emit(state.copyWith(status: DeuRefectoryDetailStatus.initial));
    try {
      emit(state.copyWith(status: DeuRefectoryDetailStatus.loading));
      final deuRefectoryDays =
          await refectoryMealsRepository.getRefectoryMeals(cache);
      emit(state.copyWith(
          status: DeuRefectoryDetailStatus.success,
          refectoryDays: deuRefectoryDays));
    } catch (e) {
      emit(state.copyWith(status: DeuRefectoryDetailStatus.failure));
    }
  }
}
