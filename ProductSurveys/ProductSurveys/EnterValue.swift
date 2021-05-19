//
//  EnterValue.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//
import SwiftUI
 
struct EnterValue: View {
       
    @State private var upcTextFieldValue = ""
    @State private var upcEntered = ""
   
    var body: some View {
        VStack {
            HStack {
                Text("UPC: ")
                TextField("Enter Product UPC", text: $upcTextFieldValue,
                    onCommit: {
                        self.upcEntered = self.upcTextFieldValue
                    }
                ).textFieldStyle(RoundedBorderTextFieldStyle())
               
                // Button to clear the text field
                Button(action: {
                    self.upcTextFieldValue = ""
                    self.upcEntered = ""
                }) {
                    Image(systemName: "multiply.circle")
                        .imageScale(.medium)
                        .font(Font.title.weight(.regular))
                }
            }   // End of HStack
            .padding(.horizontal)
 
            if !upcEntered.isEmpty {
                 NavigationLink(destination: prodItemDetails){
                                       HStack{
                                           Image(systemName: "gear")
                                           Text("Get Product Details")
                                       }
                                       .aspectRatio(contentMode: .fit)
                                   }
            
            }
        }   // End of VStack
    }
   
    var prodItemDetails: some View {
       
        // Public function getNutritionDataFromApi is given in NutritionixApiData.swift
        getProductDetailsFromApi(upc: self.upcEntered)
        
        if (isBlank(upcEntered)){
            return AnyView(noUpc)
        }
        if item.prodName.isEmpty {
            return AnyView(noData)
        }
 
      return AnyView(ProductDetails())
        
    }
   
    var noData: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
            Text("No Data for the Entered Item! \nThe Nutritionix API did not return data for the entered item with UPC \(self.upcEntered)!")
                .font(.body)
                .padding()
                .multilineTextAlignment(.center)
        }
    }
        var noUpc: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
            Text("The UPC Field is Empty! \n Please enter a product UPC.")
                .font(.body)
                .padding()
                .multilineTextAlignment(.center)
        }

    }
}
 
struct EnterFoodBarcodeUPC_Previews: PreviewProvider {
    static var previews: some View {
        EnterValue()
    }
}
 
func isBlank(_ string: String) -> Bool {
  for character in string {
    if !character.isWhitespace {
        return false
    }
  }
  return true
}
