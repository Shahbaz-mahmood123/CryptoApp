//
//  TextGeneration.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-21.
//

import SwiftUI

struct TextGeneration: View {
    
    @State var prompt: String = "Should i invest in bitcoin?"
//    @State var response: Response? = nil
//    @State var newsResponse: NewsResponse? = nil
    var body: some View {
        
        TabView{
            VStack(alignment: .leading){
                
                HStack{
                    ImageSlider()
                }
                HStack(){
                }
            }
        }.background(){
            Ellipse()
                .fill(Color.blue)
            .opacity(0.3)}
//        .onAppear{AlpacaService().getnews(completion: {(newsResponse) in self.newsResponse = newsResponse })}
        
        
    }
}

struct TextGeneration_Previews: PreviewProvider {
    static var previews: some View {
        TextGeneration()
            .preferredColorScheme(.light)
    }
}
