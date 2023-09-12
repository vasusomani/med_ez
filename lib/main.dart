import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'logic/utils/shared_preferences.dart';
import 'presentation/router/route_generator.dart';
import 'constants/colors.dart';

bool? loginStatus;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loginStatus = await HelperFunctions.getUserLoggedInStatus();
  debugPrint(loginStatus.toString());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Med-Ez',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: appBarColor),
        dividerColor: Colors.transparent,
        scaffoldBackgroundColor: bgPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: (loginStatus == null)
          ? '/'
          : (loginStatus == false)
              ? '/login'
              : '/home',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
