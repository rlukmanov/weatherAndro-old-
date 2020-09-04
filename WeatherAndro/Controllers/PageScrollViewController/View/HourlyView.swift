//
//  hourlyView.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 03.09.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import UIKit

class HourlyView: UIView {
    
    // MARK: - properties
    
    private let hourlyInfoScrollView: UIScrollView = {
        let hourlyInfoScrollView = UIScrollView()
        
        hourlyInfoScrollView.showsHorizontalScrollIndicator = false
        hourlyInfoScrollView.showsVerticalScrollIndicator = false
        hourlyInfoScrollView.backgroundColor = .none
        hourlyInfoScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyInfoScrollView
    }()
    
    private let hourlyContentView: UIView = {
        let mainInfoView = UIView()
        
        mainInfoView.backgroundColor = .none
        mainInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        return mainInfoView
    }()
    
    private let hourlyInfoTitleLabel: UILabel = {
        let hourlyInfoTitleLabel = UILabel()
        
        hourlyInfoTitleLabel.text = "" // Hourly
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
        
        hourlyButtonView.layer.cornerRadius = 17
        hourlyButtonView.backgroundColor = UIColor(red: 162.0 / 255.0, green: 202.0 / 255.0, blue: 227.0 / 255.0, alpha: 0.4)
        hourlyButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyButtonView
    }()
    
    private let hourlyButtonLabel: UILabel = {
        let hourlyButtonLabel = UILabel()
        
        hourlyButtonLabel.textColor = UIColor(red: 230.0 / 255.0, green: 246.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)
        hourlyButtonLabel.text = "" // 48 hours
        hourlyButtonLabel.font = .systemFont(ofSize: 13, weight: .medium)
        hourlyButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyButtonLabel
    }()
    
    private let hourlyButton: UIButton = {
        let hourlyButton = UIButton()
        
        hourlyButton.backgroundColor = .none
        hourlyButton.layer.cornerRadius = 17
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
    
    // MARK: - configure func
    
    func configure() {
        self.backgroundColor = UIColor(red: 146.0 / 255.0, green: 192.0 / 255.0, blue: 225.0 / 255.0, alpha: 0.4)
        self.layer.cornerRadius = 23
        self.translatesAutoresizingMaskIntoConstraints = false
        self.hourlyInfoScrollView.delegate = self
        
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - addSubviews func
    
    private func addSubviews() {
        addSubview(hourlyArrowIconRightImageView)
        addSubview(hourlyArrowIconLeftImageView)
        addSubview(hourlyButtonView)
        hourlyButtonView.addSubview(hourlyButtonLabel)
        hourlyButtonView.addSubview(hourlyButton)
        addSubview(hourlyInfoScrollView)
        hourlyInfoScrollView.addSubview(hourlyContentView)
        addSubview(hourlyInfoTitleLabel)
        hourlyContentView.addSubview(hourlyTimeStackView)
        hourlyContentView.addSubview(hourlyPillarStackView)
    }
    
    // MARK: - setContentOffset func
    
    func setContentOffset() {
        hourlyInfoScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        hourlyArrowIconRightImageView.isHidden = false
    }
    
    // MARK: - set funcs
    
    func setupData(resultOneCall: OneCallApiModel) {
        hourlyInfoTitleLabel.text = "Hourly"
        hourlyButtonLabel.text = "48 hours"
        setHourlyTimeValue(timeFirst: (resultOneCall.hourly?.first?.dt)!, timezoneOffset: (resultOneCall.timezone_offset)!)
        setHourlyIcons(hourlyList: (resultOneCall.hourly)!)
        setHourlyPercipitation(hourlyList: (resultOneCall.hourly)!)
        setHourlyPillar(hourlyList: (resultOneCall.hourly)!, maxSize: 37)
        setHourlyTemperature(hourlyList: (resultOneCall.hourly)!)
    }
    
    private func setHourlyTimeValue(timeFirst: Float, timezoneOffset: Int) {
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
    
    private func setHourlyIcons(hourlyList: [HourlyModel]) {
        var listIcons: [String]
        
        listIcons = getListHourlyIcons(hourlyList: hourlyList)
        
        for i in 0..<listIcons.count {
            let iconImageView = UIImageView()
            
            iconImageView.image = UIImage(named: listIcons[i])
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            
            hourlyContentView.addSubview(iconImageView)
            
            iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
            iconImageView.centerXAnchor.constraint(equalTo: hourlyTimeValueArray[i].centerXAnchor, constant: -1).isActive = true
            iconImageView.bottomAnchor.constraint(equalTo: hourlyContentView.bottomAnchor, constant: -107).isActive = true
        }
    }
    
    private func setHourlyPercipitation(hourlyList: [HourlyModel]) {
        var listProbabilities: [String]
           
        listProbabilities = getListHourlyPercipitation(hourlyList: hourlyList)
           
        for i in 0..<listProbabilities.count {
            let iconImageView = UIImageView()
            let probabilityLabel = UILabel()
            
            // icon
            
            iconImageView.image = UIImage(named: "DropWaterIcon")
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
               
            hourlyContentView.addSubview(iconImageView)
               
            iconImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
            iconImageView.widthAnchor.constraint(equalToConstant: 7).isActive = true
            iconImageView.leftAnchor.constraint(equalTo: hourlyTimeValueArray[i].centerXAnchor, constant: -15).isActive = true
            iconImageView.bottomAnchor.constraint(equalTo: hourlyContentView.bottomAnchor, constant: -85).isActive = true
            
            // value
            
            probabilityLabel.text = listProbabilities[i]
            probabilityLabel.textColor = .white
            probabilityLabel.font = .systemFont(ofSize: 10, weight: .medium)
            probabilityLabel.translatesAutoresizingMaskIntoConstraints = false
            
            hourlyContentView.addSubview(probabilityLabel)
            
            probabilityLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 4).isActive = true
            probabilityLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        }
    }
    
    private func setHourlyPillar(hourlyList: [HourlyModel], maxSize: Float) {
        var pillarHeightList: [Float]
        
        pillarHeightList = getSizePillarHourly(hourlyList: hourlyList, maxSize: maxSize)
        
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
            
            // top icon
            
            pillarView.addSubview(pillarTopImageView)
            
            pillarTopImageView.image = UIImage(named: "PillarTopIcon")
            pillarTopImageView.translatesAutoresizingMaskIntoConstraints = false
            
            pillarTopImageView.heightAnchor.constraint(equalToConstant: 3).isActive = true
            pillarTopImageView.widthAnchor.constraint(equalToConstant: 6).isActive = true
            pillarTopImageView.centerXAnchor.constraint(equalTo: pillarView.centerXAnchor).isActive = true
            pillarTopImageView.bottomAnchor.constraint(equalTo: pillarBaseImageView.topAnchor).isActive = true
            
            hourlyPillarTopImageViewArray.append(pillarTopImageView)
            hourlyPillarStackView.addArrangedSubview(pillarView)
            hourlyPillarViewArray.append(pillarView)
            hourlyPillarBaseImageViewArray.append(pillarBaseImageView)
        }
    }
    
    private func setHourlyTemperature(hourlyList: [HourlyModel]) {
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
    
    // MARK: - setup constraints
    
    private func setupConstraints() {
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
    }
    
    private func setupConstraintsHourlyInfoTitleLabel() {
        hourlyInfoTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22).isActive = true
        hourlyInfoTitleLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -9).isActive = true
    }
    
