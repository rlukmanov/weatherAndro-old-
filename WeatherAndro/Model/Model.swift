//
//  model.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 31.08.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation

let weekOfDaysArray = ["Sun", "Mon", "Tue", "Wed", "Thu",
                       "Fri", "Sat"]
let monthArray = ["January", "February", "March", "April",
                  "May", "June", "July", "August", "September",
                  "October", "November", "December"]

// MARK: - type degree enum

enum typeDegree {
    case celsius
    case kelvin
    case fahrenheit
}

// MARK: - convert degree func

// input temperature in kelvin
func convertDegree(temperature: Float, typeResult: typeDegree) -> String {
    var result: Float = 0
    
    switch typeResult {
    case .celsius:
        result = temperature - 273.15
    case .fahrenheit:
        result = (temperature - 273.15) * 9 / 5 + 32
    case .kelvin:
        result = temperature
    }
    
    return String(Int(round(result)))
}

// MARK: - get current data func

func currentData(timeZone: Int) -> String {
    var resultConvert: String = ""
    let date = Date()
    var calendar = Calendar.current
    
    if let timeZone = TimeZone(secondsFromGMT: timeZone) {
        calendar.timeZone = timeZone
    }
    
    let dayWeek = calendar.component(.weekday, from: date) - 1
    let day = calendar.component(.day, from: date)
    let month = calendar.component(.month, from: date) - 1
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    var minutesString = String(minutes)
    
    if minutes < 10 {
        minutesString.insert("0", at: minutesString.startIndex)
    }
    
    resultConvert += weekOfDaysArray[dayWeek]
    resultConvert += ","
    resultConvert += String(day)
    resultConvert += " "
    resultConvert += monthArray[month]
    resultConvert += " "
    resultConvert += String(hour)
    resultConvert += ":"
    resultConvert += minutesString
    
    return resultConvert
}

// MARK: - convert precipitation func

func precipitationConvert(value: Float) -> String {
    return String(Int(round(value * 100)))
}

// MARK: - convert time to list string

func convertTimeListHour(timeFirst: Float, timezoneOffset: Int) -> [String] {
    var listResult = [String]()
    
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: timezoneOffset)!
    let date = Date(timeIntervalSince1970: TimeInterval(timeFirst))
    let firstHour = calendar.component(.hour, from: date) + 1
    
    for i in 0..<8 {
        listResult.append(String((3 * i + firstHour) % 24) + ":00")
    }
    
    return listResult
}

// MARK: - getSizePillarHourly func

func getSizePillarHourly(hourlyList: [HourlyModel], maxSize: Float) -> [Float] {
    var listResult = [Float]()
    var currentTemperature: Float
    var stepValue: Float
    var min: Float = (hourlyList.first?.temp)!
    var max: Float = 0
    
    for i in 0..<8 {
        currentTemperature = (hourlyList[3 * i + 1].temp)!
        
        if currentTemperature > max {
            max = currentTemperature
        }
        
        if currentTemperature < min {
            min = currentTemperature
        }
    }
    
    stepValue = maxSize / (max - min)
    
    for i in 0..<8 {
        //let date = Date(timeIntervalSince1970: TimeInterval((hourlyList[3 * i + 1].dt)!))
        
        //print(convertDegree(temperature: (hourlyList[3 * i + 1].temp)!, typeResult: .celsius), " time: ", calendar.component(.hour, from: date), "hour, day: ", calendar.component(.day, from: date))
        listResult.append(stepValue * ((hourlyList[3 * i + 1].temp)! - min))
    }
    
    //print(listResult)
    
    return listResult
}

// MARK: - getHourlyListTemperature func

func getHourlyListTemperature(hourlyList: [HourlyModel]) -> [String] {
    var listResult = [String]()
    
    for i in 0..<8 {
        listResult.append(convertDegree(temperature: (hourlyList[3 * i + 1].temp)!, typeResult: .celsius) + "\u{00B0}")
    }
    
    return listResult
}

// MARK: - getDailyList func

func getDailyList(dailyList: [DailyModel], timezoneOffset: Int) -> [String] {
    var resultList = [String]()
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    
    resultList.append("Today")
    
    for i in 1..<7 {
        let date = Date(timeIntervalSince1970: TimeInterval((dailyList[i].dt)!))
        
        resultList.append(weekOfDaysArray[calendar.component(.weekday, from: date) - 1])
    }
    
    return resultList
}

// MARK: - getSizePillarDaily func

func getSizePillarDaily(dailyList: [DailyModel], maxSize: Float) -> [(Float, Float)] {
    var listResult = [(Float, Float)]() // first - offset bottom, second - height pillar
    var currentTemperatureMin: Float
    var currentTemperatureMax: Float
    var stepValue: Float
    var min: Float = (dailyList.first?.temp?.max)!
    var max: Float = 0
    
    for i in 0..<7 {
        currentTemperatureMin = (dailyList[i].temp?.min)!
        currentTemperatureMax = (dailyList[i].temp?.max)!
        
        if currentTemperatureMax > max {
            max = currentTemperatureMax
        }
        
        if currentTemperatureMin < min {
            min = currentTemperatureMin
        }
    }
    
    stepValue = maxSize / (max - min)
    
    for i in 0..<7 {
        listResult.append((stepValue * ((dailyList[i].temp?.min)! - min), maxSize - stepValue * (max - (dailyList[i].temp?.max)!)))
        listResult[i].1 -= listResult[i].0
    }
    
    return listResult

}

// MARK: - getDailyListTemperature func

func getDailyListTemperature(dailyList: [DailyModel]) -> [(String, String)] {
    var listResult = [(String, String)]()
    var temperatureMax: String
    var temperatureMin: String
    
    for i in 0..<7 {
        temperatureMax = String(convertDegree(temperature: (dailyList[i].temp?.max)!, typeResult: .celsius)) + "\u{00B0}"
        temperatureMin = String(convertDegree(temperature: (dailyList[i].temp?.min)!, typeResult: .celsius)) + "\u{00B0}"
        listResult.append((temperatureMin, temperatureMax))
    }
    
    return listResult
}

