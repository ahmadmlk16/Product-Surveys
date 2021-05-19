//
//  SurveyItem.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct SurveyItem: View {
    // Input Parameter
    let survey: ProductSurvey
   
    var body: some View {
                       HStack {
                //generates the image of the survey item
                        getImageFromUrl(url: "https://img.youtube.com/vi/\(survey.answerToQuestion4)/hqdefault.jpg") .resizable()
            .aspectRatio(contentMode: .fit) .frame(width: 80.0, height: 80.0)
            
                VStack(alignment: .leading){
                    Text(survey.answerToQuestion1)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    Text(survey.answerToQuestion2)
                    .font(.callout)
                    .lineLimit(3)
                    Text(survey.dateTime)
                .font(.callout)
                .multilineTextAlignment(.leading)
                }
        }   // End of HStack
    }
   
}
 
 
struct SurveyItem_Previews: PreviewProvider {
    static var previews: some View {
        SurveyItem(survey: surveyStructList[0])
    }
}
