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
    
    var newData = false
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    private var currentCity: String?
    
    private var currentPage: typePage
    
    weak var delegate: ViewControllerDelegate?
    
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
    
    // MARK: - search button properties
    
    private let searchIconImageView: UIImageView = {
        let searchIconImageView = UIImageView()
        
        searchIconImageView.image = UIImage(named: "lensIconWhite")
        searchIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return searchIconImageView
    }()
    
    private let searchButton: UIButton = {
        let searchButton = UIButton()
        
        searchButton.addTarget(self, action: #selector(addNewCity), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        return searchButton
    }()
    
    // MARK: - settings button properties
    
    private let deleteIconImageView: UIImageView = {
        let settingsIconImageView = UIImageView()
        
        settingsIconImageView.image = UIImage(named: "DeleteIcon")
        settingsIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return settingsIconImageView
    }()
    
    private let deleteButton: UIButton = {
        let deleteButton = UIButton()
        
        deleteButton.addTarget(self, action: #selector(deleteCurrentCity), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        return deleteButton
    }()
    
    // MARK: - name place property
    private let namePlaceLabel: UILabel = {
        let namePlaceLabel = UILabel()
        
        namePlaceLabel.text = ""
        namePlaceLabel.font = .systemFont(ofSize: 16, weight: .medium)
        namePlaceLabel.textColor = UIColor(red: 240.0 / 255.0, green: 239.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)
        namePlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return namePlaceLabel
    }()
    
    // MARK: - date time properties
    
    private let dateTimeLabel: UILabel = {
        let dateTimeLabel = UILabel()
        
        dateTimeLabel.text = ""
        dateTimeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dateTimeLabel.textColor = UIColor(red: 178.0 / 255.0, green: 181.0 / 255.0, blue: 253.0 / 255.0, alpha: 1)
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dateTimeLabel
    }()
    
    // MARK: - temperature value property
    
    private let temperatureValueLabel: UILabel = {
        let temperatureValueLabel = UILabel()
        
        temperatureValueLabel.text = ""
        temperatureValueLabel.font = .systemFont(ofSize: 80, weight: .thin)
        temperatureValueLabel.textColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)
        temperatureValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return temperatureValueLabel
    }()
    
    private let weatherIconImageView: UIImageView = {
        let weatherIconImageView = UIImageView()
        
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return weatherIconImageView
    }()
    
    // MARK: - feels like property
    
    private let feelsLikeLabel: UILabel = {
        let feelsLikeLabel = UILabel()
        
        feelsLikeLabel.text = ""
        feelsLikeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        feelsLikeLabel.textColor = UIColor(red: 210.0 / 255.0, green: 223.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return feelsLikeLabel
    }()
    
    // MARK: - type weather property
    
    private let typeWeatherLabel: UILabel = {
        let typeWeatherLabel = UILabel()
        
        typeWeatherLabel.text = ""
        typeWeatherLabel.font = .systemFont(ofSize: 16, weight: .medium)
        typeWeatherLabel.textColor = UIColor(red: 239.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        typeWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return typeWeatherLabel
    }()
    
    private let mainView = MainView()
    
    private let hourlyView = HourlyView()
    
    private let dailyView = DailyView()
    
    private let detailsView = DetailsView()
    
    private let apiIconImageView: UIImageView = {
        let apiIconImageView = UIImageView()
        
        apiIconImageView.image = UIImage(named: "OpenWeatherIcon-2")
        apiIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return apiIconImageView
    }()
    
    private let apiNameLabel: UILabel = {
        let apiNameLabel = UILabel()
        
        apiNameLabel.text = "OpenWeather Api"
        apiNameLabel.textColor = .white
        apiNameLabel.font = .systemFont(ofSize: 10, weight: .medium)
        apiNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return apiNameLabel
    }()
    
    private let leftIconImageView: UIImageView = {
        let leftIconImageView = UIImageView()
        
        leftIconImageView.image = UIImage(named: "ArrowIconLeft")
        leftIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return leftIconImageView
    }()
    
    private let rightIconImageView: UIImageView = {
        let rightIconImageView = UIImageView()
        
        rightIconImageView.image = UIImage(named: "ArrowIconRight")
        rightIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return rightIconImageView
    }()
    
    // MARK: - Search page
    
    let searchTextField = { () -> UITextField in
        let tempSearch = UITextField()
        
        tempSearch.borderStyle = .roundedRect
        tempSearch.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        tempSearch.attributedPlaceholder = NSAttributedString(string: "Enter the name of the city",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.6)])
        tempSearch.textColor = .white
        tempSearch.keyboardAppearance = .light
        
        tempSearch.translatesAutoresizingMaskIntoConstraints = false
        
        return tempSearch
    }()
    
    // MARK: - Initializer
    
    init(type: typePage, cityInput: String) {
        currentCity = cityInput
        currentPage = type
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        switch currentPage {
        case .otherPage:
            hideAll()
            view.addSubview(searchTextField)
            setupConstraintsForSearchTextField()
            searchTextField.delegate = self
        case .prevCity:
            loadData(city: currentCity ?? "Moscow")
        default:
            break
        }
    }
    
    // MARK: - search
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
            view.endEditing(true)
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    // MARK: - setup data funcs
    
    func setFeelsLikeLabel(resultOneCall: OneCallApiModel) {
        showViews()
        feelsLikeLabel.text = convertDegree(temperature: (resultOneCall.daily?.first?.temp?.max)!, typeResult: .celsius)
        feelsLikeLabel.text! += "\u{00B0}"
        feelsLikeLabel.text! += "/"
        feelsLikeLabel.text! += convertDegree(temperature: (resultOneCall.daily?.first?.temp?.min)!, typeResult: .celsius)
        feelsLikeLabel.text! += "\u{00B0}"
        feelsLikeLabel.text! += " Feels like "
        feelsLikeLabel.text! += convertDegree(temperature: (resultOneCall.current?.feels_like)!, typeResult: .celsius)
        feelsLikeLabel.text! += "\u{00B0}"
    }
    
    func setData(resultFiveDay: OfferModel) {
        showViews()
        namePlaceLabel.text = resultFiveDay.city?.name
        mainView.setupData(resultFiveDay: resultFiveDay)
    }
    
    func setData(resultOneCall: OneCallApiModel) {
        showViews()
        temperatureValueLabel.text = convertDegree(temperature: (resultOneCall.current?.temp)!, typeResult: .celsius) + "\u{00B0}"
        typeWeatherLabel.text = resultOneCall.current?.weather?.first?.main
        dateTimeLabel.text = currentData(timeZone: (resultOneCall.timezone_offset)!)
        weatherIconImageView.image = UIImage(named: (resultOneCall.current?.weather?.first?.icon)!)
        setFeelsLikeLabel(resultOneCall: resultOneCall)
        hourlyView.setupData(resultOneCall: resultOneCall)
        dailyView.setupData(resultOneCall: resultOneCall)
        detailsView.setupData(resultOneCall: resultOneCall)
    }
    
    // MARK: - hide all
    
    private func hideAll() {
        mainView.isHidden = true
        hourlyView.isHidden = true
        dailyView.isHidden = true
        detailsView.isHidden = true
        rightIconImageView.isHidden = true
        leftIconImageView.isHidden = true
        searchButton.isEnabled = false
        searchIconImageView.isHidden = true
    }
    
    // MARK: show all hidden
    
    private func showViews() {
        switch currentPage {
        case .otherPage:
            self.searchTextField.isEnabled = false
            self.searchTextField.isHidden = true
            self.view.endEditing(true)
            mainView.isHidden = false
            hourlyView.isHidden = false
            dailyView.isHidden = false
            detailsView.isHidden = false
            leftIconImageView.isHidden = false
            searchButton.isEnabled = true
            searchIconImageView.isHidden = false
        default:
            break
        }
    }
    
    // MARK: - add subviews func

    private func addSubviews() {
        view.addSubview(searchIconImageView)
        view.addSubview(searchButton)
        view.addSubview(deleteIconImageView)
        view.addSubview(deleteButton)
        view.addSubview(namePlaceLabel)
        view.addSubview(dateTimeLabel)
        view.addSubview(pageScrollView)
        
        pageScrollView.addSubview(contentView)
        
        contentView.addSubview(temperatureValueLabel)
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(leftIconImageView)
        contentView.addSubview(rightIconImageView)
        contentView.addSubview(feelsLikeLabel)
        contentView.addSubview(typeWeatherLabel)
        
        contentView.addSubview(mainView)
        contentView.addSubview(hourlyView)
        contentView.addSubview(dailyView)
        contentView.addSubview(detailsView)
        
        contentView.addSubview(apiIconImageView)
        contentView.addSubview(apiNameLabel)
    }
    
    // MARK: - setup constraints funcs

    private func setupConstraints() {
        setupConstraintsSearchIconImageView()
        setupConstraintsSearchButton()
        setupConstraintsSettingsIconImageView()
        setupConstraintsDeleteButton()
        setupConstraintsNamePlaceLabel()
        setupConstraintsDateTimeLabel()
        setupConstraintsPageScrollView()
        
        setupConstraintsContentView()
        
        setupConstraintsTemperatureValueLabel()
        setupConstraintsWeatherIconImageView()
        setupConstraintsLeftIconImageView()
        setupConstraintsRightIconImageView()
        setupConstraintsFeelsLikeLabel()
        setupConstraintsTypeWeatherLabel()
        
        setupConstraintsMainView()
        setupConstraintsHourlyView()
        setupConstraintsDailyView()
        setupConstraintsDetailsView()
        
        setupConstraintsApiIconImageView()
        setupConstraintsApiNameLabel()
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
    
    private func setupConstraintsSearchIconImageView() {
        searchIconImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -57).isActive = true
        searchIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39).isActive = true
        searchIconImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        searchIconImageView.widthAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    private func setupConstraintsSearchButton() {
        searchButton.centerXAnchor.constraint(equalTo: searchIconImageView.centerXAnchor).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: searchIconImageView.centerYAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupConstraintsSettingsIconImageView() {
        deleteIconImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22).isActive = true
        deleteIconImageView.topAnchor.constraint(equalTo: searchIconImageView.topAnchor).isActive = true
        deleteIconImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        deleteIconImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupConstraintsDeleteButton() {
        deleteButton.centerXAnchor.constraint(equalTo: deleteIconImageView.centerXAnchor).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: deleteIconImageView.centerYAnchor).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupConstraintsTemperatureValueLabel() {
        temperatureValueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13).isActive = true
        temperatureValueLabel.leftAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -16).isActive = true
    }
    
    private func setupConstraintsWeatherIconImageView() {
        weatherIconImageView.rightAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -27).isActive = true
        weatherIconImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        weatherIconImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        weatherIconImageView.bottomAnchor.constraint(equalTo: mainView.topAnchor, constant: -145).isActive = true
    }
    
    private func setupConstraintsLeftIconImageView() {
        leftIconImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        leftIconImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        leftIconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 19).isActive = true
        leftIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 58).isActive = true
    }
    
    private func setupConstraintsRightIconImageView() {
        rightIconImageView.widthAnchor.constraint(equalTo: leftIconImageView.widthAnchor).isActive = true
        rightIconImageView.heightAnchor.constraint(equalTo: leftIconImageView.heightAnchor).isActive = true
        rightIconImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -19).isActive = true
        rightIconImageView.topAnchor.constraint(equalTo: leftIconImageView.topAnchor).isActive = true
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
    
    private func setupConstraintsApiIconImageView() {
        apiIconImageView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        apiIconImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        apiIconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 37).isActive = true
        apiIconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    private func setupConstraintsApiNameLabel() {
        apiNameLabel.leftAnchor.constraint(equalTo: apiIconImageView.rightAnchor, constant: 6).isActive = true
        apiNameLabel.centerYAnchor.constraint(equalTo: apiIconImageView.centerYAnchor).isActive = true
    }
    
    fileprivate func setupConstraintsForSearchTextField() {
        searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
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

// MARK: - UpScrollProtocol

extension PageScrollViewController: UpScrollProtocol {
    func setContentOffset() {
        pageScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        hourlyView.setContentOffset()
        dailyView.setContentOffset()
    }
}

// MARK: - HideArrowProtocol

extension PageScrollViewController: HideShowArrowProtocol {
    func hideRightIcon() {
        rightIconImageView.isHidden = true
    }
    
    func showRightIcon() {
        rightIconImageView.isHidden = false
    }
    
    func hideLeftIcon() {
        leftIconImageView.isHidden = true
    }
    
    func showLeftIcon() {
        leftIconImageView.isHidden = false
    }
}

// MARK: - UITextFieldDelegate
extension PageScrollViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let city = searchTextField.text, city != "" else {
            return false
        }
        
        newData = true
        loadData(city: city)
        
        return true
    }
}

// MARK: - ActionCityProtocol

extension PageScrollViewController: ActionCityProtocol {
    @objc func addNewCity() {
        delegate?.addNewCity()
    }
    
    @objc func deleteCurrentCity() {
        delegate?.deleteCurrentCity()
    }
}
