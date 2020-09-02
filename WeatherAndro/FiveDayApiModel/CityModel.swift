//
//  CityModel.swift
//  Weather App
//
//  Created by Ruslan Lukmanov on 20.07.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation

class CityModel: Codable {
    var name: String? // City name
    var timezone: Int? // Shift in seconds from UTC
}
