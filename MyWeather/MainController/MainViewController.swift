import UIKit

class MainViewController: UIViewController, MainModulePresenterInput {
    
    var presenter: MainModulePresenterOutput?
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .null, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.register(HourlyWeatherTableViewCell.self, forCellReuseIdentifier: "cell")
        view.register(CurrentWeatherTableViewCell.self, forCellReuseIdentifier: "cell1")
        view.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: "cell2")
        return view
    }()
    
    var hourlyTableViewCell: HourlyWeatherTableViewCell?
    var dailyForecastTableViewCell: DailyForecastTableViewCell?
    
    init(presenter: MainModulePresenterOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.updateForecast()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()
        }
    }
}

extension MainViewController {
    func setupViews() {
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
        presenter?.buildCurrentForecastData(cell: cell1!, indexPath: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HourlyWeatherTableViewCell
        hourlyTableViewCell = cell
        cell?.hourlyColletctionView.dataSource = self
        cell?.hourlyColletctionView.delegate = self
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as? DailyForecastTableViewCell
        dailyForecastTableViewCell = cell2
        cell2?.dailyForecastCollectionView.dataSource = self
        cell2?.dailyForecastCollectionView.delegate = self
        
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
//            self.navigationController?.pushViewController(presenter!.toHourController(), animated: true)
            presenter?.toHourController()
        default:
            break
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.hourlyTableViewCell?.hourlyColletctionView {
            return 24
        }
        if collectionView == self.dailyForecastTableViewCell?.dailyForecastCollectionView {
            return presenter?.setNumbersOfDailyCells() ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case dailyForecastTableViewCell?.dailyForecastCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell4", for: indexPath) as! DailyCollectionViewCell
            presenter?.buildDailyForecastsData(cell: cell, indexPath: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell4", for: indexPath) as! HourlyCollectionViewCell
            presenter?.buildHourlyForecastsData(cell: cell, indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case dailyForecastTableViewCell?.dailyForecastCollectionView:
            return CGSize(width: dailyForecastTableViewCell!.contentView.frame.width, height: 56)
        default:
            return CGSize(width: 44, height: 83)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case hourlyTableViewCell?.hourlyColletctionView:
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        default:
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case dailyForecastTableViewCell?.dailyForecastCollectionView:
            presenter?.toDailyController(indexPath: indexPath)
        default:
            break
        }
    }
}
