import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    let timeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 12)
        view.textColor = UIColor(red: 0.613, green: 0.592, blue: 0.592, alpha: 1)
        return view
    }()
    
    let descriptionImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tempLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? UIColor(named: "blue") : .white
            self.timeLabel.textColor = isSelected ? .white : .gray
            self.tempLabel.textColor = isSelected ? .white : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
//        self.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.layer.cornerRadius = 22
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor(red: 0.671, green: 0.737, blue: 0.918, alpha: 1).cgColor
        self.isUserInteractionEnabled = false
        
        [timeLabel, descriptionImageView, tempLabel].forEach(contentView.addSubview(_:))
        
        [timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
         
         descriptionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         descriptionImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
         descriptionImageView.widthAnchor.constraint(equalToConstant: 20),
         descriptionImageView.heightAnchor.constraint(equalToConstant: 20),
         
         tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         tempLabel.topAnchor.constraint(equalTo: descriptionImageView.bottomAnchor, constant: 7)
        ].forEach {$0.isActive = true}
    }
}
