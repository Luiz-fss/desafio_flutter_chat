import 'package:flutter/material.dart';

import '../../../utils/enums/home_menu_action.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final VoidCallback onLogout;


  const HomeAppBar({
    super.key,
    required this.title,
    required this.onLogout,
  });


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFF667EEA),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actions: [
        PopupMenuButton<HomeMenuAction>(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onSelected: (action) {
            switch (action) {
              case HomeMenuAction.logout:
                onLogout();
                break;
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem<HomeMenuAction>(
                value: HomeMenuAction.logout,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 20,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text('Sair'),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(
    kToolbarHeight,
  );
}