import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:star_astro/common/utils/api_constant.dart';
import 'package:star_astro/common/utils/global.dart';
import 'package:star_astro/lib/provider/home/home_provider.dart';
import 'package:star_astro/lib/screens/home/page/home_page_view.dart';
import 'package:star_astro/lib/screens/settings/edit_profile/edit_profile.dart';
import '../../../widgets/app_scaffold.dart';
import 'widget/home_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true; // Track loading state
  bool _hasShownProfileDialog = false; // Track profile dialog

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await homeProvider.getUserDetail(context);
    setState(() {
      _isLoading = false;
    });
    _checkProfileCompletion(context);
  }

  void _checkProfileCompletion(BuildContext context) {
    if (_hasShownProfileDialog) return;

    final globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    final firstName = globalProvider.userModel?.firstName ?? '';

    if (firstName.isEmpty || firstName == ' ') {
      _hasShownProfileDialog = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1A2B4D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Text(
              'Complete Your Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sora',
              ),
            ),
            content: const Text(
              'plete your profile to continue.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Sora',
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Go to Profile',
                  style: TextStyle(
                    color: Color(0xFF1A2B4D),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Sora',
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    print("HomeScreen build method called");
    log("Access token in home $accessToken");
    return AppScaffold(
      body: _buildHomeView(context),
      bottomNavigationBar: HomeBottomNavigationBar(
        homeProvider: homeProvider,
        scrollController: _scrollController,
      ),
      floatingActionButton: _floatingButton(homeProvider),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHomeView(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(decoration: TextDecoration.none),
      child: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Consumer<HomeProvider>(
                builder: (context, value, child) {
                  return IndexedStack(
                    index: value.selectedBottomId == 1 ? 0 : 1,
                    children: [
                      HomePageView(scrollController: _scrollController),
                      const SizedBox.shrink(),
                    ],
                  );
                },
              ),
      ),
    );
  }

  Widget _floatingButton(HomeProvider homeProvider) {
    return SizedBox(
      height: 70.0,
      width: 70.0,
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () => homeProvider.onBottomItemClick(2, context),
        child: Lottie.asset('assets/siri.json'),
      ),
    );
  }
}
