import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/views/shared/appstyle.dart';
import '../../../controllers/payment_notifier_provider.dart';
import '../mainscreen.dart';

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentNotifier = Provider.of<PaymentNotifier>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            paymentNotifier.setPaymentUrl = '';
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MainScreen()),
            );
          },
          child: const Icon(Icons.close, color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.cancel, color: Colors.red, size: 90),
            const SizedBox(height: 20),
            Text(
              'Payment Failed',
              style: appstyle(26, FontWeight.bold, Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              'Something went wrong.\nPlease try again.',
              textAlign: TextAlign.center,
              style: appstyle(20, FontWeight.bold, Colors.black),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                paymentNotifier.setPaymentUrl = '';
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => MainScreen()),
                );
              },
              child: const Text(
                'Try Again',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
