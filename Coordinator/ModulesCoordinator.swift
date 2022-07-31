import Foundation
import UIKit

class Coordinator {
    
    private var navigationController: UINavigationController
    var factory: ModulesFactory
    
    init(navi: UINavigationController, factory: ModulesFactory) {
        self.navigationController = navi
        self.factory = factory
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func start() {
        switch UserDefaults.standard.bool(forKey: "isn'tFirstStart") {
        case false:
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.pushViewController(factory.makeStartView(coordinator: self), animated: false)
        case true:
            navigationController.setNavigationBarHidden(false, animated: false)
            navigationController.pushViewController(factory.makeMainPageModule(coordinator: self), animated: false)
        }
    }
    
    func showMainPageView() {
        navigationController.setNavigationBarHidden(false , animated: true)
        navigationController.pushViewController(factory.makeMainPageModule(coordinator: self), animated: true)
    }
    
    func showHourlyModule(model: HourlyForecastModel) {
        navigationController.pushViewController(factory.makeHourModule(model: model, coordinator: self), animated: true)
    }
    
    func showDailyView(model: DailyForecastModel, indexPath: IndexPath) {
        navigationController.pushViewController(factory.makeDailyModule(model: model, selectedIndexPath: indexPath, coordinator: self), animated: true)
    }
    
    func showAddCityView(controller: UIPageViewController) {
        controller.setViewControllers([factory.makeAddCityView(coordinator: self)], direction: .forward, animated: true)
    }
    
    func showStarView() {
        navigationController.pushViewController(factory.makeStartView(coordinator: self), animated: true)
    }
    
    func showSettingsView() {
        navigationController.present(factory.makeSettingsView(coordinator: self), animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
