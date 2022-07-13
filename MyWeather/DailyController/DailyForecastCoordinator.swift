import Foundation
import UIKit

protocol DailyForecastPresenterOutput {
    func setCityName(_ label: UILabel)
    func buildDataForCollection(cell: DailyDatesCollectionViewCell, indexPath: IndexPath)
    func setDataForViews(dayView: DayView, nightView: NightView, sunMoonView: SunMoonView, completion: () -> IndexPath)
    func setSelectedItem() -> IndexPath
}

class DailyPresenter {
    
    let model: DailyForecastModel
    
    let selectedIndexPath: IndexPath
    
    init(model: DailyForecastModel, selectedIndexPath: IndexPath) {
        self.model = model
        self.selectedIndexPath = selectedIndexPath
    }
    
}

extension DailyPresenter: DailyForecastPresenterOutput {
    
    func setCityName(_ label: UILabel) {
        label.text = model.cityName
    }
    
    func buildDataForCollection(cell: DailyDatesCollectionViewCell, indexPath: IndexPath) {
        cell.dateLabel.text = model.forecasts[indexPath.item].dt.toShotDate()
    }
    
    func setDataForViews(dayView: DayView, nightView: NightView, sunMoonView: SunMoonView, completion: () -> IndexPath) {
        
        dayView.tempLabel.text = "\(Int(model.forecasts[completion().item].temp!.day))"
        dayView.descriptionLabel.text = model.forecasts[completion().item].weatherDescription?.withFirstUppercase()
        
        dayView.feelLikeStack.image.image = UIImage(named: "feelLike")
        dayView.feelLikeStack.desLabel.text = "По ощущениям"
        dayView.feelLikeStack.valueLabel.text = "\(Int(model.forecasts[completion().item].feelsLike!.day))°"
        
        dayView.windStack.image.image = UIImage(named: "wind")
        dayView.windStack.desLabel.text = "Ветер"
        dayView.windStack.valueLabel.text = "\(Int(model.forecasts[completion().item].windSpeed))"
        
        dayView.uviStack.image.image = UIImage(named: "sun")
        dayView.uviStack.desLabel.text = "Уф индекс"
        dayView.uviStack.valueLabel.text = "\(Int(model.forecasts[completion().item].uvi))"
        
        dayView.rainStack.image.image = UIImage(named: "precipitation")
        dayView.rainStack.desLabel.text = "Дождь"
        dayView.rainStack.valueLabel.text = "\(Int(model.forecasts[completion().item].pop * 100))%"
        
        dayView.cloudsStack.image.image = UIImage(named: "cloud")
        dayView.cloudsStack.desLabel.text = "Облачность"
        dayView.cloudsStack.valueLabel.text = "\(model.forecasts[completion().item].clouds)"
        
        nightView.tempLabel.text = "\(Int(model.forecasts[completion().item].temp!.night))"
        nightView.descriptionLabel.text = model.forecasts[completion().item].weatherDescription?.withFirstUppercase()
        
        nightView.feelLikeStack.image.image = UIImage(named: "feelLike")
        nightView.feelLikeStack.desLabel.text = "По ощущениям"
        nightView.feelLikeStack.valueLabel.text = "\(Int(model.forecasts[completion().item].feelsLike!.night))°"
        
        nightView.windStack.image.image = UIImage(named: "wind")
        nightView.windStack.desLabel.text = "Ветер"
        nightView.windStack.valueLabel.text = "\(Int(model.forecasts[completion().item].windSpeed))"
        
        nightView.uviStack.image.image = UIImage(named: "sun")
        nightView.uviStack.desLabel.text = "Уф индекс"
        nightView.uviStack.valueLabel.text = "\(Int(model.forecasts[completion().item].uvi))"
        
        nightView.rainStack.image.image = UIImage(named: "precipitation")
        nightView.rainStack.desLabel.text = "Дождь"
        nightView.rainStack.valueLabel.text = "\(Int(model.forecasts[completion().item].pop * 100))%"
        
        nightView.cloudsStack.image.image = UIImage(named: "cloud")
        nightView.cloudsStack.desLabel.text = "Облачность"
        nightView.cloudsStack.valueLabel.text = "\(model.forecasts[completion().item].clouds)"
        
        let sunriseTime = model.forecasts[completion().item].sunrise
        let sunsetTime = model.forecasts[completion().item].sunset
        
        sunMoonView.sunStack.timeLabel.text = (sunsetTime - sunriseTime).toTimeInterval()
        sunMoonView.sunStack.riseLabel.text = "\(sunriseTime.toTime())"
        sunMoonView.sunStack.setLabel.text = "\(sunsetTime.toTime())"
        
        let moonriseTime = model.forecasts[completion().item].moonrise
        let moonsetTime = model.forecasts[completion().item].moonset
        
        sunMoonView.moonStack.timeLabel.text = (moonsetTime - moonriseTime).toTimeInterval()
        sunMoonView.moonStack.riseLabel.text = "\(moonriseTime.toTime())"
        sunMoonView.moonStack.setLabel.text = "\(moonsetTime.toTime())"
    }
    
    func setSelectedItem() -> IndexPath {
        self.selectedIndexPath
    }
}
