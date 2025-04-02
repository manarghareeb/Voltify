import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; 

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(const BalanceInitial());


  Future<void> loadBalance() async {
    final prefs = await SharedPreferences.getInstance();
    double storedBalance = prefs.getDouble('balance') ?? 0.0;
    double electricityConsumption = prefs.getDouble('electricityConsumption') ?? 0.0;
    String renewalDate = prefs.getString('renewalDate') ?? "--/--/----";

    emit(BalanceUpdated(balance: storedBalance, electricityConsumption: electricityConsumption, renewalDate: renewalDate));
  }


  Future<void> _saveBalance(double newBalance, double electricityConsumption, {bool updateDate = false}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', newBalance);
    await prefs.setDouble('electricityConsumption', electricityConsumption);


    if (updateDate) {
      String newRenewalDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
      await prefs.setString('renewalDate', newRenewalDate);
    }
  }


  void rechargeBalance(double amount) {

  double newElectricityConsumption = calculateConsumption(amount);

  emit(BalanceUpdated(
    balance: amount,
    electricityConsumption: newElectricityConsumption,
    renewalDate: state.renewalDate,
  ));
}


double calculateConsumption(double amount) {
  double ratePerKW = 1.5;
  return amount / ratePerKW;
}
}
