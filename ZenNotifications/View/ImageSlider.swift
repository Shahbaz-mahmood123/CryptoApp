//
//  ImageSlider.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-05.
//

import SwiftUI

struct ImageSlider: View {
    @State var search = ""
    @State var index = 0
    @State var newsResponse: NewsResponse? = nil
    @ObservedObject var viewModel = NewsViewModel()
    
    var body: some View {
        GeometryReader{ geometryReader in
            LazyVStack {
                TabView(selection: $index) {
                    let count = viewModel.newsResponse?.news.count
                    ForEach(0...5, id: \.self) { index in
                        ZStack(alignment: .bottom){
                            HStack(alignment: .top){
                                let image =  URL(string: newsResponse?.news[index].images[1].url ?? "https://imageio.forbes.com/specials-images/dam/imageserve/908633080/960x0.jpg?fit=bounds&format=jpg&width=960")
                                AsyncImage( url: image){ image in image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                  
                                }
                            }.opacity(0.9)
                            VStack{
                            HStack(){
                                Text(newsResponse?.news[index].headline ?? "error getting latest news")
                                    .fontWeight(.heavy)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: geometryReader.size.width)
                                    .foregroundColor(.black)
                            }.padding()
                                HStack{
                                    let summary = newsResponse?.news[index].summary
                                    
                                    Text(summary ?? "Summary")
                                        .fontWeight(.light)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: geometryReader.size.width)
                                        .foregroundColor(.black)
                                }
                            }.frame(minHeight: geometryReader.size.height / 2)
                                .background(
                                    Rectangle()
                                        .opacity(0.8)
                                        .foregroundColor(.white)
                                )
                        }.tag(index)
                        
                    }
                }
                .frame(minWidth: geometryReader.size.width, minHeight:geometryReader.size.height)
                //.padding(.top, 25)
                .tabViewStyle(PageTabViewStyle())
               // .animation(.easeOut)
            }
            .padding(.vertical)
            
        }.onAppear{viewModel.fetchNews()}
    }
}
struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        TextGeneration()
    }
}
