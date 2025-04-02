import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltify/features/Home/presentation/cubit/balance_cubit.dart';
import 'package:voltify/features/const_themes.dart';

class RechargeCard extends StatelessWidget {
  final TextEditingController amountController;
  final Function(double) onRecharge;

  RechargeCard({
    Key? key,
    required this.amountController,
    required this.onRecharge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize.intial(context);

    return Container(
      margin: EdgeInsets.all(ScreenSize.width * 0.02),
      padding: EdgeInsets.all(ScreenSize.width * 0.05),
      decoration: BoxDecoration(
        color: AppTheme.kThirdColor,
        borderRadius: BorderRadius.circular(ScreenSize.width * 0.04),
        border: Border.all(color: AppTheme.kSecondaryColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppTheme.kSecondaryColor.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Recharge Balance',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenSize.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.015),
          BlocBuilder<BalanceCubit, BalanceState>(
            builder: (context, state) {
              double balance = 0.0;

              if (state is BalanceInitial) {
                balance = state.balance;
              } else if (state is BalanceUpdated) {
                balance = state.balance;
              }

              return Text(
                'Current Balance: ${balance.toStringAsFixed(2)}EGP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSize.width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
          SizedBox(height: ScreenSize.height * 0.025),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              hintText: 'Enter Amount to Recharge',
              hintStyle: TextStyle(color: Colors.grey[300]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenSize.width * 0.03),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenSize.width * 0.03),
                borderSide: BorderSide(color: Color(0xFF00FF99)),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: ScreenSize.height * 0.015),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.kSecondaryColor,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenSize.width * 0.03),
                ),
              ),
              onPressed: () {
                double? amount = double.tryParse(amountController.text);

                if (amount != null && amount > 0) {
                  print("Recharging with: $amount");


                  context.read<BalanceCubit>().rechargeBalance(amount);
                  amountController.clear();


                  Future.delayed(Duration(milliseconds: 300), () {
                    if (context.mounted) {

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Icon(Icons.check_circle,
                              color: AppTheme.kSecondaryColor, size: 50),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Recharge Successful!'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop();
                                if (Navigator.of(context).canPop()) {
                                  Navigator.of(context)
                                      .pop();
                                }
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid amount')),
                  );
                }
              },
              child: Text(
                "Recharge Now",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenSize.width * 0.045,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
