//
//  TemperatureContentView.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 12.08.2022.
//

import UIKit

class TemperatureContentView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "lightBlue")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        draw()
    }
    
    func draw() {
        let path = UIBezierPath()
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: 50, y: 50)
        path.move(to: start)
        path.addLine(to: end)
        let color = UIColor.red
        color.setStroke()
        path.lineWidth = 1
        path.stroke()
    }

}
