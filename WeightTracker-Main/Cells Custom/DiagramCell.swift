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
    var sevenPeople = [Person]()
    var thirdtyPeople = [Person]()
    var weightUnit = ""
    var desiredWeight:Double = -1
    var targetWeight = [Double]()
     let filterPeople = [Person]()
    
    let segmentOfCharts:UISegmentedControl = {
        let sm = UISegmentedControl (items: ["One","Two","Three"])
        sm.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        sm.selectedSegmentIndex = 2
        sm.setTitle("7 days", forSegmentAt: 0)
        sm.setTitle("30 days", forSegmentAt: 1)
        sm.setTitle("All time", forSegmentAt: 2)
        sm.tintColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return sm
    }()
    
    
    let charViews: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.7513060775)

        v.clipsToBounds = true
        return v
    }()
    
    let viewForChart:LineChartView = {
        let chart = LineChartView()
        return chart
    }()
    
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var months: [String] = []
    var unitsSold = [Double]()
    weak var axisFormatDelegate: IAxisValueFormatter?
    var weightChangeStackView: UIStackView!
    var topLabelStackView: UIStackView!
    var secondLabelStackView: UIStackView!
    var change7DaysStackView: UIStackView!
    var change30DaysStackView: UIStackView!
    var timeStartStackView: UIStackView!
    var numberOfDaysStackView: UIStackView!
    
    
    var aboveView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.2996668904)
        v.clipsToBounds = true
        return v
    }()
    
    var aboveTiltleView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5481810775)
        return v
    }()
    
    var aboveTiltleViewLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Summary"
        lb.font = UIFont(name:"TrebuchetMS", size: 25)
        lb.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        return lb
    }()
    
    var startKgTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Initial weight"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return lb
    }()
    
    var startKgLabel: UILabel = {
        let lb = UILabel()
        lb.text = "66.0 Kg"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return lb
    }()
    
    var changeKgTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "All time"
        lb.font = lb.font.withSize(13.0)
        lb.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return lb
    }()
    
    var changeKgLabel: UILabel = {
        let lb = UILabel()
        lb.text = "-3.0"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return lb
    }()
    
    var change7DayTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "In 7 days"
        lb.font = lb.font.withSize(13.0)
        lb.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return lb
    }()
    
    var change7DayLabel: UILabel = {
        let lb = UILabel()
        lb.text = "-3.0"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return lb
    }()
    
    var change30DayTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "In 30 days"
        lb.font = lb.font.withSize(13.0)
        lb.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return lb
    }()
    
    var change30DayLabel: UILabel = {
        let lb = UILabel()
        lb.text = "-3.0"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return lb
    }()
    
    let titleWeightTrendsView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
        v.clipsToBounds = true
        return v
    }()
    
    let weightTrendLineView1:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5527583397)
        v.layer.cornerRadius = 1
        v.clipsToBounds = true
        return v
    }()
    let weightTrendLineView2:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5527583397)
         v.layer.cornerRadius = 1
        v.clipsToBounds = true
        return v
    }()
    
    var weightTrendsLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Weight changes"
        lb.font = lb.font.withSize(18.0)
        lb.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return lb
    }()
    
    var timeStartTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Start day"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return lb
    }()
    
    var timeStartLabel: UILabel = {
        let lb = UILabel()
        lb.text = "1/1/2019"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return lb
    }()

    var totalDaysTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Total days"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return lb
    }()
    
    var totalDaysLabel: UILabel = {
        let lb = UILabel()
        lb.text = "62"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return lb
    }()

    
    var lineView:UIView = {
        var v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.2996668904)
        v.clipsToBounds = true
       
        return v
    }()
    
    override func setUpView() {
        super.setUpView()
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // add image to Detail View
        let backgroundImage = UIImage(named: "toolCellBackground")
        let backgroundView = UIImageView(image: backgroundImage)
        backgroundView.contentMode = .scaleToFill
        
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        self.addSubview(aboveView)
        aboveView.translatesAutoresizingMaskIntoConstraints = false
        aboveView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        aboveView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        aboveView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        aboveView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        aboveView.addSubview(aboveTiltleView)
        aboveTiltleView.translatesAutoresizingMaskIntoConstraints = false
        aboveTiltleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        aboveTiltleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        aboveTiltleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        aboveTiltleView.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        aboveView.addSubview(aboveTiltleViewLabel)
        aboveTiltleViewLabel.translatesAutoresizingMaskIntoConstraints = false
        aboveTiltleViewLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        aboveTiltleViewLabel.leadingAnchor.constraint(equalTo: aboveView.leadingAnchor, constant: 8).isActive = true
        
        setupStartDay()
        setupInitialWeight()
        
        setupTotalDay()
        
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: totalDaysLabel.bottomAnchor, constant: 5.0).isActive = true
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        

        
        setupWeightTrends()
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
                if(embedDateForCountInSumOfDay != people[i].date) {
                    sumOfDays += 1
                    embedDateForCountInSumOfDay = people[i].date!
                }
            }
            let startKg = round(people[0].weight * 100)/100
            let change  = round(((people.last?.weight)! - people.first!.weight) * 100)/100
            startKgLabel.text = "\(String(startKg)) \(weightUnit)"
            changeKgLabel.text = "\(String(change))"
            timeStartLabel.text = people[0].date
            // sum of days
            
            totalDaysLabel.text = String(sumOfDays)
            setWeight7TrendValue(dates: get7and30DayBefore())
            setWeight30TrendValue(dates: get7and30DayBefore())
            
        }else {
            startKgLabel.text = "No record"
            changeKgLabel.text = "_"
            change7DayLabel.text = "_"
            change30DayLabel.text = "_"
            timeStartLabel.text = "No record"
            totalDaysLabel.text = "0"
        }
        addSubview(viewForChart)
        viewForChart.translatesAutoresizingMaskIntoConstraints = false
        viewForChart.centerXAnchor.constraint(equalTo: charViews.centerXAnchor).isActive = true
        viewForChart.topAnchor.constraint(equalTo: segmentOfCharts.bottomAnchor, constant: 8.0).isActive = true
        viewForChart.bottomAnchor.constraint(equalTo: charViews.bottomAnchor, constant: -8.0).isActive = true
        viewForChart.widthAnchor.constraint(equalToConstant: self.frame.width - 18.0).isActive = true
        
        startDrawValue(subPeople: people)
    }
    
    func startDrawValue(subPeople: [Person]) {
        months = []
        unitsSold = []
        if  subPeople.count >= 1 {
            print(subPeople[subPeople.count-1].weight)
            for i in 0..<subPeople.count {
                let subString = subPeople[i].date?.prefix(5)
                months.append(String(subString ?? ""))
                unitsSold.append(Double(subPeople[i].weight))
            }
            setChart(dataEntryX: months, dataEntryY: unitsSold)
        
        }
    }
    
    //MARK: - Set Weight change (coding)
    
    func setWeight7TrendValue(dates:[Int]) {
        print(people.count)
        var indexOfSevenDay = people.count - 1
        for i in people.reversed() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let date = dateFormatter.date(from: i.date!)
            dateFormatter.dateFormat = "yyyyMMdd"
            let dateInFormat = dateFormatter.string(from: date!)
            if let dateForUseToCompare = Int(dateInFormat){
               
                if dateForUseToCompare < dates[0] {
                    indexOfSevenDay += 1
                    if indexOfSevenDay < people.count {
                        let sevenWeight =  round((people.last!.weight - people[indexOfSevenDay].weight) * 100)/100
                        change7DayLabel.text = "\(sevenWeight)"
                        sevenPeople = []
                        let sp = people[indexOfSevenDay...(people.count-1)]
                        sevenPeople = Array(sp)
                        
                    }else {
                        change7DayLabel.text = "_"
                        sevenPeople = []
                    }
                    
                    return
                }
                indexOfSevenDay -= 1
            }
        }
        let sevenWeight = round((people.last!.weight - people[0].weight) * 100)/100
        sevenPeople = []
        sevenPeople = people
        change7DayLabel.text = "\(sevenWeight)"
    }
    
    func setWeight30TrendValue(dates:[Int]) {
        print(people.count)
        var indexOfThirtyDay = people.count - 1
        for i in people.reversed() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let date = dateFormatter.date(from: i.date!)
            dateFormatter.dateFormat = "yyyyMMdd"
            let dateInFormat = dateFormatter.string(from: date!)
            if let dateForUseToCompare = Int(dateInFormat){
                if dateForUseToCompare < dates[1] {
                    indexOfThirtyDay += 1
                    if indexOfThirtyDay < people.count {
                        let thirtyWeight =  round((people.last!.weight - people[indexOfThirtyDay].weight) * 100)/100
                        change30DayLabel.text = "\(thirtyWeight)"
                        thirdtyPeople = []
                        let sp = people[indexOfThirtyDay...(people.count-1)]
                        thirdtyPeople = Array(sp)
                    }else {
                        change30DayLabel.text = "_"
                        thirdtyPeople = []
                    }
                    return
                }
                indexOfThirtyDay -= 1
            }
        }
        let thirtyWeight = round((people.last!.weight - people[0].weight) * 100)/100
        change30DayLabel.text = "\(thirtyWeight)"
        thirdtyPeople = []
        thirdtyPeople = people
    }
    
    func get7and30DayBefore() -> [Int]{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
        
        
        let toDate = Date()
        let sevenDaysBefore = Calendar.current.date(byAdding: .day, value: -7, to: toDate)
        let thirdtyDaysBefore = Calendar.current.date(byAdding: .day, value: -30, to: toDate)
        
        let sevenDaysBeforeInFormat = formatter.string(from: sevenDaysBefore!)
        let thirdtyDaysBeforeInFormat = formatter.string(from: thirdtyDaysBefore!)
        if let seven = Int(sevenDaysBeforeInFormat) , let thirdty = Int(thirdtyDaysBeforeInFormat) {
            return [seven,thirdty]
        }
        return [0,0]
    }
    
    
    func setChartViews() {
        
        if #available(iOS 11.0, *) {
            let safeArea = self.safeAreaLayoutGuide
            
            addSubview(charViews)
            charViews.translatesAutoresizingMaskIntoConstraints = false
            charViews.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            charViews.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: -1.0).isActive = true
            charViews.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0.0).isActive = true
            charViews.widthAnchor.constraint(equalToConstant: self.frame.width - 0).isActive = true
        } else {
            addSubview(charViews)
            charViews.translatesAutoresizingMaskIntoConstraints = false
            charViews.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            charViews.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: -20.0).isActive = true
            charViews.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0).isActive = true
            charViews.widthAnchor.constraint(equalToConstant: self.frame.width - 18.0).isActive = true
        }
        

        
    }
    
    func setSegment() {
        
        addSubview(segmentOfCharts)
        segmentOfCharts.translatesAutoresizingMaskIntoConstraints = false
        segmentOfCharts.trailingAnchor.constraint(equalTo: charViews.trailingAnchor, constant: -8.0).isActive = true
        segmentOfCharts.topAnchor.constraint(equalTo: charViews.topAnchor, constant: 8.0).isActive = true
        segmentOfCharts.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        segmentOfCharts.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        
         segmentOfCharts.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)

    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        if sender.selectedSegmentIndex == 0 {
           startDrawValue(subPeople: sevenPeople)
        }else if sender.selectedSegmentIndex == 1 {
            startDrawValue(subPeople: thirdtyPeople)
        }else {
            startDrawValue(subPeople: people)
        }
    }
    

    
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Double]) {

        
        layoutIfNeeded()
        updateConstraintsIfNeeded()
        
        axisFormatDelegate = self
        viewForChart.noDataText = "You need to provide data for the chart."
        var dataEntries:[ChartDataEntry] = []
        var dataTargetWeightEntries:[ChartDataEntry] = []
        for i in 0..<forX.count{
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(forY[i]) , data: months as AnyObject?)
            dataEntries.append(dataEntry)
            if desiredWeight != -1 {
                let dataEntry = BarChartDataEntry(x: Double(i), y: desiredWeight , data: months as AnyObject?)
                dataTargetWeightEntries.append(dataEntry)
            }
        }
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Weight")
        chartDataSet.colors = [#colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)]
        chartDataSet.circleRadius = 4
        chartDataSet.lineWidth = 2
        
        let chartTargetDataSet = LineChartDataSet(values: dataTargetWeightEntries, label: "Target weight")
        chartTargetDataSet.colors = [#colorLiteral(red: 0.3882352941, green: 0.8549019608, blue: 0.2196078431, alpha: 1)]
        chartTargetDataSet.circleRadius = 2
        chartTargetDataSet.circleColors = [#colorLiteral(red: 0.3882352941, green: 0.8549019608, blue: 0.2196078431, alpha: 1)]
        chartTargetDataSet.lineWidth = 4
        
        let chartData = LineChartData(dataSet: chartDataSet)
        chartData.addDataSet(chartTargetDataSet)
        
        chartData.setDrawValues(false)
        viewForChart.data = chartData
        viewForChart.setVisibleXRangeMaximum(20)
        viewForChart.autoScaleMinMaxEnabled = true
        viewForChart.doubleTapToZoomEnabled = false
        viewForChart.pinchZoomEnabled = true
        viewForChart.moveViewToX(Double(months.count))
        viewForChart.xAxis.gridColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 0.4001509778)
        viewForChart.leftAxis.gridColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 0.4001509778)
        viewForChart.rightAxis.gridColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 0.4001509778)

        let xAxisValue = viewForChart.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        
        viewForChart.reloadInputViews()
        
    }
    
    func setupWeightTrends() {
        
        
        let days7ChangeView = UIView()
        let days30ChangeView = UIView()
        let allDaysChangeView = UIView()
        
        weightChangeStackView = UIStackView(arrangedSubviews: [days7ChangeView,days30ChangeView,allDaysChangeView])
        weightChangeStackView.axis = .horizontal
        weightChangeStackView.distribution = .fillEqually
        
        lineView.addSubview(weightChangeStackView)
        weightChangeStackView.translatesAutoresizingMaskIntoConstraints = false
        weightChangeStackView.topAnchor.constraint(equalTo: lineView.topAnchor, constant: 25).isActive = true
        weightChangeStackView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor, constant: 0.0).isActive = true
        weightChangeStackView.trailingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 0.0).isActive = true
        weightChangeStackView.bottomAnchor.constraint(equalTo: lineView.bottomAnchor, constant: -0.0).isActive = true
        
        lineView.addSubview(weightTrendLineView1)
        weightTrendLineView1.translatesAutoresizingMaskIntoConstraints = false
        weightTrendLineView1.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: 5).isActive = true
        weightTrendLineView1.trailingAnchor.constraint(equalTo: days7ChangeView.trailingAnchor, constant: -1).isActive = true
        weightTrendLineView1.widthAnchor.constraint(equalToConstant: 2).isActive = true
        weightTrendLineView1.bottomAnchor.constraint(equalTo: lineView.bottomAnchor, constant: -7.0).isActive = true
        
        lineView.addSubview(weightTrendLineView2)
        weightTrendLineView2.translatesAutoresizingMaskIntoConstraints = false
        weightTrendLineView2.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: 5).isActive = true
        weightTrendLineView2.trailingAnchor.constraint(equalTo: days30ChangeView.trailingAnchor, constant: -1).isActive = true
        weightTrendLineView2.widthAnchor.constraint(equalToConstant: 2).isActive = true
        weightTrendLineView2.bottomAnchor.constraint(equalTo: lineView.bottomAnchor, constant: -7.0).isActive = true
        
        
        //add all time
        let currentKgTitleLabelView = UIView()
        let currentKgLabelView = UIView()
        
        secondLabelStackView = UIStackView(arrangedSubviews: [currentKgTitleLabelView,currentKgLabelView])
        secondLabelStackView.axis = .vertical
        secondLabelStackView.distribution = .fillEqually
        
        lineView.addSubview(secondLabelStackView)
        secondLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        secondLabelStackView.topAnchor.constraint(equalTo: allDaysChangeView.topAnchor, constant: -6).isActive = true
        secondLabelStackView.leadingAnchor.constraint(equalTo: allDaysChangeView.leadingAnchor, constant: 0.0).isActive = true
        secondLabelStackView.trailingAnchor.constraint(equalTo: allDaysChangeView.trailingAnchor, constant: 0.0).isActive = true
        secondLabelStackView.bottomAnchor.constraint(equalTo: allDaysChangeView.bottomAnchor, constant: 0.0).isActive = true
        
        addSubview(changeKgTitleLabel)
        changeKgTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        changeKgTitleLabel.bottomAnchor.constraint(equalTo: currentKgTitleLabelView.bottomAnchor, constant: 0.0).isActive = true
        changeKgTitleLabel.centerXAnchor.constraint(equalTo: currentKgTitleLabelView.centerXAnchor).isActive = true
        
        
        addSubview(changeKgLabel)
        changeKgLabel.translatesAutoresizingMaskIntoConstraints = false
        changeKgLabel.centerXAnchor.constraint(equalTo: currentKgLabelView.centerXAnchor).isActive = true
        changeKgLabel.topAnchor.constraint(equalTo: currentKgLabelView.topAnchor, constant: 0).isActive = true
        
        
        //add 7 day time
        let change7DayTitleLabelView = UIView()
        let change7DayLabelView = UIView()
        
        change7DaysStackView = UIStackView(arrangedSubviews: [change7DayTitleLabelView,change7DayLabelView])
        change7DaysStackView.axis = .vertical
        change7DaysStackView.distribution = .fillEqually
        
        lineView.addSubview(change7DaysStackView)
        change7DaysStackView.translatesAutoresizingMaskIntoConstraints = false
        change7DaysStackView.topAnchor.constraint(equalTo: days7ChangeView.topAnchor, constant: -6).isActive = true
        change7DaysStackView.leadingAnchor.constraint(equalTo: days7ChangeView.leadingAnchor, constant: 0.0).isActive = true
        change7DaysStackView.trailingAnchor.constraint(equalTo: days7ChangeView.trailingAnchor, constant: 0.0).isActive = true
        change7DaysStackView.bottomAnchor.constraint(equalTo: days7ChangeView.bottomAnchor, constant: 0.0).isActive = true
        
        addSubview(change7DayTitleLabel)
        change7DayTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        change7DayTitleLabel.bottomAnchor.constraint(equalTo: change7DayTitleLabelView.bottomAnchor, constant: 0.0).isActive = true
        change7DayTitleLabel.centerXAnchor.constraint(equalTo: change7DayTitleLabelView.centerXAnchor).isActive = true
        
        
        addSubview(change7DayLabel)
        change7DayLabel.translatesAutoresizingMaskIntoConstraints = false
        change7DayLabel.centerXAnchor.constraint(equalTo: change7DayLabelView.centerXAnchor).isActive = true
        change7DayLabel.topAnchor.constraint(equalTo: change7DayLabelView.topAnchor, constant: 0).isActive = true
        
        //add 30 day time
        let change30DayTitleLabelView = UIView()
        let change30DayLabelView = UIView()
        
        change30DaysStackView = UIStackView(arrangedSubviews: [change30DayTitleLabelView,change30DayLabelView])
        change30DaysStackView.axis = .vertical
        change30DaysStackView.distribution = .fillEqually
        
        lineView.addSubview(change30DaysStackView)
        change30DaysStackView.translatesAutoresizingMaskIntoConstraints = false
        change30DaysStackView.topAnchor.constraint(equalTo: days30ChangeView.topAnchor, constant: -6).isActive = true
        change30DaysStackView.leadingAnchor.constraint(equalTo: days30ChangeView.leadingAnchor, constant: 0.0).isActive = true
        change30DaysStackView.trailingAnchor.constraint(equalTo: days30ChangeView.trailingAnchor, constant: 0.0).isActive = true
        change30DaysStackView.bottomAnchor.constraint(equalTo: days30ChangeView.bottomAnchor, constant: 0.0).isActive = true
        
        addSubview(change30DayTitleLabel)
        change30DayTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        change30DayTitleLabel.bottomAnchor.constraint(equalTo: change30DayTitleLabelView.bottomAnchor, constant: 0.0).isActive = true
        change30DayTitleLabel.centerXAnchor.constraint(equalTo: change30DayTitleLabelView.centerXAnchor).isActive = true
        
        
        addSubview(change30DayLabel)
        change30DayLabel.translatesAutoresizingMaskIntoConstraints = false
        change30DayLabel.centerXAnchor.constraint(equalTo: change30DayLabelView.centerXAnchor).isActive = true
        change30DayLabel.topAnchor.constraint(equalTo: change30DayLabelView.topAnchor, constant: 0).isActive = true
        
        
        //Weight trends title
        lineView.addSubview(titleWeightTrendsView)
        titleWeightTrendsView.translatesAutoresizingMaskIntoConstraints = false
        titleWeightTrendsView.topAnchor.constraint(equalTo: lineView.topAnchor, constant: 0).isActive = true
        titleWeightTrendsView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor, constant: 0.0).isActive = true
        titleWeightTrendsView.trailingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 0.0).isActive = true
        titleWeightTrendsView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        titleWeightTrendsView.addSubview(weightTrendsLabel)
        weightTrendsLabel.translatesAutoresizingMaskIntoConstraints = false
        weightTrendsLabel.topAnchor.constraint(equalTo: lineView.topAnchor, constant: 0).isActive = true
        weightTrendsLabel.centerXAnchor.constraint(equalTo: lineView.centerXAnchor).isActive = true
        
    }

    fileprivate func setupInitialWeight() {
        let startKgTitleLabelView = UIView()
        let startKgLabelView = UIView()
        
        topLabelStackView = UIStackView(arrangedSubviews: [startKgTitleLabelView,startKgLabelView])
        topLabelStackView.axis = .horizontal
        topLabelStackView.distribution = .fillEqually
        
        addSubview(topLabelStackView)
        topLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        topLabelStackView.topAnchor.constraint(equalTo: timeStartStackView.bottomAnchor, constant: -3).isActive = true
        topLabelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22.0).isActive = true
        topLabelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        topLabelStackView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        addSubview(startKgTitleLabel)
        startKgTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        startKgTitleLabel.topAnchor.constraint(equalTo: topLabelStackView.topAnchor, constant: 3.0).isActive = true
        startKgTitleLabel.leadingAnchor.constraint(equalTo: topLabelStackView.leadingAnchor, constant: 8.0).isActive = true
        
        addSubview(startKgLabel)
        startKgLabel.translatesAutoresizingMaskIntoConstraints = false
        startKgLabel.topAnchor.constraint(equalTo: startKgLabelView.topAnchor, constant: 3.0).isActive = true
        startKgLabel.trailingAnchor.constraint(equalTo: startKgLabelView.trailingAnchor, constant: -22).isActive = true
    }
    
    fileprivate func setupChangeLabels() {
        let currentKgTitleLabelView = UIView()
        
        let currentKgLabelView = UIView()
        
        secondLabelStackView = UIStackView(arrangedSubviews: [currentKgTitleLabelView,currentKgLabelView])
        secondLabelStackView.axis = .horizontal
        secondLabelStackView.distribution = .fillEqually
        
        addSubview(secondLabelStackView)
        secondLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        secondLabelStackView.topAnchor.constraint(equalTo: lineView.topAnchor, constant: 28).isActive = true
        secondLabelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22.0).isActive = true
        secondLabelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        secondLabelStackView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        addSubview(changeKgTitleLabel)
        changeKgTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        changeKgTitleLabel.topAnchor.constraint(equalTo: currentKgTitleLabelView.topAnchor, constant: 0.0).isActive = true
        changeKgTitleLabel.leadingAnchor.constraint(equalTo: currentKgTitleLabelView.leadingAnchor, constant: 8.0).isActive = true
        
        addSubview(changeKgLabel)
        changeKgLabel.translatesAutoresizingMaskIntoConstraints = false
        changeKgLabel.topAnchor.constraint(equalTo: currentKgLabelView.topAnchor, constant: 0.0).isActive = true
        changeKgLabel.trailingAnchor.constraint(equalTo: currentKgLabelView.trailingAnchor, constant: -22).isActive = true
       
    }
    
    fileprivate func setupStartDay() {
        let timeStartTitleLabelView = UIView()
        let timeStartLabelView = UIView()
        
        timeStartStackView = UIStackView(arrangedSubviews: [timeStartTitleLabelView,timeStartLabelView])
        timeStartStackView.axis = .horizontal
        timeStartStackView.distribution = .fillEqually
        
        addSubview(timeStartStackView)
        timeStartStackView.translatesAutoresizingMaskIntoConstraints = false
        timeStartStackView.topAnchor.constraint(equalTo: aboveView.topAnchor, constant: 43.0).isActive = true
        timeStartStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22.0).isActive = true
        timeStartStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12.0).isActive = true
        timeStartStackView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        addSubview(timeStartTitleLabel)
        timeStartTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeStartTitleLabel.topAnchor.constraint(equalTo: timeStartStackView.topAnchor, constant: 3.0).isActive = true
        timeStartTitleLabel.leadingAnchor.constraint(equalTo: timeStartStackView.leadingAnchor, constant: 8.0).isActive = true


        addSubview(timeStartLabel)
        timeStartLabel.translatesAutoresizingMaskIntoConstraints = false
        timeStartLabel.topAnchor.constraint(equalTo: timeStartLabelView.topAnchor, constant: 3.0).isActive = true
        timeStartLabel.trailingAnchor.constraint(equalTo: timeStartLabelView.trailingAnchor, constant: -22).isActive = true
    }
    
    fileprivate func setupTotalDay() {
        let numberOfDaysTitleLabelView = UIView()
        let numberOfDaysLabelView = UIView()
 
        numberOfDaysStackView = UIStackView(arrangedSubviews: [numberOfDaysTitleLabelView,numberOfDaysLabelView])
        numberOfDaysStackView.axis = .horizontal
        numberOfDaysStackView.distribution = .fillEqually
        
        addSubview(numberOfDaysStackView)
        numberOfDaysStackView.translatesAutoresizingMaskIntoConstraints = false
        numberOfDaysStackView.topAnchor.constraint(equalTo: topLabelStackView.bottomAnchor, constant: -3.0).isActive = true
        numberOfDaysStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22.0).isActive = true
        numberOfDaysStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12.0).isActive = true
        numberOfDaysStackView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        addSubview(totalDaysTitleLabel)
        totalDaysTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        totalDaysTitleLabel.topAnchor.constraint(equalTo: numberOfDaysStackView.topAnchor, constant: 3.0).isActive = true
        totalDaysTitleLabel.leadingAnchor.constraint(equalTo: numberOfDaysStackView.leadingAnchor, constant: 8.0).isActive = true


        addSubview(totalDaysLabel)
        totalDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        totalDaysLabel.topAnchor.constraint(equalTo: numberOfDaysStackView.topAnchor, constant: 3.0).isActive = true
        totalDaysLabel.trailingAnchor.constraint(equalTo: numberOfDaysStackView.trailingAnchor, constant: -22).isActive = true
    }
    
}
extension DiagramCell: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value) % months.count]
    }
}
