//
//  WeatherOfferModel.swift
//  Weather App
//
//  Created by Ruslan Lukmanov on 21.07.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation

class WeatherOfferModel: Codable {
    var main: String? // Group of weather parameters (Rain, Snow etc.)
    var description: String? // Weather condition within the group
    var icon: String? // Weather icon id
}
