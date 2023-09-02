import 'dart:developer';
import 'package:assign_khalti/common/constant/constant_text.dart';
import 'package:assign_khalti/common/service/network/exception_handler.dart';
import 'package:assign_khalti/src/home/model/bank_model.dart';
import 'package:assign_khalti/src/home/repository/bank_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/shared_pref.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  final BankRepository _repository = BankRepository();

  final ExceptionHandler _handler = ExceptionHandler();

  List<BankModel> tempList = [], filteredList = [];

  BankBloc() : super(BankStateInitial()) {
    on<FetchBankListEvent>(_mapFetchBankListEventToState);
    on<SearchBankListEvent>(_mapSearchBankListEventToState);
  }

  Future<void> _mapFetchBankListEventToState(
      FetchBankListEvent event, Emitter<BankState> emit) async {
    emit(BankStateLoading());

    final cacheExpired = await SharePref.getData(
        key: ConstantText.isCacheExpired, type: 'bool', dValue: true);
    try {
      log("cached expired? in bloc => $cacheExpired");
      final response = await _repository.getBankList(
        deviceModel: event.deviceModel,
        cacheExpired: cacheExpired,
      );

      tempList = response ?? [];
      filteredList = tempList;
      emit(BankStateLoaded(bankList: response ?? []));
    } catch (e) {
      emit(BankStateError(message: _handler.parseError(e)));
    }
  }

  Future<void> _mapSearchBankListEventToState(
      SearchBankListEvent event, Emitter<BankState> emit) async {
    emit(SearchBankStateLoading());

    filteredList = tempList
        .where((u) => (u.name
                .toLowerCase()
                .startsWith(event.query.toLowerCase()) ||
            u.swiftCode.toLowerCase().startsWith(event.query.toLowerCase())))
        .toList();

    // log("searched key=> ${event.query}");
    // log("searched list => $filteredList");
    // log("temp list => $tempList");

    emit(SearchBankStateLoaded(bankList: filteredList));
  }
}
