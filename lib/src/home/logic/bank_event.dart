part of 'bank_bloc.dart';

sealed class BankEvent extends Equatable {
  const BankEvent();

  @override
  List<Object> get props => [];
}

class FetchBankListEvent extends BankEvent {
  const FetchBankListEvent(
      {required this.deviceModel, this.isCacheExpired = true});

  final String deviceModel;
  final bool isCacheExpired;

  @override
  List<Object> get props => [deviceModel, isCacheExpired];
}

class SearchBankListEvent extends BankEvent {
  const SearchBankListEvent({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}
