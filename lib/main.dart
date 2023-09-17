import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'logic/utils/shared_preferences.dart';
import 'presentation/router/route_generator.dart';
import 'constants/colors.dart';

bool? loginStatus;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loginStatus = await HelperFunctions.getUserLoggedInStatus();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  runApp(const ProviderScope(child: MyApp()));
  AlanVoice.addButton(
    "c25662af6edb2b8a6d36dcb5ba0cc49f2e956eca572e1d8b807a3e2338fdd0dc/prod",
    buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT,
    bottomMargin: 100,
  );
  AlanVoice.deactivate();
  AlanVoice.hideButton();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AlanVoice.deactivate();
    AlanVoice.hideButton();
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
