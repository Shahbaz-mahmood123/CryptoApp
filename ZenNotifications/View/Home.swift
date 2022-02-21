//
//  Home.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-21.
//

import SwiftUI


let image = UIImage(systemName: "multiply.circle.fill")
struct Home: View {
    var body: some View {
        NavigationView {
            TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                Homepage().tabItem {  Label("Home", systemImage: "list.dash")}.tag(1)
                TextGeneration().tabItem { Label("Text Generation", systemImage: "square.and.pencil") }.tag(2)
                Settings().tabItem { Label("Settings", systemImage: "person") }.tag(3)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
