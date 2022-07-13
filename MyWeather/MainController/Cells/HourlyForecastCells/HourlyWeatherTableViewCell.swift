import UIKit

class HourlyWeatherTableViewCell: UITableViewCell {
    
    let moreDetailetLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        view.attributedText = NSMutableAttributedString(string: "Подробнее на 24 часа", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: 0.16])
        return view
    }()
    
    let hourlyColletctionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell4")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        hourlyColletctionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        selectionStyle = .none
        [moreDetailetLabel, hourlyColletctionView].forEach(contentView.addSubview(_:))
        
        [moreDetailetLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
         moreDetailetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         moreDetailetLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -103),
         
         hourlyColletctionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         hourlyColletctionView.topAnchor.constraint(equalTo: moreDetailetLabel.bottomAnchor, constant: 10),
         hourlyColletctionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         hourlyColletctionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}
