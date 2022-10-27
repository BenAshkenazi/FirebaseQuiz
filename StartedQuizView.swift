//
//  StartedQuizView.swift
//  TemplateMuse
//
//  Created by Ben Ashkenazi on 5/24/22.
//tba:
//high score page

import SwiftUI
import AVFoundation

struct StartedQuizView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var correct : Int
    @Binding var wrong : Int
    @Binding var name: String
    
    @StateObject var data = QuestionViewModel()
    @StateObject var dataHigh = HighScoreViewModel()
    
    @State var timeRemaining = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var answered: Int
    @State var audioPlayer: AVAudioPlayer?
    //makes out of question pages inivs
    @State var noQOpacity = 0.0
    
    //sets initial color of buttons
    @State var aColor = Color.white
    @State var bColor = Color.white
    @State var cColor = Color.white
    @State var dColor = Color.white
   
    //sets status and next text to be initally without value
    @State var nextText = ""
    @State var status = ""
    @State private var disabled = false
    @State private var nextClosed = true
    
    //Sets value of each answer, questions and right answer to be blank
    @State var a = ""
    @State var b = ""
    @State var c = ""
    @State var d = ""
    @State var rightString = ""
    @State var answerStr = ""
    @State var questionStr = ""
    
    //questions already used
    @State var takenQs = [""]
    
    @State var userID = ""
    
    //resets question page
    func reloadQs() -> Void{
        aColor = Color.white
        bColor = Color.white
        cColor = Color.white
        dColor = Color.white
        //closes next button and opens
        nextClosed = true
        disabled = false
        nextText = ""
        status = ""
        timeRemaining = 30

        var searching  = true
        //gets random question from list
        var thisQ = data.questions.randomElement()
        
        //checks to see if all questions have already been used
        if (takenQs.count-1 == data.questions.count) || (wrong == 0) {
            searching = false
            noQOpacity = 1.0
            dataHigh.putInUser(userName: name, userScore: correct)
            dataHigh.getUsers()
            userID = dataHigh.uniqueIDDoc


        }
        
        while(searching){
            //checks if chosen question has already been used before
            if(takenQs.contains(thisQ!.question!)) == false{
                takenQs.append(thisQ!.question!)
                searching = false
                //sets answer
                rightString = thisQ!.answer!
                var possibles = [thisQ?.answer,thisQ?.optionA,thisQ?.optionB,thisQ?.optionC]
                //shuffles answers and assigns them to a, b, c and d
                possibles.shuffle()
                questionStr = thisQ?.question ?? "No Q found"
                a = possibles[0] ?? "No option found"
                b = possibles[1] ?? "No option found"
                c = possibles[2] ?? "No option found"
                d = possibles[3] ?? "No option found"
                
            }else{
                thisQ = data.questions.randomElement()
            }
        }
    }
    
    func choseAnswer(choseStr: String){
        //change color of buttons to red
        aColor = Color.red
        bColor = Color.red
        cColor = Color.red
        dColor = Color.red
        //changes color of correct answer to green
        if(a == rightString){
            aColor = Color.green
        }else if(b == rightString){
            bColor = Color.green
        }else if(c == rightString){
            cColor = Color.green
        }else{
            dColor = Color.green
        }
        //increments score
        if (choseStr == rightString){
            status = "You got it!"
            correct+=1
            playSound(sound: "correct", type: "wav")
        }else if(choseStr == "outoftime"){
            status = "You ran out of time!"
            wrong+=1
            playSound(sound: "wrong", type: "wav")

        }else{
            status = "You failed"
            wrong+=1
            playSound(sound: "wrong", type: "wav")

        }
        disabled = true
        nextClosed = false
        nextText = "Move to next question"
        
        if (takenQs.count-1 == data.questions.count) || (wrong == 0) {
            nextText = "Move to High Score Page"

        }
    }
    
    

   

    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("ERROR")
            }
        }
    }
    
    var body: some View {
        if data.questions.isEmpty{
            //Spins while questions load in
            ProgressView()
                .onAppear(perform: {
                    data.getQuestions()
                })
        }else{
            ZStack{
                VStack{
                    HStack{
                        Label(
                            title: {Text(correct == 0 ? "0":"\(correct)")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            },
                            icon: {Image(systemName: "checkmark")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                            }
                        ).padding()
                        Spacer()
                        Label(
                            title: {Text(wrong == 0 ? "0":"\(abs(wrong))")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            },
                            icon: {Image(systemName: "heart")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            }
                        ).padding()
                    }
                    Text(status)
                    VStack(spacing: 22){
                        Text(questionStr)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.top,25)
                        
                        Text("\(timeRemaining)")
                                   .onReceive(timer) { _ in
                                       if(nextClosed){
                                           if timeRemaining > 0 {
                                               timeRemaining -= 1
                                           }else{
                                               choseAnswer(choseStr: "outoftime")
                                           }
                                       }
                                   }
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            choseAnswer(choseStr: a)
                        }, label: {
                            Text(a)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).stroke(aColor))
                        }).disabled(disabled)
                        
                        Button(action: {
                            choseAnswer(choseStr: b)
                        }, label: {
                            Text(b)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).stroke(bColor))
                        }).disabled(disabled)
                        
                        Button(action: {
                            choseAnswer(choseStr: c)
                        }, label: {
                            Text(c)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).stroke(cColor))
                        }).disabled(disabled)
                        
                        Button(action: {
                            choseAnswer(choseStr: d)
                        }, label: {
                            Text(d)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).stroke(dColor))
                            
                        }).disabled(disabled)
                    }
                    .padding()
                    Button("Done") {
                        dismiss()
                    }
                    .onAppear{
                        reloadQs()
                    }
                    .onDisappear{
                        correct = 0
                        wrong = -3
                        data.questions = []
                    }
                    .interactiveDismissDisabled()
                    Button(nextText) {
                        reloadQs()
                    }
                    .disabled(nextClosed)
                }
                
                ZStack{
                    Rectangle().fill(Color.black)
                    VStack{
                        Text("High Scores: ")
                        ScrollView(){
                            ScrollViewReader { proxy in

                                LazyVStack{
                                   
                                    ForEach(dataHigh.users) { user in
                                        VStack{
                                            Text(user.name!+": \(user.score!) points")
                                                .font(.system(size: 30))
                                                .padding(.bottom, 2)
                                                .background(userID == user.idDoc! ? Color.red : Color.black)
                                                
                                        }
                                        .onAppear{
                                            proxy.scrollTo(user.idDoc!)
                                            print("SCROLLED!")
                                            dataHigh.users.sort()
                                        }
                                    
                                    }
                                }
                                
                            }
                    }
                        Button("Done") {
                            dismiss()
                        }
                    }
                    
                        
                }.opacity(noQOpacity)
                                
            }
        }
    }
}

