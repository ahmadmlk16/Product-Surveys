//
//  Store.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

// store object
import SwiftUI
struct Store: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    var price: String
    var url: String
    var currencyCode: String
    var currencySymbol: String
}
