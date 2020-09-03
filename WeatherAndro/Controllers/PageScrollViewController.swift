//
//  ViewController.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 27.08.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import UIKit
import CoreLocation

class PageScrollViewController: UIViewController {
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    // MARK: - properties

    private let pageScrollView: UIScrollView = {
        let pageScrollView = UIScrollView()
        
        pageScrollView.showsHorizontalScrollIndicator = false
        pageScrollView.showsVerticalScrollIndicator = false
        pageScrollView.backgroundColor = .none
        pageScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return pageScrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()

        contentView.backgroundColor = .none
        contentView.translatesAutoresizingMaskIntoConstraints = false

        return contentView
    }()
    
    private let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        
        backgroundImageView.image = UIImage(named: "Background")
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return backgroundImageView
    }()
    
    // MARK: - places button properties
    
    private let titlePlacesLabel: UILabel = {
        let titlePlacesLabel = UILabel()
        
        titlePlacesLabel.text = "Locations"
        titlePlacesLabel.font = .systemFont(ofSize: 15, weight: .medium)
        titlePlacesLabel.textColor = .white
        titlePlacesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titlePlacesLabel
    }()
    
    // MARK: - search button properties
    
    private let searchIconImageView: UIImageView = {
        let searchIconImageView = UIImageView()
        
        searchIconImageView.image = UIImage(named: "lensIconWhite")
        searchIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return searchIconImageView
    }()
    
    // MARK: - settings button properties
    
    private let settingsIconImageView: UIImageView = {
        let settingsIconImageView = UIImageView()
        
        settingsIconImageView.image = UIImage(named: "settingsMenu")
        settingsIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return settingsIconImageView
    }()
    
    // MARK: - name place property
    private let namePlaceLabel: UILabel = {
        let namePlaceLabel = UILabel()
        
        namePlaceLabel.text = "Москва"
        namePlaceLabel.font = .systemFont(ofSize: 16, weight: .medium)
        namePlaceLabel.textColor = UIColor(red: 240.0 / 255.0, green: 239.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)
        namePlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return namePlaceLabel
    }()
    
    // MARK: - date time properties
    
    private let dateTimeLabel: UILabel = {
        let dateTimeLabel = UILabel()
        
        dateTimeLabel.text = "вс, 30 августа 0:16"
        dateTimeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dateTimeLabel.textColor = UIColor(red: 178.0 / 255.0, green: 181.0 / 255.0, blue: 253.0 / 255.0, alpha: 1)
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dateTimeLabel
    }()
    
    // MARK: - temperature value property
    
    private let temperatureValueLabel: UILabel = {
        let temperatureValueLabel = UILabel()
        
        temperatureValueLabel.text = "14" + "\u{00B0}"
        temperatureValueLabel.font = .systemFont(ofSize: 80, weight: .thin)
        temperatureValueLabel.textColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)
        temperatureValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return temperatureValueLabel
    }()
    
    // MARK: - feels like property
    
    private let feelsLikeLabel: UILabel = {
        let feelsLikeLabel = UILabel()
        
        feelsLikeLabel.text = "19" + "\u{00B0}" + "/" + "13" + "\u{00B0}" + " Ощущается как 13" + "\u{00B0}"
        feelsLikeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        feelsLikeLabel.textColor = UIColor(red: 210.0 / 255.0, green: 223.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return feelsLikeLabel
    }()
    
    // MARK: - type weather property
    
    private let typeWeatherLabel: UILabel = {
        let typeWeatherLabel = UILabel()
        
        typeWeatherLabel.text = "Ясно"
        typeWeatherLabel.font = .systemFont(ofSize: 16, weight: .medium)
        typeWeatherLabel.textColor = UIColor(red: 239.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        typeWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return typeWeatherLabel
    }()
    
    private let mainView = MainView()
    
    private let hourlyView = HourlyView()
    
    private let dailyView = DailyView()
    
    private let detailsView = DetailsView()
    
    // MARK: - viewDidLoad func

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.pageScrollView.delegate = self
        
        mainView.configure()
        hourlyView.configure()
        dailyView.configure()
        detailsView.configure()
        
        addSubviews()
        setupConstraints()
        
        loadData(city: "Moscow")
    }
    
    // MARK: - preferredStatusBarStyle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - setup data funcs
    
    func setData(resultFiveDay: OfferModel) {
        namePlaceLabel.text = resultFiveDay.city?.name
        
        mainView.setupData(resultFiveDay: resultFiveDay)
    }
    
    func setData(resultOneCall: OneCallApiModel) {
        temperatureValueLabel.text = convertDegree(temperature: (resultOneCall.current?.temp)!, typeResult: .celsius) + "\u{00B0}"
        typeWeatherLabel.text = resultOneCall.current?.weather?.first?.main
        dateTimeLabel.text = currentData(timeZone: (resultOneCall.timezone_offset)!)
        
        feelsLikeLabel.text = convertDegree(temperature: (resultOneCall.daily?.first?.temp?.max)!, typeResult: .celsius)
        feelsLikeLabel.text! += "\u{00B0}"
        feelsLikeLabel.text! += "/"
        feelsLikeLabel.text! += convertDegree(temperature: (resultOneCall.daily?.first?.temp?.min)!, typeResult: .celsius)
        feelsLikeLabel.text! += "\u{00B0}"
        feelsLikeLabel.text! += " Feels like "
        feelsLikeLabel.text! += convertDegree(temperature: (resultOneCall.current?.feels_like)!, typeResult: .celsius)
        feelsLikeLabel.text! += "\u{00B0}"
        
        hourlyView.setupData(resultOneCall: resultOneCall)
        dailyView.setupData(resultOneCall: resultOneCall)
        detailsView.setupData(resultOneCall: resultOneCall)
    }
    
    // MARK: - add subviews func

    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(titlePlacesLabel)
        view.addSubview(searchIconImageView)
        view.addSubview(settingsIconImageView)
        view.addSubview(namePlaceLabel)
        view.addSubview(dateTimeLabel)
        view.addSubview(pageScrollView)
        
        pageScrollView.addSubview(contentView)
        
        contentView.addSubview(temperatureValueLabel)
        contentView.addSubview(feelsLikeLabel)
        contentView.addSubview(typeWeatherLabel)
        
        contentView.addSubview(mainView)
        contentView.addSubview(hourlyView)
        contentView.addSubview(dailyView)
        contentView.addSubview(detailsView)
    }
    
    // MARK: - setup constraints funcs

    private func setupConstraints() {
        setupConstraintsBackgroundImageView()
        setupConstraintsTitlePlacesLabel()
        setupConstraintsSearchIconImageView()
        setupConstraintsSettingsIconImageView()
        setupConstraintsNamePlaceLabel()
        setupConstraintsDateTimeLabel()
        setupConstraintsPageScrollView()
        
        setupConstraintsContentView()
        
        setupConstraintsTemperatureValueLabel()
        setupConstraintsFeelsLikeLabel()
        setupConstraintsTypeWeatherLabel()
        
        setupConstraintsMainView()
        setupConstraintsHourlyView()
        setupConstraintsDailyView()
        setupConstraintsDetailsView()
    }
    
    private func setupConstraintsBackgroundImageView() {
        backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupConstraintsNamePlaceLabel() {
        namePlaceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 91).isActive = true
        namePlaceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupConstraintsDateTimeLabel() {
        dateTimeLabel.topAnchor.constraint(equalTo: namePlaceLabel.bottomAnchor, constant: 8).isActive = true
        dateTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupConstraintsPageScrollView() {
        pageScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 148).isActive = true
        pageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pageScrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    private func setupConstraintsContentView() {
        contentView.leftAnchor.constraint(equalTo: pageScrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: pageScrollView.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: pageScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: pageScrollView.bottomAnchor).isActive = true
    }
    
    private func setupConstraintsTitlePlacesLabel() {
        titlePlacesLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -94).isActive = true
        titlePlacesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39).isActive = true
    }
    
    private func setupConstraintsSearchIconImageView() {
        searchIconImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -57).isActive = true
        searchIconImageView.topAnchor.constraint(equalTo: titlePlacesLabel.topAnchor).isActive = true
        searchIconImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        searchIconImageView.widthAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    private func setupConstraintsSettingsIconImageView() {
        settingsIconImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -28).isActive = true
        settingsIconImageView.topAnchor.constraint(equalTo: searchIconImageView.topAnchor).isActive = true
        settingsIconImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        settingsIconImageView.widthAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    private func setupConstraintsTemperatureValueLabel() {
        temperatureValueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13).isActive = true
        temperatureValueLabel.leftAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -16).isActive = true
    }
    
    private func setupConstraintsFeelsLikeLabel() {
        feelsLikeLabel.topAnchor.constraint(equalTo: temperatureValueLabel.bottomAnchor, constant: 18).isActive = true
        feelsLikeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    private func setupConstraintsTypeWeatherLabel() {
        typeWeatherLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 18).isActive = true
        typeWeatherLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    private func setupConstraintsMainView() {
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 236).isActive = true
        mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 105).isActive = true
    }
    
    private func setupConstraintsHourlyView() {
        hourlyView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        hourlyView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        hourlyView.heightAnchor.constraint(equalToConstant: 288).isActive = true
        hourlyView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 35).isActive = true
    }
    
    private func setupConstraintsDailyView() {
        dailyView.topAnchor.constraint(equalTo: hourlyView.bottomAnchor, constant: 35).isActive = true
        dailyView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        dailyView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        dailyView.heightAnchor.constraint(equalToConstant: 338).isActive = true
    }
    
    private func setupConstraintsDetailsView() {
        detailsView.topAnchor.constraint(equalTo: dailyView.bottomAnchor, constant: 35).isActive = true
        detailsView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        detailsView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        detailsView.heightAnchor.constraint(equalToConstant: 138).isActive = true
        detailsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35).isActive = true
    }
}

// MARK: - UIScrollViewDelegate

extension PageScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screenSize = UIScreen.main.bounds
        let percentage = scrollView.contentOffset.y / (scrollView.contentSize.height * 896.0 / screenSize.height )
        
        // "animation" hide view
        if percentage >= 0 && percentage <= 0.1 && scrollView.contentOffset.x == 0 {
            dateTimeLabel.alpha = 1 - 10 * percentage
        } else if percentage > 0.1 {
            dateTimeLabel.alpha = 0
        }
    }
}
