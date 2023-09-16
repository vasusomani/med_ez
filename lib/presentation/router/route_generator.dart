import 'package:flutter/material.dart';
import '../components/page_navigator.dart';
import '../screen/dashboard_screen.dart';
import '../screen/login_screen.dart';
import '../screen/profile_screen.dart';
import '../screen/welcome_screen.dart';
import '../screen/video_screen.dart';

class RouteGenerator extends NavigatorObserver {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => PagesNavigator());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      // case '/webview': // Add the case for the web view route
      //   if (settings.arguments is List<String>) {
      //     final List<String> data = settings.arguments as List<String>;
      //     return MaterialPageRoute(
      //         builder: (_) => WebViewScreen(
      //               url: data[0],
      //               exerciseName: data[1],
      //             ));
      //   }
      //   return _errorRoute();
      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}

//Navigator.of(context).pushNamed('/webview', arguments: 'https://u.pcloud.link/publink/show?code=XZgcVNVZNOWUrQ2u8MhT2sdmGlHbvmUIhwxy');
