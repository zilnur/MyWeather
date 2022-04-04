//
//  MainPageViewController.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 03.04.2022.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    private let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.currentPageIndicatorTintColor = .black
        view.tintColor = .systemIndigo
        view.numberOfPages = 3
        view.pageIndicatorTintColor = .lightGray
        return view
    }()
    
    let qwe = [0,1,2,3,4]

    var ewq = 0
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        dataSource = self
        delegate = self
        pageControl.numberOfPages = qwe.count + 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addVC(index: Int) -> UIViewController {
        let vc = MainViewController(index: index)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(pageControl)
        [pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ].forEach {$0.isActive = true}
        let vc = MainViewController(index: 0)
            setViewControllers([vc], direction: .forward, animated: true)
    }
}

extension MainPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? MainViewController else {return nil}
        guard let index = qwe.firstIndex(of: vc.index) else {return nil}
        ewq = index
        print(ewq, index)
        if index == 0 {
            return nil
        }
        return MainViewController(index: index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? MainViewController else {return nil}
        guard let index = qwe.firstIndex(of: vc.index) else {return nil}
        ewq = index
        print(ewq, index)
        if index == qwe.count - 1 {
            let svc = StartViewController()
            let index = 5
            ewq = index
            return svc
        }
        if index == qwe.count + 2 {
            return nil
        }
        let nvc = MainViewController(index: index + 1)
        return nvc
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageControl.currentPage = ewq
    }
    
}
