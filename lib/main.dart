import 'app/services/clear_focus_observer.dart';
import 'app/utils/import.dart';
import 'app/utils/scroll_behavior.dart';

@pragma('vm:entry-point')
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      config: const ToastificationConfig(
        animationDuration: Duration(milliseconds: 250),
        alignment: Alignment.topCenter,
        maxToastLimit: 1,
      ),
      child: GetMaterialApp(
        title: AppConstant.appName,
        debugShowCheckedModeBanner: false,
        getPages: AppPage.routes,
        initialRoute: AppPage.initial,
        initialBinding: AppBinding(),
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.system,
        scrollBehavior: AppScrollBehavior(),
        defaultTransition: Transition.cupertino,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorObservers: [
          ClearFocusOnNavigateObserver(),
          if (AppConstant.isFirebaseEnabled) AppAnalyticsObserver(),
        ],
        builder: (context, child) => AppBuilder(child: child!),
      ),
    );
  }
}
