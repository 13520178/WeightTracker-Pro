//
//  HistoryCell.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 2/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit
import CoreData

class HistoryCell: BaseCell, UITableViewDelegate, UITableViewDataSource {
    
     var people = [Person]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        let request : NSFetchRequest<Person> = Person.fetchRequest()
        do {
            try people = context.fetch(request)
        } catch  {
            print("Error to fetch Item data")
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MyCell
        let max = people.count - 1
        if let date = people[max - indexPath.row].date {
            cell.dateLabel.text = String(date.description)
        }
        cell.weightLabel.text = String(people[max - indexPath.row].weight) + " Kg"
        return cell
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


