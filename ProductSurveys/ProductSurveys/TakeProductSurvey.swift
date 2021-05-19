//
//  TakeProductSurvey.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

struct TakeProductSurvey: View {
    
    //all state variables
    @EnvironmentObject var userData: UserData
    @State private var prodName = ""
    @State private var manuName = ""
    @State private var upcCode = ""
    @State private var ytId = ""
    @State private var q5 = 0
    @State private var q6 = false
    @State private var q7 = 0
    @State private var q8 : Double = 0
    @State private var checkbox1 = false
    @State private var checkbox2 = false
    @State private var checkbox3 = false
    @State private var checkbox4 = false
    @State private var checkbox5 = false
    @State private var checkbox6 = false
    @State private var checkbox7 = false
    @State private var checkbox8 = false
    @State private var checkbox9 = false
    @State private var checkbox10 = false
    
    @State private var showingAlert = false
    @State private var showingSaved = false
    
    //qustion arrays
    let surveyQuestions = ["Enter Product Name", "Enter Product Manufacturer Name", "Enter Product Universal Product Code (UPC)", "Enter Product YouTube Video ID", "The YouTube video correctly and fairly describes the characteristics of the product.", "Which of the following words would you use to describe the product? Check all that apply!", "How likely would you recommend this product to others?", "Overall, how would you rate this product on a scale from 1 to 10, where 1 is the worst and 10 is the best?"]
    
    let q5MultipleChoices =   ["Strongly agree" ,"Somewhat agree","Neither agree nor disagree","Somewhat disagree","Strongly disagree"]
    
    let q6MultipleChoices = ["Good Value for Money", "High Quality", "Impractical", "Ineffective", "Overpriced","Poor Quality", "Reliable", "Unique", "Unreliable", "Useful"]
    
