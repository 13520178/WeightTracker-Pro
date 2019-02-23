//
//  HistoryCell.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 2/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class HistoryCell: BaseCell, UITableViewDelegate, UITableViewDataSource {
    
    
    var weightDates:[weightDate] = []
    
    var tableView: UITableView = {
        var tb = UITableView()
        return tb
    }()
    
    override func setUpView() {
        super.setUpView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        addWeightDate()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MyCell
        cell.dateLabel.text = weightDates[indexPath.row].date
        cell.weightLabel.text = String(weightDates[indexPath.row].weight) + " Kg"
        return cell
    }
    
    func addWeightDate() {
        let wd1 = weightDate()
        wd1.date = "21/08/2019"
        wd1.weight = 64.1
        weightDates.append(wd1)
        
        let wd2 = weightDate()
        wd2.date = "23/08/2019"
        wd2.weight = 65
        weightDates.append(wd2)
        
        let wd3 = weightDate()
        wd3.date = "25/08/2019"
        wd3.weight = 66
        weightDates.append(wd2)
        
        let wd4 = weightDate()
        wd4.date = "27/08/2019"
        wd4.weight = 63
        weightDates.append(wd4)
        
        let wd5 = weightDate()
        wd5.date = "29/08/2019"
        wd5.weight = 62
        weightDates.append(wd5)
        
        let wd6 = weightDate()
        wd6.date = "1/09/2019"
        wd6.weight = 63
        weightDates.append(wd6)
        
        let wd7 = weightDate()
        wd7.date = "3/09/2019"
        wd7.weight = 59
        weightDates.append(wd7)
        
        let wd8 = weightDate()
        wd8.date = "5/10/2019"
        wd8.weight = 61
        weightDates.append(wd8)
    }
}

class MyCell:UITableViewCell {
    
    var weightStackView: UIStackView!
    
    
    var weightLabel: UILabel = {
        var lb = UILabel()
        lb.text = "64.0 kg"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        
        return lb
    }()
    
    var dateLabel: UILabel = {
        var lb = UILabel()
        lb.textColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        lb.text = "22/11/2018"
        lb.font = lb.font.withSize(16)
        return lb
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    func setupView() {
        let weightTitleLabelView = UIView()
        
        let weightLabelView = UIView()
        
        weightStackView = UIStackView(arrangedSubviews: [weightTitleLabelView,weightLabelView])
        weightStackView.axis = .horizontal
        weightStackView.distribution = .fillEqually
        
        addSubview(weightStackView)
        weightStackView.translatesAutoresizingMaskIntoConstraints = false
        weightStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        weightStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        weightStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: weightTitleLabelView.topAnchor, constant: 3.0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: weightTitleLabelView.leadingAnchor, constant: 0.0).isActive = true

        addSubview(weightLabel)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.topAnchor.constraint(equalTo: weightLabelView.topAnchor, constant: 3.0).isActive = true
        weightLabel.trailingAnchor.constraint(equalTo: weightLabelView.trailingAnchor, constant: -30).isActive = true
        
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class weightDate {
    var weight: Float
    var date : String
    init() {
        weight = 0
        date = ""
    }
}
