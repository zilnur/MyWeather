import Foundation
import CoreData

class DatabaseService {
    
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
                newCity.currentWeather?.dt = Int32(city.current.dt)
                newCity.currentWeather?.clouds = Int16(city.current.clouds)
                newCity.currentWeather?.humidity = city.current.humidity
                newCity.currentWeather?.sunrise = city.current.sunrise
                newCity.currentWeather?.sunset = city.current.sunset
                newCity.currentWeather?.temp = city.current.temp
                newCity.currentWeather?.weatherDescription = city.current.weather[0].description
                newCity.currentWeather?.windDeg = Int16(city.current.windDeg)
                newCity.currentWeather?.windSpeed = city.current.windSpeed
                newCity.daily = NSSet(array: city.daily)
                newCity.hour = NSSet(array: city.hourly)
                do {
                    try self.backgrounContext.save()
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
