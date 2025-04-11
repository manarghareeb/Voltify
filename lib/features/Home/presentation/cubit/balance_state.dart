part of 'balance_cubit.dart';

abstract class BalanceState extends Equatable {
  final double balance;
  final double electricityConsumption;
  final String renewalDate;
  final double percent;

  const BalanceState({
    required this.balance,
    required this.electricityConsumption,
    required this.renewalDate,
    required this.percent,
  });

  @override
  List<Object> get props => [balance, electricityConsumption, renewalDate, percent];
}

class BalanceInitial extends BalanceState {
  const BalanceInitial() : super(balance: 0.0, electricityConsumption: 0.0, renewalDate: "--/--/----", percent: 0.0,);
}

class BalanceUpdated extends BalanceState {
  const BalanceUpdated({
    required double balance,
    required double electricityConsumption,
    required String renewalDate,
    required double percent,
  }) : super(
          balance: balance,
          electricityConsumption: electricityConsumption,
          renewalDate: renewalDate,
          percent: percent,
        );
}