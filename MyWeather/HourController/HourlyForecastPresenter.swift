import Foundation
import UIKit

protocol HourlyPresenterInput {
    
}

protocol HourlyPresenterOutput {
    func buildDataForTable(cell: HourlyTempChangeTableViewCell, indexPath: IndexPath)
    func setCityNameForHeader(label: UILabel)
    func setNumberOfItems() -> Int
    func setChartData() -> (dtArray: [Double], tempArray: [Double], humidityArray: [Double])
    func goBack()
}

class HourlyForecastPresenter: HourlyPresenterOutput {
    
    let model: HourlyForecastModel
    
    let coordinator: Coordinator
    
    init(model: HourlyForecastModel, coordinator: Coordinator) {
        self.model = model
        self.coordinator = coordinator
    }
    
    func buildDataForTable(cell: HourlyTempChangeTableViewCell, indexPath: IndexPath) {
        cell.dateLabel.text = model.forecasts[indexPath.item].dt.toShotDate()
        cell.timeLabel.text = model.forecasts[indexPath.item].dt.toTime()
        cell.tempLabel.text = "\(model.forecasts[indexPath.item].temp.toString())°"
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
    
    func setChartData() -> (dtArray: [Double], tempArray: [Double], humidityArray: [Double]) {
        var dtArray = [Double]()
        var tempArray = [Double]()
        var qArray = [Double]()
        for i in model.forecasts {
            dtArray.append(Double(i.dt))
            tempArray.append(i.temp)
            qArray.append(Double(i.humidity))
        }
        
        return (dtArray, tempArray, qArray)
    }
    
    func goBack() {
        coordinator.back()
    }
    
}
