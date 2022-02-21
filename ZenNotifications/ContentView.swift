//
//  ContentView.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-03.
//

import SwiftUI
import GoogleSignIn
import Firebase

struct ContentView: View {
    
    @AppStorage("log_Status") var log_Status = false
    
    var body: some View {
        if log_Status{
            //Home view
            Home()
        }
        else{
            LoginPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
