import UIKit
import Charts

class HourTableHeaderView: UIView {
    
    var dates: [Double]?

    lazy var HourTempAndHumidityChartView: LineChartView = {
        let view = LineChartView()
        view.leftAxis.drawGridLinesEnabled = false
        view.rightAxis.drawGridLinesEnabled = false
        view.drawGridBackgroundEnabled = false
        view.leftAxis.drawLabelsEnabled = false
        view.rightAxis.drawLabelsEnabled = false
        view.xAxis.labelPosition = .bottom
        view.xAxis.drawAxisLineEnabled = false
        view.doubleTapToZoomEnabled = false
        view.leftAxis.enabled = false
        view.rightAxis.enabled = false
        view.drawBordersEnabled = false
        view.xAxis.granularity = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.xAxis.valueFormatter = xformatter
        view.backgroundColor = UIColor(named: "lightBlue")
        return view
    }()
    
    var xformatter: IAxisValueFormatter?
    var yFormatter: IValueFormatter?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xformatter = self
        yFormatter = self
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dataSets(dateValues: [Double], tempValues: [Double], humidituValues: [Double]){
        self.dates = dateValues
        var data: [ChartDataEntry] = []
        var data2: [ChartDataEntry] = []
        for (index, _) in dateValues.enumerated() {
            let entry = ChartDataEntry(x: Double(index), y: Double(tempValues[index]))

            let enty1 = ChartDataEntry(x: Double(index), y: Double(humidituValues[index]))
            data.append(entry)
            data2.append(enty1)
        }
        
        lazy var dataSet: LineChartDataSet = {
            let dataSet = LineChartDataSet(entries: data,label: "Температура °")
            dataSet.colors = [NSUIColor.orange]
            dataSet.circleColors = [.white]
            dataSet.circleRadius = 4
            dataSet.valueFont = UIFont(name: "Rubik-Regular", size: 14)!
            dataSet.valueFormatter = yFormatter
            return dataSet
        }()
        
        lazy var humidityDataSet: LineChartDataSet = {
            let dataSet1 = LineChartDataSet(entries: data2, label: "Влажность %")
            dataSet1.colors = [.blue]
            dataSet1.circleColors = [.white]
            dataSet1.circleRadius = 4
            dataSet1.valueFont =  UIFont(name: "Rubik-Regular", size: 14)!
            dataSet1.valueFormatter = yFormatter
            return dataSet1
        }()
        
        lazy var chartData = LineChartData(dataSets: [dataSet, humidityDataSet])
        
        HourTempAndHumidityChartView.data = chartData
        HourTempAndHumidityChartView.setVisibleXRangeMaximum(5)
    }
    
    func setupViews() {
        self.addSubview(HourTempAndHumidityChartView)
        
        [HourTempAndHumidityChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         HourTempAndHumidityChartView.topAnchor.constraint(equalTo: self.topAnchor),
         HourTempAndHumidityChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         HourTempAndHumidityChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
         
         self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ].forEach({$0.isActive = true})
    }

}

extension HourTableHeaderView: IAxisValueFormatter, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(describing: Int(value))
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        return Int32(dates![index]).toTime()
    }
    
    
}
    
