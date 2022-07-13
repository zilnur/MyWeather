import UIKit

class DailyForecastTableViewCell: UITableViewCell {

    let dailyLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Ежедневный прогноз"
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        return view
    }()
    
    let daisLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedText = NSMutableAttributedString(string: "7 дней", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: 0.16])
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    let dailyForecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(DailyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell4")
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = .white
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [dailyLabel, daisLabel, dailyForecastCollectionView].forEach(contentView.addSubview(_:))
        
        [dailyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         dailyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
         
         daisLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
         daisLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         daisLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -538),
         
         dailyForecastCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         dailyForecastCollectionView.topAnchor.constraint(equalTo: daisLabel.bottomAnchor),
         dailyForecastCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         dailyForecastCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}
