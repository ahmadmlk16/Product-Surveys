//
//  ProductDetails.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//


import SwiftUI
 
struct ProductDetails: View {

    var body: some View {
        /*
         foodItem global variable was obtained in NutritionixApiData.swift
         A Form cannot have more than 10 Sections. Group the Sections if more than 10.
         */
        Form {
            Group {
                Section(header: Text("Barcode Number")) {
                    Text(verbatim: item.barcodeNumber)
                }
                Section(header: Text("Product Name")) {
                    Text(verbatim: item.prodName)
                }
                Section(header: Text("Product Manufacturer Name")) {
                    Text(verbatim: item.manuName)
                }
                Section(header: Text("Product Description")) {
                    Text(verbatim: item.prodDesc)
                }
            }
            
            Group {
                
                
                Section(header: Text("Product Images")) {
                         ForEach(imageList) { aImage in
                            getImageFromUrl(url: aImage.url)
                            .resizable()
                            .scaledToFit()
                         }
                   
                }
                
                
                
                Section(header: Text("Stores Selling the Product")) {
                     ForEach(storeList) { aStore in
                         NavigationLink(destination:
                            WebView(url: aStore.url)
                                .navigationBarTitle(Text(aStore.name), displayMode: .inline) )
                         {
                            VStack(alignment: .leading){
                                Text(aStore.name)
                                HStack{
                                    Text (aStore.currencySymbol)
                                    Text (aStore.price)
                                    Text (aStore.currencyCode)
                                }
                             }
                             .padding(.horizontal, 10.0)
                         }
                     }
               
            }
                

            }
        }   // End of Form
        .navigationBarTitle(Text("Nutrition Details"), displayMode: .inline)
        .font(.system(size: 14))
    }
}
 
struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
       ProductDetails()
    }
}
 
