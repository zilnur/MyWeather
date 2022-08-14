//
//  HourHeaderCollectionViewCell.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 31.07.2022.
//

import UIKit

class HourHeaderCollectionViewCell: UICollectionViewCell {
    
    var nextTimeTemp: Int?
    
    var isFirstCell: Bool = false
    var isLastCell: Bool = false
    
    let temperatureLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let temperatureDot: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle.fill")
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let weatherIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "09d"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let humidityLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(named: "MyBlack")
        view.font = UIFont(name: "Rubik-Regular", size: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeDot: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeLabel: UILabel = {
        let view = UILabel()
//        label.textColor = UIColor(named: "MyBlack")
        view.font = UIFont(name: "Rubik-Regular", size: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let temperatureContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        if !isLastCell {
            drawGradient()
            drawLine()
        }
        drawDashedLines()
    }
    
    func putDotOfTemperature(minTemperature: Double, maxTemperature: Double, temp: Double) {
        temperatureContentView.addSubview(temperatureDot)
        temperatureContentView.addSubview(temperatureLabel)
        
        let differenceBitweenMaxAndMinTemp = maxTemperature - minTemperature
        let pointsPerDegree = 20 / differenceBitweenMaxAndMinTemp
        let currentTemperatureOffset = Int((maxTemperature - temp) * pointsPerDegree)
        
        [temperatureDot.leadingAnchor.constraint(equalTo: temperatureContentView.leadingAnchor),
         temperatureDot.topAnchor.constraint(equalTo: temperatureContentView.topAnchor, constant: CGFloat(currentTemperatureOffset)),
         temperatureDot.heightAnchor.constraint(equalToConstant: 4),
         temperatureDot.widthAnchor.constraint(equalToConstant: 4),
         
         temperatureLabel.bottomAnchor.constraint(equalTo: temperatureDot.topAnchor, constant: -2),
         temperatureLabel.leadingAnchor.constraint(equalTo: temperatureContentView.leadingAnchor)
        ].forEach({$0.isActive = true})
    }
    
    private func setupViews() {
        contentView.addSubview(temperatureContentView)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(timeDot)
        contentView.addSubview(timeLine)
        contentView.addSubview(timeLabel)
        [
            temperatureContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            temperatureContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            temperatureContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            temperatureContentView.heightAnchor.constraint(equalToConstant: 25),
            
            weatherIcon.topAnchor.constraint(equalTo: temperatureContentView.bottomAnchor, constant: 14),
            weatherIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherIcon.heightAnchor.constraint(equalToConstant: 16),
            weatherIcon.widthAnchor.constraint(equalToConstant: 16),
            
            humidityLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 4),
            humidityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            timeDot.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 9),
            timeDot.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeDot.heightAnchor.constraint(equalToConstant: 8),
            timeDot.widthAnchor.constraint(equalToConstant: 4),
            
            timeLine.centerYAnchor.constraint(equalTo: timeDot.centerYAnchor),
            timeLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            timeLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            timeLabel.topAnchor.constraint(equalTo: timeDot.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ]
        .forEach {$0.isActive = true}
    }
    
    public func drawDashedLines() {
        if isFirstCell {
            addDashedLine(begin: CGPoint(x: temperatureContentView.frame.minX,
                                         y: temperatureContentView.frame.minY),
                          end: CGPoint(x: temperatureContentView.frame.minX,
                                       y: temperatureContentView.frame.maxY))
        }
        addDashedLine(begin: CGPoint(x: temperatureContentView.frame.minX,
                                     y: temperatureContentView.frame.maxY),
                      end: CGPoint(x: temperatureContentView.frame.maxX,
                                   y: temperatureContentView.frame.maxY))
    }
    
    private func addDashedLine(begin: CGPoint, end: CGPoint) {
        let lineDashPattern: [NSNumber]  = [3,3]
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor
        shapeLayer.lineWidth = 0.3
        shapeLayer.lineDashPattern = lineDashPattern
        
        let path = CGMutablePath()
        path.addLines(between: [begin, end])
        
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawLine() {
        let path = UIBezierPath()
        let start = CGPoint(x: temperatureDot.frame.maxX, y: 31 + temperatureDot.frame.midY)
        let end = CGPoint(x: 51, y: 33 + CGFloat(nextTimeTemp!))
        print(end)
        path.move(to: start)
        path.addLine(to: end)
        let color = UIColor.blue
        color.setStroke()
        path.lineWidth = 0.3
        path.stroke()
    }
    
    func drawGradient() {
        let path = UIBezierPath()
        let end = CGPoint(x: 51, y: 33 + CGFloat(nextTimeTemp!))
        path.move(to: CGPoint(x: temperatureContentView.frame.minX,
                              y: temperatureContentView.frame.maxY))
        path.addLine(to: CGPoint(x: temperatureDot.frame.minX,
                                 y: temperatureDot.frame.midY + 31))
        path.addLine(to: end)
        path.addLine(to: CGPoint(x: temperatureContentView.frame.maxX,
                                 y: temperatureContentView.frame.maxY))
        
        let gradient = CGGradient(colorsSpace: nil, colors: [UIColor(named: "gradient")!.cgColor, UIColor.white.cgColor] as CFArray, locations: nil)!

        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()

        path.addClip()
        ctx.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: frame.height / 2), options: [])

        ctx.restoreGState()
    }
    
}
