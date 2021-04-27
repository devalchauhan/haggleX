import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/core/presentation/widget/background.dart';
import 'package:hagglex/feature/auth/presantation/widgets/login_widgets.dart';
import 'package:hagglex/feature/auth/presantation/widgets/registration_widgets.dart';
import 'package:hagglex/feature/dashboard/presantation/pages/cryptosave_page.dart';
import 'package:hagglex/feature/dashboard/presantation/pages/dashboard_page.dart';
import 'package:hagglex/feature/dashboard/presantation/pages/more_page.dart';
import 'package:hagglex/feature/dashboard/presantation/pages/transfer_page.dart';
import 'package:hagglex/feature/dashboard/presantation/pages/wallet_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: kTextStyle,
    ),
    Text(
      'Index 1: Business',
      style: kTextStyle,
    ),
    Text(
      'Index 2: School',
      style: kTextStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          IndexedStack(
            index: _selectedIndex,
            children: [
              DashboardPage(),
              WalletPage(),
              TransferPage(),
              CryptoSavePage(),
              MorePage(),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horizontal_circle_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Cryptosave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kColorPrimary,
        unselectedItemColor: kColorPrimary20,
        onTap: _onItemTapped,
      ),
    );
  }
}
