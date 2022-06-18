import UIKit

class DailyForecastViewController: UIViewController {
    
    var dailyForecasts: [DailyForecast]?
    
    var cityName = ""
    var item = 2
    
    private lazy var cityNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        view.text = "Казань"
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(DailyDatesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dayView = DayView()
    
    private let nightView = NightView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
}

extension DailyForecastViewController {
    func setupViews() {
        [cityNameLabel, collectionView, dayView, nightView].forEach(view.addSubview(_:))
        view.backgroundColor = .white
        
        [cityNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
         cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
         cityNameLabel.heightAnchor.constraint(equalToConstant: 30),
         
         collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         collectionView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 40),
         collectionView.bottomAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 90),
         collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         
         dayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         dayView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
         dayView.heightAnchor.constraint(equalToConstant: 341),
         dayView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
         
         nightView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         nightView.topAnchor.constraint(equalTo: dayView.bottomAnchor, constant: 12),
         nightView.heightAnchor.constraint(equalToConstant: 341),
         nightView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30)
        ].forEach {$0.isActive = true}
    }
}

extension DailyForecastViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dailyForecasts!.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DailyDatesCollectionViewCell
        cell?.dailyForecast = self.dailyForecasts![indexPath.item + 1]
        switch indexPath.item {
        case item:
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        default: break
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 88, height: 36)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DailyDatesCollectionViewCell
        dayView.tempLabel.text = "\(Int(cell.dailyForecast!.temp!.day))"
        dayView.feelLikeStack.valueLabel.text = String(describing: (cell.dailyForecast!.feelsLike!.day))
        dayView.windStack.valueLabel.text = "\(Int(cell.dailyForecast!.windSpeed))"
        dayView.uviStack.valueLabel.text = "\(Int(cell.dailyForecast!.uvi))"
        dayView.cloudsStack.valueLabel.text = "\(cell.dailyForecast!.clouds)"
    }
}
