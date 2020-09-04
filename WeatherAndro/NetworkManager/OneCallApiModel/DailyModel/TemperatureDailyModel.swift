//
//  TemperatureDailyModel.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 01.09.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation

class TemperatureDailyModel: Codable {
    var day: Float?
    var morn: Float?
    var night: Float?
    var min: Float?
    var max: Float?
}
