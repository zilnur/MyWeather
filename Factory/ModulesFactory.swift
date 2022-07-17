import Foundation
import UIKit

class ModulesFactory {
    
    func makeMainPageModule(coordinator: Coordinator) -> UIViewController {
        let presenter = MainPagePresenter(coordinator: coordinator)
        let view = MainPageViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func makeMainModule(city: City, coordinator: Coordinator) -> UIViewController {
        let presenter = MainModulePresenter(city: city, coordinator: coordinator)
        let view = MainViewController(presenter: presenter)
        presenter.view = view
        view.title = presenter.city.name
        return view
    }
    
    func makeHourModule(model: HourlyForecastModel, coordinator: Coordinator) -> UIViewController {
        let presenter = HourlyForecastPresenter(model: model, coordinator: coordinator)
        let view = HourForecastViewController(presenter: presenter)
        return view
    }
    
    func makeDailyModule(model: DailyForecastModel, selectedIndexPath: IndexPath, coordinator: Coordinator) -> UIViewController {
        let presenter = DailyPresenter(model: model, selectedIndexPath: selectedIndexPath, coordinator: coordinator)
        let view = DailyForecastViewController(presenter: presenter)
        return view
    }
    
    func makeSettingsView(coordinator: Coordinator, completion: @escaping () -> ()) -> UIViewController {
        let view = SettingsViewController(coordinator: coordinator, completion: completion)
        view.modalPresentationStyle = .fullScreen
        view.modalTransitionStyle = .coverVertical
        return view
    }
    
    func makeAddCityView(coordinator: Coordinator) -> UIViewController {
        let view = AddCityViewController(coordinator: coordinator)
        return view
    }
    
    func makeStartView(coordinator: Coordinator) -> UIViewController {
        let view = StartViewController(coordinator: coordinator)
        return view
    }
}
