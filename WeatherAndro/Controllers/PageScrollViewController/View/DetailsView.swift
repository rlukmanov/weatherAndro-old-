//
//  DetailsView.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 03.09.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    
    // MARK: - properties
    
    private let detailsTitleLabel: UILabel = {
        let detailsTitleLabel = UILabel()
        
        detailsTitleLabel.text = "" // Details
        detailsTitleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        detailsTitleLabel.textColor = UIColor(red: 211.0 / 255.0, green: 230.0 / 255.0, blue: 239.0 / 255.0, alpha: 1)
        detailsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return detailsTitleLabel
    }()
    
    private let detailsSeparatorImageView: UIImageView = {
        let detailsSeparatorImageView = UIImageView()
        
        detailsSeparatorImageView.image = UIImage(named: "DetailsSeparator")
        detailsSeparatorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return detailsSeparatorImageView
    }()
    
    private let detailsSunsetTitleLabel: UILabel = {
        let detailsSunsetTitleLabel = UILabel()
        
        detailsSunsetTitleLabel.text = "" // Sunset
        detailsSunsetTitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        detailsSunsetTitleLabel.textColor = .white
        detailsSunsetTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return detailsSunsetTitleLabel
    }()
    
    private let detailsSunriseTitleLabel: UILabel = {
        let detailsSunriseTitleLabel = UILabel()
        
        detailsSunriseTitleLabel.text = "" // Sunrise
        detailsSunriseTitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        detailsSunriseTitleLabel.textColor = .white
        detailsSunriseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return detailsSunriseTitleLabel
    }()
    
    private let detailsSunsetTimeLabel: UILabel = {
        let detailsSunsetTimeLabel = UILabel()
        
        detailsSunsetTimeLabel.text = ""
        detailsSunsetTimeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        detailsSunsetTimeLabel.textColor = .white
        detailsSunsetTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return detailsSunsetTimeLabel
    }()
    
    private let detailsSunriseTimeLabel: UILabel = {
        let detailsSunriseTimeLabel = UILabel()
        
        detailsSunriseTimeLabel.text = ""
        detailsSunriseTimeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        detailsSunriseTimeLabel.textColor = .white
        detailsSunriseTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return detailsSunriseTimeLabel
    }()
    
    private let sunriseImageView: UIImageView = {
        let sunriseImageView = UIImageView()
        
        sunriseImageView.image = UIImage(named: "Sunrise")
        sunriseImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return sunriseImageView
    }()
    
    private let sunsetImageView: UIImageView = {
        let sunsetImageView = UIImageView()
        
        sunsetImageView.image = UIImage(named: "Sunrise")
        sunsetImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return sunsetImageView
    }()
    
    // MARK: - configure func
    
    func configure() {
        self.backgroundColor = UIColor(red: 146.0 / 255.0, green: 192.0 / 255.0, blue: 225.0 / 255.0, alpha: 0.4)
        self.layer.cornerRadius = 23
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - addSubviews func
        
    private func addSubviews() {
        addSubview(detailsTitleLabel)
        addSubview(detailsSeparatorImageView)
        addSubview(detailsSunsetTitleLabel)
        addSubview(detailsSunriseTitleLabel)
        addSubview(detailsSunsetTimeLabel)
        addSubview(detailsSunriseTimeLabel)
        addSubview(sunriseImageView)
        addSubview(sunsetImageView)
    }
    
    // MARK: - set funcs
    
    func setupData(resultOneCall: OneCallApiModel) {
        detailsTitleLabel.text = "Details"
        detailsSunsetTitleLabel.text = "Sunset"
        detailsSunriseTitleLabel.text = "Sunrise"
        
        var sunsetSunrise: (String, String)
        
        sunsetSunrise = getSunsetSunriseTime(dailyList: (resultOneCall.daily)!, timeZone: (resultOneCall.timezone_offset)!)
        detailsSunsetTimeLabel.text = sunsetSunrise.0
        detailsSunriseTimeLabel.text = sunsetSunrise.1
    }
    
    // MARK: - setup constraints
    
    private func setupConstraints() {
        setupConstraintsDetailsTitleLabel()
        setupConstraintsDetailsSeparatorImageView()
        setupConstraintsDetailsSunsetTitleLabel()
        setupConstraintsDetailsSunriseTitleLabel()
        setupConstraintsDetailsSunsetTimeLabel()
        setupConstraintsDetailsSunriseTimeLabel()
        setupConstraintsSunriseImageView()
        setupConstraintsSunsetImageView()
    }
    
    private func setupConstraintsDetailsTitleLabel() {
        detailsTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22).isActive = true
        detailsTitleLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -9).isActive = true
    }
    
    private func setupConstraintsDetailsSeparatorImageView() {
        detailsSeparatorImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 63).isActive = true
        detailsSeparatorImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35).isActive = true
        detailsSeparatorImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupConstraintsDetailsSunsetTitleLabel() {
        detailsSunsetTitleLabel.leftAnchor.constraint(equalTo: detailsSeparatorImageView.leftAnchor).isActive = true
        detailsSunsetTitleLabel.bottomAnchor.constraint(equalTo: detailsSeparatorImageView.topAnchor, constant: -28).isActive = true
    }
    
    private func setupConstraintsDetailsSunriseTitleLabel() {
        detailsSunriseTitleLabel.leftAnchor.constraint(equalTo: detailsSeparatorImageView.leftAnchor).isActive = true
        detailsSunriseTitleLabel.topAnchor.constraint(equalTo: detailsSeparatorImageView.topAnchor, constant: 27).isActive = true
    }
    
    private func setupConstraintsDetailsSunsetTimeLabel() {
        detailsSunsetTimeLabel.rightAnchor.constraint(equalTo: detailsSeparatorImageView.rightAnchor).isActive = true
        detailsSunsetTimeLabel.bottomAnchor.constraint(equalTo: detailsSunsetTitleLabel.bottomAnchor).isActive = true
    }
    
    private func setupConstraintsDetailsSunriseTimeLabel() {
        detailsSunriseTimeLabel.rightAnchor.constraint(equalTo: detailsSeparatorImageView.rightAnchor).isActive = true
        detailsSunriseTimeLabel.topAnchor.constraint(equalTo: detailsSunriseTitleLabel.topAnchor).isActive = true
    }
    
    private func setupConstraintsSunriseImageView() {
        sunriseImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 37).isActive = true
        sunriseImageView.centerYAnchor.constraint(equalTo: detailsSunriseTitleLabel.centerYAnchor).isActive = true
        sunriseImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        sunriseImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    private func setupConstraintsSunsetImageView() {
        sunsetImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 37).isActive = true
        sunsetImageView.centerYAnchor.constraint(equalTo: detailsSunsetTitleLabel.centerYAnchor).isActive = true
        sunsetImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        sunsetImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
    }
}
