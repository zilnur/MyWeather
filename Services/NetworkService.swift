import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    let api = "c9b20455baf67b0f54988645cdb51382"
    
    let decoder = JSONDecoder()
    
    func getCoordinates(cityName: String, complition: @escaping(String, Double, Double) -> Void) {
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
            print("qweewq")
        }
    }
    
    func addCity(cityName: String, complition: @escaping(CityModel, String) -> Void) {
        getCoordinates(cityName: cityName) { [weak self] name, lon, lat in
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
    
    func getCityNameFormCoordinates(lat: Double, lon: Double, completion: @escaping(String) -> ()) {
        guard let url = URL(string: "http://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=1&appid=\(api)") else {
            print("qqqwww")
            return }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let uData = data else { return }
            do {
                let coordinates = try JSONDecoder().decode([Coordinates].self, from: uData)
                let name = coordinates[0].localNames.ru
                completion(name)
            } catch {
                print(error)
            }
        }
        session.resume()
    }
    
}
