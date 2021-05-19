//
//  ProductDataFromApi.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation
 

// Declare productItem as a global mutable variable accessible in all Swift files

var item = ProductItem(barcodeNumber: "", prodName: "", manuName: "", prodDesc: "", prodImageUrl: "")
var imageList = [ProductImage]()
var storeList = [Store]()


fileprivate var previousUPC = ""
 
/*
 =================================================================
 Get Nutrition Data from the API for the product Item with UPC.
 Universal Product Code (UPC) is a barcode symbology consisting of
 12 numeric digits that are uniquely assigned to a trade item.
 =================================================================
 */
public func getProductDetailsFromApi(upc: String) {
   
    // Avoid executing this function if already done for the same UPC
    if upc == previousUPC {
        return
    } else {
        previousUPC = upc
    }
   
    /*
     Create an empty instance of productStruct defined in productStruct.swift
     Assign its unique id to the global variable productItem
     */
    item = ProductItem(barcodeNumber: "", prodName: "", manuName: "", prodDesc: "", prodImageUrl: "")
   
 
    /*
    *********************************************
    *   Obtaining API Search Query URL Struct   *
    *********************************************
    */
   
    var apiQueryUrlStruct: URL?
   
     if let urlStruct = URL(string: "https://api.barcodelookup.com/v2/products?barcode=\(upc)&key=l3agpclkskpupn893ek41t0er94xvh") {
         apiQueryUrlStruct = urlStruct
     } else {
         // productItem will have the initial values set as above
         return
     }
   
    /*
    *******************************
    *   HTTP GET Request Set Up   *
    *******************************
    */
 
    
     let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                       cachePolicy: .useProtocolCachePolicy,
                                       timeoutInterval: 10.0)
    
     request.httpMethod = "GET"

    
     /*
     *********************************************************************
     *  Setting Up a URL Session to Fetch the JSON File from the API     *
     *  in an Asynchronous Manner and Processing the Received JSON File  *
     *********************************************************************
     */
    
     /*
      Create a semaphore to control getting and processing API data.
      signal() -> Int    Signals (increments) a semaphore.
      wait()             Waits for, or decrements, a semaphore.
      */
     let semaphore = DispatchSemaphore(value: 0)
    
     URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
         /*
         URLSession is established and the JSON file from the API is set to be fetched
         in an asynchronous manner. After the file is fetched, data, response, error
         are returned as the input parameter values of this Completion Handler Closure.
         */
        
         // Process input parameter 'error'
         guard error == nil else {
             semaphore.signal()
             return
         }
        
         // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
         guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
             semaphore.signal()
             return
         }
        
         // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
         guard let jsonDataFromApi = data else {
             semaphore.signal()
             return
         }
 
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
            Foundation framework’s JSONSerialization class is used to convert JSON data
            into Swift data types such as Dictionary, Array, String, Number, or Bool.
            */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                              options: JSONSerialization.ReadingOptions.mutableContainers)
 
            /*
             JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
             Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
             where Dictionary Key type is String and Value type is Any (instance of any type)
             */
            var jsonDataDictionary = Dictionary<String, Any>()
            
            if let jsonObject = jsonResponse as? [String: Any] {
                jsonDataDictionary = jsonObject
            } else {
                semaphore.signal()
                return
            }
           
            //------------------------
            // Obtain products JSON Array
            //------------------------
           
            var productsJsonArray = [Any]()
            if let jArray = jsonDataDictionary["products"] as? [Any] {
                productsJsonArray = jArray
            } else {
                semaphore.signal()
                return
            }
               
            //-------------------------
            // Obtain products JSON Object
            //-------------------------
           
            var productsJsonObject = [String: Any]()
            if let jObject = productsJsonArray[0] as? [String: Any] {
                productsJsonObject = jObject
            } else {
                semaphore.signal()
                return
            }
           
            //----------------
            // Initializations
            //----------------
 
            var barcodeNumber = "", prodName = "", manuName = "", prodDesc = "", prodImageUrl = ""
    
 
            print(productsJsonObject)
            
            if let BN = productsJsonObject["barcode_number"] as? String {
                barcodeNumber = BN
            }

           
            if let PN = productsJsonObject["product_name"] as? String {
                prodName = PN
            }
            
           
            if let M = productsJsonObject["manufacturer"] as? String {
                manuName = M
            }
            
             if let D = productsJsonObject["description"] as? String {
                           prodDesc = D
                       }
            
            
            var imagesJsonArray = [String]()
            if let iArray = productsJsonObject["images"] as? [String] {
                    imagesJsonArray = iArray
            }
            
            
            imageList.removeAll()
            
            var l = 0
            for _ in imagesJsonArray{
                
                imageList.append(ProductImage(id: UUID(), url: imagesJsonArray[l]))
                l = l + 1            }
            
             var storesJsonArray = [Any]()
            if let jArray = productsJsonObject["stores"] as? [Any] {
                    storesJsonArray = jArray
            }

            var storesJsonObject = [String: Any]()
            var i = 0
            
            
            storeList.removeAll()
            
            for _ in storesJsonArray{

                 if let jObject = storesJsonArray[i] as?[String: Any]{
                     storesJsonObject = jObject
                     i = i + 1

                    
                     var name = ""
                     var price = ""
                     var url = ""
                     var currencyCode = ""
                     var currencySymbol = ""

                    
                    
                     
                       // feed values from json into global foundCat
                     
                     if let n = storesJsonObject["store_name"]as? String{
                         name = n
                     }
                     if let p = storesJsonObject["store_price"]as? String{
                         price = p
                     }
                    if let u = storesJsonObject["product_url"]as? String{
                        url = u
                    }
                    if let cc = storesJsonObject["currency_code"]as? String{
                        currencyCode = cc
                    }
                    if let cs = storesJsonObject["currency_symbol"]as? String{
                        currencySymbol = cs
                    }
                     //append the new News item into the list
                    storeList.append(Store(id: UUID(), name: name, price: price, url: url, currencyCode: currencyCode, currencySymbol: currencySymbol))
                     
                 
                     
                 }else{
                     semaphore.signal()
                     return
                 }
            
             }

            
             item = ProductItem(barcodeNumber: barcodeNumber, prodName: prodName, manuName: manuName, prodDesc: prodDesc, prodImageUrl: prodImageUrl)
               
        } catch {
            semaphore.signal()
            return
        }
       
        semaphore.signal()
    }).resume()
   
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.
    
     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 10 seconds expires.
    */
 
    _ = semaphore.wait(timeout: .now() + 10)
       
}
 
 
