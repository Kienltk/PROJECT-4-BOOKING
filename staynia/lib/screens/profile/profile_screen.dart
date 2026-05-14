import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/button/app_button.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/widgets/custom_scaffold.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/data/entity/enum/app_button_type.dart';
import 'package:staynia/providers/manager/user/user_bloc.dart';
import 'package:staynia/providers/manager/user/user_event.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseScreen<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildScreen(context);
  }

  @override
  Widget buildScreen(BuildContext context) {
    return CustomScaffold(
      bodyBuilder: (user) {
        return SingleChildScrollView(
          child: ContainerBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Box.s70,
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: user!.document != null
                      ? NetworkImage(user.document!.imageUrl!)
                      : null,
                  child: user.document == null
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  user.fullName ?? user.username ?? '-',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email ?? "-",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),
                _buildInfoTile('Phone number', user.phone),
                _buildInfoTile('Address', user.address),
                _buildInfoTile('Status', _statusText(user.status)),
                _buildInfoTile(
                  'Account type',
                  (user.type == 1 || user.type == "1") ? " Admin" : "User",
                ),
                const SizedBox(height: 30),
                AppButton(
                  content: 'Logout',
                  type: AppButtonType.primary,
                  onClick: () {
                    context.read<UserBloc>().add(LogoutSubmit());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoTile(String title, String? value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                value?.isNotEmpty == true ? value! : '-',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusText(int? status) {
    switch (status) {
      case 1:
        return 'Active';
      case 0:
        return 'InActive';
      default:
        return '-';
    }
  }
}
