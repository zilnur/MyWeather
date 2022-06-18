import Foundation
import CoreData

class DatabaseService {
    
    static let shared = DatabaseService()
    
    private let container: NSPersistentContainer
    
    private lazy var backgrounContext = container.newBackgroundContext()
    
    init() {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if error != nil {
                fatalError()
            }
        }
        self.container = container
    }
    
    func addCity(cityName: String) {
        NetworkService.shared.addCity(cityName: cityName) { [weak self] city, name in
            guard let self = self else { return }
            self.backgrounContext.perform {
                let newCity = NSEntityDescription.insertNewObject(forEntityName: "City", into: self.backgrounContext) as! City
                let current = NSEntityDescription.insertNewObject(forEntityName: "CurrentWeather", into: self.backgrounContext) as! CurrentWeather
                current.temp = city.current.temp
                current.dt = Int32(city.current.dt)
                current.windSpeed = city.current.windSpeed
                current.windDeg = Int16(city.current.windDeg)
                current.clouds = Int16(city.current.clouds)
                current.humidity = Int16(city.current.humidity)
                current.weatherDescription = city.current.weather[0].discription
                current.sunset = Int32(city.current.sunset)
                current.sunrise = Int32(city.current.sunrise)
                newCity.name = name
                newCity.lon = city.lon
                newCity.lat = city.lat
                newCity.currentWeather = current
//                newCity.currentWeather?.temp = current.temp
//                newCity.currentWeather?.sunset = current.sunset
//                newCity.currentWeather?.sunrise = current.sunrise
//                newCity.currentWeather?.humidity = current.humidity
//                newCity.currentWeather?.dt = current.dt
//                newCity.currentWeather?.clouds = current.clouds
//                newCity.currentWeather?.weatherDescription = current.weatherDescription
//                newCity.currentWeather?.windDeg = current.windDeg
//                newCity.currentWeather?.windSpeed = current.windSpeed
                let dailies = NSMutableSet()
                for i in city.daily {
                        let daily = NSEntityDescription.insertNewObject(forEntityName: "DailyForecast", into: self.backgrounContext) as! DailyForecast
                        let feelLike = NSEntityDescription.insertNewObject(forEntityName: "FeelsLike", into: self.backgrounContext) as! FeelsLike
                        feelLike.night = i.feelsLike.night
                        feelLike.morn = i.feelsLike.morn
                        feelLike.eve = i.feelsLike.eve
                        feelLike.day = i.feelsLike.day
                        
                        let temp = NSEntityDescription.insertNewObject(forEntityName: "Temp", into: self.backgrounContext) as! Temp
                        temp.night = i.temp.night
                        temp.morn = i.temp.morn
                        temp.min = i.temp.min
                        temp.max = i.temp.max
                        temp.eve = i.temp.eve
                        temp.day = i.temp.day
                        
                        daily.windSpeed = i.windSpeed
                        daily.windDeg = Int16(i.windDeg)
                        daily.weatherDescription = i.weather[0].discription
                        daily.clouds = Int16(i.clouds)
                        daily.dt = Int32(i.dt)
                    daily.humidity = Int16(i.humidity)
                    daily.sunrise = Int32(i.sunrise)
                    daily.sunset = Int32(i.sunset)
                        daily.temp = temp
                        daily.uvi = i.uvi
                        daily.feelsLike = feelLike
                        dailies.add(daily)
                }
                newCity.daily = dailies
                let hourlies = NSMutableSet()
                for i in city.hourly {
                        let hourly = NSEntityDescription.insertNewObject(forEntityName: "HourForecast", into: self.backgrounContext) as! HourForecast
                        hourly.weatherDescription = i.weather[0].discription
                        hourly.feelsLike = i.feelsLike
                        hourly.uvi = i.uvi
                        hourly.temp = i.temp
                        hourly.humidity = Int16(i.humidity)
                        hourly.dt = Int32(i.dt)
                        hourly.clouds = Int16(i.clouds)
                        hourly.windDeg = Int16(i.windDeg)
                        hourly.windSpeed = i.windSpeed
                        hourlies.add(hourly)
                }
                newCity.hour = hourlies
                do {
                    try self.backgrounContext.save()
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    
    func setCitiesArray() -> [City] {
        var uCities: [City] = []
        let request = City.fetchRequest()
        do {
            let cities = try container.viewContext.fetch(request)
            uCities = cities
        } catch let error {
            print(error)
        }
        return uCities
    }
    
    func setCities(){
        let request = City.fetchRequest()
        do {
            let cities = try backgrounContext.fetch(request)
            print(cities.count)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

