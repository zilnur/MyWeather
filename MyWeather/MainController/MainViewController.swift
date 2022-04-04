//
//  MainViewController.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 30.03.2022.
//

import UIKit

class MainViewController: UIViewController {
//
//    private let pageControl: UIPageControl = {
//        let view = UIPageControl()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.currentPageIndicatorTintColor = .black
//        view.tintColor = .systemIndigo
//        view.numberOfPages = 3
//        view.pageIndicatorTintColor = .lightGray
//        return view
//    }()
    
    let index: Int
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .null, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}

extension MainViewController {
    func setupViews() {
        
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        [tableView].forEach(view.addSubview(_:))
        
//        [pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19),
//         pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         
         [tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        9
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = String(self.index)
        return cell
    }
    
}

