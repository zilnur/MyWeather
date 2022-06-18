import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainModulePresenterOutput?
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .null, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.register(HourlyWeatherTableViewCell.self, forCellReuseIdentifier: "cell")
        view.register(CurrentWeatherTableViewCell.self, forCellReuseIdentifier: "cell1")
        view.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: "cell2")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        setupViews()
    }
}

extension MainViewController {
    func setupViews() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        [tableView].forEach(view.addSubview(_:))
        
         [tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach {$0.isActive = true}
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? CurrentWeatherTableViewCell
        cell1?.setUpViewsValues(data: (presenter?.buildCurrentForecastData())!)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HourlyWeatherTableViewCell
        cell?.hourlyForecasts = presenter?.buildHourlyForecastsData()
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as? DailyForecastTableViewCell
        cell2?.dailies = presenter?.buildDailyForecastsData()
        cell2?.onVC = { item in
            let dailyVC = DailyForecastViewController()
//            dailyVC.dailyForecasts = cell2?.dailies
            dailyVC.item = item
            self.navigationController?.pushViewController(dailyVC, animated: true)
        }
        
        switch indexPath.section {
        case 0:
            return cell1 ?? UITableViewCell()
        case 1:
            return cell ?? UITableViewCell()
        case 2:
            return cell2 ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
//            let descriptor = NSSortDescriptor(key: "dt", ascending: true)
//            let hourVC = HourForecastViewController(hourlyForecast: city.hour?.sortedArray(using: [descriptor]) as! [HourForecast],city: city.name!)
            self.navigationController?.pushViewController(presenter!.toHourController(), animated: true)
        default:
            break
        }
    }
}
