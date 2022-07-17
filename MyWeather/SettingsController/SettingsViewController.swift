import UIKit

class SettingsViewController: UIViewController {
    
    let coordinator: Coordinator
    
    var completion: () -> ()

    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let configLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Настройки"
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Температура"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        return label
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Скорость ветра"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        return label
    }()
    
    private let timeFormatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Формат времени"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        return label
    }()
    
    private let notifivationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Уведомления"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        return label
    }()
    
    private let tempControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["C","F"])
        view.translatesAutoresizingMaskIntoConstraints = false
        switch UserDefaults.standard.bool(forKey: "isCelsius") {
        case true:
            view.selectedSegmentIndex = 0
        case false:
            view.selectedSegmentIndex = 1
        }
        view.selectedSegmentTintColor = UIColor(red: 0.122, green: 0.302, blue: 0.773, alpha: 1)
        view.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        view.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        return view
    }()
    
    private let windControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Mi","Km"])
        view.translatesAutoresizingMaskIntoConstraints = false
        switch UserDefaults.standard.bool(forKey: "isMetrics") {
        case true:
            view.selectedSegmentIndex = 1
        case false:
            view.selectedSegmentIndex = 0
        }
        view.selectedSegmentTintColor = UIColor(red: 0.122, green: 0.302, blue: 0.773, alpha: 1)
        view.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        view.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        return view
    }()
    
    private let timeFormatControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["12","24"])
        view.translatesAutoresizingMaskIntoConstraints = false
        switch UserDefaults.standard.bool(forKey: "is24") {
        case true:
            view.selectedSegmentIndex = 1
        case false:
            view.selectedSegmentIndex = 0
        }
        view.selectedSegmentTintColor = UIColor(red: 0.122, green: 0.302, blue: 0.773, alpha: 1)
        view.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        view.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        return view
    }()
    
    private let notificationsControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["On","Off"])
        view.translatesAutoresizingMaskIntoConstraints = false
        switch UserDefaults.standard.bool(forKey: "isOn") {
        case true:
            view.selectedSegmentIndex = 0
        case false:
            view.selectedSegmentIndex = 1
        }
        view.selectedSegmentTintColor = UIColor(red: 0.122, green: 0.302, blue: 0.773, alpha: 1)
        view.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        view.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        return view
    }()
    
    private lazy var setupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Установить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(setConfigs), for: .touchUpInside)
        button.layer.cornerRadius = 10
        switch button.isFocused {
        case true:
            button.backgroundColor = UIColor(named: "focus")
        default:
            button.backgroundColor = UIColor(named: "normal")
        }
        return button
    }()
    
    private let upCloudImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "upperCloud"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let middleCloudImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "middleCloud"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.5
        return image
    }()
    
    private let lowCloudImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "lowerCloud"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    init(coordinator: Coordinator, completion: @escaping () -> ()) {
        self.coordinator = coordinator
        self.completion = completion
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
    
    @objc func setConfigs() {
        if tempControl.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(true, forKey: "isCelsius")
        } else {
            UserDefaults.standard.set(false, forKey: "isCelsius")
        }
        if windControl.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(false, forKey: "isMetrics")
        } else {
            UserDefaults.standard.set(true, forKey: "isMetrics")
        }
        if timeFormatControl.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(false, forKey: "is24")
        } else {
            UserDefaults.standard.set(true, forKey: "is24")
        }
        if notificationsControl.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(true, forKey: "isOn")
        } else {
            UserDefaults.standard.set(false, forKey: "isOn")
        }
        dismiss(animated: true)
        completion()
    }

}

extension SettingsViewController {
    func setupViews() {
        [upCloudImageView, middleCloudImageView, lowCloudImageView, backgroundView].forEach(view.addSubview(_:))
        [configLabel,tempLabel,windLabel,timeFormatLabel,notifivationsLabel, tempControl, windControl, timeFormatControl, notificationsControl, setupButton].forEach(backgroundView.addSubview(_:))
        
        [upCloudImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         upCloudImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 37),
         upCloudImageView.heightAnchor.constraint(equalToConstant: 58),
         upCloudImageView.widthAnchor.constraint(equalToConstant: 250),
         
         middleCloudImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 121),
         middleCloudImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         middleCloudImageView.heightAnchor.constraint(equalToConstant: 94),
         middleCloudImageView.widthAnchor.constraint(equalToConstant: 182),
        
         backgroundView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 28),
         backgroundView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor,constant: -28),
         backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         backgroundView.heightAnchor.constraint(equalToConstant: 320),
         backgroundView.widthAnchor.constraint(equalToConstant: 320),
         
         lowCloudImageView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 81),
         lowCloudImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         lowCloudImageView.heightAnchor.constraint(equalToConstant: 65),
         lowCloudImageView.widthAnchor.constraint(equalToConstant: 217),
         
         configLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
         configLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor,constant: 27),
         
         tempLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
         tempLabel.topAnchor.constraint(equalTo: configLabel.bottomAnchor, constant: 20),
         
         windLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
         windLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 30),
         
         timeFormatLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
         timeFormatLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 30),
         
         notifivationsLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
         notifivationsLabel.topAnchor.constraint(equalTo: timeFormatLabel.bottomAnchor, constant: 30),
         notifivationsLabel.heightAnchor.constraint(equalTo: timeFormatLabel.heightAnchor),
         
         tempControl.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 57),
         tempControl.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30),
         tempControl.heightAnchor.constraint(equalToConstant: 30),
         tempControl.widthAnchor.constraint(equalToConstant: 80),
         
         windControl.topAnchor.constraint(equalTo: tempControl.bottomAnchor, constant: 20),
         windControl.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30),
         windControl.heightAnchor.constraint(equalToConstant: 30),
         windControl.widthAnchor.constraint(equalToConstant: 80),
         
         timeFormatControl.topAnchor.constraint(equalTo: windControl.bottomAnchor, constant: 20),
         timeFormatControl.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30),
         timeFormatControl.heightAnchor.constraint(equalToConstant: 30),
         timeFormatControl.widthAnchor.constraint(equalToConstant: 80),
         
         notificationsControl.topAnchor.constraint(equalTo: timeFormatControl.bottomAnchor, constant: 20),
         notificationsControl.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30),
         notificationsControl.heightAnchor.constraint(equalToConstant: 30),
         notificationsControl.widthAnchor.constraint(equalToConstant: 80),
         
         setupButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 35),
         setupButton.topAnchor.constraint(equalTo: notifivationsLabel.bottomAnchor, constant: 42),
         setupButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -35),
         setupButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16)
        ].forEach {$0.isActive = true}
    }
}
