//
//  QuestionView.swift
//  TemplateMuse
//
//  Created by Ben Ashkenazi on 5/24/22.
//

import SwiftUI

struct QuestionView: View {
    @Binding var question: Question
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    
    var body: some View {
        VStack(spacing: 22){
            Text(question.question!)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding(.top,25)
            Spacer(minLength: 0)
            
            Button(action: {}, label: {
                Text(question.optionA!)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white))
                
                    
            })
            
            Button(action: {}, label: {
                Text(question.optionB!)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white))
                
                    
            })
            
            Button(action: {}, label: {
                Text(question.optionC!)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white))
                
                    
            })
            
            Button(action: {}, label: {
                Text(question.answer!)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white))
                
                    
            })
            
            
        }
        HStack{
            Button(action: {}, label: {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white))
                
                    
            })
            Button(action: {}, label: {
                Text("Next Question")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white))
                
                    
            })
        }
        .padding()
    }
}


