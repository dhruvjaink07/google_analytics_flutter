import 'package:analytics_test/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

class AnalyticsEngine {
  static final _instance = FirebaseAnalytics.instance;
  static Future<void> init(){
    return Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
  static void _userLogsin(String loginMethod) async {
    return _instance.logLogin(loginMethod: loginMethod);
  }
  static Future<void> addItemToCart(String itemId,int cost){
    return _instance.logAddToCart(items: [AnalyticsEventItem(itemId: itemId,price: cost)]);
  }

  static void counterPressed()async{
    return _instance.logEvent(name: 'counterPressed');
  }
}
