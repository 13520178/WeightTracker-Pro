//
//  Sub2ViewController.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 3/20/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class Sub2ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {

    //MARK: - Outlet variable
    @IBOutlet weak var topViewAnchorConstant: NSLayoutConstraint!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var inpurView: UIView!
    
    //Segment setup
    
    @IBOutlet weak var segmentUnit: UISegmentedControl!
    @IBOutlet weak var metricStackView: UIStackView!
    @IBOutlet weak var imperialStackView: UIStackView!
    
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var bottomInputView: NSLayoutConstraint!
    
    @IBOutlet weak var genderTextfield: UITextField!
    @IBOutlet weak var activityTextfield: UITextField!
    @IBOutlet weak var heightTextfield: UITextField!
    @IBOutlet weak var weightTextfield: UITextField!
    @IBOutlet weak var ageTextfield: UITextField!
    @IBOutlet weak var backButton: UIButton!
    
    // Outlet in imperial Unit
    @IBOutlet weak var ftTextfield: UITextField!
    @IBOutlet weak var inTextfield: UITextField!
    @IBOutlet weak var lbsWeightTextField: UITextField!
    @IBOutlet weak var ageInImperialTextfield: UITextField!
    @IBOutlet weak var genderInImperialTextfield: UITextField!
    @IBOutlet weak var sedentaryInImperialTextfield: UITextField!
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField ==  ftTextfield {
            return range.location <= 1
        } else if textField ==  inTextfield {
            return range.location <= 2
        }
        else {
            return range.location <= 10
        }
    }
    

    
    var textFieldIsChange = UITextField()
    var viewHeight:CGFloat = 0
    var inputViewHeight:CGFloat = 0
    var genderIndex = 0
    var activityIndex = 0
    
    
    
    let genderArray = ["Female", "Male"]
    let activityArray = ["Sedentary","Lightly active","Moderately active","Very active", "Super active"]
    
    // Picker setup
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var activityPicker: UIPickerView!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPicker {
            return genderArray.count
        }else if pickerView == activityPicker {
            return activityArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderPicker {
            return genderArray[row]
        }else if pickerView == activityPicker {
            return activityArray[row]
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPicker {
            genderIndex = row
            genderTextfield.text = genderArray[row]
            genderInImperialTextfield.text = genderArray[row]
        }else if pickerView == activityPicker {
            activityIndex = row
            activityTextfield.text = activityArray[row]
            sedentaryInImperialTextfield.text = activityArray[row]
        }
        
    }
    
    
    //MARK: - Result View Variable
    let resultView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    
    let okButtonResultView:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        btn.layer.cornerRadius = 10.0
        btn.clipsToBounds = true
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        btn.setTitle("OK", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        return btn
    }()
    
    let resultLabel: UILabel = {
        let l = UILabel()
        l.text = "Result"
        l.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.light)
        l.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return l
    }()
    
    let bmrResultView:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    let bmrResultLabel: UILabel = {
        let l = UILabel()
        l.text = "BMR"
        l.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return l
    }()
    
    let bmrResultValueLabel: UILabel = {
        let l = UILabel()
        l.text = " 1605.9"
        l.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        l.layer.cornerRadius = 10.0
        l.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return l
    }()
    
    let caloriePerDayLabel: UILabel = {
        let l = UILabel()
        l.text = "Daily calories needs to maintain your weight"
        l.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return l
    }()
    
    let calorieValuePerDayLabel: UILabel = {
        let l = UILabel()
        l.text = "2459.0"
        l.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        return l
    }()
    let caloriePerDayDescripLabel: UILabel = {
        let l = UILabel()
        l.text = "This is the total amount of calories your body needs to absorb to aid in performing daily activities."
        l.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHeight = view.frame.height
        inputViewHeight = inpurView.frame.height
        genderPicker.delegate = self
        activityPicker.delegate = self
        ftTextfield.delegate = self
        inTextfield.delegate = self
        
        //Setup result view
        resultView.isHidden = true
        view.addSubview(resultView)
        resultView.translatesAutoresizingMaskIntoConstraints = false
        resultView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        resultView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        resultView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 32).isActive = true
        //resultView.heightAnchor.constraint(equalToConstant: self.view.frame.height - 152).isActive = true
        
        
        
        resultView.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.centerXAnchor.constraint(equalTo: resultView.centerXAnchor).isActive = true
        resultLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 16).isActive = true
        
        resultView.addSubview(bmrResultView)
        bmrResultView.translatesAutoresizingMaskIntoConstraints = false
        bmrResultView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bmrResultView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 24).isActive = true
        bmrResultView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 96).isActive = true
        bmrResultView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        
        
        bmrResultView.addSubview(bmrResultValueLabel)
        bmrResultValueLabel.translatesAutoresizingMaskIntoConstraints = false
        bmrResultValueLabel.trailingAnchor.constraint(equalTo: bmrResultView.trailingAnchor, constant: 0).isActive = true
        bmrResultValueLabel.leadingAnchor.constraint(equalTo: bmrResultView.leadingAnchor, constant: 62).isActive = true
        bmrResultValueLabel.topAnchor.constraint(equalTo: bmrResultView.topAnchor, constant: 0).isActive = true
        bmrResultValueLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        bmrResultView.addSubview(bmrResultLabel)
        bmrResultLabel.translatesAutoresizingMaskIntoConstraints = false
        bmrResultLabel.leadingAnchor.constraint(equalTo: bmrResultView.leadingAnchor, constant: 0).isActive = true
        bmrResultLabel.topAnchor.constraint(equalTo: bmrResultView.topAnchor, constant: 0).isActive = true
        bmrResultLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        bmrResultLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        resultView.addSubview(caloriePerDayLabel)
        caloriePerDayLabel.translatesAutoresizingMaskIntoConstraints = false
        caloriePerDayLabel.topAnchor.constraint(equalTo: bmrResultView.bottomAnchor, constant: 12).isActive = true
        caloriePerDayLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 32).isActive = true
        caloriePerDayLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -32).isActive = true
        
        resultView.addSubview(calorieValuePerDayLabel)
        calorieValuePerDayLabel.translatesAutoresizingMaskIntoConstraints = false
        calorieValuePerDayLabel.topAnchor.constraint(equalTo: caloriePerDayLabel.bottomAnchor, constant: 8).isActive = true
        calorieValuePerDayLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 32).isActive = true
        calorieValuePerDayLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -32).isActive = true
        
        resultView.addSubview(caloriePerDayDescripLabel)
        caloriePerDayDescripLabel.translatesAutoresizingMaskIntoConstraints = false
        caloriePerDayDescripLabel.topAnchor.constraint(equalTo: calorieValuePerDayLabel.bottomAnchor, constant: 8).isActive = true
        caloriePerDayDescripLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 32).isActive = true
        caloriePerDayDescripLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -32).isActive = true
        
        //OK Buton
        resultView.addSubview(okButtonResultView)
        okButtonResultView.translatesAutoresizingMaskIntoConstraints = false
        okButtonResultView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        okButtonResultView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        okButtonResultView.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: 8).isActive = true
        okButtonResultView.topAnchor.constraint(equalTo: caloriePerDayDescripLabel.bottomAnchor, constant: 24).isActive = true
        okButtonResultView.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -16).isActive = true
        okButtonResultView.addTarget(self, action: #selector(okButtonResultViewPressed), for: .touchUpInside)
    }
    
    
    //MARK: - Action handle
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            metricStackView.isHidden = false
            imperialStackView.isHidden = true
            genderPicker.selectRow(0, inComponent: 0, animated: true)
            activityPicker.selectRow(0, inComponent: 0, animated: true)
            genderTextfield.text = genderArray[0]
            activityTextfield.text = activityArray[0]
        }else {
            metricStackView.isHidden = true
            imperialStackView.isHidden = false
            genderPicker.selectRow(0, inComponent: 0, animated: true)
            activityPicker.selectRow(0, inComponent: 0, animated: true)
            genderInImperialTextfield.text = genderArray[0]
            sedentaryInImperialTextfield.text = activityArray[0]
        }
    }
    
    @objc func okButtonResultViewPressed() {
        backButton.isHidden = true
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.resultView.alpha = 0
            self.inpurView.alpha = 1
        }, completion: { finished in
            self.resultView.isHidden = true
            self.inpurView.isHidden = false
        })
        
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldTextDidBegin() {
        backButton.isHidden = true
        bottomInputView.constant = 10
        self.topViewAnchorConstant.constant = (self.viewHeight/2 - self.inputViewHeight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.cancelButton.isHidden = false
            self.okButton.isHidden = false
        })
        self.blurView.isHidden = false
    }

    @IBAction func heightDidBegin(_ sender: UITextField) {
        textFieldTextDidBegin()
    }
    
    @IBAction func weightDidBegin(_ sender: UITextField) {
        
       textFieldTextDidBegin()
    }
    @IBAction func ageDidBegin(_ sender: UITextField) {
        
       textFieldTextDidBegin()
    }
    
    @IBAction func genderDidBegin(_ sender: UITextField) {

        backButton.isHidden = true

        bottomInputView.constant = 10
        self.topViewAnchorConstant.constant = (self.viewHeight/2 - self.inputViewHeight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.cancelButton.isHidden = false
            self.okButton.isHidden = false
            self.genderPicker.isHidden = false
            self.activityPicker.isHidden = true
            self.view.endEditing(true)
        })
        self.blurView.isHidden = false
    }
    
    @IBAction func activityLevel(_ sender: UITextField) {
        
        backButton.isHidden = true
        
        bottomInputView.constant = 10
        self.topViewAnchorConstant.constant = (self.viewHeight/2 - self.inputViewHeight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.cancelButton.isHidden = false
            self.okButton.isHidden = false
            self.genderPicker.isHidden = true
            self.activityPicker.isHidden = false
            self.view.endEditing(true)
        })
        self.blurView.isHidden = false
    }
    
    //Imperial did begin
    @IBAction func ftTextfieldDidBegin(_ sender: UITextField) {
        textFieldTextDidBegin()
    }
    @IBAction func inTextfieldDidBegin(_ sender: UITextField) {
        textFieldTextDidBegin()
    }
    @IBAction func lbsWeightTextfieldDidBegin(_ sender: UITextField) {
        textFieldTextDidBegin()
    }
    @IBAction func ageInImperialTextfieldDidBegin(_ sender: Any) {
        textFieldTextDidBegin()
    }
    @IBAction func genderImperialTextfieldDidBegin(_ sender: UITextField) {
        backButton.isHidden = true
        
        bottomInputView.constant = 10
        self.topViewAnchorConstant.constant = (self.viewHeight/2 - self.inputViewHeight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.cancelButton.isHidden = false
            self.okButton.isHidden = false
            self.genderPicker.isHidden = false
            self.activityPicker.isHidden = true
            self.view.endEditing(true)
        })
        self.blurView.isHidden = false
    }
    @IBAction func activityImperialTextfieldDidBegin(_ sender: UITextField) {
        backButton.isHidden = true
        
        bottomInputView.constant = 10
        self.topViewAnchorConstant.constant = (self.viewHeight/2 - self.inputViewHeight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.cancelButton.isHidden = false
            self.okButton.isHidden = false
            self.genderPicker.isHidden = true
            self.activityPicker.isHidden = false
            self.view.endEditing(true)
        })
        self.blurView.isHidden = false
    }
    
    
  
    
    @IBAction func okPressed(_ sender: UIButton) {
        activityPicker.isHidden = true
        genderPicker.isHidden = true 
        calculateBMR()
       
    }
    
    func displayResultAfterOKButtonPressed(bmrValue:Double) {
        if activityIndex == 0 {
            calorieValuePerDayLabel.text = String(round((bmrValue*1.2)*100)/100)
        }else if activityIndex == 1 {
            calorieValuePerDayLabel.text = String(round((bmrValue*1.375)*100)/100)
        }else if activityIndex == 2 {
            calorieValuePerDayLabel.text = String(round((bmrValue*1.55)*100)/100)
        }else if activityIndex == 3 {
            calorieValuePerDayLabel.text = String(round((bmrValue*1.725)*100)/100)
        }else if activityIndex == 4 {
            calorieValuePerDayLabel.text = String(round((bmrValue*1.9)*100)/100)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.resultView.alpha = 1
            self.inpurView.alpha = 0
        }, completion: { finished in
            self.resultView.isHidden = false
            self.inpurView.isHidden = true
            self.activityPicker.isHidden = true
            self.genderPicker.isHidden = true
            self.backButton.isHidden = false
            self.view.endEditing(true)
        })
    }
    
    func calculateBMR() {
        if segmentUnit.selectedSegmentIndex == 0 {
            if weightTextfield.text == "" || heightTextfield.text == "" || ageTextfield.text == "" {
                print("Co nhap weight gi dau ma'")
                AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type.")
            }else {
                if let weight = Float(weightTextfield.text!) , let height = Float(heightTextfield.text!) , let age = Int(ageTextfield.text!){
                    if (weight > 1 && weight < 400) && (height > 30 && height < 250) && (1 <= age && age <= 150) {
                        
                        
                        
                        var bmrValue = 0.0
                        if genderIndex == 0 {
                            let weightPart = 9.6 * weight
                            let heightPart = 1.8 * height
                            let agePart =  4.7 * Float(age)
                            bmrValue = Double(655.1 + weightPart + heightPart - agePart)
                            print(bmrValue)
                            bmrResultValueLabel.text = String(round(bmrValue*100)/100)
                            
                        }else if genderIndex == 1 {
                            let weightPart = 13.7 * weight
                            let heightPart = 5 * height
                            let agePart =  6.8 * Float(age)
                            bmrValue = Double(66.47 + weightPart + heightPart - agePart)
                            print(bmrValue)
                            bmrResultValueLabel.text = String(round(bmrValue*100)/100)
                        }
                        
                        displayResultAfterOKButtonPressed(bmrValue: bmrValue)
                       
                        
                    }else {
                        AlertController.showAlert(inController: self, tilte: "Something is not reasonable", message: "It looks like you entered an unreasonable value 🙄 ")
                    }
                    
                }else {
                    AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type.")
                }
            }
        }else {
            if lbsWeightTextField.text == "" || ftTextfield.text == "" || inTextfield.text == "" || ageInImperialTextfield.text == "" {
                print("Co nhap weight gi dau ma'")
                AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type.")
            }else {
                if let weight = Float(lbsWeightTextField.text!) , let ftHeight = Float(ftTextfield.text!),let inHeight = Float(inTextfield.text!) , let age = Int(ageInImperialTextfield.text!){
                    if (weight > 1 && weight < 800) && (ftHeight > 0 && ftHeight < 11) && (inHeight >= 0 && inHeight < 100) && (1 <= age && age <= 150) {
                        
                        let height = ftHeight * 30.48 + inHeight * 2.54
                        
                        var bmrValue = 0.0
                        if genderIndex == 0 {
                            let weightPart = 9.6 * (weight * 0.45359237)
                            let heightPart = 1.8 * height
                            let agePart =  4.7 * Float(age)
                            bmrValue = Double(655.1 + weightPart + heightPart - agePart)
                            print(bmrValue)
                            bmrResultValueLabel.text = String(round(bmrValue*100)/100)
                            
                        }else if genderIndex == 1 {
                            let weightPart = 13.7 * (weight * 0.45359237)
                            let heightPart = 5 * height
                            let agePart =  6.8 * Float(age)
                            bmrValue = Double(66.47 + weightPart + heightPart - agePart)
                            print(bmrValue)
                            bmrResultValueLabel.text = String(round(bmrValue*100)/100)
                        }
                        
                        displayResultAfterOKButtonPressed(bmrValue: bmrValue)
                        
                        
                    }else {
                        AlertController.showAlert(inController: self, tilte: "Something is not reasonable", message: "It looks like you entered an unreasonable value 🙄 ")
                    }
                    
                }else {
                    AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type.")
                }
            }
        }
        
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        bottomInputView.constant = -20
        self.topViewAnchorConstant.constant = 213
        self.cancelButton.isHidden = true
        self.okButton.isHidden = true
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.activityPicker.isHidden = true
            self.genderPicker.isHidden = true
            self.heightTextfield.text = ""
            self.weightTextfield.text = ""
            self.ageTextfield.text = ""
            self.lbsWeightTextField.text = ""
            self.ftTextfield.text = ""
            self.inTextfield.text = ""
            self.ageInImperialTextfield.text = ""
            self.backButton.isHidden = false
        })
        self.blurView.isHidden = true
        view.endEditing(true)
    }
    
}
