import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:voltify/features/Home/presentation/cubit/balance_cubit.dart';
import 'package:voltify/features/const_themes.dart';

class CirclePercentWidget extends StatelessWidget {
  
  const CirclePercentWidget({super.key});

  @override

  Widget build(BuildContext context) {
    return BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        double percent = 0.0;
        String balanceText = "--";

        if (state is BalanceUpdated) {
          double maxBalance = state.balance;

          if (maxBalance > 0) {
            percent = (state.balance / maxBalance).clamp(0.0, 1.0);
            balanceText = "${(percent * 100).toStringAsFixed(1)}%";
          } else {
            balanceText = "0%";
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 14.0,
              animation: true,
              animationDuration: 1000,
              percent: percent,
              center: Text(
                balanceText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              circularStrokeCap: CircularStrokeCap.butt,
              progressColor: AppTheme.kSecondaryColor,
              backgroundColor: Colors.grey.shade600,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(Icons.electric_bolt,
                        color: AppTheme.kSecondaryColor, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      "Usage",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.grey.shade500, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      "Residual",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
