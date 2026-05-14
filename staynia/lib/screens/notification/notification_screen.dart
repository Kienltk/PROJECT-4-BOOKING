import 'package:flutter/material.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/core/base/base_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends BaseScreen<NotificationScreen> {
  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: 'Notification', divider: true));
  }
}
