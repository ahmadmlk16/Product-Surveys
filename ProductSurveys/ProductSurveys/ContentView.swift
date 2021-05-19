//
//  ContentView.swift
//  ProductSurveys
//
//  Created by CS3714 on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
// Home view
struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack(alignment: .leading) {
                    
                    Image ("Survey")
                        .resizable()
                        .padding([.leading, .bottom, .trailing], 10.0)
                        .scaledToFit()
                    
                    NavigationLink(destination: SurveyList()) {
                        HStack {
                            Image(systemName: "rectangle.stack")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                                .font(Font.title.weight(.regular))
                                .frame(width: 60)
                            Text("Product Surveys Taken")
                                .font(.headline)
                        }
                        .padding(.horizontal, 10.0)
                    }.padding(.bottom, 30)
                    
                    NavigationLink(destination: TakeProductSurvey()) {
                        HStack {
                            Image(systemName: "rectangle.stack.badge.plus")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                                .font(Font.title.weight(.regular))
                                .frame(width: 60)
                            Text("Take Product Survey")
                                .font(.headline)
                        }
                        .padding(.horizontal, 10.0)
                    }.padding(.bottom, 30)
                    
                    
                        NavigationLink(destination: ScanProductBarcode()) {
                        HStack {
                            Image(systemName: "barcode.viewfinder")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                                .font(Font.title.weight(.regular))
                                .frame(width: 60)
                            Text("Scan Product Barcode")
                                .font(.headline)
                        }
                        .padding(.horizontal, 10.0)
                    }.padding(.bottom, 30)
                   
                    NavigationLink(destination: EnterValue()) {
                        HStack {
                            Image(systemName: "pencil.and.ellipsis.rectangle")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                                .font(Font.title.weight(.regular))
                                .frame(width: 60)
                            Text("Enter Product Barcode Value")
                                .font(.headline)
                        }
                        .padding(.horizontal, 10.0)
                    }.padding(.bottom, 30)
                   
                   
                    Text("Powered By")
                        .font(.headline)
                        .padding(.horizontal, 13.0)
               
                    NavigationLink(destination:
                        WebView(url: "https://www.barcodelookup.com/api")
                            .navigationBarTitle(Text("Barcood Lookup API"), displayMode: .inline) )
                        {
                            HStack{
                            Image("ApiLogo")
                                .renderingMode(.original)   // To keep the logo in its original form
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 37)
                                Text("BarcodeLookup.com")
                                    .padding(.horizontal, 5.0)
                            }
                            .padding(.horizontal, 10.0)
                        }
               
                }   // End of VStack
                .navigationBarTitle(Text("Home"), displayMode: .inline)
           
            }
                   // End of NavigationView
        }   // End of ZStack
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
