import Foundation

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
    let moonrise: Int
    let moonset: Int
    let temp: TempModel
    let feelsLike: FeelsLikeModel
    let humidity: Double
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let clouds: Int
    let uvi: Double
    let pop: Double
    
    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise
        case sunset
        case moonrise
        case moonset
        case temp
        case feelsLike = "feels_like"
        case humidity
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case clouds
        case uvi
        case weather
        case pop
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
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case discription = "description"
        case icon = "icon"
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
