import UIKit

class DailyDatesCollectionViewCell: UICollectionViewCell {
    
    var dailyForecast: DailyForecast? {
        didSet {
            self.dateLabel.text = dailyForecast!.dt.toShotDate()
        }
    }
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? UIColor(named: "blue") : .white
            self.dateLabel.textColor = isSelected ? .white : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(dateLabel)
        contentView.layer.cornerRadius = 5
        
        [dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ].forEach {$0.isActive = true}
    }
}
