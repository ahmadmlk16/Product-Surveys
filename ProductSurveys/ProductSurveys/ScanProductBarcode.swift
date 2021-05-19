//
//  ScanProductBarcode.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
import AVFoundation
 
struct ScanProductBarcode: View {
 
    // barcode contains the UPC value of the barcode image
    @State var barcode: String = ""
   
    // lightOn indicates if the flashlight is turned on or off
    @State var lightOn: Bool = false
   
    var body: some View {
        VStack {
            // Show barcode scanning camera view if no barcode image is present
            if barcode.isEmpty {
                /*
                 Display barcode scanning camera view on the background layer because
                 we will display the results on the foreground layer in the same view.
                 */
                ZStack {
                    /*
                     BarcodeScanner displays the barcode scanning camera view, obtains the barcode
                     value, and stores it into the @State variable 'barcode'. When the @State value
                     changes,the view invalidates its appearance and recomputes this body view.
                    
                     When this body view is recomputed, 'barcode' will not be empty and the
                     else part of the if statement will be executed, which displays barcode
                     processing results on the foreground layer in this same view.
                     */
                    BarcodeScanner(code: self.$barcode)
                   
                    // Display the flashlight button created in FlashlightButton.swift
                    flashlightButtonView
                   
                    /*
                     Display the scan focus region image to guide the user during scanning.
                     The image is constructed in ScanFocusRegion.swift upon app launch.
                     */
                    scanFocusRegionImage
                }
            } else {
                // Show barcode processing results
                prodItemDetails
            }
        }   // End of VStack
        .onDisappear() {
            self.lightOn = false
        }
    }
   
    var flashlightButtonView: some View {
        return VStack {
            HStack {
                Spacer()    // Spaces to show the button on the right of the screen
                FlashlightButton(lightOn: self.$lightOn)
                    .padding()
            }
            Spacer()        // Spaces to show the button on the top of the screen
        }
        // Using Spacer(), the button is positioned on the top right corner of the screen
    }
   
    var prodItemDetails: some View {
 
        // Public function getNutritionDataFromApi is given in NutritionixApiData.swift
        getProductDetailsFromApi(upc: self.barcode)
 
        if item.prodName.isEmpty {
            return AnyView (noNutritionData)
       }
 
        //return AnyView(FoodNutritionDetails(code: self.$barcode))
      
        return AnyView(ProductDetails())
       
    }
 
    var noNutritionData: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
            Text("No Data for the Scanned Item! \nThe Nutritionix API did not return data for the scanned item with UPC \(self.barcode)!")
                .font(.body)
                .padding()
                .multilineTextAlignment(.center)
        }
    }
 
}
 
struct ScanFoodBarcode_Previews: PreviewProvider {
    static var previews: some View {
        ScanProductBarcode()
    }
}
 
 
