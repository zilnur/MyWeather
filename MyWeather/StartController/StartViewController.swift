import UIKit

class StartViewController: UIViewController {
    
    let coordinator: Coordinator
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "onBoardImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let infoTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
            Разрешить приложению  Weather использовать данные
            о местоположении вашего устройства
            
            
            Чтобы получить более точные прогнозы погоды во время движения или путешествия
            
            Вы можете изменить свой выбор в любое время из меню приложения
            """
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        return label
    }()
    
    private lazy var yesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        switch button.isFocused {
        case true:
            button.backgroundColor = UIColor(named: "focus")
        default:
            button.backgroundColor = UIColor(named: "normal")
        }
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(tapYesBtn), for: .touchUpInside)
//        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var noButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(tapNoBtn), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        setupViews()
    }
    
    @objc func tapYesBtn() {
        UserDefaults.standard.set(true, forKey: "isn'tFirstStart")
        LocationService.shared.getApproval {
            guard let lat = LocationService.shared.getLocations()?.coordinate.latitude,
                let lon = LocationService.shared.getLocations()?.coordinate.longitude else { return }
            NetworkService.shared.getCityNameFormCoordinates(lat: lat, lon: lon) {cityName in
                DatabaseService.shared.addCity(cityName: cityName.convert()) {
                    DispatchQueue.main.async {
                        self.coordinator.showMainPageView()
                    }
                }
            }
        }
    }
    
    @objc func tapNoBtn() {
        UserDefaults.standard.set(true, forKey: "isn'tFirstStart")
        coordinator.showMainPageView()
    }

}

extension StartViewController {
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [image, infoTextLabel, yesButton, noButton].forEach(contentView.addSubview(_:))
        [scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         scrollView.topAnchor.constraint(equalTo: view.topAnchor),
         scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         
         contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
         contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
         contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
         contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
         contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
         
         image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 62),
         image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         image.widthAnchor.constraint(equalToConstant: 304.5),
         image.heightAnchor.constraint(equalToConstant: 334),
         
         infoTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
         infoTextLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 29.97),
         infoTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
         
         yesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
         yesButton.topAnchor.constraint(equalTo: infoTextLabel.bottomAnchor, constant: 40),
         yesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
         yesButton.heightAnchor.constraint(equalToConstant: 40),
         
         noButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
         noButton.topAnchor.constraint(equalTo: yesButton.bottomAnchor, constant: 20),
         noButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
         noButton.heightAnchor.constraint(equalToConstant: 40),
         noButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}
