//
//  File.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 04.09.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

protocol ViewControllerDelegate: AnyObject {
    func addNewCity()
    func deleteCurrentCity()
}
