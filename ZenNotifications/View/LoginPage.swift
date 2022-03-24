//
//  LoginPage.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-03.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LoginPage: View {
    
    @State var isLoading: Bool = false
    
    @AppStorage("log_Status") var log_Status = false
    
    var body: some View {
        VStack{
            

            VStack( spacing:40 ){
                Text("TL;DR")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(Color.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                
                Button {
                    handleLogin()
                } label: {
                    HStack(spacing:15){
                        Image("Google")
                            .resizable()
                            //.renderingMode()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height:28)
                        
                        Text("Create Account")
                            .font(.title3)
                            .fontWeight(.medium)
                            .kerning(1.1)
                            
                    }
                    .foregroundColor(Color("Blue"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        
                        Capsule()
                            .strokeBorder(Color(.white))
                    )
                }.preferredColorScheme(.dark)
                .padding(.top, 25)
                
                Text(getAttributedString(string:"By creating an account, you are agreeing to our Terms of Service"))
                    .font(.body.bold())
                    .foregroundColor(.white)
                    .kerning(1.1)
                    .lineSpacing(8)
                    .multilineTextAlignment(.center)
                
                    .frame(maxWidth: .infinity,maxHeight: .infinity,  alignment: .top)
                
            }
            .padding()
            .padding(.top,40)
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
            .overlay(
                ZStack{
                    if isLoading{
                        Color.black
                            .opacity(0.25)
                            .ignoresSafeArea()
                        
                        ProgressView()
                            .font(.title2)
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
        )
            .background(
                Image("LoginBackground")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
            )
        
    }
    func getAttributedString(string:String)->AttributedString{
        var attributedString = AttributedString(string)
        
        if let range = attributedString.range(of: "Terms of Service"){
            
            attributedString[range].foregroundColor = .black
            attributedString[range].font = .body.bold()
            
        }
            return attributedString
    }
    
    //Login logic
    func handleLogin(){
        guard let clientID = FirebaseApp.app()?.options.clientID else{ return }
        let config = GIDConfiguration(clientID: clientID)
        
        isLoading = true
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()){
            [self]user, err in
            
            if let error = err {
                isLoading = false
                print(error.localizedDescription)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else{
                isLoading = false
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            //firebase auth
            Auth.auth().signIn(with: credential) {result, err in
                
                isLoading = false
                 
                if let error = err {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else{
                    return
                }
                
                print(user.displayName ?? "Success!")
                
                withAnimation {
                    log_Status = true
                }


            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    func getRootViewController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
