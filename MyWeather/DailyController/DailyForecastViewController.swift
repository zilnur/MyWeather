import UIKit

class DailyForecastViewController: UIViewController {
    
    let presenter: DailyForecastPresenterOutput
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cityNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(DailyDatesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let dayView = DayView()
    
    private let nightView = NightView()
    
    private let sunMoonView = SunMoonView()
    
    init(presenter: DailyForecastPresenterOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        collectionView.reloadData()
        collectionView.selectItem(at: presenter.setSelectedItem(), animated: false, scrollPosition: .centeredHorizontally)
        if let indexPaths = collectionView.indexPathsForSelectedItems {
            presenter.setDataForViews(dayView: dayView, nightView: nightView, sunMoonView: sunMoonView) {
                indexPaths[0]
            }
        }
    }
}

extension DailyForecastViewController {
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [cityNameLabel, collectionView, dayView, nightView, sunMoonView].forEach(contentView.addSubview(_:))
        view.backgroundColor = .white
        presenter.setCityName(cityNameLabel)
        
        [scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         scrollView.topAnchor.constraint(equalTo: view.topAnchor),
         scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         
         contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
         contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
         contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
         contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
         contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
         
         cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
         cityNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
         cityNameLabel.heightAnchor.constraint(equalToConstant: 30),
         
         collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         collectionView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 40),
         collectionView.bottomAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 90),
         collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         
         dayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         dayView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
         dayView.heightAnchor.constraint(equalToConstant: 341),
         dayView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
         
         nightView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         nightView.topAnchor.constraint(equalTo: dayView.bottomAnchor, constant: 12),
         nightView.heightAnchor.constraint(equalToConstant: 341),
         nightView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
         
         sunMoonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         sunMoonView.topAnchor.constraint(equalTo: nightView.bottomAnchor, constant: 12),
         sunMoonView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
         sunMoonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}

extension DailyForecastViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DailyDatesCollectionViewCell
        presenter.buildDataForCollection(cell: cell ?? DailyDatesCollectionViewCell(), indexPath: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 88, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.setDataForViews(dayView: dayView, nightView: nightView, sunMoonView: sunMoonView) {
            return indexPath
        }
    }
}
