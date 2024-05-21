//
//  AppDelegate.swift
//  UniviaFarmer
//
//  Created by Nik on 16/01/23.
//

import UIKit
//import IQKeyboardManagerSwift
//import GoogleMaps
import Loaf
import ObjectMapper
//import Firebase
//import FirebaseMessaging
//import UserNotifications
//import FirebaseFirestore
//import FirebaseCore


let APPLICATION_DELEGATE = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
//    let getLocation = GetLocation()
    var viewControllers = UIViewController()
  //  var geoCoder = CLGeocoder()
   // var stateListModel = [StateListModel]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//   //     FirebaseApp.configure()
//        
//        //Get Firebase data
//        getFirebaseData()
//        
//        // IQKeyboardManager
//   //     IQKeyboardManager.shared.enable = true
//        
//        // Google map
//    //    GMSServices.provideAPIKey(AppKeys.GoogleMapKey.rawValue)
        
//        checkReachability()
//        
//        // Get state list
//        getLocalStateList()
//        
//        // Push Notification
//        pushNotificationInit(application: application)
    /*
         Get User data
        if getUserData() != nil {
            if getString(key: userDefaultsKeys.token.rawValue) != "" {
                UserToken.userToken = getString(key: userDefaultsKeys.token.rawValue)
            }
            if getString(key: userDefaultsKeys.languageID.rawValue) != "" {
                UserLoginData.languageID = getString(key: userDefaultsKeys.languageID.rawValue)
            }
            UserLoginData.userData = getUserData()
            
            AppLabel.arrLanguageLabelList = getLanguageData()
            setLableUniversal()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tabBarController()
            }
        }
        
         Get Location
        getLocation.run { [self] in
            if let location = $0 {
                print("location = \(location.coordinate.latitude) \(location.coordinate.longitude)")
                UserLoginData.Latitude = location.coordinate.latitude
                UserLoginData.Longitude = location.coordinate.longitude
                
                self.getCurrentState()
            } else {
                print("Get Location failed \(getLocation.didFailWithError)")
            }
        }
        
        
        return true
    }
    
    //MARK: - Navigate controller -
    
    func tabBarController(){
        let controller = tabBarStoryboard().instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        let navigate = UINavigationController(rootViewController: controller)
        APPLICATION_DELEGATE.window?.rootViewController = navigate
    }
    
     MARK:- API Call
    func genarateUserToken(completion: @escaping (_ statuscode: Bool) -> Void) {
        DataManager.shared.getUserToken { [weak self] (result) in
            switch result {
            case .success(let userModel):
                UserToken.userToken = (userModel.Result![0].token)!
                saveString(strin: UserToken.userToken, key: userDefaultsKeys.token.rawValue)
                
                completion(true)
                
            case .failure(let apiError):
                print("Error ", apiError.localizedDescription)
                completion(false)
            }
        }
    }

        func toastMessage(message: String){
            //        Loaf(message, location: .bottom, sender: self).show()
            Loaf(message, state: .custom(.init(backgroundColor: .black, icon: nil, textAlignment: .center, width: .screenPercentage(0.8))), sender: (window?.rootViewController)!).show(.custom(1.0))
            
        }
    
    func toastMessageViewController(message: String, controller: UIViewController){
        //        Loaf(message, location: .bottom, sender: self).show()
        Loaf(message, state: .custom(.init(backgroundColor: .black, icon: nil, textAlignment: .center, width: .screenPercentage(0.8))), sender: controller).show(.custom(1.0))
    }

    func imagePreviewViewController(url: String){
        let controller = detailsStoryboard().instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
        controller.imageURL = url
        let navigate = UINavigationController(rootViewController: controller)
        navigate.modalPresentationStyle = .overFullScreen
        navigate.hidesBottomBarWhenPushed = true
        presentViewController(viewController: navigate)
    }
    
    //MARK: - Notification init -
    
    func pushNotificationInit(application: UIApplication){
        // notification
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                AppSetting.FCMTokenString = token
            }
        }
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
            if (granted)
            {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    //MARK: - checkReachability
    func checkReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: Notification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reachability().monitorReachabilityChanges()
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let status = userInfo["Status"] as! String
            print("status ", status)
        }
    }
   */
    func checkInternetConnection() -> Bool {
        let status = Reachability().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            return false
        case .online(.wwan):
            print("Connected via WWAN")
            return true
        case .online(.wiFi):
            print("Connected via WiFi")
            return true
        }
    }
    /*
    //MARK: - Get firebase
    func getFirebaseData(){
        
        let storage = Firestore.firestore()
        
        storage.collection("ForceUpdate").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    print("Service ", document.get("Service") ?? "")
                    print("UFAIOS ", document.get("UFAIOS") ?? "")
                    print("ShowPopupUFA ", document.get("ShowPopupUFA") ?? "")
                    print("delete account ", document.get("DeleteAccount") ?? "")
                    
                    StoreLink.firebaseAppVersion = "\(document.get("UFAIOS") ?? "")"
                    StoreLink.showPoupup = "\(document.get("ShowPopupUFA") ?? "")"
                    StoreLink.isAvailable = "\(document.get("Service") ?? "")"
                    StoreLink.deleteAccount = document.get("DeleteAccount") as! Int
                }
                
                NotificationCenter.default.post(name: Notification.Name("forceUpdateClick"), object: nil)
            }
        }
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        getFirebaseData()
    }
    */
        return true
}

