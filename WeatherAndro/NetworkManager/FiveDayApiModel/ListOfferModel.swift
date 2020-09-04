//
//  ListOfferModel.swift
//  Weather App
//
//  Created by Ruslan Lukmanov on 20.07.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation

class ListOfferModel: Codable {
    var dt: Float? // Time of data forecasted, unix, UTC
    var main: MainOfferModel?
    var weather: [WeatherOfferModel]?
    var pop: Float? // Probability of precipation
    var dt_txt: String?
}
