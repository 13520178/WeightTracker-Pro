//
//  HistoryCell.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 2/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit
import CoreData

protocol HistoryCellDelegate {
    func touchToDeleteCell(index : Int)
    func showDetailHistory(index : Int)
}

class HistoryCell: BaseCell, UITableViewDelegate, UITableViewDataSource {
    
    var people = [Person]()
    var weightUnit = ""
    
    var delegate: HistoryCellDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tableView: UITableView = {
        var tb = UITableView()
        tb.backgroundColor = UIColor.clear
        tb.separatorStyle = .none
       
        return tb
    }()
    
    let headerTable:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6987634202)
        return v
    }()
    
    let headerTableLabel:UILabel = {
        let l = UILabel()
        l.text = "Daily records"
        l.font = UIFont.systemFont(ofSize: 30)
        l.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return l
    }()
    
    override func setUpView() {
        super.setUpView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
        
        let backgroundImage = UIImage(named: "toolCellBackground")
        let backgroundView = UIImageView(image: backgroundImage)
        backgroundView.contentMode = .scaleToFill
        
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        addSubview(headerTable)
        headerTable.translatesAutoresizingMaskIntoConstraints = false
        headerTable.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        headerTable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        headerTable.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        addSubview(headerTableLabel)
        headerTableLabel.translatesAutoresizingMaskIntoConstraints = false
        headerTableLabel.centerXAnchor.constraint(equalTo: headerTable.centerXAnchor).isActive = true
        headerTableLabel.centerYAnchor.constraint(equalTo: headerTable.centerYAnchor).isActive = true

        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        
        
        
        
        let request : NSFetchRequest<Person> = Person.fetchRequest()
        do {
            try people = context.fetch(request)
        } catch  {
            print("Error to fetch Item data")
        }
        
        //long press
        //Long Press
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delegate = self as? UIGestureRecognizerDelegate
        self.tableView.addGestureRecognizer(longPressGesture)
       
    }
    
    @objc func handleLongPress(longPressGesture:UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: p)
        if indexPath == nil {
            print("Long press on table view, not row.")
        }
        else if (longPressGesture.state == UIGestureRecognizer.State.began) {
            print("Long press on row, at \(indexPath!.row)")
            delegate?.touchToDeleteCell(index: indexPath!.row)
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
        cell.weightLabel.text = "\(String(people[max - indexPath.row].weight)) \(weightUnit)"
        if people[max - indexPath.row].time == "Morning" {
            cell.timeLabel.text = "M"
            cell.timeLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }else if people[max - indexPath.row].time == "Afternoon" {
            cell.timeLabel.text = "A"
            cell.timeLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }else if people[max - indexPath.row].time == "Evening" {
            cell.timeLabel.text = "E"
            cell.timeLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }else {
            cell.timeLabel.text = "N"
            cell.timeLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        delegate?.showDetailHistory(index: indexPath.row)
    }
    
 
}

class MyCell:UITableViewCell {
    
    var weightStackView: UIStackView!
    var weightLabel: UILabel = {
        var lb = UILabel()
        lb.text = "64.0 kg"
        lb.font = lb.font.withSize(16.0)
        lb.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return lb
    }()
    
    var dateLabel: UILabel = {
        var lb = UILabel()
        lb.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lb.text = "22/11/2018"
        lb.font = lb.font.withSize(16)
        return lb
    }()
    
    var timeLabel : UILabel = {
        var lb = UILabel()
        lb.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        lb.text = "M"
        lb.font = lb.font.withSize(18)
        return lb
    }()
    
    var showDetailLabel: UILabel = {
        var lb = UILabel()
        lb.text = "❯"
        lb.font = lb.font.withSize(30.0)
        lb.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return lb
    }()
    
    var lineView:UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6465802339)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView() {
        
        let weightTitleLabelView = UIView()
        let weightLabelView = UIView()
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2987202837)
        
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
        dateLabel.topAnchor.constraint(equalTo: weightTitleLabelView.topAnchor, constant: 5.0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: weightTitleLabelView.leadingAnchor, constant: 0.0).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 105.0).isActive = true 
        
        
        addSubview(weightLabel)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.topAnchor.constraint(equalTo: weightLabelView.topAnchor, constant: 5.0).isActive = true
        weightLabel.trailingAnchor.constraint(equalTo: weightLabelView.trailingAnchor, constant: -60).isActive = true
        

        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: weightTitleLabelView.topAnchor, constant: 4.0).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 5.0).isActive = true
        
        addSubview(showDetailLabel)
        showDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        showDetailLabel.topAnchor.constraint(equalTo: weightLabelView.topAnchor, constant: -5.0).isActive = true
        showDetailLabel.trailingAnchor.constraint(equalTo: weightLabelView.trailingAnchor, constant: -10).isActive = true
        
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



