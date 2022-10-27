//
//  ContentView.swift
//  TemplateMuse
//
//  Created by Ben Ashkenazi on 5/18/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            NavigationView{
                
                VStack{
                    
                    Text("Title Here")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                    
                    NavigationLink( destination: QuizView()){
                        ZStack{
                            Capsule()
                                .stroke(Color.black, lineWidth: 0.5)
                                .background(Color.white.opacity(0.0))
                            Text("Take the Quiz!")
                                .font(Font.headline.weight(.bold))
                        }
                    }
                    
                    NavigationLink( destination: BirdView()){
                        ZStack{
                            Capsule()
                                .stroke(Color.black, lineWidth: 0.5)
                                .background(Color.white.opacity(0.0))
                            Text("Take a tour!")
                                .font(Font.headline.weight(.bold))
                        }
                    }
                    
                    NavigationLink( destination: QuizView()){
                        ZStack{
                            Capsule()
                                .stroke(Color.black, lineWidth: 0.5)
                                .background(Color.white.opacity(0.0))
                            Text("Hours/Contact")
                                .font(Font.headline.weight(.bold))
                        }
                    }
                    
                    
                    
                }
            }
        }
    }
}