    let q7MultipleChoices = ["Extremely likely","Somewhat likely","Neither likely nor unlikely","Somewhat unlikely","Extremely unlikely"]
    
    
    var body: some View {
        Form {
            Group{
                Section(header: Text(surveyQuestions[0])) {
                    HStack{
                        TextField("Product Name", text: $prodName)
                        Button(action: {
                            self.prodName = ""
                        }) {
                            Image(systemName: "multiply.circle")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                    
                }
                Section(header: Text(surveyQuestions[1])) {
                    
                    HStack{
                        TextField("Manufacturer Name", text: $manuName)
                        Button(action: {
                            self.manuName = ""
                        }) {
                            Image(systemName: "multiply.circle")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                }
                Section(header: Text(surveyQuestions[2])) {
                    HStack{
                        TextField("UPC", text: $upcCode)
                        Button(action: {
                            self.upcCode = ""
                        }) {
                            Image(systemName: "multiply.circle")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                }
                
                
                Section(header: Text(surveyQuestions[3])) {
                    
                    HStack{
                        TextField("Youtube Video ID", text: $ytId)
                        Button(action: {
                            self.ytId = ""
                        }) {
                            Image(systemName: "multiply.circle")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }                    }}
                if !ytId.isEmpty {
                    Section(header: Text(surveyQuestions[4])) {
                        VStack {
                            WebView(url: "http://www.youtube.com/embed/\(self.ytId)")
                                .frame(height: 250)
                                .navigationBarTitle(Text("Play Product Video"), displayMode: .inline)
                                .padding()
                            question5
                        }
                    }
                }
                
            }
            
            Group{
                
                Section(header: Text(surveyQuestions[5])) {
                    question6
                }
                Section(header: Text(surveyQuestions[6])) {
                    question7
                }
                Section(header: Text(surveyQuestions[7])) {
                    VStack {
                        HStack{
                            Text("1")
                            Slider(value: $q8, in: 1...10, step: 1)
                            Text("10")
                        }
                        Text(Int(q8).description)
                    }
                    
                }
            }
            
        }
        .alert(isPresented: $showingSaved){ Alert(title: Text("Survey Saved!"), message: Text("Congratulations! Your survey is successfully saved!"), dismissButton: .default(Text("OK")))}
            
        .navigationBarTitle(Text("Take Survey"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.saveSurvey()
                
            }) {
                Text("Save")
        })
        
    }
    
    
    
    
    //question 5 view
    var question5: some View {
        
        Picker(selection: $q5, label: Text("Answer")){
            ForEach(0 ..< q5MultipleChoices.count){
                Text(self.q5MultipleChoices[$0])
            }
        }
    }
    
    //question 6 view
    var question6: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: checkbox1 ? "checkmark.square" : "square").onTapGesture {
                    self.checkbox1.toggle()
                    self.q6 = true
                }
                Text(q6MultipleChoices[0])
            }
            HStack {
                Image(systemName: checkbox2 ? "checkmark.square" : "square").onTapGesture {
                    self.checkbox2.toggle()
                    self.q6 = true
                }
                Text(q6MultipleChoices[1])
            }
            HStack {
                Image(systemName: checkbox3 ? "checkmark.square" : "square").onTapGesture {
                    self.checkbox3.toggle()
                    self.q6 = true
                }
                Text(q6MultipleChoices[2])
            }
            HStack {
                Image(systemName: checkbox4 ? "checkmark.square" : "square").onTapGesture {
                    self.checkbox4.toggle()
                    self.q6 = true
                }
                Text(q6MultipleChoices[3])
            }
            HStack {
                Image(systemName: checkbox5 ? "checkmark.square" : "square").onTapGesture {
                    self.checkbox5.toggle()
                    self.q6 = true
                }
                Text(q6MultipleChoices[4])
            }
            HStack {
                Image(systemName: checkbox6 ? "checkmark.square" : "square").onTapGesture {
                    self.checkbox6.toggle()
                    self.q6 = true
                }
                Text(q6MultipleChoices[5])
            }
            HStack {
                Image(systemName: checkbox7 ? "checkmark.square" : "square").onTapGesture {
                    self.checkbox7.toggle()
                    self.q6 = true
                }
                Text(q6MultipleChoices[6])
            }
            HStack {
                Image(systemName: checkbox8 ? "checkmark.square" : "square").onTapGesture {
                    self.checkbox8.toggle()
                    self.q6 = true
                }
                Text(q6MultipleChoices[7])
            }
            
            
            HStack {
                Image(systemName: checkbox9 ? "checkmark.square" : "square").onTapGesture {
                    self.checkbox9.toggle()
                    self.q6 = true
                }
                Text(q6MultipleChoices[8])
            }
            HStack {
                Image(systemName: checkbox10 ? "checkmark.square" : "square").onTapGesture {
                    self.checkbox10.toggle()
                    self.q6 = true
                }
                Text(q6MultipleChoices[9])
            }
            
            
        }  .alert(isPresented: $showingAlert){ Alert(title: Text("Unanswered Question!"), message: Text("Please answer each question!"), dismissButton: .default(Text("OK")))}
            
            .imageScale(.medium)
            .font(.system(size: 16))
    }
    
    //question 7 view
    var question7: some View {
        
        Picker(selection: $q7, label: Text("Answer")){
            ForEach(0 ..< q7MultipleChoices.count){
                Text(self.q7MultipleChoices[$0])
            }
        }
    }
    
    //save the survey into user data
    func saveSurvey() {
        
        // Input Data Validation
        if self.prodName.isEmpty || self.manuName.isEmpty || self.upcCode.isEmpty || self.ytId.isEmpty || !self.q6 {
            
            self.showingAlert = true
            return
        }
        
        
        let stringDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let currdate = dateFormatter.string(from: stringDate)
        
        let Q1 = prodName
        let Q2 = manuName
        let Q3 = upcCode
        let Q4 = ytId
        let Q5 = q5MultipleChoices[q5]
        var Q6 = ""
        if (checkbox1){
            
            Q6.append(q6MultipleChoices[0])
            Q6.append(", ")        }
        if (checkbox2){
            
            Q6.append(q6MultipleChoices[1])
            Q6.append(", ")        }
        if (checkbox3){
            
            Q6.append(q6MultipleChoices[2])
            Q6.append(", ")
        }
        if (checkbox4){
            
            Q6.append(q6MultipleChoices[3])
            Q6.append(", ")
        }
        if (checkbox5){
            
            Q6.append(q6MultipleChoices[4])
            Q6.append(", ")
        }
        if (checkbox6){
            
            Q6.append(q6MultipleChoices[5])
            Q6.append(", ")
        }
        if (checkbox7){
            
            Q6.append(q6MultipleChoices[6])
            Q6.append(", ")
        }
        if (checkbox8){
            
            Q6.append(q6MultipleChoices[7])
            Q6.append(", ")
        }
        if (checkbox9){
            
            Q6.append(q6MultipleChoices[8])
            Q6.append(", ")
        }
        if (checkbox10){
            
            Q6.append(q6MultipleChoices[9])
            Q6.append(", ")
        }
        Q6.removeLast()
        Q6.removeLast()
        
        let Q7 = q7MultipleChoices[q7]
        let Q8 = Int(q8)
        
        self.userData.surveyList.append(ProductSurvey(id: UUID(), dateTime: currdate, answerToQuestion1: Q1,answerToQuestion2: Q2,answerToQuestion3: Q3,answerToQuestion4: Q4,answerToQuestion5: Q5,answerToQuestion6: Q6,answerToQuestion7: Q7,answerToQuestion8: Q8))
        
        surveyStructList = self.userData.surveyList
        
        self.showingSaved = true
        
        prodName = ""
        manuName = ""
        upcCode = ""
        ytId = ""
        q5 = 0
        q6 = false
        q7 = 0
        q8 = 0
        checkbox1 = false
        checkbox2 = false
        checkbox3 = false
        checkbox4 = false
        checkbox5 = false
        checkbox6 = false
        checkbox7 = false
        checkbox8 = false
        checkbox9 = false
        checkbox10 = false
        
        
    }
    
    
    
}




struct TakeProductSurvey_Previews: PreviewProvider {
    static var previews: some View {
        TakeProductSurvey()
    }
}
