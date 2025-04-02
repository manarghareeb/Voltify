part of 'balance_cubit.dart';

abstract class BalanceState extends Equatable {
  final double balance;
  final double electricityConsumption;
  final String renewalDate;

  const BalanceState({
    required this.balance,
    required this.electricityConsumption,
    required this.renewalDate,
  });

  @override
  List<Object> get props => [balance, electricityConsumption, renewalDate];
}

class BalanceInitial extends BalanceState {
  const BalanceInitial() : super(balance: 0.0, electricityConsumption: 0.0, renewalDate: "--/--/----");
}


class BalanceUpdated extends BalanceState {
  const BalanceUpdated({
    required double balance,
    required double electricityConsumption,
    required String renewalDate,
  }) : super(balance: balance, electricityConsumption: electricityConsumption, renewalDate: renewalDate);
}
