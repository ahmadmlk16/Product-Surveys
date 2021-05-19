//
//  ProductSurvey.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
//Product survey Object 
struct ProductSurvey: Hashable, Codable, Identifiable {
   
    var id: UUID        // Storage Type: String, Use Type (format): UUID
    var dateTime: String
    var answerToQuestion1: String
    var answerToQuestion2: String
    var answerToQuestion3: String
    var answerToQuestion4: String
    var answerToQuestion5: String
    var answerToQuestion6: String
    var answerToQuestion7: String
    var answerToQuestion8: Int

}


