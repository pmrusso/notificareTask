import Foundation

let UpdateRegionsNotificationKey = "com.pushMapTest.app"

class NotificareService:NSObject, NotificarePushLibDelegate{
    
    func start(withOptions launchOptions: [NSObject: AnyObject]?){
        NotificarePushLib.shared().launch()
        NotificarePushLib.shared().delegate = self
        NotificarePushLib.shared().handleOptions(launchOptions)
    }
    
    func notificarePushLib(library: NotificarePushLib!, onReady info: [NSObject : AnyObject]!) {
        NotificarePushLib.shared().registerForWebsockets()
        NotificarePushLib.shared().registerUserNotifications()
    }
    
    func notificarePushLib(library: NotificarePushLib!, didRegisterForWebsocketsNotifications uuid: String!) {
        library!.registerDeviceForWebsockets(uuid, completionHandler: { _ in
            NotificarePushLib.shared().startLocationUpdates()
            }, errorHandler: { error in
                print(error.description)
        })
    }
    
    func notificarePushLib(library: NotificarePushLib!, didReceiveWebsocketNotification info: [NSObject : AnyObject]!) {
        NotificarePushLib.shared().openNotification(info)
    }
    
    func notificarePushLib(library: NotificarePushLib!, didStartMonitoringForRegion region: CLRegion!) {
        sendNotificationOfUpdatedRegions()
    }
    
    func notificarePushLib(library: NotificarePushLib!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        print(error)
    }
    
    func notificarePushLib(library: NotificarePushLib!, didUpdateLocations locations: [AnyObject]!) {
        sendNotificationOfUpdatedRegions()
    }
    
    private func sendNotificationOfUpdatedRegions() {
        NSNotificationCenter.defaultCenter().postNotificationName(UpdateRegionsNotificationKey, object: self)
    }
}