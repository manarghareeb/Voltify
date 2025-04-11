import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final String userId;

  BalanceCubit(this.userId) : super(const BalanceInitial());


  Future<void> loadBalance() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data() as Map<String, dynamic>;

        double storedBalance = (data['balance'] ?? 0.0).toDouble();
        double electricityConsumption = (data['electricity'] ?? 0.0).toDouble();

        DateTime renewalDate = DateTime.now();
        if (data.containsKey('renwalDate') && data['renwalDate'] is Timestamp) {
          renewalDate = (data['renwalDate'] as Timestamp).toDate();
        }

        emit(BalanceUpdated(
          balance: storedBalance,
          electricityConsumption: electricityConsumption,
          renewalDate: DateFormat('dd/MM/yyyy').format(renewalDate),
          percent: 0.0,
        ));
      } else {
        emit(BalanceUpdated(
          balance: 0.0,
          electricityConsumption: 0.0,
          renewalDate: "--/--/----",
          percent: 0.0,
        ));
      }
    } catch (e) {
      print("error: $e");
    }
  }


  Future<void> _saveBalance(double newBalance, double electricityConsumption,
      {bool updateDate = false}) async {
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      Map<String, dynamic> data = {
        'balance': newBalance,
        'electricity': electricityConsumption,
      };

      if (updateDate) {
        data['renwalDate'] = Timestamp.fromDate(DateTime.now());
      }

      await userRef.update(data);
    } catch (e) {
      print(" $e");
    }
  }


void rechargeBalance(double amount) async {
  try {
    if (amount <= 0) {
      print("invalid amount");
      return;
    }

    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot userSnapshot = await transaction.get(userRef);

      if (!userSnapshot.exists) {
        print("user not found");
        return;
      }

      double currentBalance = (userSnapshot.data() as Map<String, dynamic>)?['balance'] ?? 0.0;
      double newBalance = amount;

      transaction.update(userRef, {'balance': newBalance});

      transaction.set(userRef.collection('recharge').doc(), {
        'amount': amount,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });

    print("Amount: $amount");
  } catch (e) {
    print(" $e");
  }
}

  double calculateConsumption(double amount) {
    double ratePerKW = 1.5;
    return amount / ratePerKW;
  }
}


  double calculatePercentage(double current, double total) {
    if (total == 0) return 0;
    return (current / total) * 100;
  }
