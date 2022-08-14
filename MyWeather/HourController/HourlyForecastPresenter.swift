import Foundation
import UIKit

protocol HourlyPresenterInput {
    
}

protocol HourlyPresenterOutput {
    func buildDataForTable(cell: HourlyTempChangeTableViewCell, indexPath: IndexPath)
    func setCityNameForHeader(label: UILabel)
    func setNumberOfItems() -> Int
    func goBack()
    func buildDataForCollection(cell: HourHeaderCollectionViewCell, indexPath: IndexPath)
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
    
    func buildDataForCollection(cell: HourHeaderCollectionViewCell, indexPath: IndexPath) {
        cell.temperatureLabel.text = "\(model.forecasts[indexPath.item].temp.toString())°"
        cell.humidityLabel.text = "\(model.forecasts[indexPath.item].humidity)%"
        cell.timeLabel.text = model.forecasts[indexPath.item].dt.toTime()
        
        let minTemp = model.forecasts.min(by: {$0.temp < $1.temp})!.temp
        let maxTemp = model.forecasts.max(by: {$0.temp < $1.temp})!.temp
        if indexPath.item < setNumberOfItems() - 1 {
            let differenceBitweenMaxAndMinTemp = maxTemp - minTemp
            let pointsPerDegree = 20 / differenceBitweenMaxAndMinTemp
            let currentTemperatureOffset = Int((maxTemp - model.forecasts[indexPath.item + 1].temp) * pointsPerDegree)
            cell.nextTimeTemp = currentTemperatureOffset
            print(cell.nextTimeTemp)
        }
        cell.putDotOfTemperature(minTemperature: minTemp, maxTemperature: maxTemp, temp: model.forecasts[indexPath.item].temp)
        if indexPath.item == 0 {
            cell.isFirstCell = true
        }
        if indexPath.item == model.forecasts.count - 1 {
            cell.isLastCell = true
        }
    }
    
    func setCityNameForHeader(label: UILabel) {
        label.text = model.name
    }
    
    func setNumberOfItems() -> Int {
        return model.forecasts.count
    }
    
    func goBack() {
        coordinator.back()
    }
    
}