    private func setupConstraintsHourlyInfoScrollView() {
        hourlyInfoScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 38).isActive = true
        hourlyInfoScrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 41).isActive = true
        hourlyInfoScrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -41).isActive = true
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
        hourlyArrowIconRightImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 112).isActive = true
        hourlyArrowIconRightImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17).isActive = true
        hourlyArrowIconRightImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        hourlyArrowIconRightImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func setupConstraintsHourlyArrowIconleftImageView() {
        hourlyArrowIconLeftImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 112).isActive = true
        hourlyArrowIconLeftImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 17).isActive = true
        hourlyArrowIconLeftImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        hourlyArrowIconLeftImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func setupConstraintsHourlyButtonView() {
        hourlyButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -34).isActive = true
        hourlyButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
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
        hourlyTimeStackView.rightAnchor.constraint(equalTo: hourlyContentView.rightAnchor).isActive = true
        hourlyTimeStackView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        hourlyTimeStackView.widthAnchor.constraint(equalToConstant: 571).isActive = true
    }
    
    private func setupConstraintsHourlyPillarStackView() {
        hourlyPillarStackView.leftAnchor.constraint(equalTo: hourlyTimeStackView.leftAnchor).isActive = true
        hourlyPillarStackView.rightAnchor.constraint(equalTo: hourlyTimeStackView.rightAnchor).isActive = true
        hourlyPillarStackView.bottomAnchor.constraint(equalTo: hourlyContentView.bottomAnchor).isActive = true
        hourlyPillarStackView.heightAnchor.constraint(equalToConstant: 43).isActive = true
    }
}

// MARK: - UIScrollViewDelegate

extension HourlyView: UIScrollViewDelegate {
    
    // hide arrows
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screenSize = UIScreen.main.bounds
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
