//
//  TextGeneration.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-21.
//

import SwiftUI

struct TextGeneration: View {
    
    @State var prompt: String = "Should i invest in bitcoin?"
    @State var response: Response? = nil
    @State var newsResponse: NewsResponse? = nil
    var body: some View {
        
        TabView{
            VStack(alignment: .leading){
                
                HStack{
                    ImageSlider()
                }
                HStack(){

                }
                
//                HStack{
//                    GroupBox(label:
//                                Label("Enter some text below to get a TL;DR", systemImage: "square.and.pencil")
//                    ) {
//                        TextEditor(text: $prompt).foregroundColor(Color.gray)
//                            .font(.custom("HelveticaNeue", size: 13))
//                            .lineSpacing(5)
//                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150, alignment: .topLeading)
//
//                            .frame(height: 200)
//                    }
//
//
//                }
//                HStack{
//                    Button(action: {GPT3TextComepletion().textCompletion(promptText: prompt, completion: {(response) in self.response = response })}) {
//                        Text("Submit")
//                    }.padding(20)
//                        .foregroundColor(Color.white)
//                        .background(Color.blue)
//                    //.scaleEffect(configuration.isPressed ? 0.95 : 1)
//                    VStack{
//                        Text(response?.choices[0].text ?? "some data")
//
//                    }
//                }
            }
            
            
        }.background(){
            Ellipse()
                .fill(Color.blue)
            .opacity(0.3)}
        .onAppear{AlpacaService().getnews(completion: {(newsResponse) in self.newsResponse = newsResponse })}
        
        
    }
}

struct TextGeneration_Previews: PreviewProvider {
    static var previews: some View {
        TextGeneration()
            .preferredColorScheme(.light)
    }
}
