//
//  DiagramCell.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 2/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit
import Charts
import CoreData

class DiagramCell: BaseCell {
    
    var people = [Person]()
    
    let segmentOfCharts:UISegmentedControl = {
        let sm = UISegmentedControl (items: ["One","Two"])
        sm.selectedSegmentIndex = 0
        sm.setImage(UIImage(named: "lineChart"), forSegmentAt: 0)
        sm.setImage(UIImage(named: "barChart"), forSegmentAt: 1)
        sm.tintColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return sm
    }()
    
    let charViews: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        v.layer.cornerRadius = 8.0
        v.clipsToBounds = true
        return v
    }()
    
    let viewForChart:LineChartView = {
        let chart = LineChartView()
        return chart
    }()
    
    let viewForChartCandle:BarChartView = {
//        let v = UIView()
//        v.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//        v.isHidden = true
//        return v
        
        let chart = BarChartView()
        chart.isHidden = true
        return chart
    }()
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var months: [String] = []
    var unitsSold = [Double]()
    weak var axisFormatDelegate: IAxisValueFormatter?
    var topLabelStackView: UIStackView!
    var secondLabelStackView: UIStackView!
    var timeStartStackView: UIStackView!
    var numberOfDaysStackView: UIStackView!
    
    
    var startKgTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Initial weight"
        lb.font = lb.font.withSize(15.0)
        lb.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return lb
    }()
    
    var startKgLabel: UILabel = {
        let lb = UILabel()
        lb.text = "66.0 Kg"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return lb
    }()
    
    var currentKgTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Current weight"
        lb.font = lb.font.withSize(15.0)
        lb.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return lb
    }()
    
    var currentKgLabel: UILabel = {
        let lb = UILabel()
        lb.text = "64.0 Kg"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return lb
    }()
    
    var timeStartTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Start day"
        lb.font = lb.font.withSize(15.0)
        lb.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return lb
    }()
    
    var timeStartLabel: UILabel = {
        let lb = UILabel()
        lb.text = "1/1/2019"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return lb
    }()

    var totalDaysTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Total days"
        lb.font = lb.font.withSize(15.0)
        lb.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return lb
    }()
    
    var totalDaysLabel: UILabel = {
        let lb = UILabel()
        lb.text = "62"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return lb
    }()

    
    var lineView:UIView = {
        var v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return v
    }()
    
    override func setUpView() {
        super.setUpView()
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setupTopLabels()
        setupSecondLabels()
        
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: secondLabelStackView.bottomAnchor, constant: 5.0).isActive = true
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        setupStartTime()
        setupNumberOfDays()
        
        
        setChartViews()
        setSegment()

        let request : NSFetchRequest<Person> = Person.fetchRequest()
        do {
            try people = context.fetch(request)
        } catch  {
            print("Error to fetch Item data")
        }
        
        
        

        if  people.count >= 1 {
            var sumOfDays = 0
            var embedDateForCountInSumOfDay = ""
            print(people[people.count-1].weight)
            for i in 0..<people.count {
                let subString = people[i].date?.prefix(5)
                months.append(String(subString ?? ""))
                unitsSold.append(Double(people[i].weight))
                if(embedDateForCountInSumOfDay != people[i].date) {
                    sumOfDays += 1
                    embedDateForCountInSumOfDay = people[i].date!
                    
                }
            }
            let startKg = round(unitsSold[0] * 100)/100
            let currentKg  = round(unitsSold.last! * 100)/100
            startKgLabel.text = String(startKg) + " Kg"
            currentKgLabel.text = String(currentKg) + " Kg"
            timeStartLabel.text = people[0].date
            // sum of days
           
            totalDaysLabel.text = String(sumOfDays)
            setChartCandle(dataEntryX: months, dataEntryY: unitsSold)
            setChart(dataEntryX: months, dataEntryY: unitsSold)
            
        }else {
            startKgLabel.text = "No record"
            currentKgLabel.text = "No record"
            timeStartLabel.text = "No record"
            totalDaysLabel.text = "0"
        }

        
    }
    
    
    func setChartViews() {
        addSubview(charViews)
        charViews.translatesAutoresizingMaskIntoConstraints = false
        charViews.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        charViews.topAnchor.constraint(equalTo: numberOfDaysStackView.bottomAnchor, constant: 8.0).isActive = true
        charViews.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        charViews.widthAnchor.constraint(equalToConstant: self.frame.width - 10.0).isActive = true
    }
    
    func setSegment() {
        addSubview(segmentOfCharts)
        segmentOfCharts.translatesAutoresizingMaskIntoConstraints = false
        segmentOfCharts.centerXAnchor.constraint(equalTo: charViews.centerXAnchor).isActive = true
        segmentOfCharts.topAnchor.constraint(equalTo: charViews.topAnchor, constant: 10.0).isActive = true
        segmentOfCharts.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        segmentOfCharts.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        
         segmentOfCharts.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)

    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        if sender.selectedSegmentIndex == 0 {
            viewForChart.isHidden = false
            viewForChartCandle.isHidden = true
        }else {
            viewForChart.isHidden = true
            viewForChartCandle.isHidden = false
        }
    }
    
    func setChartCandle(dataEntryX forX:[String],dataEntryY forY: [Double]) {
        addSubview(viewForChartCandle)
        viewForChartCandle.translatesAutoresizingMaskIntoConstraints = false
        viewForChartCandle.centerXAnchor.constraint(equalTo: charViews.centerXAnchor).isActive = true
        viewForChartCandle.topAnchor.constraint(equalTo: segmentOfCharts.bottomAnchor, constant: 0.0).isActive = true
        viewForChartCandle.bottomAnchor.constraint(equalTo: charViews.bottomAnchor, constant: -16.0).isActive = true
        viewForChartCandle.widthAnchor.constraint(equalToConstant: self.frame.width - 0.0).isActive = true
        
        layoutIfNeeded()
        updateConstraintsIfNeeded()
        
       
        axisFormatDelegate = self
        viewForChartCandle.noDataText = "You need to provide data for the chart."
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<forX.count{
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(forY[i]) , data: months as AnyObject?)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Weight")
        chartDataSet.colors = [#colorLiteral(red: 0.7289724051, green: 0.6552841139, blue: 1, alpha: 1)]
        let chartData = BarChartData(dataSet: chartDataSet)
        viewForChartCandle.data = chartData
        viewForChartCandle.setVisibleXRangeMaximum(10)
        viewForChartCandle.autoScaleMinMaxEnabled = true
        viewForChartCandle.moveViewToX(Double(months.count))
        let xAxisValue = viewForChartCandle.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        viewForChartCandle.reloadInputViews()
        
    }

    
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Double]) {
        addSubview(viewForChart)
        viewForChart.translatesAutoresizingMaskIntoConstraints = false
        viewForChart.centerXAnchor.constraint(equalTo: charViews.centerXAnchor).isActive = true
        viewForChart.topAnchor.constraint(equalTo: segmentOfCharts.bottomAnchor, constant: 0.0).isActive = true
        viewForChart.bottomAnchor.constraint(equalTo: charViews.bottomAnchor, constant: -16.0).isActive = true
        viewForChart.widthAnchor.constraint(equalToConstant: self.frame.width - 0.0).isActive = true
        
        layoutIfNeeded()
        updateConstraintsIfNeeded()
        
        axisFormatDelegate = self
        viewForChart.noDataText = "You need to provide data for the chart."
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<forX.count{
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(forY[i]) , data: months as AnyObject?)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Weight")
        chartDataSet.colors = [#colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)]
        let chartData = LineChartData(dataSet: chartDataSet)
        viewForChart.data = chartData
        viewForChart.setVisibleXRangeMaximum(5)
        viewForChart.autoScaleMinMaxEnabled = true
        viewForChart.moveViewToX(Double(months.count))
        let xAxisValue = viewForChart.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        viewForChart.reloadInputViews()
        
    }

    fileprivate func setupTopLabels() {
        let startKgTitleLabelView = UIView()
        
        let startKgLabelView = UIView()
        
        topLabelStackView = UIStackView(arrangedSubviews: [startKgTitleLabelView,startKgLabelView])
        topLabelStackView.axis = .horizontal
        topLabelStackView.distribution = .fillEqually
        
        addSubview(topLabelStackView)
        topLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        topLabelStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0).isActive = true
        topLabelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        topLabelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        topLabelStackView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        addSubview(startKgTitleLabel)
        startKgTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        startKgTitleLabel.topAnchor.constraint(equalTo: topLabelStackView.topAnchor, constant: 3.0).isActive = true
        startKgTitleLabel.leadingAnchor.constraint(equalTo: topLabelStackView.leadingAnchor, constant: 0.0).isActive = true
        
        addSubview(startKgLabel)
        startKgLabel.translatesAutoresizingMaskIntoConstraints = false
        startKgLabel.topAnchor.constraint(equalTo: startKgLabelView.topAnchor, constant: 3.0).isActive = true
        startKgLabel.trailingAnchor.constraint(equalTo: startKgLabelView.trailingAnchor, constant: -30).isActive = true
    }
    
    fileprivate func setupSecondLabels() {
        let currentKgTitleLabelView = UIView()
        
        let currentKgLabelView = UIView()
        
        secondLabelStackView = UIStackView(arrangedSubviews: [currentKgTitleLabelView,currentKgLabelView])
        secondLabelStackView.axis = .horizontal
        secondLabelStackView.distribution = .fillEqually
        
        addSubview(secondLabelStackView)
        secondLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        secondLabelStackView.topAnchor.constraint(equalTo: topLabelStackView.bottomAnchor, constant: 3.0).isActive = true
        secondLabelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        secondLabelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        secondLabelStackView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        addSubview(currentKgTitleLabel)
        currentKgTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        currentKgTitleLabel.topAnchor.constraint(equalTo: currentKgTitleLabelView.topAnchor, constant: 0.0).isActive = true
        currentKgTitleLabel.leadingAnchor.constraint(equalTo: currentKgTitleLabelView.leadingAnchor, constant: 0.0).isActive = true
        
        addSubview(currentKgLabel)
        currentKgLabel.translatesAutoresizingMaskIntoConstraints = false
        currentKgLabel.topAnchor.constraint(equalTo: currentKgLabelView.topAnchor, constant: 0.0).isActive = true
        currentKgLabel.trailingAnchor.constraint(equalTo: currentKgLabelView.trailingAnchor, constant: -30).isActive = true
       
    }
    
    fileprivate func setupStartTime() {
        let timeStartTitleLabelView = UIView()
        let timeStartLabelView = UIView()
        
        timeStartStackView = UIStackView(arrangedSubviews: [timeStartTitleLabelView,timeStartLabelView])
        timeStartStackView.axis = .horizontal
        timeStartStackView.distribution = .fillEqually
        
        addSubview(timeStartStackView)
        timeStartStackView.translatesAutoresizingMaskIntoConstraints = false
        timeStartStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 6.0).isActive = true
        timeStartStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        timeStartStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        timeStartStackView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        addSubview(timeStartTitleLabel)
        timeStartTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeStartTitleLabel.topAnchor.constraint(equalTo: timeStartStackView.topAnchor, constant: 3.0).isActive = true
        timeStartTitleLabel.leadingAnchor.constraint(equalTo: timeStartStackView.leadingAnchor, constant: 0.0).isActive = true


        addSubview(timeStartLabel)
        timeStartLabel.translatesAutoresizingMaskIntoConstraints = false
        timeStartLabel.topAnchor.constraint(equalTo: timeStartLabelView.topAnchor, constant: 3.0).isActive = true
        timeStartLabel.trailingAnchor.constraint(equalTo: timeStartLabelView.trailingAnchor, constant: -30).isActive = true
    }
    
    fileprivate func setupNumberOfDays() {
        let numberOfDaysTitleLabelView = UIView()
        let numberOfDaysLabelView = UIView()
 
        numberOfDaysStackView = UIStackView(arrangedSubviews: [numberOfDaysTitleLabelView,numberOfDaysLabelView])
        numberOfDaysStackView.axis = .horizontal
        numberOfDaysStackView.distribution = .fillEqually
        
        addSubview(numberOfDaysStackView)
        numberOfDaysStackView.translatesAutoresizingMaskIntoConstraints = false
        numberOfDaysStackView.topAnchor.constraint(equalTo: timeStartStackView.bottomAnchor, constant: 3.0).isActive = true
        numberOfDaysStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        numberOfDaysStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        numberOfDaysStackView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        addSubview(totalDaysTitleLabel)
        totalDaysTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        totalDaysTitleLabel.topAnchor.constraint(equalTo: numberOfDaysStackView.topAnchor, constant: 3.0).isActive = true
        totalDaysTitleLabel.leadingAnchor.constraint(equalTo: numberOfDaysStackView.leadingAnchor, constant: 0.0).isActive = true


        addSubview(totalDaysLabel)
        totalDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        totalDaysLabel.topAnchor.constraint(equalTo: numberOfDaysStackView.topAnchor, constant: 3.0).isActive = true
        totalDaysLabel.trailingAnchor.constraint(equalTo: numberOfDaysStackView.trailingAnchor, constant: -30).isActive = true
    }
    
}
extension DiagramCell: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value) % months.count]
    }
}
