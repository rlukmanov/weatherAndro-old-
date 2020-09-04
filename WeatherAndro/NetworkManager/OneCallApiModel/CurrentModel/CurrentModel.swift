//
//  CurrentModel.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 01.09.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation

class CurrentModel: Codable {
    var dt: Float?
    var sunrise: Float?
    var sunset: Float?
    var temp: Float?
    var feels_like: Float?
    var weather: [WeatherCurrentModel]?
}
