//
//  DailyView.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 03.09.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import UIKit

class DailyView: UIView {
    
    // MARK: - properties
    
    private let dailyInfoTitleLabel: UILabel = {
        let dailyInfoTitleLabel = UILabel()
        
        dailyInfoTitleLabel.text = "Daily"
        dailyInfoTitleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        dailyInfoTitleLabel.textColor = UIColor(red: 211.0 / 255.0, green: 230.0 / 255.0, blue: 239.0 / 255.0, alpha: 1)
        dailyInfoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dailyInfoTitleLabel
    }()
    
    private let dailyInfoScrollView: UIScrollView = {
        let dailyInfoScrollView = UIScrollView()
        
        dailyInfoScrollView.showsHorizontalScrollIndicator = false
        dailyInfoScrollView.showsVerticalScrollIndicator = false
        dailyInfoScrollView.backgroundColor = .none
        dailyInfoScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return dailyInfoScrollView
    }()
    
    private let dailyContentView: UIView = {
        let dailyInfoView = UIView()
        
        dailyInfoView.backgroundColor = .none
        dailyInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        return dailyInfoView
    }()
    
    private let dailyWeekdaysStackView: UIStackView = {
        let dailyWeekdaysStackView = UIStackView()
        
        dailyWeekdaysStackView.axis = .horizontal
        dailyWeekdaysStackView.distribution = .fillEqually
        dailyWeekdaysStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return dailyWeekdaysStackView
    }()
    
    private let dailyButtonView: UIView = {
        let dailyButtonView = UIView()
        
        dailyButtonView.layer.cornerRadius = 17
        dailyButtonView.backgroundColor = UIColor(red: 162.0 / 255.0, green: 202.0 / 255.0, blue: 227.0 / 255.0, alpha: 0.4)
        dailyButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        return dailyButtonView
    }()
    
    private let dailyButtonLabel: UILabel = {
        let dailyButtonLabel = UILabel()
        
        dailyButtonLabel.textColor = UIColor(red: 230.0 / 255.0, green: 246.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)
        dailyButtonLabel.text = "15 days"
        dailyButtonLabel.font = .systemFont(ofSize: 13, weight: .medium)
        dailyButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dailyButtonLabel
    }()
    
    private let dailyButton: UIButton = {
        let dailyButton = UIButton()
        
        dailyButton.backgroundColor = .none
        dailyButton.layer.cornerRadius = 17
        dailyButton.translatesAutoresizingMaskIntoConstraints = false
        
        return dailyButton
    }()
    
    private let dailyPillarStackView: UIStackView = {
        let dailyPillarStackView = UIStackView()
        
        dailyPillarStackView.distribution = .fillEqually
        dailyPillarStackView.axis = .horizontal
        dailyPillarStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return dailyPillarStackView
    }()
    
    private let dailyArrowIconRightImageView: UIImageView = {
        let hourlyArrowIconRightImageView = UIImageView()
        
        hourlyArrowIconRightImageView.image = UIImage(named: "ArrowIconRight")
        hourlyArrowIconRightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return hourlyArrowIconRightImageView
    }()
    
    private let dailyArrowIconLeftImageView: UIImageView = {
        let hourlyArrowIconLeftImageView = UIImageView()
           
        hourlyArrowIconLeftImageView.image = UIImage(named: "ArrowIconLeft")
        hourlyArrowIconLeftImageView.isHidden = true
        hourlyArrowIconLeftImageView.translatesAutoresizingMaskIntoConstraints = false
           
        return hourlyArrowIconLeftImageView
    }()
    
    private var dailyPillarBottomImageViewArray = Array<UIImageView>()
    private var dailyPillarTopImageViewArray = Array<UIImageView>()
    
    // MARK: - configure func
    
