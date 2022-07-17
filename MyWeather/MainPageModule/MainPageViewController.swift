import UIKit

class MainPageViewController: UIPageViewController {
    
    let presenter: MainPagePresenterOutput
    
    lazy var pageControl: UIPageControl = {
        var view = UIPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.currentPageIndicatorTintColor = .black
        view.tintColor = .systemIndigo
        view.isUserInteractionEnabled = false
        view.pageIndicatorTintColor = .lightGray
        return view
    }()
    
    lazy var locationButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "location"), for: .normal)
        view.addTarget(self, action: #selector(addCityAlert), for: .touchUpInside)
        return view
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        let view = UIBarButtonItem(customView: locationButton)
        return view
    }()
    
    lazy var settingsButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "config"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapSettingsBtn), for: .touchUpInside)
        return view
    }()
    
    lazy var leftButton: UIBarButtonItem = {
        let view = UIBarButtonItem(customView: settingsButton)
        return view
    }()
    
    init(presenter: MainPagePresenterOutput) {
        self.presenter = presenter
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        presenter.setMainPageControllers(self)
        delegate = self
        dataSource = self
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.leftBarButtonItem = leftButton
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        self.view.insertSubview(pageControl, at: 0)
        pageControl.numberOfPages = presenter.setNumberOfPages()
        [pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         
         locationButton.widthAnchor.constraint(equalToConstant: 20),
         locationButton.heightAnchor.constraint(equalToConstant: 26),
         
         settingsButton.widthAnchor.constraint(equalToConstant: 34),
         settingsButton.heightAnchor.constraint(equalToConstant: 26)
        ].forEach {$0.isActive = true}
    }
    
    @objc func addCityAlert() {
        let alert = UIAlertController(title: "Добавить город", message: "Введите название города", preferredStyle: .alert)
        alert.addTextField()
        let alertOk = UIAlertAction(title: "OK", style: .default) {_ in
            guard let text = alert.textFields?[0].text else { return }
            DatabaseService.shared.addCity(cityName: text.convert()) {
                DispatchQueue.main.async {
                    self.presenter.afterAddNewCity(controller: self)
                    self.pageControl.numberOfPages = self.presenter.setNumberOfPages()
                }
            }
        }
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel)
        [alertOk, alertCancel].forEach {alert.addAction($0)}
        self.present(alert, animated: true)
    }
    
    @objc func tapSettingsBtn() {
        presenter.openSettings() {
            self.presenter.setMainPageControllers(self)
        }
    }
}

extension MainPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        self.presenter.beforeViewController(viewControllerBefore: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        self.presenter.afterViewController(pageController: pageViewController, viewControllerAfter: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        presenter.pageControllerFinishAnimating(pageViewController: pageViewController)
    }
    
}

extension MainPageViewController: MainPagePresenterInput {
    func setCurrenPage(currentPage: Int) {
        pageControl.currentPage = currentPage
    }
    
    func update() {
        self.pageControl.numberOfPages = presenter.setNumberOfPages()
    }
}
