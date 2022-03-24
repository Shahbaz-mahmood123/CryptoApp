//
//  ZenNotificationsApp.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-03.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct ZenNotificationsApp: App {
    
    //connecting delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) ->Bool{
        
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, open url:URL, options: [UIApplication.OpenExternalURLOptionsKey:Any]) ->Bool{
        
        return GIDSignIn.sharedInstance.handle(url)
        
        
    }
}
