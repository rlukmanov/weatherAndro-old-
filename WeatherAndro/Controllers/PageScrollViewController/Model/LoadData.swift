//
//  LoadSetData.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 31.08.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension PageScrollViewController {
    
    private func showAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "The city was not found. Check and change the name",
                                      preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in })
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white
        alert.view.tintColor = .black
        
        self.present(alert, animated: true)
    }
    
    // MARK: - load data
    
    func loadData(city: String) {
        var coord: CLLocationCoordinate2D?
        let semaphore = DispatchSemaphore(value: 0)
        
        _ = NetworkManager.shared.getWeather(city: city, completion: { (result) in
                
            guard let result = result else {
                DispatchQueue.main.async {
                    print("Didn't find this city!")

                    self.showAlert()
                }
                    
                return
            }
                    
            coord = CLLocationCoordinate2DMake(CLLocationDegrees((result.city?.coord?.lat)!), CLLocationDegrees((result.city?.coord?.lon)!))
            semaphore.signal()
                    
            DispatchQueue.main.async {
                self.setData(resultFiveDay: result)
            }
        })

        semaphore.wait()
        
        _ = NetworkManager.shared.getWeatherOneCallApi(coord: coord, completion: { (result) in
    
             guard let result = result else {
                DispatchQueue.main.async {
                    print("Didn't find this city!")

                    self.showAlert()
                }
                        
                return
            }
                    
            DispatchQueue.main.async {
                self.setData(resultOneCall: result)
            }
        })
    }
}
