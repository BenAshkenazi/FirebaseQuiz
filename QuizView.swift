//
//  QuizView.swift
//  TemplateMuse
//
//  Created by Ben Ashkenazi on 5/18/22.
//

import SwiftUI

struct QuizView: View {
    @State private var showSheet = false
    @State var name = ""
    @State private var errorMessage = ""
    @State private var disabled = true
    @State var correct = 0
    @State var wrong = -3
    @State var answered = 0
    var set = ""

    
    func curseWords(val: String) -> Bool {
        let strippedVal = String(val.filter { !" \n\t\r".contains($0) }).lowercased()
        var wordArray: [String] = []

        let url = Bundle.main.url(forResource: "ProfanityWords", withExtension: "txt")!
        do {
            let string = try String(contentsOf: url, encoding: .utf8)
            wordArray = string.components(separatedBy: CharacterSet.newlines)
        } catch {
            print(error)
        }
        
        if(wordArray.contains(strippedVal)){
            return true
        }else{
            for word in wordArray {
                if(strippedVal.contains(word)){
                    return true
                }
            }
        }
        return false
    }
    
    
    var body: some View {
        VStack{
            
            TextField("Enter your name here: ", text: $name)
                .onSubmit{
                    if(curseWords(val: name)){
                        errorMessage = "Sorry, you can't use that username."
                        disabled = true
                    }else{
                        disabled = false
                        errorMessage = ""
                    }
                }
            
            Button {
                showSheet.toggle()
            } label: {
                VStack{
                    Text("Start Game!")
                }
            }
            .disabled(disabled)

            Text(errorMessage)


            
        }
        .sheet(isPresented: $showSheet, content: {
            StartedQuizView(correct: $correct, wrong: $wrong, name: $name, answered: $answered)
        })
    }
        
    
    
    

}








