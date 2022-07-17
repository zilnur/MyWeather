import Foundation
import UIKit
import Combine

protocol MainPagePresenterOutput {
    func setMainPageControllers(_ controller: UIPageViewController)
    func beforeViewController(viewControllerBefore viewController: UIViewController) -> UIViewController?
    func afterViewController(pageController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    func setNumberOfPages() -> Int
    func pageControllerFinishAnimating(pageViewController: UIPageViewController)
    func afterAddNewCity(controller: UIPageViewController)
    func openSettings(completion: @escaping ()-> ())
}

protocol MainPagePresenterInput {
    func setCurrenPage(currentPage: Int)
    func update()
}

class MainPagePresenter: MainPagePresenterOutput {
    
    var cities: [City]
    
    var view: MainPagePresenterInput?
    
    let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.cities = DatabaseService.shared.setCitiesArray()
    }
    
    func setMainPageControllers(_ controller: UIPageViewController) {
        if cities.isEmpty {
            coordinator.showAddCityView(controller: controller)
        } else {
            let presenter = MainModulePresenter(city: cities[0],coordinator: coordinator)
            let svc = MainViewController(presenter: presenter)
            svc.presenter = presenter
            presenter.view = svc
            controller.setViewControllers([svc], direction: .forward, animated: true)
            controller.title = presenter.city.name
        }
    }
    
    func beforeViewController(viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard cities.isEmpty == false else {return nil}
        guard let vc = viewController as? MainViewController else {
            let view = coordinator.factory.makeMainModule(city: cities.last!, coordinator: coordinator)
            return view
        }
        let city = vc.presenter?.cityName
        guard let index = cities.firstIndex(where: {$0.name == city}) else { return nil }
        guard city != cities.first?.name else { return nil }
        let view = coordinator.factory.makeMainModule(city: cities[index - 1], coordinator: coordinator)
        return view
    }
    
    func afterViewController(pageController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard cities.isEmpty == false else { return nil }
        guard let VC = viewController as? MainViewController else { return nil }
        let city = VC.presenter?.cityName
        if city == cities.last?.name {
            return nil
        }
        guard let index = cities.firstIndex(where: {$0.name == city}) else { return nil }
        let view = coordinator.factory.makeMainModule(city: cities[index + 1], coordinator: coordinator)
        return view
    }
    
    func setNumberOfPages() -> Int {
        cities.count
    }
    
    func pageControllerFinishAnimating(pageViewController: UIPageViewController) {
        if let vc = pageViewController.viewControllers?[0] as? MainViewController {
        pageViewController.title = vc.presenter?.cityName
            guard let index = cities.firstIndex(where: {$0.name == vc.presenter?.cityName}) else { return }
            view?.setCurrenPage(currentPage: index)
        }
    }
    
    func afterAddNewCity(controller: UIPageViewController) {
        cities = DatabaseService.shared.setCitiesArray()
        let presenter = MainModulePresenter(city: cities.last!, coordinator: coordinator)
        let svc = MainViewController(presenter: presenter)
        svc.presenter = presenter
        presenter.view = svc
        view?.update()
        view?.setCurrenPage(currentPage: cities.count)
        print(cities.count)
        controller.setViewControllers([svc], direction: .forward, animated: true)
        controller.title = presenter.city.name
    }
    
    func openSettings(completion: @escaping ()-> ()) {
        coordinator.showSettingsView(completion: completion)
    }
}
