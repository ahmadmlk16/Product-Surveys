//
//  SurveyDetails.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
import MapKit
 
struct SurveyDetails: View {
    // Input Parameter
    let survey: ProductSurvey
   
    var body: some View {
        // A Form cannot have more than 10 Sections.
        // Group the Sections if more than 10.
        Form {
            Group{
            Section(header: Text("Survey Taken On")) {
                    Text(survey.dateTime)
            }
            Section(header: Text("Product Name")) {
                Text(survey.answerToQuestion1)
            }
            Section(header: Text("Product Manufacturer Name")) {
                Text(survey.answerToQuestion2)
            }
            
                
                Section(header: Text("Product Details")){
                    NavigationLink(destination: prodItemDetails){
                        HStack{
                            Image(systemName: "gear")
                            Text("Get Product Details")
                        }
                        .aspectRatio(contentMode: .fit)
                    }
                }
                
                
            Section(header: Text("Product Youtube Video")){
                NavigationLink(destination: WebView(url: "http://www.youtube.com/embed/\(survey.answerToQuestion4)")){
                    HStack{
                        Image( "YT")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Play Product Youtube Video")
                    }
                    .aspectRatio(contentMode: .fit)
                }
            }
            }
            Group{
                
            Section(header: Text("The Youtube video correctly and fairly describes the characteristics of the product")){
                Text(survey.answerToQuestion5)
            }
            Section(header: Text("Which of the following words would you use to describe the product? CHeck all that apply!")) {
                Text(survey.answerToQuestion6)
            }
            Section(header: Text("How likely would you recommend this product to others?")) {
                Text(survey.answerToQuestion7)
            }
            Section(header: Text("Overall, how would you rate this product on a scale from 1 to 10, where 1 is the worst and 10 is the best?")) {
                Text(survey.answerToQuestion8.description)
            }

            }
 
        }   // End of Form
        .navigationBarTitle(Text("Survey Details"), displayMode: .inline)
        .font(.system(size: 14))
    }
   


 
 var prodItemDetails: some View {
 
        // Public function getNutritionDataFromApi is given in NutritionixApiData.swift
    getProductDetailsFromApi(upc: survey.answerToQuestion3)
 
        if item.prodName.isEmpty {
            return AnyView (noData)
       }
 
        //return AnyView(FoodNutritionDetails(code: self.$barcode))
      
        return AnyView(ProductDetails())
       
    }
 
    var noData: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
            Text("No Product Data Found! \nThe Barecode Lookup API did not return data for the product item with UPC \n \(survey.answerToQuestion3)!")
                .font(.body)
                .padding()
                .multilineTextAlignment(.center)
        }
    }
}
struct SurveyDetails_Previews: PreviewProvider {
    static var previews: some View {
       SurveyDetails(survey: surveyStructList[0])
    }
}
