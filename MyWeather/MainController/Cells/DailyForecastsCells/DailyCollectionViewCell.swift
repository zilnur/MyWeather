import UIKit

struct DailyForecastData {
    let date: Int32
    let humidity: Int16
    let description: String
    let minTemp: Double
    let maxTemp: Double
}

class DailyCollectionViewCell: UICollectionViewCell {
    
//    var daily: DailyForecast? {
//        didSet {
//            dateLabel.text = daily!.dt.toShotDate()
//            label.text = "\(String(describing: daily!.humidity))%"
//            descreiptionLabel.text = daily!.weatherDescription?.withFirstUppercase()
//            minMaxTempLabel.text = "\(Int(daily!.temp!.min))°/\(Int(daily!.temp!.max))°"
//        }
//    }
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "sun"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.font = UIFont(name: "Rubik-Regular", size: 12)
        return view
    }()
    
    let descreiptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    let minMaxTempLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor(named: "lightBlue")
        contentView.layer.cornerRadius = 5
        [dateLabel, imageView, label, descreiptionLabel, minMaxTempLabel].forEach(contentView.addSubview(_:))
        
        [dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
         dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
         
         imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
         imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
         imageView.widthAnchor.constraint(equalToConstant: 15),
         imageView.heightAnchor.constraint(equalToConstant: 17),
         
         label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
         label.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
         
         descreiptionLabel.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 13),
         descreiptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
         descreiptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -19),
         
         minMaxTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
         minMaxTempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26)
        ].forEach {$0.isActive = true}
    }
    
    func setViewsValues(data: DailyForecastData) {
        dateLabel.text = data.date.toShotDate()
        label.text = "\(String(describing: data.humidity))%"
        descreiptionLabel.text = data.description.withFirstUppercase()
        minMaxTempLabel.text = "\(Int(data.minTemp))°/\(Int(data.maxTemp))°"
    }
}
