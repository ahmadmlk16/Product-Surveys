//
//  ProductSurveyData.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation
import SwiftUI
 
// Global array of survey structs
var surveyStructList = [ProductSurvey]()
 
/*
 Difference between fileprivate and private:
 fileprivate --> makes this constant accessible anywhere only inside this source file.
 private     --> makes it accessible only inside the type (e.g., class, struct) that declared it.
 */
fileprivate let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
 
/*
 ******************************
 MARK: - Read survey Data File
 ******************************
 */
public func readSurveyDataFile() {
   
    let surveyDataFilename = "SurveysTakenData.json"
   
    // Obtain URL of the survey data file in document directory on user's device
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(surveyDataFilename)
 
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
       
        // survey data file exists in the document directory
 
        surveyStructList = loadFromDocumentDirectory(surveyDataFilename)
        print("surveyData is loaded from document directory")
       
    } catch {
        // survey data file does not exist in the document directory; Load it from the main bundle.
       
        surveyStructList = loadFromMainBundle(surveyDataFilename)
        print("surveyData is loaded from main bundle")
    }
}
 
/*
***********************************************
MARK: - Load survey Data File from Main Bundle
***********************************************
*/
func loadFromMainBundle<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
   
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Unable to find \(filename) in main bundle.")
    }
   
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Unable to load \(filename) from main bundle:\n\(error)")
    }
   
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename) as \(T.self):\n\(error)")
    }
}
 
/*
 *****************************************************
 MARK: - Write survey Data File to Document Directory
 *****************************************************
 */
public func writeSurveyDataFile() {
 
    // Obtain the URL of the JSON file in the document directory on the user's device
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("SurveysTakenData.json")
 
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(surveyStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded survey data to document directory!")
        }
    } else {
        fatalError("Unable to encode survey data!")
    }
}
 
/*
******************************************************
MARK: - Load survey Data File from Document Directory
******************************************************
*/
func loadFromDocumentDirectory<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
   
    // Obtain the URL of the JSON file in the document directory on the user's device
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent(filename)
   
    guard let file = urlOfJsonFileInDocumentDirectory
        else {
            fatalError("Unable to find \(filename) in document directory.")
    }
   
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Unable to load \(filename) from document directory:\n\(error)")
    }
   
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename) as \(T.self):\n\(error)")
    }
}
 
