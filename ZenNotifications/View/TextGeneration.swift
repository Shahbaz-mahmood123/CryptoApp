//
//  TextGeneration.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2021-12-21.
//

import SwiftUI

struct TextGeneration: View {

    @State var prompt: String = "A neutron star is the collapsed core of a massive supergiant star, which had a total mass of between 10 and 25 solar masses, possibly more if the star was especially metal-rich.[1] Neutron stars are the smallest and densest stellar objects, excluding black holes and hypothetical white holes, quark stars, and strange stars.[2] Neutron stars have a radius on the order of 10 kilometres (6.2 mi) and a mass of about 1.4 solar masses.[3] They result from the supernova explosion of a massive star, combined with gravitational collapse, that compresses the core past white dwarf star density to that of atomic nuclei."
    @State var response: Response? = nil
      var body: some View {
          VStack(){
              GroupBox(label:
                   Label("Enter some text below to get a TL;DR", systemImage: "square.and.pencil")
               ) {
                  TextEditor(text: $prompt).foregroundColor(Color.gray)
                      .font(.custom("HelveticaNeue", size: 13))
                      .lineSpacing(5)
                      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150, alignment: .topLeading)

                   .frame(height: 200)
               }

              Button(action: {GPT3TextComepletion().textCompletion(promptText: prompt, completion: {(response) in self.response = response })}) {
                  Text("test")
              }.padding(20)
                  .foregroundColor(Color.white)
                  .background(Color.blue)
                  //.scaleEffect(configuration.isPressed ? 0.95 : 1)
              VStack{
                  Text(response?.choices[0].text ?? "some data")

              }
              Spacer()
          }
      }
}

struct TextGeneration_Previews: PreviewProvider {
    static var previews: some View {
        TextGeneration()
            .preferredColorScheme(.light)
    }
}
