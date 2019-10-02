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
import UserNotifications

protocol InputWeightCellDelegate {
    func changeAndUpdateCell(didChange: Bool, person:Person)
    func checkIfWrongInput()
    func checkIfOverInput()
    func disableUserInteraction()
    func enableUserInteraction()
    func resetData()
    func showSub1()
    func showSub2()
    func showSub3()
    func showSub4()
    func notificationOff()
}

class InputWeightCell: BaseCell,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate{
    
    let titleView :UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6452142446)
        return v
    }()
    
    var aboveTiltleViewLabel: UILabel = {
        let lb = UILabel()
        lb.text = "New weight"
        lb.font = UIFont(name:"TrebuchetMS", size: 25)
        lb.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        return lb
    }()
    
    var aboveSubTiltleViewLabel: UILabel = {
        let l = UILabel()
        l.text = "Tools box"
        l.font = UIFont.systemFont(ofSize: 16)
        l.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return l
    }()

   
    //MARK: - MainView variables
    let inputWeightView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    let bellowInputWeightViewImage: UIImageView = {
        let backgroundImage = UIImage(named: "bellowInputWeightView")
        let backgroundView = UIImageView(image: backgroundImage)
        backgroundView.contentMode = .scaleToFill
        
        return backgroundView
    }()
    
    //MARK: - Textfield setup
    
    let inputWeightTextfield :UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string:"Weight...", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),NSAttributedString.Key.font :UIFont(name: "Arial", size: 25)!])
        tf.font = UIFont.systemFont(ofSize: 25)
        tf.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        tf.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3161546204)
        tf.textAlignment = .center
        tf.keyboardType = .decimalPad
        tf.isUserInteractionEnabled = true
        tf.setBottomBorder()
        return tf
    }()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("tf touch")
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        
        if hour >= 6 && hour < 12 {
            print("Morning")
            timePicker.selectRow(0, inComponent: 0, animated: true)
            pickerSelectedRow = 0
        }else if hour >= 12 && hour < 17 {
            print("Afternoom")
            timePicker.selectRow(1, inComponent: 0, animated: true)
            pickerSelectedRow = 1
        }else if hour >= 17 && hour < 20 {
            print("Everning")
            timePicker.selectRow(2, inComponent: 0, animated: true)
            pickerSelectedRow = 2
        }else {
            print("night")
            timePicker.selectRow(3, inComponent: 0, animated: true)
            pickerSelectedRow = 3
        }
    }
    
    let noteLabel: UILabel = {
        let label = UILabel()
        label.text = "  Note (optional)"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "  Time"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let noteTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3005895322)
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        tv.layer.cornerRadius = 12.0
        tv.layer.borderWidth = 1
        tv.layer.borderColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 0.6547761695)
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
    
    let bellOnOrOffLabel:UILabel = {
        let label = UILabel()
        label.text = "Reminder"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let bellReminderTimeLabel:UILabel = {
        let label = UILabel()
        label.text = "Set reminder time"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return label
    }()
    
    let segmentOfBell:UISegmentedControl = {
        let sm = UISegmentedControl (items: ["Off","On"])
        sm.selectedSegmentIndex = 0
        sm.setTitle("Off", forSegmentAt: 0)
        sm.setTitle("On", forSegmentAt: 1)
        sm.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return sm
    }()
    
    
    
    let imageBelowEnterButton: UIImageView = {
        let image = UIImage(named: "enterButton")
        let iu = UIImageView(image: image)
        iu.layer.cornerRadius = 20
        iu.clipsToBounds = true
        return iu
    }()
    
    let bellButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        bt.setImage(#imageLiteral(resourceName: "bell"), for: .normal)
        bt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        bt.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bt.titleLabel?.font = UIFont(name:"TrebuchetMS", size: 24)
        bt.layer.cornerRadius = 0
        
        return bt
    }()
    
    let okBellButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        bt.setTitle("Ok", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        bt.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bt.layer.cornerRadius = 0
        
        return bt
    }()
    
    let cancleBellButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        bt.setTitle("Cancle", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        bt.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bt.layer.cornerRadius = 0
        
        return bt
    }()
    
    
    let enterButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        bt.setTitle("Enter", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        bt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        bt.titleLabel?.font = UIFont(name:"TrebuchetMS", size: 24)
        bt.layer.cornerRadius = 0

        return bt
    }()
    
    
    //UIPicker set up
    let defaults = UserDefaults.standard
    var pickerSelectedRow = 0
    let timeArray = ["Morning", "Afternoon", "Evening", "Night"]
    let timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.isHidden = false
        return picker
    }()
    
    let timeBellPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
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
        if row == 0 {
            let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)])
            return myTitle
        }else if row == 1 {
             let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)])
            return myTitle
        }else if row == 2 {
             let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)])
            return myTitle
        }else {
             let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)])
            return myTitle
        }

    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelectedRow = row
    }
    
    let resetButton: UIButton = {
        let bt = UIButton()
        let image = UIImage(named: "toolBoxButton")
        bt.setImage(image, for: .normal)
        bt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bt.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        bt.layer.borderWidth = 1
        bt.layer.cornerRadius = 10
        return bt
    }()
    

    
    let resetInBlurViewButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        bt.setTitle("⊗", for: .normal)
        bt.titleLabel?.font = UIFont(name:"Avenir-Light", size: 25)
        bt.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        bt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        return bt
    }()
    
    let blurView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5497507669)
        
        return v
    }()
    
    let blurViewForBell:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5497507669)
        
        return v
    }()
    
    let caculatorView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.layer.cornerRadius = 25
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        v.clipsToBounds = true
        return v
    }()
    
    let bellView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.layer.cornerRadius = 5
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        v.clipsToBounds = true
        v.isHidden = true
        return v
    }()
    
    let titleBellView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        v.clipsToBounds = true
        return v
    }()
    
    let footerBellView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        v.clipsToBounds = true
        return v
    }()
    
    let titleCaculatorView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        v.clipsToBounds = true
        return v
    }()
    
    let calculationToolsLabel : UILabel =  {
        let label = UILabel()
        label.text = "Calculation tools"
        label.font = UIFont(name:"TrebuchetMS", size: 18)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    var delegate: InputWeightCellDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK: - SubsView Variable
    let subView1 = InputWeightSubView()
    let subView2 = InputWeightSubView()
    let subView3 = InputWeightSubView()
    let subView4 = InputWeightSubView()
    
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
        self.inputWeightTextfield.delegate = self
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        
        inputWeightView.layer.cornerRadius = 8.0
        inputWeightView.layer.masksToBounds = true
        
        
        let selfWidth = self.layer.frame.width
        let selfHeight = self.layer.frame.height
        
        addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        titleView.widthAnchor.constraint(equalToConstant: selfWidth).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        addSubview(bellButton)
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        bellButton.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 8).isActive = true
        bellButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        bellButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        bellButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bellButton.addTarget(self, action: #selector(bellPressed), for: .touchUpInside)
        
        
        
        
        addSubview(aboveTiltleViewLabel)
        aboveTiltleViewLabel.translatesAutoresizingMaskIntoConstraints = false
        aboveTiltleViewLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        aboveTiltleViewLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 43).isActive = true
        
        addSubview(aboveSubTiltleViewLabel)
        aboveSubTiltleViewLabel.translatesAutoresizingMaskIntoConstraints = false
        aboveSubTiltleViewLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        aboveSubTiltleViewLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -52).isActive = true
        
        addSubview(inputWeightView)
        inputWeightView.translatesAutoresizingMaskIntoConstraints = false
        inputWeightView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        inputWeightView.topAnchor.constraint(equalTo: self.topAnchor, constant: (selfHeight-360)/2).isActive = true
        inputWeightView.widthAnchor.constraint(equalToConstant: selfWidth - 24).isActive = true
        inputWeightView.heightAnchor.constraint(equalToConstant: 360.0).isActive = true
        
        inputWeightView.addSubview(bellowInputWeightViewImage)
        bellowInputWeightViewImage.translatesAutoresizingMaskIntoConstraints = false
        bellowInputWeightViewImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bellowInputWeightViewImage.bottomAnchor.constraint(equalTo: self.inputWeightView.bottomAnchor, constant: 0).isActive = true
        bellowInputWeightViewImage.widthAnchor.constraint(equalToConstant: selfWidth - 24).isActive = true
        bellowInputWeightViewImage.heightAnchor.constraint(equalToConstant:60.0).isActive = true
        
        
        inputWeightView.addSubview(inputWeightTextfield)
        inputWeightTextfield.translatesAutoresizingMaskIntoConstraints = false
        inputWeightTextfield.centerXAnchor.constraint(equalTo: inputWeightView.centerXAnchor).isActive = true
        inputWeightTextfield.topAnchor.constraint(equalTo: inputWeightView.topAnchor, constant: 18.0).isActive = true
        inputWeightTextfield.widthAnchor.constraint(equalToConstant: selfWidth - 100).isActive = true
        inputWeightTextfield.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        let trailingTextField = (self.layer.frame.width - 240.0)/(-2)
        print(trailingTextField)
        addSubview(kgLabel)
        kgLabel.translatesAutoresizingMaskIntoConstraints = false
        kgLabel.topAnchor.constraint(equalTo: inputWeightTextfield.bottomAnchor, constant: 8).isActive = true
        kgLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingTextField).isActive = true
        
        addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.topAnchor.constraint(equalTo: kgLabel.bottomAnchor, constant: 4).isActive = true
        noteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 50 ).isActive = true
        
        addSubview(noteTextView)
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 0).isActive = true
        noteTextView.centerXAnchor.constraint(equalTo: inputWeightView.centerXAnchor).isActive = true
        noteTextView.widthAnchor.constraint(equalToConstant: selfWidth - 100).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 40).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 50 ).isActive = true
        
        addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 7).isActive = true
        timePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 100 ).isActive = true
        timePicker.widthAnchor.constraint(equalToConstant: selfWidth - 200).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
        
            
        addSubview(imageBelowEnterButton)
        imageBelowEnterButton.translatesAutoresizingMaskIntoConstraints = false
        imageBelowEnterButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageBelowEnterButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        imageBelowEnterButton.topAnchor.constraint(equalTo: inputWeightView.bottomAnchor, constant: -22).isActive = true
        imageBelowEnterButton.trailingAnchor.constraint(equalTo: inputWeightView.trailingAnchor, constant: -12).isActive = true

        
        addSubview(enterButton)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        enterButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        enterButton.topAnchor.constraint(equalTo: inputWeightView.bottomAnchor, constant: -22).isActive = true
        enterButton.trailingAnchor.constraint(equalTo: inputWeightView.trailingAnchor, constant: -12).isActive = true
        enterButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        

        
        addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.widthAnchor.constraint(equalToConstant: 38).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        resetButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 1.5).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkTouchInBlurView))
        blurView.isHidden = true
        addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.widthAnchor.constraint(equalToConstant: self.layer.frame.width ).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: self.layer.frame.height).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        blurView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.blurView.addGestureRecognizer(gesture)
        
        let blurViewForBellGesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkTouchInBlurViewForBell))
        blurViewForBell.isHidden = true
        addSubview(blurViewForBell)
        blurViewForBell.translatesAutoresizingMaskIntoConstraints = false
        blurViewForBell.widthAnchor.constraint(equalToConstant: self.layer.frame.width ).isActive = true
        blurViewForBell.heightAnchor.constraint(equalToConstant: self.layer.frame.height).isActive = true
        blurViewForBell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        blurViewForBell.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.blurViewForBell.addGestureRecognizer(blurViewForBellGesture)
        
        
        addSubview(bellView)
        bellView.translatesAutoresizingMaskIntoConstraints = false
        bellView.widthAnchor.constraint(equalToConstant: self.layer.frame.width - 30).isActive = true
        bellView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        bellView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bellView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        bellView.addSubview(titleBellView)
        titleBellView.translatesAutoresizingMaskIntoConstraints = false
        titleBellView.widthAnchor.constraint(equalToConstant: self.layer.frame.width - 30).isActive = true
        titleBellView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleBellView.topAnchor.constraint(equalTo: bellView.topAnchor, constant: 0).isActive = true
        titleBellView.leadingAnchor.constraint(equalTo: bellView.leadingAnchor, constant: 0).isActive = true
        
        
        bellView.addSubview(bellOnOrOffLabel)
        bellOnOrOffLabel.translatesAutoresizingMaskIntoConstraints = false
        bellOnOrOffLabel.leadingAnchor.constraint(equalTo: bellView.leadingAnchor, constant: 16).isActive = true
        bellOnOrOffLabel.topAnchor.constraint(equalTo: bellView.topAnchor, constant: 8).isActive = true
        
        
        bellView.addSubview(segmentOfBell)
        segmentOfBell.translatesAutoresizingMaskIntoConstraints = false
        segmentOfBell.widthAnchor.constraint(equalToConstant: 80).isActive = true
        segmentOfBell.heightAnchor.constraint(equalToConstant: 26).isActive = true
        segmentOfBell.trailingAnchor.constraint(equalTo: bellView.trailingAnchor, constant: -8).isActive = true
        segmentOfBell.topAnchor.constraint(equalTo: bellView.topAnchor, constant: 7).isActive = true
        

        
        bellView.addSubview(timeBellPicker)
        timeBellPicker.translatesAutoresizingMaskIntoConstraints = false
        timeBellPicker.topAnchor.constraint(equalTo: bellOnOrOffLabel.bottomAnchor, constant: 12).isActive = true
        timeBellPicker.centerXAnchor.constraint(equalTo: bellView.centerXAnchor).isActive = true
        timeBellPicker.widthAnchor.constraint(equalToConstant: self.layer.frame.width - 28).isActive = true
        timeBellPicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        
        bellView.addSubview(okBellButton)
        okBellButton.translatesAutoresizingMaskIntoConstraints = false
        okBellButton.widthAnchor.constraint(equalToConstant: (self.layer.frame.width - 32)/2).isActive = true
        okBellButton.heightAnchor.constraint(equalToConstant: 37).isActive = true
        okBellButton.bottomAnchor.constraint(equalTo: bellView.bottomAnchor, constant: 0).isActive = true
        okBellButton.leadingAnchor.constraint(equalTo: bellView.leadingAnchor, constant: 0).isActive = true
         okBellButton.addTarget(self, action: #selector(bellOkPressed), for: .touchUpInside)
        
        bellView.addSubview(cancleBellButton)
        cancleBellButton.translatesAutoresizingMaskIntoConstraints = false
        cancleBellButton.widthAnchor.constraint(equalToConstant: (self.layer.frame.width - 32)/2).isActive = true
        cancleBellButton.heightAnchor.constraint(equalToConstant: 37).isActive = true
        cancleBellButton.bottomAnchor.constraint(equalTo: bellView.bottomAnchor, constant: 0).isActive = true
        cancleBellButton.trailingAnchor.constraint(equalTo: bellView.trailingAnchor, constant: 0).isActive = true
        cancleBellButton.addTarget(self, action: #selector(checkTouchInBlurViewForBell), for: .touchUpInside)
        
        addSubview(caculatorView)
        caculatorView.translatesAutoresizingMaskIntoConstraints = false
        caculatorView.widthAnchor.constraint(equalToConstant: self.layer.frame.width).isActive = true
        caculatorView.heightAnchor.constraint(equalToConstant: 380).isActive = true
        caculatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 380).isActive = true
        caculatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        caculatorView.addSubview(titleCaculatorView)
        titleCaculatorView.translatesAutoresizingMaskIntoConstraints = false
        titleCaculatorView.widthAnchor.constraint(equalToConstant: self.layer.frame.width).isActive = true
        titleCaculatorView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        titleCaculatorView.topAnchor.constraint(equalTo: caculatorView.topAnchor, constant: 0).isActive = true
        titleCaculatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
       

        caculatorView.addSubview(resetInBlurViewButton)
        resetInBlurViewButton.translatesAutoresizingMaskIntoConstraints = false
        resetInBlurViewButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        resetInBlurViewButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        resetInBlurViewButton.topAnchor.constraint(equalTo: caculatorView.topAnchor, constant: 0).isActive = true
        resetInBlurViewButton.trailingAnchor.constraint(equalTo: caculatorView.trailingAnchor, constant: -2).isActive = true
        resetInBlurViewButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
        
        setupsubsCalculatorView()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
        
        if defaults.bool(forKey: "isBellOn") {
            bellButton.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            segmentOfBell.selectedSegmentIndex = 1
        }else {
            bellButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            segmentOfBell.selectedSegmentIndex = 0
        }
        
    }
    
    //MARK: - setup SubsCalculatorView
    @objc func checkTouchInBlurView(sender : UITapGestureRecognizer) {
        print("touched !!!")
        if blurView.isHidden == false {
            blurView.isHidden = true
            self.isUserInteractionEnabled = true
            delegate?.enableUserInteraction()
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.caculatorView.frame.origin.y += 355
            }, completion: nil)
        }
        
    }
    
    @objc func checkTouchInBlurViewForBell(sender : UITapGestureRecognizer) {
        print("touched !!!")
        if blurViewForBell.isHidden == false {
            blurViewForBell.isHidden = true
            self.isUserInteractionEnabled = true
            delegate?.enableUserInteraction()
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                //Some thing happen with bellView
                self.bellView.isHidden = true
            }, completion: nil)
        }
        
    }
    
    @objc func bellOkPressed(sender : UITapGestureRecognizer) {
        print("touched !!!")
        if blurViewForBell.isHidden == false {
            blurViewForBell.isHidden = true
            self.isUserInteractionEnabled = true
            delegate?.enableUserInteraction()
            
            //Set Bell Color
            
            if segmentOfBell.selectedSegmentIndex == 0 {
                bellButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                defaults.set(false, forKey: "isBellOn")
            }else {
                bellButton.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                defaults.set(true, forKey: "isBellOn")
            }
            
          
            
            let date = timeBellPicker.date
            let components = Calendar.current.dateComponents([.hour, .minute,.second], from: date)
            let hour = components.hour!
            let minute = components.minute!

            
            print(hour)
            print(minute)
            if(segmentOfBell.selectedSegmentIndex == 1){
                UNService.shared.timerRequest(with: components)
            }else {
                UNService.shared.removeRequest()
            }
            
   
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                //Some thing happen with bellView
                self.bellView.isHidden = true
            }, completion: nil)
        }
        
    }
    
    
    
    func setupsubsCalculatorView() {
        caculatorView.addSubview(calculationToolsLabel)
        calculationToolsLabel.translatesAutoresizingMaskIntoConstraints = false
        calculationToolsLabel.topAnchor.constraint(equalTo: caculatorView.topAnchor, constant: 7.0).isActive = true
        calculationToolsLabel.leadingAnchor.constraint(equalTo: caculatorView.leadingAnchor, constant: 12.0).isActive = true
        
        
        let subView1Tap = UITapGestureRecognizer(target: self, action: #selector(subView1HandleTap(_:)))
        subView1.addGestureRecognizer(subView1Tap)
        subView1.setupProperty(captionText: "BMI", contentText: "Determine reasonable weight",imageName: "BMI", imageBackGround: "green")
        caculatorView.addSubview(subView1)
        subView1.translatesAutoresizingMaskIntoConstraints = false
        subView1.topAnchor.constraint(equalTo: caculatorView.topAnchor, constant: 45.0).isActive = true
        subView1.centerXAnchor.constraint(equalTo: caculatorView.centerXAnchor).isActive = true
        subView1.widthAnchor.constraint(equalToConstant: self.layer.frame.width - 16).isActive = true
        subView1.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        
        
        let subView2Tap = UITapGestureRecognizer(target: self, action: #selector(subView2HandleTap(_:)))
        subView2.addGestureRecognizer(subView2Tap)
        subView2.setupProperty(captionText: "BMR (TDEE)", contentText: "Total daily calories using",imageName: "BMR", imageBackGround: "orange")
        caculatorView.addSubview(subView2)
        subView2.translatesAutoresizingMaskIntoConstraints = false
        subView2.topAnchor.constraint(equalTo: subView1.bottomAnchor, constant: 12.0).isActive = true
        subView2.centerXAnchor.constraint(equalTo: caculatorView.centerXAnchor).isActive = true
        subView2.widthAnchor.constraint(equalToConstant: self.layer.frame.width - 16).isActive = true
        subView2.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        
        
        let subView3Tap = UITapGestureRecognizer(target: self, action: #selector(subView3HandleTap(_:)))
        subView3.addGestureRecognizer(subView3Tap)
        subView3.setupProperty(captionText: "YMCA", contentText: "Body fat calculator",imageName: "bodyFat",imageBackGround: "blue")
        caculatorView.addSubview(subView3)
        subView3.translatesAutoresizingMaskIntoConstraints = false
        subView3.topAnchor.constraint(equalTo: subView2.bottomAnchor, constant: 12.0).isActive = true
        subView3.centerXAnchor.constraint(equalTo: caculatorView.centerXAnchor).isActive = true
        subView3.widthAnchor.constraint(equalToConstant: self.layer.frame.width - 16).isActive = true
        subView3.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        
        
        let subView4Tap = UITapGestureRecognizer(target: self, action: #selector(subView4HandleTap(_:)))
        subView4.addGestureRecognizer(subView4Tap)
        subView4.setupProperty(captionText: "WHR", contentText: "Waist-to-Hip ratio",imageName: "WHR", imageBackGround: "pink")
        caculatorView.addSubview(subView4)
        subView4.translatesAutoresizingMaskIntoConstraints = false
        subView4.topAnchor.constraint(equalTo: subView3.bottomAnchor, constant: 12.0).isActive = true
        subView4.centerXAnchor.constraint(equalTo: caculatorView.centerXAnchor).isActive = true
        subView4.widthAnchor.constraint(equalToConstant: self.layer.frame.width - 16).isActive = true
        subView4.heightAnchor.constraint(equalToConstant: 64.0).isActive = true

    }
    
    
    //MARK: - Action Handle
    @objc func subView1HandleTap( _ sender: UITapGestureRecognizer? = nil) {
        delegate?.showSub1()
    }
    
    @objc func subView2HandleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.showSub2()
    }
    
    @objc func subView3HandleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.showSub3()
    }
    
    @objc func subView4HandleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.showSub4()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        endEditing(true)
    }
    
    @objc func resetButtonAction(sender: UIButton!) {
       if caculatorView.frame.origin.y == self.layer.frame.height {
            blurView.isHidden = false
            self.isUserInteractionEnabled = true
            delegate?.disableUserInteraction()
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.caculatorView.frame.origin.y -= 355
            }, completion: nil)
        }else {
            blurView.isHidden = true
            self.isUserInteractionEnabled = true
            delegate?.enableUserInteraction()
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.caculatorView.frame.origin.y += 355
            }, completion: nil)
        }
        
        
       
    }
    
    @objc func bellPressed(sender: UIButton!) {
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    if self.bellView.isHidden {
                        self.blurViewForBell.isHidden = false
                        self.isUserInteractionEnabled = true
                        self.delegate?.disableUserInteraction()
                        
                        if self.defaults.bool(forKey: "isBellOn") {
                            self.segmentOfBell.selectedSegmentIndex = 1
                        }else {
                            self.segmentOfBell.selectedSegmentIndex = 0
                        }
                        
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                            self.bellView.isHidden = false
                        }, completion: nil)
                    }else {
                        self.blurViewForBell.isHidden = true
                        self.isUserInteractionEnabled = true
                        self.delegate?.enableUserInteraction()
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                            self.bellView.isHidden = true
                        }, completion: nil)
                    }
                }
            }
            else {
                self.delegate?.notificationOff()
                
            }
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        
        if inputWeightTextfield.text != ""
        {
            if var w = inputWeightTextfield.text {
                w = w.replacingOccurrences(of: ",", with: ".")
                if let w = Float(w) {
                    if w > 1 && w <= 400 {
                        let person = Person(context: context)
                        person.weight = w
                        person.date = Date().string(format: "dd-MM-yyyy")
                        person.note = noteTextView.text!
                        person.time = timeArray[pickerSelectedRow]
                        savePerson()
                        
//                        let person1 = Person(context: context)
//                        person1.weight = 80
//                        person1.date = "06-04-2019"
//                        person1.note = ""
//                        person1.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person2 = Person(context: context)
//                        person2.weight = 79.5
//                        person2.date = "07-04-2019"
//                        person2.note = ""
//                        person2.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person3 = Person(context: context)
//                        person3.weight = 79.3
//                        person3.date = "08-04-2019"
//                        person3.note = ""
//                        person3.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person4 = Person(context: context)
//                        person4.weight = 79
//                        person4.date = "09-04-2019"
//                        person4.note = ""
//                        person4.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person5 = Person(context: context)
//                        person5.weight = 78.5
//                        person5.date = "10-04-2019"
//                        person5.note = ""
//                        person5.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person6 = Person(context: context)
//                        person6.weight = 78
//                        person6.date = "11-04-2019"
//                        person6.note = ""
//                        person6.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person7 = Person(context: context)
//                        person7.weight = 77.6
//                        person7.date = "12-04-2019"
//                        person7.note = ""
//                        person7.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person8 = Person(context: context)
//                        person8.weight = 77.2
//                        person8.date = "13-04-2019"
//                        person8.note = ""
//                        person8.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person9 = Person(context: context)
//                        person9.weight = 70
//                        person9.date = "01-05-2019"
//                        person9.note = ""
//                        person9.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person10 = Person(context: context)
//                        person10.weight = 69.5
//                        person10.date = "02-05-2019"
//                        person10.note = ""
//                        person10.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person11 = Person(context: context)
//                        person11.weight = 69.4
//                        person11.date = "03-05-2019"
//                        person11.note = ""
//                        person11.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person12 = Person(context: context)
//                        person12.weight = 69.6
//                        person12.date = "04-05-2019"
//                        person12.note = ""
//                        person12.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person13 = Person(context: context)
//                        person13.weight = 69
//                        person13.date = "05-05-2019"
//                        person13.note = ""
//                        person13.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person14 = Person(context: context)
//                        person14.weight = 68
//                        person14.date = "06-05-2019"
//                        person14.note = ""
//                        person14.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person15 = Person(context: context)
//                        person15.weight = 68.4
//                        person15.date = "07-05-2019"
//                        person15.note = ""
//                        person15.time = timeArray[pickerSelectedRow]
//                        savePerson()
//
//                        let person16 = Person(context: context)
//                        person16.weight = 67.9
//                        person16.date = "08-05-2019"
//                        person16.note = ""
//                        person16.time = timeArray[pickerSelectedRow]
//                        savePerson()
                        
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
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.5563300252, green: 0.3507795036, blue: 0.9688282609, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1)
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
