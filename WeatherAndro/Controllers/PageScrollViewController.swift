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
    
    // MARK: - main info properties
    
    private let mainInfoView: UIView = {
        let mainInfoView = UIView()
        
        mainInfoView.backgroundColor = UIColor(red: 146.0 / 255.0, green: 192.0 / 255.0, blue: 225.0 / 255.0, alpha: 0.4)
        mainInfoView.layer.cornerRadius = 23
        mainInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        return mainInfoView
    }()
    
    private let dropIconImageView: UIImageView = {
        let dropIconImageView = UIImageView()
        
        dropIconImageView.image = UIImage(named: "DropWaterIcon")
        dropIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return dropIconImageView
    }()
    
    private let precipitationTitleLabel: UILabel = {
        let precipitationTitleLabel = UILabel()
        
        precipitationTitleLabel.text = "Precipitation"
        precipitationTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        precipitationTitleLabel.textColor = UIColor(red: 233.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        precipitationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return precipitationTitleLabel
    }()
    
    private let precipitationValueLabel: UILabel = {
        let precipitationValueLabel = UILabel()
        
        precipitationValueLabel.text = "40%"
        precipitationValueLabel.font = .systemFont(ofSize: 14, weight: .medium)
        precipitationValueLabel.textColor = UIColor(red: 233.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        precipitationValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return precipitationValueLabel
    }()
    
    private let lineInfoSeparator: UIImageView = {
        let lineInfoSeparator = UIImageView()
        
        lineInfoSeparator.image = UIImage(named: "LineInfoSeparator")
        lineInfoSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        return lineInfoSeparator
    }()
    
    // MARK: - hourly info properties
    
    private let hourlyInfoScrollView: UIScrollView = {
        let hourlyInfoScrollView = UIScrollView()
        
        hourlyInfoScrollView.showsHorizontalScrollIndicator = false
        hourlyInfoScrollView.showsVerticalScrollIndicator = false
        hourlyInfoScrollView.backgroundColor = .none
        hourlyInfoScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyInfoScrollView
    }()
    
    private let hourlyBackgroundView: UIView = {
        let mainBackgroundView = UIView()

        mainBackgroundView.backgroundColor = UIColor(red: 146.0 / 255.0, green: 192.0 / 255.0, blue: 225.0 / 255.0, alpha: 0.4)
        mainBackgroundView.layer.cornerRadius = 23
        mainBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        return mainBackgroundView
    }()
    
    private let hourlyContentView: UIView = {
        let mainInfoView = UIView()
        
        mainInfoView.backgroundColor = .none
        mainInfoView.layer.cornerRadius = 23
        mainInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        return mainInfoView
    }()
    
    private let hourlyInfoTitleLabel: UILabel = {
        let hourlyInfoTitleLabel = UILabel()
        
        hourlyInfoTitleLabel.text = "Hourly"
        hourlyInfoTitleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        hourlyInfoTitleLabel.textColor = UIColor(red: 211.0 / 255.0, green: 230.0 / 255.0, blue: 239.0 / 255.0, alpha: 1)
        hourlyInfoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyInfoTitleLabel
    }()
    
    private let hourlyTimeStackView: UIStackView = {
        let hourlyTimeStackView = UIStackView()
        
        hourlyTimeStackView.axis = .horizontal
        hourlyTimeStackView.distribution = .fillEqually
        hourlyTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyTimeStackView
    }()
    
    private let hourlyArrowIconRightImageView: UIImageView = {
        let hourlyArrowIconRightImageView = UIImageView()
        
        hourlyArrowIconRightImageView.image = UIImage(named: "ArrowIconRight")
        hourlyArrowIconRightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyArrowIconRightImageView
    }()
    
    private let hourlyArrowIconLeftImageView: UIImageView = {
        let hourlyArrowIconLeftImageView = UIImageView()
           
        hourlyArrowIconLeftImageView.image = UIImage(named: "ArrowIconLeft")
        hourlyArrowIconLeftImageView.isHidden = true
        hourlyArrowIconLeftImageView.translatesAutoresizingMaskIntoConstraints = false
           
        return hourlyArrowIconLeftImageView
    }()
    
    private let hourlyButtonView: UIView = {
        let hourlyButtonView = UIView()
        
        hourlyButtonView.layer.cornerRadius = 23
        hourlyButtonView.backgroundColor = UIColor(red: 162.0 / 255.0, green: 202.0 / 255.0, blue: 227.0 / 255.0, alpha: 0.4)
        hourlyButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyButtonView
    }()
    
    private let hourlyButtonLabel: UILabel = {
        let hourlyButtonLabel = UILabel()
        
        hourlyButtonLabel.textColor = UIColor(red: 230.0 / 255.0, green: 246.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)
        hourlyButtonLabel.text = "48 hours"
        hourlyButtonLabel.font = .systemFont(ofSize: 13, weight: .medium)
        hourlyButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyButtonLabel
    }()
    
    private let hourlyButton: UIButton = {
        let hourlyButton = UIButton()
        
        hourlyButton.backgroundColor = .none
        hourlyButton.layer.cornerRadius = 23
        hourlyButton.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyButton
    }()
    
    private let hourlyPillarStackView: UIStackView = {
        let hourlyPillarStackView = UIStackView()
        
        hourlyPillarStackView.distribution = .fillEqually
        hourlyPillarStackView.axis = .horizontal
        hourlyPillarStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyPillarStackView
    }()
    
    private var hourlyTimeValueArray = Array<UILabel>()
    private var hourlyPillarBaseImageViewArray = Array<UIImageView>()
    private var hourlyPillarTopImageViewArray = Array<UIImageView>()
    private var hourlyPillarViewArray = Array<UIView>()
    private var hourlyTemperatureLabelArray = Array<UILabel>()
    
    // MARK: - daily info properties
    
    private let dailyInfoView: UIView = {
        let mainInfoView = UIView()
        
        mainInfoView.backgroundColor = UIColor(red: 146.0 / 255.0, green: 192.0 / 255.0, blue: 225.0 / 255.0, alpha: 0.4)
        mainInfoView.layer.cornerRadius = 23
        mainInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        return mainInfoView
    }()
    
    // MARK: - viewDidLoad func

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.pageScrollView.delegate = self
        self.hourlyInfoScrollView.delegate = self
        
        addSubviews()
        setupConstraints()
        
        loadData(city: "Moscow")
    }
    
    // MARK: - preferredStatusBarStyle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - set data funcs
    
    func setHourlyTimeValue(timeFirst: Float, timezoneOffset: Int) {
        let listHour = convertTimeListHour(timeFirst: timeFirst, timezoneOffset: timezoneOffset)
        
        for i in 0..<listHour.count {
            let timeValueLabel = UILabel()
            
            timeValueLabel.text = listHour[i]
            timeValueLabel.textColor = .white
            timeValueLabel.textAlignment = .center
            timeValueLabel.font = .systemFont(ofSize: 15, weight: .regular)
            hourlyTimeStackView.addArrangedSubview(timeValueLabel)
            hourlyTimeValueArray.append(timeValueLabel)
        }
    }
    
    func setHourlyPillar(hourlyList: [HourlyModel], maxSize: Float) {
        var pillarHeightList: [Float]
        
        pillarHeightList = getSizePillar(hourlyList: hourlyList, maxSize: maxSize)
        
        for i in 0..<pillarHeightList.count {
            let pillarView = UIView()
            let pillarBaseImageView = UIImageView()
            let pillarBottomImageView = UIImageView()
            let pillarTopImageView = UIImageView()
            
            // bottom icon
            
            pillarView.addSubview(pillarBottomImageView)
            
            pillarBottomImageView.image = UIImage(named: "PillarBottomIcon")
            pillarBottomImageView.translatesAutoresizingMaskIntoConstraints = false
            
            pillarBottomImageView.heightAnchor.constraint(equalToConstant: 3).isActive = true
            pillarBottomImageView.widthAnchor.constraint(equalToConstant: 6).isActive = true
            pillarBottomImageView.centerXAnchor.constraint(equalTo: pillarView.centerXAnchor).isActive = true
            pillarBottomImageView.bottomAnchor.constraint(equalTo: pillarView.bottomAnchor).isActive = true
            
            // base icon
            
            pillarView.addSubview(pillarBaseImageView)
            
            pillarBaseImageView.image = UIImage(named: "PillarBaseIcon")
            pillarBaseImageView.translatesAutoresizingMaskIntoConstraints = false
            
            pillarBaseImageView.heightAnchor.constraint(equalToConstant: CGFloat(pillarHeightList[i])).isActive = true
            pillarBaseImageView.widthAnchor.constraint(equalToConstant: 6).isActive = true
            pillarBaseImageView.centerXAnchor.constraint(equalTo: pillarView.centerXAnchor).isActive = true
            pillarBaseImageView.bottomAnchor.constraint(equalTo: pillarBottomImageView.topAnchor).isActive = true
            
            hourlyPillarStackView.addArrangedSubview(pillarView)
            hourlyPillarViewArray.append(pillarView)
            hourlyPillarBaseImageViewArray.append(pillarBaseImageView)
            
            // top icon
            
            pillarView.addSubview(pillarTopImageView)
            
            pillarTopImageView.image = UIImage(named: "PillarTopIcon")
            pillarTopImageView.translatesAutoresizingMaskIntoConstraints = false
            
            pillarTopImageView.heightAnchor.constraint(equalToConstant: 3).isActive = true
            pillarTopImageView.widthAnchor.constraint(equalToConstant: 6).isActive = true
            pillarTopImageView.centerXAnchor.constraint(equalTo: pillarView.centerXAnchor).isActive = true
            pillarTopImageView.bottomAnchor.constraint(equalTo: pillarBaseImageView.topAnchor).isActive = true
            
            hourlyPillarTopImageViewArray.append(pillarTopImageView)
        }
    }
    
    func setHourlyTemperature(hourlyList: [HourlyModel]) {
        var listTemperature: [String]
        
        listTemperature = getHourlyListTemperature(hourlyList: hourlyList)
        
        for i in 0..<listTemperature.count {
            let temperatureValueLabel = UILabel()
            
            temperatureValueLabel.text = listTemperature[i]
            temperatureValueLabel.textColor = UIColor(red: 236.0 / 255.0, green: 253.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
            temperatureValueLabel.font = .systemFont(ofSize: 15, weight: .medium)
            temperatureValueLabel.translatesAutoresizingMaskIntoConstraints = false
            
            hourlyContentView.addSubview(temperatureValueLabel)
            
            temperatureValueLabel.bottomAnchor.constraint(equalTo: hourlyPillarTopImageViewArray[i].topAnchor, constant: -5).isActive = true
            temperatureValueLabel.centerXAnchor.constraint(equalTo: hourlyPillarTopImageViewArray[i].centerXAnchor, constant: 3).isActive = true
            
            hourlyTemperatureLabelArray.append(temperatureValueLabel)
        }
    }
    
    func setData(resultFiveDay: OfferModel) {
        namePlaceLabel.text = resultFiveDay.city?.name
        precipitationValueLabel.text = precipitationConvert(value: (resultFiveDay.list?.first?.pop)!) + "%"
    }
    
    func setData(resultOneCall: OneCallApiModel) {
        temperatureValueLabel.text = convertDegree(temperature: (resultOneCall.current?.temp)!, typeResult: .celsius) + "\u{00B0}"
        typeWeatherLabel.text = resultOneCall.current?.weather?.first?.main
        dateTimeLabel.text = currentData(timeZone: (resultOneCall.timezone_offset)!)
        
        feelsLikeLabel.text = convertDegree(temperature: (resultOneCall.daily?.first?.temp?.day)!, typeResult: .celsius)
        feelsLikeLabel.text! += "\u{00B0}"
        feelsLikeLabel.text! += "/"
        feelsLikeLabel.text! += convertDegree(temperature: (resultOneCall.daily?.first?.temp?.night)!, typeResult: .celsius)
        feelsLikeLabel.text! += "\u{00B0}"
        feelsLikeLabel.text! += " Feels like "
        feelsLikeLabel.text! += convertDegree(temperature: (resultOneCall.current?.feels_like)!, typeResult: .celsius)
        feelsLikeLabel.text! += "\u{00B0}"
        
        setHourlyTimeValue(timeFirst: (resultOneCall.hourly?.first?.dt)!, timezoneOffset: (resultOneCall.timezone_offset)!)
        setHourlyPillar(hourlyList: (resultOneCall.hourly)!, maxSize: 37)
        setHourlyTemperature(hourlyList: (resultOneCall.hourly)!)
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
        
        
        contentView.addSubview(mainInfoView)
        mainInfoView.addSubview(lineInfoSeparator)
        mainInfoView.addSubview(dropIconImageView)
        mainInfoView.addSubview(precipitationTitleLabel)
        mainInfoView.addSubview(precipitationValueLabel)
        
        contentView.addSubview(hourlyBackgroundView)
        hourlyBackgroundView.addSubview(hourlyArrowIconRightImageView)
        hourlyBackgroundView.addSubview(hourlyArrowIconLeftImageView)
        hourlyBackgroundView.addSubview(hourlyButtonView)
        hourlyButtonView.addSubview(hourlyButtonLabel)
        hourlyButtonView.addSubview(hourlyButton)
        contentView.addSubview(hourlyInfoScrollView)
        hourlyInfoScrollView.addSubview(hourlyContentView)
        contentView.addSubview(hourlyInfoTitleLabel)
        hourlyContentView.addSubview(hourlyTimeStackView)
        hourlyContentView.addSubview(hourlyPillarStackView)
        
        contentView.addSubview(dailyInfoView)
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
        
        setupConstraintsMainInfoView()
        setupConstraintsLineInfoSeparator()
        setupConstraintsDropIconImageView()
        setupConstraintsPrecipitationTitleLabel()
        setupConstraintsPrecipitationValueLabel()
        
        setupConstraintsHourlyBackgroundView()
        setupConstraintsHourlyInfoTitleLabel()
        setupConstraintsHourlyArrowIconRightImageView()
        setupConstraintsHourlyArrowIconleftImageView()
        setupConstraintsHourlyButtonView()
        setupConstraintsHourlyButtonLabel()
        setupConstraintsHourlyButton()
        setupConstraintsHourlyInfoScrollView()
        setupConstraintsHourlyContentView()
        setupConstraintsHourlyTimeStackView()
        setupConstraintsHourlyPillarStackView()
        
        setupConstraintsDailyInfoView()
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
    
    private func setupConstraintsContentView() {
        contentView.leftAnchor.constraint(equalTo: pageScrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: pageScrollView.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: pageScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: pageScrollView.bottomAnchor).isActive = true
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
    
    private func setupConstraintsMainInfoView() {
        mainInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 236).isActive = true
        mainInfoView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        mainInfoView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        mainInfoView.heightAnchor.constraint(equalToConstant: 105).isActive = true
    }
    
    private func setupConstraintsLineInfoSeparator() {
        lineInfoSeparator.centerYAnchor.constraint(equalTo: mainInfoView.centerYAnchor).isActive = true
        lineInfoSeparator.centerXAnchor.constraint(equalTo: mainInfoView.centerXAnchor).isActive = true
        lineInfoSeparator.heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
    
    private func setupConstraintsDropIconImageView() {
        dropIconImageView.leftAnchor.constraint(equalTo: mainInfoView.leftAnchor, constant: 41).isActive = true
        dropIconImageView.centerYAnchor.constraint(equalTo: mainInfoView.centerYAnchor).isActive = true
        dropIconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        dropIconImageView.widthAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    private func setupConstraintsPrecipitationTitleLabel() {
        precipitationTitleLabel.leftAnchor.constraint(equalTo: dropIconImageView.rightAnchor, constant: 19).isActive = true
        precipitationTitleLabel.topAnchor.constraint(equalTo: mainInfoView.topAnchor, constant: 30).isActive = true
    }
    
    private func setupConstraintsPrecipitationValueLabel() {
        precipitationValueLabel.topAnchor.constraint(equalTo: precipitationTitleLabel.bottomAnchor, constant: 7).isActive = true
        precipitationValueLabel.leftAnchor.constraint(equalTo: precipitationTitleLabel.leftAnchor).isActive = true
    }
    
    private func setupConstraintsHourlyBackgroundView() {
        hourlyBackgroundView.topAnchor.constraint(equalTo: mainInfoView.bottomAnchor, constant: 35).isActive = true
        hourlyBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        hourlyBackgroundView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        hourlyBackgroundView.heightAnchor.constraint(equalToConstant: 288).isActive = true
    }
    
    private func setupConstraintsHourlyInfoTitleLabel() {
        hourlyInfoTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22).isActive = true
        hourlyInfoTitleLabel.bottomAnchor.constraint(equalTo: hourlyBackgroundView.topAnchor, constant: -9).isActive = true
    }
    
    private func setupConstraintsHourlyInfoScrollView() {
        hourlyInfoScrollView.topAnchor.constraint(equalTo: mainInfoView.bottomAnchor, constant: 35 + 38).isActive = true
        hourlyInfoScrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 41).isActive = true
        hourlyInfoScrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -41).isActive = true
        hourlyInfoScrollView.bottomAnchor.constraint(equalTo: hourlyContentView.bottomAnchor).isActive = true
        hourlyInfoScrollView.heightAnchor.constraint(equalTo: hourlyContentView.heightAnchor).isActive = true
    }
    
    private func setupConstraintsHourlyContentView() {
        hourlyContentView.topAnchor.constraint(equalTo: hourlyInfoScrollView.topAnchor).isActive = true
        hourlyContentView.leftAnchor.constraint(equalTo: hourlyInfoScrollView.leftAnchor).isActive = true
        hourlyContentView.rightAnchor.constraint(equalTo: hourlyInfoScrollView.rightAnchor).isActive = true
        hourlyContentView.heightAnchor.constraint(equalToConstant: 288 - 84 - 38).isActive = true
    }
    
    private func setupConstraintsHourlyArrowIconRightImageView() {
        hourlyArrowIconRightImageView.topAnchor.constraint(equalTo: hourlyBackgroundView.topAnchor, constant: 112).isActive = true
        hourlyArrowIconRightImageView.rightAnchor.constraint(equalTo: hourlyBackgroundView.rightAnchor, constant: -17).isActive = true
        hourlyArrowIconRightImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        hourlyArrowIconRightImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func setupConstraintsHourlyArrowIconleftImageView() {
        hourlyArrowIconLeftImageView.topAnchor.constraint(equalTo: hourlyBackgroundView.topAnchor, constant: 112).isActive = true
        hourlyArrowIconLeftImageView.leftAnchor.constraint(equalTo: hourlyBackgroundView.leftAnchor, constant: 17).isActive = true
        hourlyArrowIconLeftImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        hourlyArrowIconLeftImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func setupConstraintsHourlyButtonView() {
        hourlyButtonView.bottomAnchor.constraint(equalTo: hourlyBackgroundView.bottomAnchor, constant: -34).isActive = true
        hourlyButtonView.centerXAnchor.constraint(equalTo: hourlyBackgroundView.centerXAnchor).isActive = true
        hourlyButtonView.widthAnchor.constraint(equalToConstant: 165).isActive = true
        hourlyButtonView.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    private func setupConstraintsHourlyButtonLabel() {
        hourlyButtonLabel.centerXAnchor.constraint(equalTo: hourlyButtonView.centerXAnchor).isActive = true
        hourlyButtonLabel.centerYAnchor.constraint(equalTo: hourlyButtonView.centerYAnchor).isActive = true
    }
    
    private func setupConstraintsHourlyButton() {
        hourlyButton.leftAnchor.constraint(equalTo: hourlyButtonView.leftAnchor).isActive = true
        hourlyButton.rightAnchor.constraint(equalTo: hourlyButtonView.rightAnchor).isActive = true
        hourlyButton.topAnchor.constraint(equalTo: hourlyButtonView.topAnchor).isActive = true
        hourlyButton.bottomAnchor.constraint(equalTo: hourlyButtonView.bottomAnchor).isActive = true
    }
    
    private func setupConstraintsHourlyTimeStackView() {
        hourlyTimeStackView.topAnchor.constraint(equalTo: hourlyContentView.topAnchor).isActive = true
        hourlyTimeStackView.leftAnchor.constraint(equalTo: hourlyContentView.leftAnchor).isActive = true
        hourlyTimeStackView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        hourlyTimeStackView.rightAnchor.constraint(equalTo: hourlyContentView.rightAnchor).isActive = true
        hourlyTimeStackView.widthAnchor.constraint(equalToConstant: 571).isActive = true
    }
    
    private func setupConstraintsHourlyPillarStackView() {
        hourlyPillarStackView.leftAnchor.constraint(equalTo: hourlyTimeStackView.leftAnchor).isActive = true
        hourlyPillarStackView.rightAnchor.constraint(equalTo: hourlyTimeStackView.rightAnchor).isActive = true
        hourlyPillarStackView.bottomAnchor.constraint(equalTo: hourlyContentView.bottomAnchor).isActive = true
        hourlyPillarStackView.heightAnchor.constraint(equalToConstant: 43).isActive = true
    }
    
    private func setupConstraintsDailyInfoView() {
        dailyInfoView.topAnchor.constraint(equalTo: hourlyBackgroundView.bottomAnchor, constant: 35).isActive = true
        dailyInfoView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        dailyInfoView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        dailyInfoView.heightAnchor.constraint(equalToConstant: 288).isActive = true
        
        dailyInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35).isActive = true
    }
    
}

// MARK: - UIScrollViewDelegate

extension PageScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screenSize = UIScreen.main.bounds
        let percentage = scrollView.contentOffset.y / (scrollView.contentSize.height * 896.0 / screenSize.height )
        
        // "animation" hide view
        if percentage >= 0 && percentage <= 0.1 {
            dateTimeLabel.alpha = 1 - 10 * percentage
        } else if percentage > 0.1 {
            dateTimeLabel.alpha = 0
        }
        
        // hide arrows
        let percentageHorizontal = scrollView.contentOffset.x / (scrollView.contentSize.width * 414.0 / screenSize.width)
        
        if (percentageHorizontal > 0.06) {
            hourlyArrowIconLeftImageView.isHidden = false
                
            if percentageHorizontal > 0.39 {
                hourlyArrowIconRightImageView.isHidden = true
            } else {
                hourlyArrowIconRightImageView.isHidden = false
            }
        } else {
            hourlyArrowIconLeftImageView.isHidden = true
        }
    }
}
