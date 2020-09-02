//
//  NetworkManager.swift
//  Weather App
//
//  Created by Ruslan Lukmanov on 20.07.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkManager {
    private init() {} // to avoid standart implementation init
    
    static let shared: NetworkManager = NetworkManager()
    let decoder = JSONDecoder()
    let task = URLSession(configuration: .default)
    
    func getWeather(city: String, completion: @escaping (OfferModel?) -> Void ) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "appid", value: "da9f74ec5dd6df3021ce4c5f8ecdc569")]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        task.dataTask(with: request) { (data, response, error) in
            if error == nil, let parsData = data {
                
                guard let weather = try? self.decoder.decode(OfferModel.self, from: parsData) else {
                    print("Unable to decode")
                    completion(nil)
                    return
                }
                
                completion(weather)
            } else {
                completion(nil)
                print("Error: \(error?.localizedDescription ?? "fault")")
            }
        }.resume()
    
    }
    
    func getWeather(coord: CLLocationCoordinate2D?, completion: @escaping (OfferModel?) -> Void ) {
        
        guard let coord = coord else { return }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [URLQueryItem(name: "lat", value: String(coord.latitude)),
                                    URLQueryItem(name: "lon", value: String(coord.longitude)),
                                    URLQueryItem(name: "appid", value: "da9f74ec5dd6df3021ce4c5f8ecdc569")]

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"

        task.dataTask(with: request) { (data, response, error) in
            if error == nil, let parsData = data {

                guard let weather = try? self.decoder.decode(OfferModel.self, from: parsData) else {
                    completion(nil)
                    return
                }

                completion(weather)
            } else {
                completion(nil)
                print("Error: \(error?.localizedDescription ?? "fault")")
            }
        }.resume()
    }
    
    func getWeatherOneCallApi( /*coord: CLLocationCoordinate2D?,*/ completion: @escaping (OneCallApiModel?) -> Void ) {
        
        let coordMoscow = CLLocationCoordinate2DMake(55.7522, 37.6156)
        
        // guard let coord = coord else { return }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/onecall"
        urlComponents.queryItems = [URLQueryItem(name: "lat", value: String(coordMoscow.latitude)),
                                    URLQueryItem(name: "lon", value: String(coordMoscow.longitude)),
                                    URLQueryItem(name: "exclude", value: "minutely"),
                                    URLQueryItem(name: "appid", value: "da9f74ec5dd6df3021ce4c5f8ecdc569")]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"

        task.dataTask(with: request) { (data, response, error) in
            if error == nil, let parsData = data {

                guard let weather = try? self.decoder.decode(OneCallApiModel.self, from: parsData) else {
                    completion(nil)
                    return
                }

                completion(weather)
            } else {
                completion(nil)
                print("Error: \(error?.localizedDescription ?? "fault")")
            }
        }.resume()
    }
}
