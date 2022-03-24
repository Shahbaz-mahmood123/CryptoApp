//
//  Settings.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-21.
//

import SwiftUI
import Firebase
import GoogleSignIn
import ModelIO

struct Settings: View {
    @AppStorage("log_Status") var log_Status = true
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("General")){
                    Button{logout() }label: {
                        Text("Logout")
                            .font(.title3)
                            .fontWeight(.medium)
                            .kerning(1.1)
                    }
                }
                Section(header: Text("Display")){
                    Toggle(isOn: .constant(true),
                           label: {
                        Text("Dark Mode")
                    }
                    )
                }
               
            }.navigationTitle("Settings")
                .listStyle(GroupedListStyle())
            


          
        }
        
        
    }
    
    func logout (){
        guard let clientID = FirebaseApp.app()?.options.clientID else{ return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signOut()
        log_Status = false
        
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}


