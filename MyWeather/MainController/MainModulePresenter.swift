import Foundation

protocol MainModulePresenterInput {
    
}

protocol MainModulePresenterOutput {
    var cityName: String { get }
    func buildCurrentForecastData() -> CurrentForecastData
    func buildDailyForecastsData() -> [DailyForecastData]
    func buildHourlyForecastsData() -> [HourlyForecastData]
    func toHourController() -> HourForecastViewController
}

class MainModulePresenter: MainModulePresenterOutput {
    
    var city: City
    
    var cityName: String
    
    init(city: City) {
        self.city = city
        self.cityName = city.name ?? ""
    }
    
    func buildCurrentForecastData() -> CurrentForecastData {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let daily = city.daily?.sortedArray(using: [descriptor]) as! [DailyForecast]
        let data = CurrentForecastData(
            minTemp: daily[0].temp!.min,
            maxTemp: daily[0].temp!.max,
            currentTemp: city.currentWeather!.temp,
            description: city.currentWeather!.weatherDescription!,
            humidity: city.currentWeather!.humidity,
            windSpeed: city.currentWeather!.windSpeed,
            clouds: city.currentWeather!.clouds,
            date: city.currentWeather!.dt,
            sunrise: city.currentWeather!.sunrise,
            sunset: city.currentWeather!.sunset)
        return data
    }
    
    func buildDailyForecastsData() -> [DailyForecastData] {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let daily = city.daily?.sortedArray(using: [descriptor]) as! [DailyForecast]
        var dataArray: [DailyForecastData] = []
        for day in daily {
            let data = DailyForecastData(
                date: day.dt,
                humidity: day.humidity,
                description: day.weatherDescription!,
                minTemp: day.temp!.min,
                maxTemp: day.temp!.max)
            dataArray.append(data)
        }
        return dataArray
    }
    
    func buildHourlyForecastsData() -> [HourlyForecastData] {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let hourly = city.hour?.sortedArray(using: [descriptor]) as! [HourForecast]
        var hourlyArray = [HourlyForecastData]()
        for hour in hourly {
            let data = HourlyForecastData(
                date: hour.dt,
                temp: hour.temp)
            hourlyArray.append(data)
        }
        return hourlyArray
    }
    
    func toHourController() -> HourForecastViewController {
        let descriptor = NSSortDescriptor(key: "dt", ascending: true)
        let hourly = city.hour?.sortedArray(using: [descriptor]) as! [HourForecast]
        let hourVC = HourForecastViewController(hourlyForecast: hourly)
        return hourVC
    }
}
