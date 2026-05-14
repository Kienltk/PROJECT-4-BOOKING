import 'package:flutter/material.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/core/theme/custom_theme.dart';

class EntryBottomNavigationBar extends StatelessWidget {
  final int index;
  final Function(int i) onClick;
  final List<Map<String, dynamic>> items;
  const EntryBottomNavigationBar({
    super.key,
    required this.index,
    required this.items,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(left: 6, right: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          shadowTop(color: const Color.fromARGB(137, 157, 157, 157), offset: const Offset(1, 5)),
        ],
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: onClick,
            useLegacyColorScheme: false,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            selectedFontSize: 8,
            unselectedItemColor: Colors.grey,
            items: items.map((item) {
              return _buildBottomBarItem(
                icon: item['icon'],
                label: item['label'],
                size: item['size'],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomBarItem({
    required String icon,
    required String label,
    required double size,
  }) {
    return BottomNavigationBarItem(
      icon: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppAssetIcon(icon, color: Colors.grey, size: size),
          const SizedBox(height: 1),
          _buildLable(label, Colors.grey),
        ],
      ),
      activeIcon: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAssetIcon(icon, color: primaryColor700, size: size),
          const SizedBox(height: 2),
          _buildLable(label, primaryColor700),
        ],
      ),
      label: '',
    );
  }

  Widget _buildLable(label, color) => Text(
    label,
    textAlign: TextAlign.center,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
  );
}
