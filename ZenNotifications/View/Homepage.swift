//
//  Homepage.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-21.
//

import SwiftUI

struct Homepage: View {
    //TODO: Need to move all the below to view models and make published properties inside the view model and also remove all constants and rename
    @State var exchangeRates: ExchangeRate? = nil
    @State var crypto = "BTC"
    @ObservedObject private var viewModel = HomePageViewModel()
    
    
    var body: some View {
        GeometryReader{ geometryReader in
            VStack(alignment: .leading){
                Section(
                ){ Label{
                    Text(exchangeRates?.realtimeCurrencyExchangeRate.the1FromCurrencyCode ?? "Crypto")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(.white.opacity(0.1))
                        .clipShape(Capsule())
                        .shadow(radius: 7)
                    Spacer()
                    let currentTime = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
                    Text(currentTime)
                        .fontWeight(.ultraLight)
                    
                } icon: {
                    Image(crypto)
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                    
                }
                }
                VStack{
                    Text("Current Exchange rate")
                        .fontWeight(.bold)
                    HStack(){
                        let currency = exchangeRates?.realtimeCurrencyExchangeRate.the3ToCurrencyCode ?? "CAD Dollars"
                        
                        let currencyRate = (convertStringToCurrency(amount: (exchangeRates?.realtimeCurrencyExchangeRate.the5ExchangeRate ?? "43,000.00") ))
                        Spacer()
                        Text("\(currencyRate)").font(.system(size:38, weight: .bold))
                        Spacer()
                        //Text(currencyRate)
                    }
                }
                
                HStack(){
                    let marketStatus = viewModel.marketStatus?.currencies.crypto ?? "Current Market Status"
                    if(marketStatus == "open" ){
                        Text("Market is: \(marketStatus)")
                            .foregroundColor(.green)
                    }
                    
                    if(marketStatus == "closed" ){
                        Text(("Market is:\(marketStatus)"))
                            .foregroundColor(.red)
                    }
                    if(marketStatus != "closed" && marketStatus != "open"){
                        Text("error getting current market status")
                            .foregroundColor(.red)
                            .fontWeight(.light)
                    }
                    
                    Spacer()
                    
                    let cryptocurrencies = ["BTC", "ETH", "MKR", "XRP", "BNB"]
                    
                    Picker("Select a cryptocurrency", selection: $crypto) {
                        ForEach(cryptocurrencies, id: \.self) {
                            Text($0)
                        }.onChange( of: crypto)
                        {            crypto in
                            //viewModel.exchangeRate
                            AlphaVantageService().getExchangeRate(cryptoSymbol: crypto, completion: {(exchangeRates) in self.exchangeRates = exchangeRates })
                        }
                        .pickerStyle(.menu)
                        // Text("Selected c: \(crypto)")
                    }
                }
                HStack(){
                    Text("Asking price")
                        .fontWeight(.light)
                    
                    let askPrice = (convertStringToCurrency(amount: exchangeRates?.realtimeCurrencyExchangeRate.the9AskPrice ?? "55"))
                    Text(askPrice).fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("Bid price")
                        .fontWeight(.light)
                    let askPrice = (convertStringToCurrency(amount: exchangeRates?.realtimeCurrencyExchangeRate.the8BidPrice ?? "55"))
                    Text(askPrice).fontWeight(.bold)
                    
                }
                //TODO: Need to pass actual market data and not fake sample data and make a better line chart. Also maybe redo the chart
                HStack(){
                    //                    HistoricalDailyDataChart(data: samplePlot)
                    //                        .frame( maxWidth:.infinity, maxHeight: 250, alignment: .top)
                    
                }
                Divider()
//                VStack{
//                    if(viewModel.dailyOpenClose?.openTrades[1].exchange == 2){
//                        let  tradePrice = convertDoubleToCurrency(amount: viewModel.dailyOpenClose?.openTrades[1].tradePrice ?? 84)
//                        let tradeSize = viewModel.dailyOpenClose?.openTrades[1].tradeSize ?? 0.5
//                        
//                        Section {
//                            
//                            Text("Bitfinex")
//                                .font(.title2)
//                                .fontWeight(.bold)
//                                .multilineTextAlignment(.leading)
//                                .padding()
//                                .background(.white.opacity(0.1))
//                                .clipShape(Ellipse())
//                            
//                            VStack{
//                                HStack{
//                                    Text("Most recent Trade Price:")
//                                    Spacer()
//                                    Text(tradePrice)
//                                }
//                                HStack{
//                                    Text("Most recent Trade Size:")
//                                    Spacer()
//                                    Text("\(tradeSize)")
//                                }
//                                
//                            }
//                        }
//
//                    }
//                    if(viewModel.dailyOpenClose?.openTrades[2].exchange == 1){
//                        let  tradePrice = convertDoubleToCurrency(amount: viewModel.dailyOpenClose?.openTrades[1].tradePrice ?? 84)
//                        Text("Coinbase")
//                        Text("Current Trade Price: \(tradePrice)")
//                    }
//                    if(viewModel.dailyOpenClose?.openTrades[3].exchange == 6){
//                        let  tradePrice = convertDoubleToCurrency(amount: viewModel.dailyOpenClose?.openTrades[1].tradePrice ?? 84)
//                        Text("global")
//                        Text("Current Trade Price: \(tradePrice)")
//                    }
//                    Spacer()
//                    //                    let test = convertDoubleToCurrency(amount: viewModel.previousDayDailyOpenClose?.openTrades[1].tradePrice ?? 68)
//                    //                    Text("testing\(test)")
//                }
                VStack{
                    
                    CryptoExchanges()
                }
                
                
            }.frame(maxWidth: geometryReader.size.width, maxHeight: geometryReader.size.height, alignment: .topLeading)}
        .navigationTitle("Crypto")
        .onAppear(){
            AlphaVantageService().getExchangeRate(cryptoSymbol: crypto, completion: {(exchangeRates) in self.exchangeRates = exchangeRates })
            
        }.preferredColorScheme(.dark)
    }
}
struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Homepage()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 13")
            
        }
    }
}

let samplePlot: [CGFloat] = [
    989,1200,750,790,650,950,1200,600,890,1209, 1400,900,1250,1600,1200
]

func convertDoubleToCurrency(amount: Double) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.locale = Locale.current
    return numberFormatter.string(from: NSNumber(value: amount))!
}

func convertStringToCurrency(amount: String) -> String{
    let response = (amount as NSString).doubleValue
    return convertDoubleToCurrency(amount: response)
}

func convertCurrencyToDouble(input: String) -> Double? {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.locale = Locale.current
    return numberFormatter.number(from: input)?.doubleValue
}

