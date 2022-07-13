import Foundation
import UIKit
import Combine

protocol MainPagePresenterOutput {
    
}

protocol MainPagePresenterInput {
    func setCurrenPage(currentPage: Int)
    func update()
}

class MainPagePresenter: MainPagePresenterOutput {
    
    var cities: [City]
    
    var view: MainPagePresenterInput?
    
    init() {
        self.cities = DatabaseService.shared.setCitiesArray()
    }
    
    func setMainPageControllers(_ controller: UIPageViewController) {
        if cities.isEmpty {
            let addVC = AddCityViewController()
            controller.setViewControllers([addVC], direction: .forward, animated: true)
            controller.title = "Добавьте город"
        } else {
            let presenter = MainModulePresenter(city: cities[0])
            let svc = MainViewController()
            svc.presenter = presenter
            presenter.view = svc
            controller.setViewControllers([svc], direction: .forward, animated: true)
            controller.title = presenter.city.name
        }
    }
    
    func beforeViewController(viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard cities.isEmpty == false else {return nil}
        guard let vc = viewController as? MainViewController else {
            let presenter = MainModulePresenter(city: cities.last!)
            let mvc = MainViewController()
            mvc.presenter = presenter
            presenter.view = mvc
            return mvc
        }
        let city = vc.presenter?.cityName
        guard let index = cities.firstIndex(where: {$0.name == city}) else { return nil }
        guard vc.presenter?.cityName != cities.first?.name else { return nil }
        let presenter = MainModulePresenter(city: cities[index - 1])
        let viewController = MainViewController()
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
    
    func afterViewController(pageController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard cities.isEmpty == false else {
            let addVC = AddCityViewController()
            addVC.onAdd = {
                let presenter = MainModulePresenter(city: self.cities.last!)
                let mainVC = MainViewController()
                mainVC.presenter = presenter
                presenter.view = mainVC
                pageController.setViewControllers([mainVC], direction: .forward, animated: true)
            }
            return AddCityViewController() }
        guard let VC = viewController as? MainViewController else { return nil }
        let city = VC.presenter?.cityName
        if city == cities.last?.name {
            let addVC = AddCityViewController()
            addVC.onAdd = {
                let presenter = MainModulePresenter(city: self.cities.last!)
                let mainVC = MainViewController()
                mainVC.presenter = presenter
                presenter.view = mainVC
                pageController.setViewControllers([mainVC], direction: .forward, animated: true)
            }
            return addVC
        }
        guard let index = cities.firstIndex(where: {$0.name == city}) else { return nil }
        let presenter = MainModulePresenter(city: cities[index + 1])
        let mvc =  MainViewController()
        presenter.view = mvc
        mvc.presenter = presenter
        return mvc
    }
    
    func setNumberOfPages() -> Int {
        cities.count + 1
    }
    
    func pageControllerFinishAnimating(pageViewController: UIPageViewController) {
        if let vc = pageViewController.viewControllers?[0] as? MainViewController {
        pageViewController.title = vc.presenter?.cityName
            guard let index = cities.firstIndex(where: {$0.name == vc.presenter?.cityName}) else { return }
            view?.setCurrenPage(currentPage: index)
        } else {
            pageViewController.title = "Добавьте город"
            view?.setCurrenPage(currentPage: cities.count + 1)
        }
    }
    
//    func updateForecast() {
//        for city in cities {
//            DatabaseService.shared.updateCity(cityName: city.name!.convert())
//        }
//        
//    }
    
    func setUpdateVC(number: Int, controller: UIPageViewController) {
        let vc = MainViewController()
        let presenter = MainModulePresenter(city: cities[number])
        vc.presenter = presenter
        controller.setViewControllers([vc], direction: .forward, animated: false)
        controller.title = presenter.cityName
    }
}
