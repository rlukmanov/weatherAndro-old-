//
//  Location.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 31.08.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - CLLocationManagerDelegate
extension PageScrollViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currentLocation = locations.last, currentLocation.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()

            let coord = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
            
            print(coord)
            // self.loadData(coord: coord)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
