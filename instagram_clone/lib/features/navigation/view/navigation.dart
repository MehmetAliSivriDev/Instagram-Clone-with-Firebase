import 'package:flutter/material.dart';
import '../../profile/view/profile_view.dart';
import '../../../core/theme/theme_notifier.dart';
import '../../add/view/add_view.dart';
import '../../home/view/home_view.dart';
import '../view_model/navigation_view_model.dart';
import '../../../product/constant/product_color.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<NavigationViewModel>(context, listen: false);
    viewModel.init();
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: viewModel.onPageChanged,
        controller: viewModel.pageController,
        children: const [
          HomeView(),
          Center(
            child: Text("2. Sayfa"),
          ),
          AddView(),
          Center(
            child: Text("4. Sayfa"),
          ),
          Center(
            child: ProfileView(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Consumer<NavigationViewModel>(
      builder: (context, viewModel, _) {
        return BottomNavigationBar(
          backgroundColor: context.watch<ThemeNotifier>().isLightTheme
              ? ProductColor.instance.white
              : ProductColor.instance.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: context.sized.dynamicHeight(0.04),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: context.watch<ThemeNotifier>().isLightTheme
              ? ProductColor.instance.black
              : ProductColor.instance.white,
          unselectedItemColor: ProductColor.instance.grey600,
          onTap: viewModel.navigationTapped,
          currentIndex: viewModel.currentIndex,
          items: const [
            BottomNavigationBarItem(
                label: "Home", icon: Icon(Icons.home_filled)),
            BottomNavigationBarItem(label: "2", icon: Icon(Icons.search_sharp)),
            BottomNavigationBarItem(label: "3", icon: Icon(Icons.add)),
            BottomNavigationBarItem(
                label: "4",
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite)),
            BottomNavigationBarItem(label: "5", icon: Icon(Icons.person)),
          ],
        );
      },
    );
  }
}
