import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/styles/colors.dart';
import '../bloc/account_bloc.dart';
import '../bloc/cart_bloc.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: IconNavBar(
        iconPath: 'assets/icons/icon_house.png',
        label: 'Home',
      ),
      activeIcon: IconNavBar(
        iconPath: 'assets/icons/icon_house.png',
        label: 'Home',
        isActive: true,
      ),
    ),
    const BottomNavigationBarItem(
      label: 'Cart',
      icon: IconNavBar(
        iconPath: 'assets/icons/icon_cart.png',
        label: 'Cart',
      ),
      activeIcon: IconNavBar(
        iconPath: 'assets/icons/icon_cart.png',
        label: 'Cart',
        isActive: true,
      ),
    ),
    const BottomNavigationBarItem(
      label: 'Profile',
      icon: IconNavBar(
        iconPath: 'assets/icons/icon_account.png',
        label: 'Profile',
      ),
      activeIcon: IconNavBar(
        iconPath: 'assets/icons/icon_account.png',
        label: 'Profile',
        isActive: true,
      ),
    ),
  ];

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AccountBloc>().add(GetAccountEvent());
      context.read<CartBloc>().add(GetCartsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavIndex,
        items: _bottomNavBarItems,
        backgroundColor: Colors.white,
        fixedColor: MyColor.primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (selected) {
          setState(() {
            bottomNavIndex = selected;
          });
        },
      ),
    );
  }
}

class IconNavBar extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool isActive;

  const IconNavBar({
    required this.label,
    required this.iconPath,
    this.isActive = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 25,
          width: 25,
          margin: const EdgeInsets.only(top: 15),
          child: Image.asset(
            iconPath,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        isActive
            ? Container(
                height: 4,
                width: 45,
                decoration: const BoxDecoration(
                  color: MyColor.primaryColor,
                ),
              )
            : const SizedBox(
                height: 5,
              ),
      ],
    );
  }
}