    func configure() {
        self.backgroundColor = UIColor(red: 146.0 / 255.0, green: 192.0 / 255.0, blue: 225.0 / 255.0, alpha: 0.4)
        self.layer.cornerRadius = 23
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dailyInfoScrollView.delegate = self
        
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - addSubviews func
    
    private func addSubviews() {
        addSubview(dailyInfoTitleLabel)
        addSubview(dailyButtonView)
        addSubview(dailyArrowIconRightImageView)
        addSubview(dailyArrowIconLeftImageView)
        dailyButtonView.addSubview(dailyButtonLabel)
        dailyButtonView.addSubview(dailyButton)
        addSubview(dailyInfoScrollView)
        dailyInfoScrollView.addSubview(dailyContentView)
        dailyContentView.addSubview(dailyWeekdaysStackView)
        dailyContentView.addSubview(dailyPillarStackView)
    }
    
    // MARK: - set funcs
    
    func setupData(resultOneCall: OneCallApiModel) {
        setDailyTimeValue(dailyList: (resultOneCall.daily)!,  timezoneOffset: (resultOneCall.timezone_offset)!)
        setDailyPillar(dailyList: (resultOneCall.daily)!, maxSize: 56)
        setDailyTemperature(dailyList: (resultOneCall.daily)!)
    }
    
    func setDailyTimeValue(dailyList: [DailyModel], timezoneOffset: Int) {
        var listWeekdays = [String]()
        
        listWeekdays = getDailyList(dailyList: dailyList, timezoneOffset: timezoneOffset)
        
        for i in 0..<listWeekdays.count {
            let weekdayLabel = UILabel()
            
            weekdayLabel.text = listWeekdays[i]
            weekdayLabel.textColor = .white
            weekdayLabel.textAlignment = .center
            weekdayLabel.font = .systemFont(ofSize: 15, weight: .regular)
            dailyWeekdaysStackView.addArrangedSubview(weekdayLabel)
        }
    }
    
    func setDailyPillar(dailyList: [DailyModel], maxSize: Float) {
        var pillarParametersList: [(Float, Float)] // // first - offset bottom, second - height pillar
        
        pillarParametersList = getSizePillarDaily(dailyList: dailyList, maxSize: maxSize)
        
        for i in 0..<pillarParametersList.count {
            let pillarView = UIView()
            let pillarBottomImageView = UIImageView()
            let pillarBaseImageView = UIImageView()
            let pillarTopImageView = UIImageView()
        
            // bottom icon
        
            pillarView.addSubview(pillarBottomImageView)
        
            pillarBottomImageView.image = UIImage(named: "PillarBottomIcon")
            pillarBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        
            pillarBottomImageView.heightAnchor.constraint(equalToConstant: 3).isActive = true
            pillarBottomImageView.widthAnchor.constraint(equalToConstant: 6).isActive = true
            pillarBottomImageView.centerXAnchor.constraint(equalTo: pillarView.centerXAnchor).isActive = true
            pillarBottomImageView.bottomAnchor.constraint(equalTo: pillarView.bottomAnchor, constant: -CGFloat(pillarParametersList[i].0)).isActive = true
            
            // base icon
            
            pillarView.addSubview(pillarBaseImageView)
            
            pillarBaseImageView.image = UIImage(named: "PillarBaseIcon")
            pillarBaseImageView.translatesAutoresizingMaskIntoConstraints = false
            
            pillarBaseImageView.heightAnchor.constraint(equalToConstant: CGFloat(pillarParametersList[i].1)).isActive = true
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
            
            dailyPillarBottomImageViewArray.append(pillarBottomImageView)
            dailyPillarTopImageViewArray.append(pillarTopImageView)
            dailyPillarStackView.addArrangedSubview(pillarView)
        }
    }
    
    func setDailyTemperature(dailyList: [DailyModel]) {
        var listTemperature: [(String, String)]
           
        listTemperature = getDailyListTemperature(dailyList: dailyList)
           
        for i in 0..<listTemperature.count {
            let temperatureBottomValueLabel = UILabel()
            let temperatureTopValueLabel = UILabel()
            
            // bottom value
            
            temperatureBottomValueLabel.text = listTemperature[i].0
            temperatureBottomValueLabel.textColor = UIColor(red: 236.0 / 255.0, green: 253.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
            temperatureBottomValueLabel.font = .systemFont(ofSize: 15, weight: .medium)
            temperatureBottomValueLabel.translatesAutoresizingMaskIntoConstraints = false
            
            dailyContentView.addSubview(temperatureBottomValueLabel)
            
            temperatureBottomValueLabel.topAnchor.constraint(equalTo: dailyPillarBottomImageViewArray[i].bottomAnchor, constant: 5).isActive = true
            temperatureBottomValueLabel.centerXAnchor.constraint(equalTo: dailyPillarBottomImageViewArray[i].centerXAnchor, constant: 3).isActive = true
            
            // top value
            
            temperatureTopValueLabel.text = listTemperature[i].1
            temperatureTopValueLabel.textColor = UIColor(red: 236.0 / 255.0, green: 253.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
            temperatureTopValueLabel.font = .systemFont(ofSize: 15, weight: .medium)
            temperatureTopValueLabel.translatesAutoresizingMaskIntoConstraints = false
            
            dailyContentView.addSubview(temperatureTopValueLabel)
            
            temperatureTopValueLabel.bottomAnchor.constraint(equalTo: dailyPillarTopImageViewArray[i].topAnchor, constant: -5).isActive = true
            temperatureTopValueLabel.centerXAnchor.constraint(equalTo: dailyPillarTopImageViewArray[i].centerXAnchor, constant: 3).isActive = true
        }
    }
    
    // MARK: - setup constraints
    
    func setupConstraints() {
        setupConstraintsDailyInfoTitleLabel()
        setupConstraintsDailyInfoScrollView()
        setupConstraintsDailyContentView()
        setupConstraintsDailyWeekdaysStackView()
        setupConstraintsDailyButtonView()
        setupConstraintsDailyButtonLabel()
        setupConstraintsDailyButton()
        setupConstraintsDailyPillarStackView()
        setupConstraintsDailyArrowIconRightImageView()
        setupConstraintsDailyArrowIconLeftImageView()
    }
    
    private func setupConstraintsDailyInfoTitleLabel() {
        dailyInfoTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22).isActive = true
        dailyInfoTitleLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -9).isActive = true
    }
    
    private func setupConstraintsDailyInfoScrollView() {
        dailyInfoScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 38).isActive = true
        dailyInfoScrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 41).isActive = true
        dailyInfoScrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -41).isActive = true
        dailyInfoScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -84).isActive = true
    }
    
    private func setupConstraintsDailyContentView() {
        dailyContentView.topAnchor.constraint(equalTo: dailyInfoScrollView.topAnchor).isActive = true
        dailyContentView.leftAnchor.constraint(equalTo: dailyInfoScrollView.leftAnchor).isActive = true
        dailyContentView.rightAnchor.constraint(equalTo: dailyInfoScrollView.rightAnchor).isActive = true
        dailyContentView.bottomAnchor.constraint(equalTo: dailyInfoScrollView.bottomAnchor).isActive = true
        dailyContentView.heightAnchor.constraint(equalTo: dailyInfoScrollView.heightAnchor).isActive = true
    }
    
    private func setupConstraintsDailyWeekdaysStackView() {
        dailyWeekdaysStackView.leftAnchor.constraint(equalTo: dailyContentView.leftAnchor).isActive = true
        dailyWeekdaysStackView.topAnchor.constraint(equalTo: dailyContentView.topAnchor).isActive = true
        dailyWeekdaysStackView.rightAnchor.constraint(equalTo: dailyContentView.rightAnchor).isActive = true
        dailyWeekdaysStackView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        dailyWeekdaysStackView.widthAnchor.constraint(equalToConstant: 502).isActive = true
    }
    
    private func setupConstraintsDailyButtonView() {
        dailyButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -34).isActive = true
        dailyButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dailyButtonView.widthAnchor.constraint(equalToConstant: 165).isActive = true
        dailyButtonView.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
       
    private func setupConstraintsDailyButtonLabel() {
        dailyButtonLabel.centerXAnchor.constraint(equalTo: dailyButtonView.centerXAnchor).isActive = true
        dailyButtonLabel.centerYAnchor.constraint(equalTo: dailyButtonView.centerYAnchor).isActive = true
    }
       
    private func setupConstraintsDailyButton() {
        dailyButton.leftAnchor.constraint(equalTo: dailyButtonView.leftAnchor).isActive = true
        dailyButton.rightAnchor.constraint(equalTo: dailyButtonView.rightAnchor).isActive = true
        dailyButton.topAnchor.constraint(equalTo: dailyButtonView.topAnchor).isActive = true
        dailyButton.bottomAnchor.constraint(equalTo: dailyButtonView.bottomAnchor).isActive = true
    }
    
    private func setupConstraintsDailyPillarStackView() {
        dailyPillarStackView.leftAnchor.constraint(equalTo: dailyWeekdaysStackView.leftAnchor).isActive = true
        dailyPillarStackView.rightAnchor.constraint(equalTo: dailyWeekdaysStackView.rightAnchor).isActive = true
        dailyPillarStackView.bottomAnchor.constraint(equalTo: dailyContentView.bottomAnchor, constant: -21).isActive = true
        dailyPillarStackView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    private func setupConstraintsDailyArrowIconRightImageView() {
        dailyArrowIconRightImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 134).isActive = true
        dailyArrowIconRightImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17).isActive = true
        dailyArrowIconRightImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        dailyArrowIconRightImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func setupConstraintsDailyArrowIconLeftImageView() {
        dailyArrowIconLeftImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 134).isActive = true
        dailyArrowIconLeftImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 17).isActive = true
        dailyArrowIconLeftImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        dailyArrowIconLeftImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
}

// MARK: - UIScrollViewDelegate

extension DailyView: UIScrollViewDelegate {
    
    // hide arrows
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screenSize = UIScreen.main.bounds
        let percentageHorizontal = scrollView.contentOffset.x / (scrollView.contentSize.width * 414.0 / screenSize.width)
        
        if (percentageHorizontal > 0.06) {
            dailyArrowIconLeftImageView.isHidden = false
                
            if percentageHorizontal > 0.29 {
                dailyArrowIconRightImageView.isHidden = true
            } else {
                dailyArrowIconRightImageView.isHidden = false
            }
        } else {
            dailyArrowIconLeftImageView.isHidden = true
        }
    }
}
