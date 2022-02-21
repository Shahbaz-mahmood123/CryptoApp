//
//  Homepage.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-21.
//

import SwiftUI

struct Homepage: View {
    @State var tickets = [Ticket]()
    @State var cryptoData: CryptoResponse? = nil
    @State var exchangeRates: ExchangeRate? = nil
    @State var dailyData: HistoricalDailyData? = nil
    var body: some View {
        ScrollView{
            VStack{
                //              List (tickets){ ticket in
                //                  VStack{
                //                      Text(ticket.title)
                //                      Text(ticket.requester)
                //                      Text(ticket.body)}
                //
                //              }
                //          }.onAppear(){
                //              Api().loadData{(tickets) in self.tickets = tickets}
                //          }
                
                Section {
                    Text("Cyrpto Currency Exchange")
                    
                    Button(action: {CryptoService().getExchangeRate(completion: {(exchangeRates) in self.exchangeRates = exchangeRates})} ) {
                        Text("Get exchange Rate")
                    }
                    
                    Button(action: {CryptoService().getCryptoData(completion: {(cryptoData) in self.cryptoData = cryptoData})} ) {
                        Text("crypto data")
                    }
                    Button(action: {CryptoService().getHistoricalDataDaily(completion: {(dailyData) in self.dailyData = dailyData})} ) {
                        Text("Daily data")
                    }
                }
            }
            
        }
        
    }
    
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}


