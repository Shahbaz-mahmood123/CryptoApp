//
//  HistoricalDailyDataChart.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-02-26.
//

import SwiftUI



struct HistoricalDailyDataChart: View {
    var data: [CGFloat]

    @State var currentPlot = ""
    @State var offset: CGSize = .zero
    @State var showPlot = false
    @State var translation: CGFloat = 0
   
    var body: some View {
        GeometryReader{ proxy in
            
            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(data.count - 1)
            
            let maxPoint = (data.max() ?? 0) + 100
            
            let points = data.enumerated().compactMap{ item -> CGPoint in
                
                let progress = item.element / maxPoint
                
                let pathHeight = progress * height
                
                let pathWidth = width * CGFloat(item.offset)
                
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            ZStack{
                Path{ path in
                    
                    path.move(to: CGPoint(x: 0, y: 0))
                    
                    path.addLines(points)
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))

                .fill(
                    
                    LinearGradient(colors: [
                        
                        Color(red: 1.0, green: 0.1, blue: 0.8),
                    
                    ], startPoint: .leading, endPoint: .trailing)
                )
                fillBG()
               
                    .clipShape(
                    
                        Path{ path in
                            
                            
                            path.move(to: CGPoint(x: 0, y: 0))
                            
                            path.addLines(points)
                            
                            path.addLine(to: CGPoint(x:proxy.size.width, y:height))
                            
                            path.addLine(to: CGPoint(x:0, y:height))
                            
                                                        
                        }
                    )
                    //.padding(.top, 1)
            }
            .overlay(
                
                VStack(spacing:0) {
                    
                    Text(currentPlot)
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.vertical,6)
                        .padding(.horizontal,10)
                        .background(Color(red: 0.4, green: 0.1, blue: 0.2), in: Capsule())
                        .offset(x: translation < 10 ? 30: 0)
                        .offset(x: translation > (proxy.size.width - 60) ? -30: 0)
                        
                    
                    
                    Rectangle()
                        .fill(Color(red: 0.4, green: 0.1, blue: 0.2))
                        .frame(width:1, height: 45)
                    
                    Circle()
                        .fill(Color(red: 0.4, green: 0.1, blue: 0.2))
                        .frame(width:22, height: 22)
                        .overlay(
                            
                            Circle()
                                .fill(.white)
                                .frame(width: 10, height: 10)
                        
                        )
                    
                  
                    
                }  //.opacity(showPlot ? 1 : 0),
                    .frame(width:80 ,height:170)
                    .offset(y:70)
                    .offset(offset),
                    alignment: .bottomLeading
            )
            .contentShape(Rectangle())
            .gesture(DragGesture().onChanged({ value in
                
                withAnimation{showPlot = true}
                
                let translation = value.location.x - 40
                
                let index = max(min(Int((translation / width).rounded() + 1), data.count - 1), 0)
                
                currentPlot = "$ \(data[index])"
                
                self.translation = translation
                
                offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                
            }).onEnded({ value in
                
                withAnimation{showPlot = false}
                
            }))
        }.padding(.horizontal,10)
        
            .overlay(
                VStack(alignment: .leading){
                    
                    let max = data.max() ?? 0
                    
                    Text("$ \(max)")
                            .font(.caption.bold())
                    Spacer()
                    
                    
                    Text("$ \(0)")
                            .font(.caption.bold())
                }
                    .frame(maxWidth: .infinity, alignment:  .leading)
            )
    }
    
    @ViewBuilder
    func fillBG() -> some View{
        
        LinearGradient(colors: [
            
            Color(red: 0.4, green: 0.1, blue: 0.2)
                .opacity(0.3)
        
        ], startPoint: .top, endPoint: .bottom)
    }
}



struct HistoricalDailyDataChart_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
            .preferredColorScheme(.dark)
    }
}