//MARK: - Get current state
//extension AppDelegate {
//    func getLocalStateList(){
//        if let path = Bundle.main.path(forResource: "india_states_codes", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                if let jsonResult = jsonResult as? NSArray {
//                    // do stuff
//                    let parsedZones = Mapper<StateListModel>().mapArray(JSONObject: jsonResult)
//                    self.stateListModel = parsedZones ?? []
//                    //                    parsedZones?.forEach({ (element) -> Void in
//                    //                        print(element.code)
//                    //                    })
//                }
//            } catch {
//                // handle error
//            }
//        }
//    }
//    
//    func getCurrentState(){
//        let position = CLLocation(latitude: UserLoginData.Latitude, longitude: UserLoginData.Longitude)
//        
//        geoCoder.reverseGeocodeLocation(position) { response , error in
//            if error != nil {
//                print("GMSReverseGeocode Error: \(String(describing: error?.localizedDescription))")
//            }else {
//                if let placeMark = response?.first {
//                    
//                    //                    let placeName = placeMark.name ?? placeMark.subThoroughfare ?? placeMark.thoroughfare!   ///Title of Marker
//                    //Formatting for Marker Snippet/Subtitle
//                    
//                    UserLoginData.CityName = placeMark.locality ?? ""
//                    
//                    let filterData = self.stateListModel.filter({$0.code == placeMark.administrativeArea})
//                    if filterData.count > 0 {
//                        UserLoginData.StateName = filterData[0].name ?? ""
//                    }
//                    print("StateName ", UserLoginData.StateName)
//                    if UserLoginData.StateName == "" {
//                        self.getCurrentState()
//                    }
//                }
//            }
//        }
//    }
//}

//MARK: - Notification delegate -

//extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        print("Firebase registration token: \(fcmToken ?? "")")
//        
//        let dataDict:[String: String] = ["token": fcmToken ?? ""]
//        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//        // TODO: If necessary send token to application server.
//        // Note: This callback is fired at each app startup and whenever a new token is generated.
//    }
//    
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        // if error
//        print("i am not available in simulator \(error)")
//    }
//    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
//        // for device token
//        var token = ""
//        for i in 0..<deviceToken.count {
//            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
//        }
//        
//        print("\(token) Application tokan.")
//        
//        AppSetting.FCMTokenString = token
//        Messaging.messaging().apnsToken = deviceToken
//    }
//    
//    // Push notification received
//    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
//        print("data :-", data)
//    }
//    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> ()) {
//        print("userInfo :-", userInfo)
//    }
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert, .badge, .sound])
//    }
//    // Push notification received
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        
//        if let messageID = userInfo as? NSDictionary {
//            print("Message ID: \(messageID)")
//            if let tempData = messageID["gcm.notification.payload"] as? String{
//                
//                if getUserData() != nil {
//                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                        
//                        
//                        if getString(key: userDefaultsKeys.token.rawValue) != "" {
//                            UserToken.userToken = getString(key: userDefaultsKeys.token.rawValue)
//                            
//                            self.convertStringJsonToObjectJson(StringJson: tempData)
//                        }
//                        
//                        
//                        else {
//                            
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
//                            
//                            if let topVC = UIApplication.topMostViewController {
//                                topVC.navigationController?.pushViewController(destinationViewController, animated: false)
//                            }
//                            
//                        }
//                    }
//                }
//                
//            }
//        }
//        completionHandler()
//    }
//    
//    
//    func convertStringJsonToObjectJson(StringJson:String){
//        
//        var dictonary:NSDictionary?
//        
//        
//        if let data = StringJson.data(using: String.Encoding.utf8) {
//            
//            do {
//                dictonary =  try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String:AnyObject] as NSDictionary?
//                
//                if let myDictionary = dictonary
//                {
//                    print(" NavigationName \(myDictionary["navigation"]!)")
//                    
//                    if myDictionary["navigation"] as! String == NavigationTitle.Product{
//                        
//                        NavigationBrandCategory.productID = myDictionary["product_id"] as! String
//                        print("this is title Product")
//                        redirectionFromNotification(navigationScreen: NavigationTitle.Product)
//                        
//                    }
//                    else if myDictionary["navigation"] as! String  == NavigationTitle.Category{
//                        print("this is title Category")
//                        
//                        NavigationBrandCategory.CategoryId = myDictionary["category_id"] as! String
//                        
//                        redirectionFromNotification(navigationScreen: NavigationTitle.Category)
//                        
//                    }
//                    else if myDictionary["navigation"]  as! String == NavigationTitle.Order{
//                        print("this is title order")
//                        NavigationBrandCategory.orderID = myDictionary["product_id"] as! String
//                        
//                        redirectionFromNotification(navigationScreen: NavigationTitle.Order)
//                        
//                    }
//                    else if myDictionary["navigation"]  as! String == NavigationTitle.Blog{
//                        print("this is title blog")
//                        NavigationBrandCategory.BlogID = myDictionary["product_id"] as! String
//                        
//                        redirectionFromNotification(navigationScreen: NavigationTitle.Blog)
//                        
//                    }
//                    else if myDictionary["navigation"]  as! String == NavigationTitle.Brand{
//                        print("this is title doctor")
//                        NavigationBrandCategory.BrandId = myDictionary["brand_id"] as! String
//                        
//                        redirectionFromNotification(navigationScreen: NavigationTitle.Brand)
//                        
//                    }
//                    else if myDictionary["navigation"]  as! String == NavigationTitle.Home{
//                        print("this is title Home")
//                        //                    NavigationBrandCategory.BrandId = myDictionary["brand_id"] as! String
//                        
//                        redirectionFromNotification(navigationScreen: NavigationTitle.Home)
//                        
//                    }
//                    else if myDictionary["navigation"]  as! String == NavigationTitle.Other{
//                        print("this is title Other")
//                        //                    NavigationBrandCategory.BrandId = myDictionary["brand_id"] as! String
//                        
//                        redirectionFromNotification(navigationScreen: NavigationTitle.Other)
//                        
//                    }
//                    else if myDictionary["navigation"]  as! String == NavigationTitle.Doctor{
//                        print("this is title Other")
//                        NavigationBrandCategory.questionID = myDictionary["product_id"] as! String
//                        
//                        redirectionFromNotification(navigationScreen: NavigationTitle.Doctor)
//                        
//                    }
//                    
//                }
//            } catch let error as NSError {
//                
//                print(error)
//            }
//        }
//    }
// 
//    func redirectionFromNotification(navigationScreen:String){
//        
//        if navigationScreen == NavigationTitle.Product {
//            
//            if Int(NavigationBrandCategory.productID) ?? 0 != 0 {
//                
////                let rootViewController = self.window!.rootViewController as! UINavigationController
////
////                let profileViewController = detailsStoryboard().instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
////                        profileViewController.productId = Int(NavigationBrandCategory.productID) ?? 0
////
////                        rootViewController.pushViewController(profileViewController, animated: true)
////
//                
//                let productDetailVc = detailsStoryboard().instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
//
//                productDetailVc.productId = Int(NavigationBrandCategory.productID) ?? 0
//                print("product id from notification \(Int(NavigationBrandCategory.productID) ?? 0)")
//
//                if let topVC = UIApplication.topMostViewController {
//                    topVC.navigationController?.pushViewController(productDetailVc, animated: false)
//                }
//                
//                
//            }
//            
//        }else if navigationScreen == NavigationTitle.Category {
//            
//            if NavigationBrandCategory.CategoryId != "" {
//                
////                let rootViewController = self.window!.rootViewController as! UINavigationController
////
////                let profileViewController = detailsStoryboard().instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
////                profileViewController.categoryID = NavigationBrandCategory.CategoryId
////
////                        rootViewController.pushViewController(profileViewController, animated: true)
////
//                
//                let categoryVc = detailsStoryboard().instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
//                categoryVc.categoryID = NavigationBrandCategory.CategoryId
//                print("category id from notification \(NavigationBrandCategory.CategoryId)")
//
//                if let topVC = UIApplication.topMostViewController {
//                    topVC.navigationController?.pushViewController(categoryVc, animated: false)
//                }
//            }
//            
//            
//            
//        }else if navigationScreen == NavigationTitle.Order {
//            
//            if NavigationBrandCategory.orderID != "" {
//                
//                
//                
//                let orderVC = sideMenuStoryboard().instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
//                orderVC.orderId = NavigationBrandCategory.orderID
//                print("orderID = from notification \(NavigationBrandCategory.orderID)")
//                if let topVC = UIApplication.topMostViewController {
//                    topVC.navigationController?.pushViewController(orderVC, animated: false)
//                }
//            }
//            
//            
//            
//        }else if navigationScreen == NavigationTitle.Other {
//            
//            let profileVc = MyProfileStoryboard().instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
//            
//            if let topVC = UIApplication.topMostViewController {
//                topVC.navigationController?.pushViewController(profileVc, animated: false)
//            }
//            
//        }
//        else if navigationScreen == NavigationTitle.Blog {
//            
//            if NavigationBrandCategory.BlogID != "" {
//                let profileVc = categoryStoryboard().instantiateViewController(withIdentifier: "BlogDetail") as! BlogDetailViewController
//                
//                profileVc.getBlogId = NavigationBrandCategory.BlogID
//                if let topVC = UIApplication.topMostViewController {
//                    topVC.navigationController?.pushViewController(profileVc, animated: false)
//                }
//                
//            }
//            
//        }
//        else if navigationScreen == NavigationTitle.Brand {
//            
//            let profileVc = detailsStoryboard().instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
//            
//            profileVc.brandId = NavigationBrandCategory.BrandId
//            if let topVC = UIApplication.topMostViewController {
//                topVC.navigationController?.pushViewController(profileVc, animated: false)
//            }
//            
//        }
//        else if navigationScreen == NavigationTitle.Home {
//            
//            tabBarController()
//            
//        }
//        else if navigationScreen == NavigationTitle.Doctor {
//        
//            if NavigationBrandCategory.questionID != ""{
//                let profileVc = detailsStoryboard().instantiateViewController(withIdentifier: "QuestionDetailsViewController") as! QuestionDetailsViewController
//                
//                profileVc.questionID = NavigationBrandCategory.questionID
//                if let topVC = UIApplication.topMostViewController {
//                    topVC.navigationController?.pushViewController(profileVc, animated: false)
//                }
//            }
//        }
//    }
//}


