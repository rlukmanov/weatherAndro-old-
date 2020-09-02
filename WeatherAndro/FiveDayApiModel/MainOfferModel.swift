//
//  MainOfferModel.swift
//  Weather App
//
//  Created by Ruslan Lukmanov on 20.07.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation

class MainOfferModel: Codable {
    var temp: Float? // Temperature
    var feels_like: Float? // Temperature. This temperature parameter accounts for the human perception of weather
}
