import 'package:flutter/material.dart';
import 'package:revisao_estudos/constants/app_colors.dart';
import 'package:revisao_estudos/models/typedef/typedef.dart';

class NavBar extends StatefulWidget {
  final AtualizarIndexCallBack atualizaIndex;

  const NavBar({
    Key key,
    @required this.atualizaIndex,
  }) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _index;

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
            icon: Icon(Icons.calendar_today),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            label: 'Revisões',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Disciplinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.repeat),
            label: 'Frequências',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
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
