import UIKit
import Flutter
import GoogleMaps
import Firebase
import FirebaseAuth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    /*if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }*/
    GMSServices.provideAPIKey("AIzaSyDFDQjJ3yDV-yrOVaB6UcVfvQOEIZm0SYI")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    /*override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let firebaseAuth = Auth.auth()
        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)
    }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let firebaseAuth = Auth.auth()
        if (firebaseAuth.canHandleNotification(userInfo)){
            // print(userInfo)
            completionHandler(.noData)
            return
        }
        // https://firebase.google.com/docs/cloud-messaging/ios/receive#handle_messages
         Messaging.messaging().appDidReceiveMessage(userInfo)
    }*/
}
