//
//  NewQuestionView.swift
//  TemplateMuse
//
//  Created by Ben Ashkenazi on 5/24/22.
//

import SwiftUI

struct NewQuestionView: View {
    @Binding var question: Question
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    @State var wrongColor = Color.white
    @State var rightColor = Color.white
    @State var status = ""
    var index: Int
    
    func getMostRecentIndex() -> Int{
        return index
    }
    
    func choseAnswer(choseRight: Bool){
        wrongColor = Color.red
        rightColor = Color.green
        if choseRight{
            status = "You got it!"
            //plus return +1 to score, plus remove indice from questions array
        }else{
            status = "You failed"
        }
    }
    
    
    var body: some View {
        VStack{
            Text(status)
        VStack(spacing: 22){
            Text(question.question!)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding(.top,25)
            Spacer(minLength: 0)
            
            Button(action: {
                choseAnswer(choseRight: false)
            }, label: {
                Text(question.optionA!)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(wrongColor))
                
                    
            })
            
            Button(action: {
                choseAnswer(choseRight: false)
            }, label: {
                Text(question.optionB!)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(wrongColor))
                
                    
            })
            
            Button(action: {
                choseAnswer(choseRight: false)
            }, label: {
                Text(question.optionC!)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(wrongColor))
                
                    
            })
            
            Button(action: {
                choseAnswer(choseRight: true)
            }, label: {
                Text(question.answer!)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(rightColor))
                
                    
            })
        }
            
        }
        .padding()
    }
}
