//
//  Sub3ViewController.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 3/20/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class Sub3ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    
    
    //MARK: - Outlet variable
    @IBOutlet weak var topViewAnchorConstant: NSLayoutConstraint!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var inpurView: UIView!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var bottomInputView: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var genderTextfield: UITextField!
    @IBOutlet weak var waistTextfield: UITextField!
    @IBOutlet weak var weightTextfield: UITextField!
    
    
    var textFieldIsChange = UITextField()
    var viewHeight:CGFloat = 0
    var inputViewHeight:CGFloat = 0
    var genderIndex = 0
    
    //MARK: - Picker setup
    let genderArray = ["Female", "Male"]
    @IBOutlet weak var genderPicker: UIPickerView!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderIndex = row
        genderTextfield.text = genderArray[row]
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
    
    let bodyFatResultView:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    let bodyFatResultLabel: UILabel = {
        let l = UILabel()
        l.text = "Body fat"
        l.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.light)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return l
    }()
    
    let bodyFatResultValueLabel: UILabel = {
        let l = UILabel()
        l.text = " 16.5 %"
        l.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        l.layer.cornerRadius = 10.0
        l.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return l
    }()
    
    let fatMassLabel: UILabel = {
        let l = UILabel()
        l.text = "Fat Mass"
        l.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return l
    }()
    
    let fatMassValueLabel: UILabel = {
        let l = UILabel()
        l.text = "9 kg"
        l.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return l
    }()
    
   
    
    let categoryLabel: UILabel = {
        let l = UILabel()
        l.text = "Category"
        l.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return l
    }()
    
    let categoryValueLabel: UILabel = {
        let l = UILabel()
        l.text = "Fit"
        l.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewHeight = view.frame.height
        inputViewHeight = inpurView.frame.height
        genderPicker.delegate = self
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
        
        resultView.addSubview(bodyFatResultView)
        bodyFatResultView.translatesAutoresizingMaskIntoConstraints = false
        bodyFatResultView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bodyFatResultView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 24).isActive = true
        bodyFatResultView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 88).isActive = true
        bodyFatResultView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        
        
        bodyFatResultView.addSubview(bodyFatResultValueLabel)
        bodyFatResultValueLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyFatResultValueLabel.trailingAnchor.constraint(equalTo: bodyFatResultView.trailingAnchor, constant: 0).isActive = true
        bodyFatResultValueLabel.leadingAnchor.constraint(equalTo: bodyFatResultView.leadingAnchor, constant: 82).isActive = true
        bodyFatResultValueLabel.topAnchor.constraint(equalTo: bodyFatResultView.topAnchor, constant: 0).isActive = true
        bodyFatResultValueLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        bodyFatResultView.addSubview(bodyFatResultLabel)
        bodyFatResultLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyFatResultLabel.leadingAnchor.constraint(equalTo: bodyFatResultView.leadingAnchor, constant: 0).isActive = true
        bodyFatResultLabel.topAnchor.constraint(equalTo: bodyFatResultView.topAnchor, constant: 0).isActive = true
        bodyFatResultLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        bodyFatResultLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
  
        resultView.addSubview(fatMassLabel)
        fatMassLabel.translatesAutoresizingMaskIntoConstraints = false
        fatMassLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 32).isActive = true
        fatMassLabel.topAnchor.constraint(equalTo: bodyFatResultView.bottomAnchor, constant: 24).isActive = true
        
        resultView.addSubview(fatMassValueLabel)
        fatMassValueLabel.translatesAutoresizingMaskIntoConstraints = false
        fatMassValueLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: view.frame.width/2).isActive = true
        fatMassValueLabel.topAnchor.constraint(equalTo: bodyFatResultView.bottomAnchor, constant: 24).isActive = true
        
        
       
        
        resultView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 32).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: fatMassValueLabel.bottomAnchor, constant: 12).isActive = true
        
        resultView.addSubview(categoryValueLabel)
        categoryValueLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryValueLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: view.frame.width/2).isActive = true
        categoryValueLabel.topAnchor.constraint(equalTo: fatMassValueLabel.bottomAnchor, constant: 12).isActive = true
        
        //OK Buton
        resultView.addSubview(okButtonResultView)
        okButtonResultView.translatesAutoresizingMaskIntoConstraints = false
        okButtonResultView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        okButtonResultView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        okButtonResultView.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: 8).isActive = true
        okButtonResultView.topAnchor.constraint(equalTo: categoryValueLabel.bottomAnchor, constant: 24).isActive = true
        okButtonResultView.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -16).isActive = true
        okButtonResultView.addTarget(self, action: #selector(okButtonResultViewPressed), for: .touchUpInside)
    }
    
    
    //MARK: - Action handle
    @objc func okButtonResultViewPressed() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.resultView.alpha = 0
            self.inpurView.alpha = 1
        }, completion: { finished in
            self.resultView.isHidden = true
            self.inpurView.isHidden = false
            self.backButton.isHidden = true
        })
        
    }
    
    @IBAction func waistDidBegin(_ sender: UITextField) {
        bottomInputView.constant = 10
        self.backButton.isHidden = true
        self.topViewAnchorConstant.constant = (self.viewHeight/2 - self.inputViewHeight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.cancelButton.isHidden = false
            self.okButton.isHidden = false
        })
        self.blurView.isHidden = false
    }
    
    @IBAction func weightDidBegin(_ sender: UITextField) {
        bottomInputView.constant = 10
        self.backButton.isHidden = true
        self.topViewAnchorConstant.constant = (self.viewHeight/2 - self.inputViewHeight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.cancelButton.isHidden = false
            self.okButton.isHidden = false
        })
        self.blurView.isHidden = false
    }
    @IBAction func genderDidBegin(_ sender: UITextField) {
        bottomInputView.constant = 10
        self.backButton.isHidden = true
        self.topViewAnchorConstant.constant = (self.viewHeight/2 - self.inputViewHeight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.cancelButton.isHidden = false
            self.okButton.isHidden = false
            self.genderPicker.isHidden = false
            self.view.endEditing(true)
        })
        self.blurView.isHidden = false
    }
    
    
    @IBAction func okPressed(_ sender: UIButton) {
        
        if weightTextfield.text == "" || waistTextfield.text == ""  {
            print("Co nhap weight gi dau ma'")
            AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type of weight or height.")
        }else {
            if var weight = Double(weightTextfield.text!) , var waist = Double(waistTextfield.text!) {
                if (weight > 1 && weight < 400) && (waist > 30 && waist < 300) {
                    weight = weight * 2.2
                    waist = waist / 2.54
                    var YMCA = 0.0
                    if genderIndex == 0 {
                        YMCA = (-76.76 + 4.15 * waist - 0.082 * weight)/weight
                        
                    }else if genderIndex == 1 {
                        YMCA = (-98.42 + 4.15 * waist - 0.082 * weight)/weight
                    }
                    
                    var fatMass = (weight / 2.2) * YMCA
                    fatMass = round(fatMass*100)/100
                    fatMassValueLabel.text = "\(fatMass) kg"
                    
                    YMCA = YMCA * 100
                    YMCA = round(YMCA*100)/100
                    if (YMCA >= 0 ) {
                        
                        bodyFatResultValueLabel.text = " \(YMCA) %"
                    }else {
                        bodyFatResultValueLabel.text = " 0.0 %"
                    }
                    
                    
                    //Category
                    if genderIndex == 0 {
                      //categoryValueLabel
                        if YMCA < 14 {
                            categoryValueLabel.text = "Essential Fat"
                        }else if 14 <= YMCA && YMCA < 20 {
                            categoryValueLabel.text = "Typical Athletes"
                        }else if 20 <= YMCA && YMCA < 24 {
                            categoryValueLabel.text = "Fitness "
                        }else if 24 <= YMCA && YMCA < 31 {
                            categoryValueLabel.text = "Acceptable"
                        }else if 31 <= YMCA  {
                            categoryValueLabel.text = "Obese"
                        }
                    }else if genderIndex == 1 {
                        if  YMCA < 6 {
                            categoryValueLabel.text = "Essential Fat"
                        }else if 6 <= YMCA && YMCA < 13 {
                            categoryValueLabel.text = "Typical Athletes"
                        }else if 13 <= YMCA && YMCA < 17 {
                            categoryValueLabel.text = "Fitness "
                        }else if 17 <= YMCA && YMCA < 25 {
                            categoryValueLabel.text = "Acceptable"
                        }else if 25 <= YMCA  {
                            categoryValueLabel.text = "Obese"
                        }
                    }
                    
                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                        self.resultView.alpha = 1
                        self.inpurView.alpha = 0
                    }, completion: { finished in
                        self.resultView.isHidden = false
                        self.inpurView.isHidden = true
                        self.genderPicker.isHidden = true
                        self.backButton.isHidden = false
                        self.view.endEditing(true)
                    })
                }else {
                    AlertController.showAlert(inController: self, tilte: "Something is not reasonable", message: "It looks like you entered an unreasonable value 🙄 ")
                }
                
            }else {
                AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type of weight or height.")
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
             self.genderPicker.isHidden = true
            self.waistTextfield.text = ""
            self.weightTextfield.text = ""
            self.backButton.isHidden = false
        })
        self.blurView.isHidden = true
        view.endEditing(true)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

   

}
