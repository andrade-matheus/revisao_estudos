import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/constants/app_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RevisaiBottomNavigationBar extends StatefulWidget {
  final TabsRouter tabsRouter;

  const RevisaiBottomNavigationBar({
    Key? key,
    required this.tabsRouter,
  }) : super(key: key);

  @override
  _RevisaiBottomNavigationBarState createState() => _RevisaiBottomNavigationBarState();
}

class _RevisaiBottomNavigationBarState extends State<RevisaiBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.navBarDivisorCinza),
        ),
      ),
      child: SalomonBottomBar(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        currentIndex: widget.tabsRouter.activeIndex,
        onTap: widget.tabsRouter.setActiveIndex,
        selectedItemColor: AppColors.navBarItemLaranja,
        unselectedItemColor: AppColors.navBarItemCinza,
        items: [
          SalomonBottomBarItem(
            icon: Icon(
              AppIcons.calendario,
              size: 30,
            ),
            title: const Text('Calendário'),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              AppIcons.revisoes,
              size: 30,
            ),
            title: const Text('Revisões'),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              AppIcons.disciplinas,
              size: 30,
            ),
            title: const Text('Disciplinas'),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              AppIcons.frequencias,
              size: 30,
            ),
            title: const Text('Frequências'),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              AppIcons.configuracoes,
              size: 30,
            ),
            title: const Text('Configurações'),
          ),
        ],
      ),
    );
  }
}