//Dymamic link
//extension AppDelegate {
//    
//    
//    func getQueryStringParameter(url: String, param: String) -> String? {
//      guard let url = URLComponents(string: url) else { return nil }
//      return url.queryItems?.first(where: { $0.name == param })?.value
//    }
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        
//        if let incomingURL = userActivity.webpageURL {
//            let newURL = URL(string: "\(incomingURL)")!
//            
//            let components = URLComponents(string: "\(incomingURL)")!
//            
//            let Link = components.queryItems!.first(where: { queryItem -> Bool in
//                queryItem.name == "link"
//            })!.value!
//            
//            print("product id \(Link)")
//            
//            let url = URL(string: "\(Link)")!
//
//            let type = url["type"]  // "blah"
//            print("type is \(type)")
//         
//            if type == DynamicLinkNavigationType.Doctor {
//                let typeId = url["IdQuestionId"]  // "blah"
//                print("QuestionId is \(typeId)")
//                
//                let profileVc = detailsStoryboard().instantiateViewController(withIdentifier: "QuestionDetailsViewController") as! QuestionDetailsViewController
//                
//                profileVc.questionID = typeId ?? ""
//                if let topVC = UIApplication.topMostViewController {
//                    topVC.navigationController?.pushViewController(profileVc, animated: false)
//                }
//                
//            }else if type == DynamicLinkNavigationType.Product{
//                let typeId = url["ProductId"]  // "blah"
//                print("ProductId is \(typeId)")
//                
//                
//                let productDetailVc = detailsStoryboard().instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
//                
//                let myString = typeId
//                let myInt = (myString as! NSString).integerValue
//                
//                productDetailVc.productId = myInt
//
//                if let topVC = UIApplication.topMostViewController {
//                    topVC.navigationController?.pushViewController(productDetailVc, animated: false)
//                }
//                
//            }else if type == DynamicLinkNavigationType.Blog{
//                let typeId = url["BlogId"]  // "blah"
//                print("BlogId is \(typeId)")
//                
//                
//                let profileVc = categoryStoryboard().instantiateViewController(withIdentifier: "BlogDetail") as! BlogDetailViewController
//                
//                profileVc.getBlogId = typeId ?? ""
//                if let topVC = UIApplication.topMostViewController {
//                    topVC.navigationController?.pushViewController(profileVc, animated: false)
//                }
//            }
////            handleIncomingURL(incomingURL)
//           
//        }
//        
//        return false
//        
//    }
}
