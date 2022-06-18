import Foundation
import Combine

struct CityModel: Decodable {
    var lat : Double
    var lon: Double
    var current: CurrentModel
    var daily: [DailyModel]
    var hourly: [HourlyModel]
}

struct CurrentModel: Decodable {
    let dt: Int
    let sunrise: Double
    let sunset: Double
    let temp: Double
    let humidity: Double
    let clouds: Int
    let windSpeed: Double
    let weather: [Weather]
    let windDeg: Int
    
    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise
        case sunset
        case temp
        case humidity
        case clouds
        case windSpeed = "wind_speed"
        case weather
        case windDeg = "wind_deg"
    }
    
}

struct DailyModel: Decodable {
    let dt: Int
    let sunrise: Double
    let sunset: Double
    let temp: TempModel
    let feelsLike: FeelsLikeModel
    let humidity: Double
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let clouds: Int
    let uvi: Double
    
    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise
        case sunset
        case temp
        case feelsLike = "feels_like"
        case humidity
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case clouds
        case uvi
        case weather
    }
}

struct TempModel: Decodable {
    let min: Double
    let max: Double
    let day: Double
    let morn: Double
    let eve: Double
    let night: Double
}

struct FeelsLikeModel: Decodable {
    let day: Double
    let morn: Double
    let eve: Double
    let night: Double
}

struct Weather: Decodable {
    let discription: String
    
    enum CodingKeys: String, CodingKey {
        case discription = "description"
    }
}

struct HourlyModel: Decodable {
    let dt: Int
    let temp: Double
    let feelsLike: Double
    let humidity: Double
    let uvi: Double
    let clouds: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case feelsLike = "feels_like"
        case humidity
        case uvi
        case clouds
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
    }
}

struct Coordinates: Decodable {
    let localNames: LocalNames
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case localNames = "local_names"
        case lat
        case lon
    }
}

struct LocalNames: Decodable {
    let ru: String
}

class NetworkService {
    
    static let shared = NetworkService()
    
    let api = "c9b20455baf67b0f54988645cdb51382"
    
    let decoder = JSONDecoder()
    
    func setCoordinates(cityName: String, complition: @escaping(String, Double, Double) -> Void) {
        if let url = URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&limit=1&appid=\(api)") {
            let session = URLSession.shared.dataTask(with: url) { data, _, error in
                if let uData = data {
                    do {
                        let json = try JSONDecoder().decode([Coordinates].self, from: uData)
                        let name = json[0].localNames.ru
                        let lat = json[0].lat
                        let lon = json[0].lon
                        complition(name,lon,lat)
                    } catch {
                        print(error)
                    }
                }
            }
            session.resume()
        } else {
            print("oops1")
        }
    }
    
    func addCity(cityName: String, complition: @escaping(CityModel, String) -> Void) {
        setCoordinates(cityName: cityName) { [weak self] name, lon, lat in
            guard let self = self else { return }
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=alerts,minutely&appid=\(self.api)&units=metric&lang=ru") else { return }
            let session = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let uData = data else { print("Oops")
                    return }
                do {
                    let city = try JSONDecoder().decode(CityModel.self, from: uData)
                    complition(city, name)
                } catch {
                    print(error)
                }
            }
            session.resume()
        }
    }
    
}
