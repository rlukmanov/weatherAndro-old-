//
//  LoadSetData.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 31.08.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation
import UIKit

extension PageScrollViewController {
    
    // MARK: - load data
    
    func loadData(city: String) {
        _ = NetworkManager.shared.getWeather(city: city, completion: { (result) in
            
            DispatchQueue.main.async {
                guard let result = result else {
            
                    DispatchQueue.main.async {
                        print("Didn't find this city!")

                        let alert = UIAlertController(title: "Error",
                                                      message: "The city was not found. Check and change the name",
                                                      preferredStyle: .alert)
                    
                        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in })
                        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white
                        alert.view.tintColor = .black
                
                        self.present(alert, animated: true)
                    }
                
                    return
                }
                
                self.setData(resultFiveDay: result)
            }
        })
        
        _ = NetworkManager.shared.getWeatherOneCallApi(completion: { (result) in
            
            DispatchQueue.main.async {
                guard let result = result else {
                    
                    
                    
                    DispatchQueue.main.async {
                        print("Didn't find this city")

                        let alert = UIAlertController(title: "Error",
                                                      message: "The city was not found. Check and change the name",
                                                      preferredStyle: .alert)
                    
                        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in })
                        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white
                        alert.view.tintColor = .black
                
                        self.present(alert, animated: true)
                    }
                
                    return
                }
                
                self.setData(resultOneCall: result)
            }
        })
    }
    
}
