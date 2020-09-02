//
//  OfferModel.swift
//  Weather App
//
//  Created by Ruslan Lukmanov on 20.07.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation

class OfferModel: Codable {
    var cod: String? // Internal parameter
    var message: Float? // Internal parameter
    var list: [ListOfferModel]?
    var city: CityModel?
}
