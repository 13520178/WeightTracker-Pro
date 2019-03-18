//
//  InputWeightCell.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 2/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol InputWeightCellDelegate {
    func changeAndUpdateCell(didChange: Bool, person:Person)
    func checkIfWrongInput()
    func checkIfOverInput()
    func resetData()
}

class InputWeightCell: BaseCell,UIPickerViewDelegate, UIPickerViewDataSource{
   
    let inputWeightView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    let inputWeightTextfield :UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string:"Weight...", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),NSAttributedString.Key.font :UIFont(name: "Arial", size: 25)!])
        tf.font = UIFont.systemFont(ofSize: 25)
        tf.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        tf.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        tf.textAlignment = .center
        tf.keyboardType = .decimalPad
        tf.isUserInteractionEnabled = true
        tf.setBottomBorder()
        return tf
    }()
    
    let noteLabel: UILabel = {
        let label = UILabel()
        label.text = "  Note:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "  Time:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let noteTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        tv.layer.cornerRadius = 12.0
        tv.layer.borderWidth = 1.5
        tv.layer.borderColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        tv.layer.masksToBounds = true
        return tv
    }()
    
    let kgLabel:UILabel = {
        let label = UILabel()
        label.text = "Kg."
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()
    
    let enterButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        bt.setTitle("Enter", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        bt.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        bt.titleLabel?.font = UIFont(name:"Avenir-Light", size: 35)
        bt.layer.cornerRadius = 28
        bt.layer.borderWidth = 1.5
        bt.layer.borderColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)

        return bt
    }()
    
    
    //UIPicker set up
    var pickerSelectedRow = 0
    let timeArray = ["Morning", "Afternoon", "Evening", "Night"]
    let timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.isHidden = false
        return picker
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeArray.count
    }

    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = timeArray[row] as String
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)])
        
        return myTitle
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelectedRow = row
    }
    
    let resetButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        let image = UIImage(named: "resetIcon")
        bt.setBackgroundImage(image, for: .normal)
        bt.layer.cornerRadius = 25
        bt.layer.borderWidth = 0
        return bt
    }()
    
    var delegate: InputWeightCellDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func setUpView() {
        super.setUpView()
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
        
        
        self.timePicker.dataSource = self
        self.timePicker.delegate = self
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        
        inputWeightView.layer.cornerRadius = 15.0
        inputWeightView.layer.borderWidth = 1.5
        inputWeightView.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        inputWeightView.layer.masksToBounds = true
        
        
        let selfWidth = self.layer.frame.width
        let selfHeight = self.layer.frame.height
        addSubview(inputWeightView)
        inputWeightView.translatesAutoresizingMaskIntoConstraints = false
        inputWeightView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        inputWeightView.topAnchor.constraint(equalTo: self.topAnchor, constant: (selfHeight-350-55)/2).isActive = true
        inputWeightView.widthAnchor.constraint(equalToConstant: selfWidth - 40).isActive = true
        inputWeightView.heightAnchor.constraint(equalToConstant: 350.0).isActive = true
        
        inputWeightView.addSubview(inputWeightTextfield)
        inputWeightTextfield.translatesAutoresizingMaskIntoConstraints = false
        inputWeightTextfield.centerXAnchor.constraint(equalTo: inputWeightView.centerXAnchor).isActive = true
        inputWeightTextfield.topAnchor.constraint(equalTo: inputWeightView.topAnchor, constant: 32.0).isActive = true
        inputWeightTextfield.widthAnchor.constraint(equalToConstant: selfWidth - 100).isActive = true
        inputWeightTextfield.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        let trailingTextField = (self.layer.frame.width - 280.0)/(-2)
        print(trailingTextField)
        addSubview(kgLabel)
        kgLabel.translatesAutoresizingMaskIntoConstraints = false
        kgLabel.topAnchor.constraint(equalTo: inputWeightTextfield.bottomAnchor, constant: 8).isActive = true
        kgLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingTextField).isActive = true
        
        addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.topAnchor.constraint(equalTo: kgLabel.bottomAnchor, constant: 12).isActive = true
        noteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 50 ).isActive = true
        
        addSubview(noteTextView)
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 4).isActive = true
        noteTextView.centerXAnchor.constraint(equalTo: inputWeightView.centerXAnchor).isActive = true
        noteTextView.widthAnchor.constraint(equalToConstant: selfWidth - 100).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 47).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 50 ).isActive = true
        
        addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 14).isActive = true
        timePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 30 ).isActive = true
        timePicker.widthAnchor.constraint(equalToConstant: selfWidth - 60).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
        
        
        
        addSubview(enterButton)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        enterButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        enterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22).isActive = true
        enterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22).isActive = true
        enterButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        resetButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        endEditing(true)
    }
    
    @objc func resetButtonAction(sender: UIButton!) {
        delegate?.resetData()
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        
        if inputWeightTextfield.text != ""
        {
            if let w = inputWeightTextfield.text {
                if let w = Float(w) {
                    if w > 1 && w <= 400 {
                        let person = Person(context: context)
                        person.weight = w
                        person.date = Date().string(format: "dd-MM-yyyy")
                        person.note = noteTextView.text!
                        person.time = timeArray[pickerSelectedRow]
                        print(person)
                        savePerson()
                        delegate?.changeAndUpdateCell(didChange: true, person: person)
                    }else {
                        delegate?.checkIfOverInput()
                    }
                }else {
                    delegate?.checkIfWrongInput()
                }
            }
        }else {
            delegate?.checkIfWrongInput()
        }
        inputWeightTextfield.text = ""
        noteTextView.text = ""
    }
    
    func savePerson() {
        do {
            try context.save()
        } catch  {
            print("Error to saving data")
        }
    }

}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
