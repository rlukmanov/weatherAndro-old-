//
//  MainView.swift
//  WeatherAndro
//
//  Created by Ruslan Lukmanov on 03.09.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import UIKit

class MainView: UIView {

    // MARK: - properties
    
    private let dropIconImageView: UIImageView = {
        let dropIconImageView = UIImageView()
        
        dropIconImageView.image = UIImage(named: "DropWaterIcon")
        dropIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return dropIconImageView
    }()
    
    private let precipitationTitleLabel: UILabel = {
        let precipitationTitleLabel = UILabel()
        
        precipitationTitleLabel.text = "" // Precipitation
        precipitationTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        precipitationTitleLabel.textColor = UIColor(red: 233.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        precipitationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return precipitationTitleLabel
    }()
    
    private let precipitationValueLabel: UILabel = {
        let precipitationValueLabel = UILabel()
        
        precipitationValueLabel.text = ""
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
    
    private let uvIndexImageView: UIImageView = {
        let uvIndexImageView = UIImageView()
        
        uvIndexImageView.image = UIImage(named: "UVIndexIcon")
        uvIndexImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return uvIndexImageView
    }()
    
    private let pressionTitleLabel: UILabel = {
        let pressionTitleLabel = UILabel()
        
        pressionTitleLabel.text = "" // Atmo pressure
        pressionTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        pressionTitleLabel.textColor = UIColor(red: 233.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        pressionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return pressionTitleLabel
    }()
    
    private let pressionValueLabel: UILabel = {
        let pressionValueLabel = UILabel()
        
        pressionValueLabel.text = ""
        pressionValueLabel.font = .systemFont(ofSize: 14, weight: .medium)
        pressionValueLabel.textColor = UIColor(red: 233.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        pressionValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return pressionValueLabel
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
        addSubview(lineInfoSeparator)
        addSubview(dropIconImageView)
        addSubview(precipitationTitleLabel)
        addSubview(precipitationValueLabel)
        addSubview(uvIndexImageView)
        addSubview(pressionTitleLabel)
        addSubview(pressionValueLabel)
    }
    
    // MARK: - set func
    
    func setupData(resultFiveDay: OfferModel) {
        precipitationTitleLabel.text = "Precipitation"
        pressionTitleLabel.text = "Atmo pressure"
        precipitationValueLabel.text = precipitationConvert(value: (resultFiveDay.list?.first?.pop)!) + "%"
        pressionValueLabel.text = String((resultFiveDay.list?.first?.main?.pressure)!) + " hPA"
    }
    
    // MARK: - setup constraints

    private func setupConstraints() {
        setupConstraintsLineInfoSeparator()
        setupConstraintsDropIconImageView()
        setupConstraintsPrecipitationTitleLabel()
        setupConstraintsPrecipitationValueLabel()
        setupConstraintsUvIndexImageView()
        setupConstraintsPressionTitleLabel()
        setupConstraintsPressionValueLabel()
    }
    
    private func setupConstraintsLineInfoSeparator() {
        lineInfoSeparator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lineInfoSeparator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lineInfoSeparator.heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
    
    private func setupConstraintsDropIconImageView() {
        dropIconImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 41).isActive = true
        dropIconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dropIconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        dropIconImageView.widthAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    private func setupConstraintsPrecipitationTitleLabel() {
        precipitationTitleLabel.leftAnchor.constraint(equalTo: dropIconImageView.rightAnchor, constant: 19).isActive = true
        precipitationTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
    }
    
    private func setupConstraintsPrecipitationValueLabel() {
        precipitationValueLabel.topAnchor.constraint(equalTo: precipitationTitleLabel.bottomAnchor, constant: 7).isActive = true
        precipitationValueLabel.leftAnchor.constraint(equalTo: precipitationTitleLabel.leftAnchor).isActive = true
    }
    
    private func setupConstraintsUvIndexImageView() {
        uvIndexImageView.leftAnchor.constraint(equalTo: lineInfoSeparator.rightAnchor, constant: 19).isActive = true
        uvIndexImageView.centerYAnchor.constraint(equalTo: dropIconImageView.centerYAnchor).isActive = true
        uvIndexImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        uvIndexImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setupConstraintsPressionTitleLabel() {
        pressionTitleLabel.leftAnchor.constraint(equalTo: uvIndexImageView.rightAnchor, constant: 19).isActive = true
        pressionTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
    }
    
    private func setupConstraintsPressionValueLabel() {
        pressionValueLabel.topAnchor.constraint(equalTo: pressionTitleLabel.bottomAnchor, constant: 7).isActive = true
        pressionValueLabel.leftAnchor.constraint(equalTo: pressionTitleLabel.leftAnchor).isActive = true
    }
}
