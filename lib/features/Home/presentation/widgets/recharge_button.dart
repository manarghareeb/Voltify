import 'package:flutter/material.dart';
import 'package:voltify/features/Home/presentation/widgets/recharge_card.dart';
import 'package:voltify/features/const_themes.dart';

class RechargeButton extends StatefulWidget {
  const RechargeButton({super.key});

  @override
  State<RechargeButton> createState() => _RechargeButtonState();
}

class _RechargeButtonState extends State<RechargeButton>
    with SingleTickerProviderStateMixin {
  bool isCardVisible = false;
  TextEditingController _amountController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _toggleCard() {
    setState(() {
      if (isCardVisible) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isCardVisible = !isCardVisible;
    });
  }

  void _chargeAccount(double amount) {
  String rawAmount = _amountController.text;
  print("Entered value before processing: '$rawAmount'");

  String formattedAmount = rawAmount.trim().replaceAll('،', '.');
  print("Entered value after formatting: '$formattedAmount'");

  if (formattedAmount.isEmpty || double.tryParse(formattedAmount) == null) {
    print("⚠️ Error: Invalid number");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Please enter a valid amount"),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  double rechargeAmount = double.parse(formattedAmount);
  print("Valid amount, recharging with: $rechargeAmount");

  _amountController.clear();

  if (isCardVisible) {
    _controller.reverse().then((_) {
      if (mounted) {
        setState(() {
          isCardVisible = false;
        });
      }
    });
  }
}
  @override
  Widget build(BuildContext context) {
    ScreenSize.intial(context);

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        if (isCardVisible)
          Positioned(
            bottom: ScreenSize.width * 0.35,
            right: ScreenSize.width * 0.05,
            left: ScreenSize.width * 0.05,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: child,
                    ),
                  ),
                );
              },
              child: RechargeCard(
                onRecharge: _chargeAccount,
                amountController: _amountController,
              ),
            ),
          ),

        // Floating Action Button
        Positioned(
          bottom: ScreenSize.width * 0.05,
          right: ScreenSize.width * 0.05,
          child: FloatingActionButton(
            onPressed: _toggleCard,
            backgroundColor: AppTheme.kThirdColor,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isCardVisible ? Icons.close : Icons.add,
                key: ValueKey(isCardVisible),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
