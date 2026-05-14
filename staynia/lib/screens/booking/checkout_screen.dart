import 'package:flutter/material.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/data/entity/model/room.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/theme_extension.dart';

class CheckoutScreen extends StatefulWidget {
  final Room room;
  const CheckoutScreen({super.key, required this.room});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends BaseScreen<CheckoutScreen> {
  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout', divider: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // Date Section
            const Text("Date", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                _dateBox("Check - In", "Nov 12, 2024"),
                const SizedBox(width: 12),
                _dateBox("Check - Out", "Nov 14, 2024"),
              ],
            ),

            const SizedBox(height: 25),
            const Text("Guest", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                _circleButton(icon: Icons.remove, onTap: () {}),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '1',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                _circleButton(
                  icon: Icons.add,
                  color: context.primaryColor,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 25),
            const Text(
              "Pay With",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withOpacitySafe(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.wallet, color: Colors.black54),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FastPayz",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "******6587",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 0,
                      ),
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            const Text(
              "Payment Details",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            _detailRow("Total : 2 Night", "\$400", bold: false),
            _detailRow("Cleaning Fee", "\$5", bold: false),
            _detailRow("Service Fee", "\$5", bold: false),
            const Divider(height: 30, thickness: 1),
            _detailRow("Total Payment:", "\$410", bold: true),
          ],
        ),
      ),
    );
  }

  Widget _dateBox(String label, String date) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.cabin, size: 16),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    Color? color,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color ?? Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color != null ? Colors.white : Colors.black54),
      ),
    );
  }

  Widget _detailRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: bold ? Colors.black : Colors.grey.shade600,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
