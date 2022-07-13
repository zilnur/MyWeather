import Foundation

protocol MainModulePresenterInput {
    func qwe()
}

protocol MainModulePresenterOutput {
    var cityName: String { get }
    func buildCurrentForecastData(cell: CurrentWeatherTableViewCell, indexPath: IndexPath)
    func buildDailyForecastsData() -> Int
    func buildDailyForecastsData(cell: DailyCollectionViewCell, indexPath: IndexPath)
    func buildHourlyForecastsData() -> Int
    func buildHourlyForecastsData(cell: HourlyCollectionViewCell, indexPath: IndexPath)
    func toHourController() -> HourForecastViewController
    func getDailies() -> [DailyForecast]
    func toDailyController(indexPath: IndexPath) -> DailyForecastViewController
    func setSelectedItemInCollectionView() -> IndexPath
    func updateForecast()
}

class MainModulePresenter: MainModulePresenterOutput {
    
    var city: City
    
    var cityName: String
    
    var view: MainModulePresenterInput?
    
    init(city: City) {
        self.city = city
        self.cityName = city.name ?? ""
    }
    
    func buildCurrentForecastData(cell: CurrentWeatherTableViewCell, indexPath: IndexPath) {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let daily = city.daily?.sortedArray(using: [descriptor]) as! [DailyForecast]
        cell.dayNightTempLabel.text = "\(Int(daily[indexPath.item].temp!.min))°/\(Int(daily[indexPath.item].temp!.max))°"
        cell.currentTemp.text = "\(Int(city.currentWeather!.temp))°"
        cell.descriptionLabel.text = city.currentWeather!.weatherDescription!.withFirstUppercase()
        cell.view.humidityValueLabel.text = "\(Int(city.currentWeather!.humidity))%"
        cell.view.windValueLabel.text = "\(Int(city.currentWeather!.windSpeed))м/с"
        cell.view.cloudsValueLabel.text = "\(String(describing: city.currentWeather!.clouds))"
        cell.dateLabel.text = city.currentWeather!.dt.toDate()
        cell.sunriseValueLabel.text = city.currentWeather!.sunrise.toTime()
        cell.sunsetValueLabel.text = city.currentWeather!.sunset.toTime()
    }
    
    func buildDailyForecastsData() -> Int{
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let daily = city.daily?.sortedArray(using: [descriptor]) as! [DailyForecast]
        return daily.count
    }
    
    func buildDailyForecastsData(cell: DailyCollectionViewCell, indexPath: IndexPath) {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let daily = city.daily?.sortedArray(using: [descriptor]) as! [DailyForecast]
        cell.dateLabel.text = daily[indexPath.item].dt.toShotDate()
        cell.label.text = "\(String(describing: daily[indexPath.item].humidity))%"
        cell.descreiptionLabel.text = daily[indexPath.item].weatherDescription?.withFirstUppercase()
        cell.minMaxTempLabel.text = "\(Int(daily[indexPath.item].temp!.min))°/\(Int(daily[indexPath.item].temp!.max))°"
    }
    
    func buildHourlyForecastsData() -> Int {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let hourly = city.hour?.sortedArray(using: [descriptor]) as! [HourForecast]
        return hourly.count
    }
    
    func buildHourlyForecastsData(cell: HourlyCollectionViewCell, indexPath: IndexPath) {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let hourly = city.hour?.sortedArray(using: [descriptor]) as! [HourForecast]
        var hourlyFiltered = [HourForecast]()
        for i in 0..<24 {
            hourlyFiltered.append(hourly[i])
        }
        cell.timeLabel.text = hourlyFiltered[indexPath.item].dt.toTime()
        cell.tempLabel.text = "\(Int(hourlyFiltered[indexPath.item].temp))°"
    }
    
    func toHourController() -> HourForecastViewController {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let hourly = city.hour?.sortedArray(using: [descriptor]) as! [HourForecast]
        var horlyFiltered = [HourForecast]()
        for i in 0..<24 {
            horlyFiltered.append(hourly[i])
        }
        let qwe = horlyFiltered[0].dt % 10800
        horlyFiltered = horlyFiltered.filter({$0.dt % 10800 == qwe})
        let hourForecastsModel = HourlyForecastModel(name: city.name!, forecasts: horlyFiltered)
        let hourlyPresenter = HourlyForecastPresenter(model: hourForecastsModel)
        let hourVC = HourForecastViewController(presenter: hourlyPresenter)
        return hourVC
    }
    
    func getDailies() -> [DailyForecast] {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let hourly = city.daily?.sortedArray(using: [descriptor]) as! [DailyForecast]
        return hourly
    }
    
    func toDailyController(indexPath: IndexPath) -> DailyForecastViewController {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let daily = city.daily?.sortedArray(using: [descriptor]) as! [DailyForecast]
        let dailyForecastModel = DailyForecastModel(cityName: city.name!, forecasts: daily)
        let dailyPresenter = DailyPresenter(model: dailyForecastModel, selectedIndexPath: indexPath)
        let dailyForecastView = DailyForecastViewController(presenter: dailyPresenter)
        return dailyForecastView
    }
    
    func setSelectedItemInCollectionView() -> IndexPath {
        let date: Int32 = {
            let date = Date()
            let interval = date.timeIntervalSince1970
            let myInt = Int32(interval)
            return myInt
        }()
        
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let hourly = city.hour?.sortedArray(using: [descriptor]) as! [HourForecast]
        var hourlyFiltered = [HourForecast]()
        for i in 0..<24 {
            hourlyFiltered.append(hourly[i])
        }
        
        let index = hourlyFiltered.firstIndex { forecast in
            guard forecast.dt <= date && forecast.dt % date < 3600 else { return false }
            return true
        } ?? 0
        
        let indexPath = IndexPath(item: index , section: 0)
        return indexPath
    }
    
    func updateForecast() {
        DatabaseService.shared.updateCity(cityName: cityName.convert()) { [weak self] city in
            guard let self = self else { return }
            self.city = city
            self.view?.qwe()
        }
    }
}
