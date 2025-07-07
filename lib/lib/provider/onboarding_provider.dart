import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingProvider with ChangeNotifier {
  int currentPage = 0;
  final PageController pageController = PageController();

  onPageChanged(int index) {
    currentPage = index;
    notifyListeners();
  }

  // navigateToSignIn(BuildContext context) {
  //   context.router.pushAndPopUntil(
  //     const SignInScreen(),
  //     predicate: (route) => false,
  //   );
  // }
  void navigateToSignIn(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go('/sign_in_screen');
    });
  }

  onTapDown(TapDownDetails details, BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;
    // Get the tap position
    final tapPosition = details.globalPosition.dx;

    if (tapPosition < screenWidth / 2) {
      //On Left Click
      if (currentPage >= 0) {
        currentPage--;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      //On Right Click
      if (currentPage < 3) {
        currentPage++;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
    notifyListeners();
  }
}
