//
//  WeatherCurrentModel.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 01.09.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation

class WeatherCurrentModel: Codable {
    var main: String? // Group of weather parameters (Rain, Snow etc.)
    var description: String? // Weather condition within the group
    var icon: String? // Weather icon id
}
