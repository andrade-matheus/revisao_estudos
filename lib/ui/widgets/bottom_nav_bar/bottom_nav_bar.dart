import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/constants/app_icons.dart';
import 'package:revisao_estudos/models/typedef/typedef.dart';

class BottomNavBar extends StatefulWidget {
  final AtualizarIndexCallBack atualizaIndex;

  const BottomNavBar({
    Key? key,
    required this.atualizaIndex,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _index;

  @override
  void initState() {
    _index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.branco,
        border: Border(
          top: BorderSide(color: AppColors.navBarDivisorCinza),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColors.branco,
        selectedItemColor: AppColors.navBarItemLaranja,
        unselectedItemColor: AppColors.navBarItemCinza,
        elevation: 0.0,
        currentIndex: _index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(AppIcons.calendario),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.revisoes),
            label: 'Revisões',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.disciplinas),
            label: 'Disciplinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.frequencias),
            label: 'Frequências',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.configuracoes),
            label: 'Configurações',
          ),
        ],
        onTap: (index) {
          if (_index != index) {
            widget.atualizaIndex(index);
            setState(() {
              _index = index;
            });
          }
        },
      ),
    );
  }
}
