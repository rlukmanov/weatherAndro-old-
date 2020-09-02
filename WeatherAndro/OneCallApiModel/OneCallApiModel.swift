//
//  OneCallApiModel.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 01.09.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation

class OneCallApiModel: Codable {
    var timezone_offset: Int?
    var current: CurrentModel?
    var hourly: [HourlyModel]?
    var daily: [DailyModel]?
}
