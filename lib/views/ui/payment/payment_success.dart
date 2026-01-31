import 'package:shop_app/views/shared/appstyle.dart';
import 'package:shop_app/views/shared/export_packages.dart';
import '../../../controllers/payment_notifier_provider.dart';
import '../mainscreen.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentNotifier = Provider.of<PaymentNotifier>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
          child: Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              color: Color(0xFF7CF4B5),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                AntDesign.closecircle,
                size: 70,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Green Circle
            Icon(AntDesign.checkcircle, size: 120.h, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Payment Successful!',
              textAlign: TextAlign.center,
              style: appstyle(40, FontWeight.bold, Colors.black),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
