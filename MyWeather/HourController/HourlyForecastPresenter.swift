import Foundation
import UIKit

protocol HourlyPresenterInput {
    
}

protocol HourlyPresenterOutput {
    func buildDataForTable(cell: HourlyTempChangeTableViewCell, indexPath: IndexPath)
    func setCityNameForHeader(label: UILabel)
    func setNumberOfItems() -> Int
    func buildDataForCollection(cell: HourCollectionViewCell, indexPath: IndexPath)
    func qwe()
}

class HourlyForecastPresenter: HourlyPresenterOutput {
    
    let model: HourlyForecastModel
    
    init(model: HourlyForecastModel) {
        self.model = model
    }
    
    func buildDataForTable(cell: HourlyTempChangeTableViewCell, indexPath: IndexPath) {
        cell.dateLabel.text = model.forecasts[indexPath.item].dt.toShotDate()
        cell.timeLabel.text = model.forecasts[indexPath.item].dt.toTime()
        cell.tempLabel.text = "\(Int(model.forecasts[indexPath.item].temp))°"
        cell.descriptionLabel.text = model.forecasts[indexPath.item].weatherDescription!.withFirstUppercase()
        cell.feelLikeLabel.text = "По ощущению \(Int(model.forecasts[indexPath.item].feelsLike))°"
        cell.windValueLabel.text = "\(Int(model.forecasts[indexPath.item].windSpeed))м/с"
        cell.precipitationValueLabel.text = "0%"
        cell.humidityValueLabel.text = "\(model.forecasts[indexPath.item].humidity)"
    }
    
    func setCityNameForHeader(label: UILabel) {
        label.text = model.name
    }
    
    func setNumberOfItems() -> Int {
        return model.forecasts.count
    }
    
    func buildDataForCollection(cell: HourCollectionViewCell, indexPath: IndexPath) {
        cell.tempLabel.text = "\(Int(model.forecasts[indexPath.item].temp))°"
        cell.precipitationValueLabel.text = "0"
        cell.timeLabel.text = model.forecasts[indexPath.item].dt.toTime()
    }
    
    func qwe() {
        var dtArray = [Int32]()
        var tempArray = [Double]()
        var qArray = [Int16]()
        for i in model.forecasts {
            dtArray.append(i.dt)
            tempArray.append(i.temp)
            qArray.append(i.humidity)
        }
        print("qwe\(dtArray),\(tempArray), \(qArray)")
        
    }
    
}
