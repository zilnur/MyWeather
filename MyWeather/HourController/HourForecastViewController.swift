import UIKit
import Charts

class HourForecastViewController: UIViewController {
    
    let presenter: HourlyPresenterOutput
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(HourlyTempChangeTableViewCell.self, forCellReuseIdentifier: "cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        view.separatorColor = .blue
        return view
    }()
    
    lazy var backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(" ⃪  Прогноз на 24 часа", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.addTarget(self, action: #selector(tapLeftBtn), for: .touchUpInside)
        return view
    }()
    
    lazy var leftButton: UIBarButtonItem = {
       let view = UIBarButtonItem(customView: backButton)
        return view
    }()
    
    init(presenter: HourlyPresenterOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tableView.reloadData()
    }
    
    @objc func tapLeftBtn() {
        presenter.goBack()
    }
}

extension HourForecastViewController {
    func setupViews() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        [tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}

extension HourForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.setNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HourlyTempChangeTableViewCell
        presenter.buildDataForTable(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HourTableHeaderView()
        view.dataSets(dateValues: presenter.setChartData().dtArray, tempValues: presenter.setChartData().tempArray, humidituValues: presenter.setChartData().humidityArray)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        223
    }
}
