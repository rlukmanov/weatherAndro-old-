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
        var success = true
        
        _ = NetworkManager.shared.getWeather(city: city, completion: { (result) in
            
            guard let result = result else {
                success = false
                
                DispatchQueue.main.async {
                    print("Didn't find this city!")

                    self.showAlert()
                }
                
                semaphore.signal()
                
                return
            }
            
            semaphore.signal()
            
            coord = CLLocationCoordinate2DMake(CLLocationDegrees((result.city?.coord?.lat)!), CLLocationDegrees((result.city?.coord?.lon)!))
                    
            DispatchQueue.main.async {
                if self.newData {
                    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
                    if !launchedBefore  {
                        UserDefaults.standard.set([String](), forKey: "Cities")
                        UserDefaults.standard.set(true, forKey: "launchedBefore")
                    }
                    
                    var arrayCities = UserDefaults.standard.array(forKey: "Cities") as! [String]
                    arrayCities.append(city)
                    UserDefaults.standard.set(arrayCities, forKey: "Cities")
                    
                    self.newData = false
                }
                
                self.setData(resultFiveDay: result)
            }
        })

        semaphore.wait()
        
        if success {
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
}
