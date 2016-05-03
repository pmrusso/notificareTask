import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var notificareService: NotificareService?
   
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        notificareService = NotificareService()
        notificareService!.start(withOptions: launchOptions)
        return true
    }
}

