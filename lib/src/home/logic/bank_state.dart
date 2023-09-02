part of 'bank_bloc.dart';

sealed class BankState extends Equatable {
  const BankState();

  @override
  List<Object> get props => [];
}

final class BankStateInitial extends BankState {}

final class BankStateLoading extends BankState {}

final class BankStateLoaded extends BankState {
  const BankStateLoaded({required this.bankList});
  final List<BankModel> bankList;
  @override
  List<Object> get props => [bankList];
}

final class BankStateError extends BankState {
  const BankStateError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

final class SearchBankStateLoading extends BankState {}

final class SearchBankStateLoaded extends BankState {
  const SearchBankStateLoaded({required this.bankList});
  final List<BankModel> bankList;
  @override
  List<Object> get props => [bankList];
}
