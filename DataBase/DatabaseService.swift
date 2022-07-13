import Foundation
import CoreData
import Combine

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
                newCity.name = name
                newCity.lon = city.lon
                newCity.lat = city.lat
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
                newCity.currentWeather = current
                let dailies = NSMutableSet()
                for i in city.daily {

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
                    
                    let daily = NSEntityDescription.insertNewObject(forEntityName: "DailyForecast", into: self.backgrounContext) as! DailyForecast
                    daily.windSpeed = i.windSpeed
                    daily.windDeg = Int16(i.windDeg)
                    daily.weatherDescription = i.weather[0].discription
                    daily.clouds = Int16(i.clouds)
                    daily.dt = Int32(i.dt)
                    daily.humidity = Int16(i.humidity)
                    daily.sunrise = Int32(i.sunrise)
                    daily.sunset = Int32(i.sunset)
                    daily.moonrise = Int32(i.moonrise)
                    daily.moonset = Int32(i.moonset)
                    daily.pop = i.pop
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
    
    func updateCity(cityName: String, completion: @escaping (City) -> ()) {
        NetworkService.shared.addCity(cityName: cityName) { [weak self] newCityData, NewCityName in
            guard let self = self else { return }
            let request = City.fetchRequest()
            request.predicate = NSPredicate(format: "%K == %@", "name", NewCityName)
            do {
                let city = try self.backgrounContext.fetch(request)
                print("qqq \(city[0].currentWeather?.dt.toTime())")
                city[0].name = NewCityName
                city[0].currentWeather?.dt = Int32(newCityData.current.dt)
                city[0].currentWeather?.sunset = Int32(newCityData.current.sunset)
                city[0].currentWeather?.sunrise = Int32(newCityData.current.sunrise)
                city[0].currentWeather?.clouds = Int16(newCityData.current.clouds)
                city[0].currentWeather?.humidity = Int16(newCityData.current.humidity)
                city[0].currentWeather?.temp = newCityData.current.temp
                city[0].currentWeather?.windDeg = Int16(newCityData.current.windDeg)
                city[0].currentWeather?.windSpeed = newCityData.current.windSpeed
                city[0].currentWeather?.weatherDescription = newCityData.current.weather.first?.discription
                
                for i in city[0].daily! {
                    self.backgrounContext.delete(i as! NSManagedObject)
                }
                let newDailySet = NSMutableSet()
                for daily in newCityData.daily {
                    let forecast = NSEntityDescription.insertNewObject(forEntityName: "DailyForecast", into: self.backgrounContext) as! DailyForecast
                    let temp = NSEntityDescription.insertNewObject(forEntityName: "Temp", into: self.backgrounContext) as! Temp
                    let feelLike = NSEntityDescription.insertNewObject(forEntityName: "FeelsLike", into: self.backgrounContext) as! FeelsLike
                forecast.windSpeed = daily.windSpeed
                forecast.windDeg = Int16(daily.windDeg)
                forecast.weatherDescription = daily.weather[0].discription
                forecast.clouds = Int16(daily.clouds)
                forecast.dt = Int32(daily.dt)
                forecast.humidity = Int16(daily.humidity)
                forecast.sunrise = Int32(daily.sunrise)
                forecast.sunset = Int32(daily.sunset)
                forecast.moonrise = Int32(daily.moonrise)
                forecast.moonset = Int32(daily.moonset)
                forecast.pop = daily.pop
//                    forecast.temp?.morn = daily.temp.morn
//                    forecast.temp?.eve = daily.temp.eve
//                    forecast.temp?.night = daily.temp.night
//                    forecast.temp?.day = daily.temp.day
//                    forecast.temp?.max = daily.temp.max
//                    forecast.temp?.min = daily.temp.min
                    temp.night = daily.temp.night
                    temp.morn = daily.temp.morn
                    temp.min = daily.temp.min
                    temp.max = daily.temp.max
                    temp.eve = daily.temp.eve
                    temp.day = daily.temp.day
                    feelLike.night = daily.feelsLike.night
                    feelLike.morn = daily.feelsLike.morn
                    feelLike.eve = daily.feelsLike.eve
                    feelLike.day = daily.feelsLike.day
                    forecast.temp = temp
                    forecast.feelsLike = feelLike
                forecast.uvi = daily.uvi
                    forecast.feelsLike?.day = daily.feelsLike.day
                    forecast.feelsLike?.night = daily.feelsLike.night
                    forecast.feelsLike?.eve = daily.feelsLike.eve
                    forecast.feelsLike?.morn = daily.feelsLike.morn
                    newDailySet.add(forecast)
                }
                city[0].daily = newDailySet
                for i in city[0].hour! {
                    self.backgrounContext.delete(i as! NSManagedObject)
                }
                let newHourlySet = NSMutableSet()
                for hourly in newCityData.hourly {
                    let forecast = NSEntityDescription.insertNewObject(forEntityName: "HourForecast", into: self.backgrounContext) as! HourForecast
                    forecast.weatherDescription = hourly.weather[0].discription
                    forecast.feelsLike = hourly.feelsLike
                    forecast.uvi = hourly.uvi
                    forecast.temp = hourly.temp
                    forecast.humidity = Int16(hourly.humidity)
                    forecast.dt = Int32(hourly.dt)
                    forecast.clouds = Int16(hourly.clouds)
                    forecast.windDeg = Int16(hourly.windDeg)
                    forecast.windSpeed = hourly.windSpeed
                    newHourlySet.add(forecast)
                }
                city[0].hour = newHourlySet
                do {
                    try self.backgrounContext.save()
                    completion(city[0])
                } catch {
                    
                }
            } catch let error{
                print(error)
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
    
    func setCitiesArraya() -> CurrentValueSubject<[City],Never> {
        let customPublisher = CurrentValueSubject<[City], Never>([])
        let request = City.fetchRequest()
        do {
            let cities = try container.viewContext.fetch(request)
            customPublisher.send(cities)
        } catch let error {
            print(error)
        }
        return customPublisher
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

