//
//  Image.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/31/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

//image object with UUID
import SwiftUI
struct ProductImage: Hashable, Codable, Identifiable {
    var id: UUID
    var url: String
}
