import UIKit

class MainPageViewController: UIPageViewController {
    
    let presenter = MainPagePresenter()
    
    lazy var pageControl: UIPageControl = {
        var view = UIPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.currentPageIndicatorTintColor = .black
        view.tintColor = .systemIndigo
        view.isUserInteractionEnabled = false
        view.pageIndicatorTintColor = .lightGray
        return view
    }()
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        presenter.setMainPageControllers(self)
        delegate = self
        dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        presenter.view = self
//        presenter.updateForecast()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton = UIBarButtonItem(image: .init(systemName: "person"), style: .plain, target: self, action: #selector(city))
        navigationItem.rightBarButtonItem = rightButton
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        self.view.insertSubview(pageControl, at: 0)
        pageControl.numberOfPages = presenter.setNumberOfPages()
        [pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ].forEach {$0.isActive = true}
    }
    
    @objc func city() {
        presenter.setMainPageControllers(self)
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
        self.delegate = self
        self.dataSource = self
    }
}
