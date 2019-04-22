//
//  Sub1ViewController.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 3/20/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class Sub1ViewController: UIViewController , UITextFieldDelegate{

    
    //MARK: - Outlet variable
    @IBOutlet weak var topViewAnchorConstant: NSLayoutConstraint!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var inpurView: UIView!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var bottomInputView: NSLayoutConstraint!
    
    @IBOutlet weak var weightTextfield: UITextField!
    
    @IBOutlet weak var heightTextfield: UITextField!
    
    
    // Outlet in imperial Unit
    
    @IBOutlet weak var ftTextfield: UITextField!
    @IBOutlet weak var inTextfield: UITextField!
    @IBOutlet weak var weightInLbsTextfield: UITextField!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField ==  ftTextfield {
            return range.location <= 4
        } else if textField ==  inTextfield {
            return range.location <= 4
        }
        else {
            return range.location <= 10
        }
    }
    
    var textFieldIsChange = UITextField()
    var viewHeight:CGFloat = 0
    var inputViewHeight:CGFloat = 0
    
    //MARK: - Result View Variable
    let resultView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
    
    let bmiResultView:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    let bmiResultLabel: UILabel = {
        let l = UILabel()
        l.text = "BMI"
        l.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.light)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return l
    }()
    
    let bmiResultValueLabel: UILabel = {
        let l = UILabel()
        l.text = " 20.43"
        l.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        l.layer.cornerRadius = 10.0
        l.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return l
    }()
    
    let bmiCategoryView1:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return v
    }()
    let bmiCategoryView1Label: UILabel = {
        let l = UILabel()
        l.text = "BMI ≤ 18.5"
        l.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    let bmiCategoryValueView1Label: UILabel = {
        let l = UILabel()
        l.text = "Underweight"
        l.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    
    let bmiCategoryView2:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return v
    }()
    let bmiCategoryView2Label: UILabel = {
        let l = UILabel()
        l.text = "18.5 < BMI ≤ 25 "
        l.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    let bmiCategoryValueView2Label: UILabel = {
        let l = UILabel()
        l.text = "Normal weight"
        l.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    
    
    let bmiCategoryView3:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return v
    }()
    let bmiCategoryView3Label: UILabel = {
        let l = UILabel()
        l.text = "25 < BMI ≤ 30"
        l.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    let bmiCategoryValueView3Label: UILabel = {
        let l = UILabel()
        l.text = "Overweight"
        l.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    
    
    let bmiCategoryView4:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return v
    }()
    let bmiCategoryView4Label: UILabel = {
        let l = UILabel()
        l.text = "30 ≤ BMI"
        l.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    let bmiCategoryValueView4Label: UILabel = {
        let l = UILabel()
        l.text = "Obesity"
        l.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    
    //Segment Setup
    @IBOutlet weak var segmentUnit: UISegmentedControl!
    @IBOutlet weak var metricStackView: UIStackView!
    @IBOutlet weak var imperialStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewHeight = view.frame.height
        inputViewHeight = inpurView.frame.height
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
        
        resultView.addSubview(bmiResultView)
        bmiResultView.translatesAutoresizingMaskIntoConstraints = false
        bmiResultView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bmiResultView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 24).isActive = true
        bmiResultView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 96).isActive = true
        bmiResultView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
       
        
        bmiResultView.addSubview(bmiResultValueLabel)
        bmiResultValueLabel.translatesAutoresizingMaskIntoConstraints = false
        bmiResultValueLabel.trailingAnchor.constraint(equalTo: bmiResultView.trailingAnchor, constant: 0).isActive = true
        bmiResultValueLabel.leadingAnchor.constraint(equalTo: bmiResultView.leadingAnchor, constant: 62).isActive = true
        bmiResultValueLabel.topAnchor.constraint(equalTo: bmiResultView.topAnchor, constant: 0).isActive = true
        bmiResultValueLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        bmiResultView.addSubview(bmiResultLabel)
        bmiResultLabel.translatesAutoresizingMaskIntoConstraints = false
        bmiResultLabel.leadingAnchor.constraint(equalTo: bmiResultView.leadingAnchor, constant: 0).isActive = true
        bmiResultLabel.topAnchor.constraint(equalTo: bmiResultView.topAnchor, constant: 0).isActive = true
        bmiResultLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        bmiResultLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        //Sub view 1
        resultView.addSubview(bmiCategoryView1)
        bmiCategoryView1.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryView1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bmiCategoryView1.topAnchor.constraint(equalTo: bmiResultView.bottomAnchor, constant: 24).isActive = true
        bmiCategoryView1.widthAnchor.constraint(equalToConstant: self.view.frame.width - 48).isActive = true
        bmiCategoryView1.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        bmiCategoryView1.addSubview(bmiCategoryView1Label)
        bmiCategoryView1Label.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryView1Label.leadingAnchor.constraint(equalTo: bmiCategoryView1.leadingAnchor, constant: 0).isActive = true
        bmiCategoryView1Label.topAnchor.constraint(equalTo: bmiCategoryView1.topAnchor, constant: 0).isActive = true
        bmiCategoryView1Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        bmiCategoryView1Label.widthAnchor.constraint(equalToConstant: (self.view.frame.width - 48)/2).isActive = true
        
        bmiCategoryView1.addSubview(bmiCategoryValueView1Label)
        bmiCategoryValueView1Label.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryValueView1Label.trailingAnchor.constraint(equalTo: bmiCategoryView1.trailingAnchor, constant: 0).isActive = true
        bmiCategoryValueView1Label.topAnchor.constraint(equalTo: bmiCategoryView1.topAnchor, constant: 0).isActive = true
        bmiCategoryValueView1Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        bmiCategoryValueView1Label.widthAnchor.constraint(equalToConstant: ((self.view.frame.width - 48)/2)-1).isActive = true
        
        
        //Sub view 2
        resultView.addSubview(bmiCategoryView2)
        bmiCategoryView2.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryView2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bmiCategoryView2.topAnchor.constraint(equalTo: bmiCategoryView1.bottomAnchor, constant: -1).isActive = true
        bmiCategoryView2.widthAnchor.constraint(equalToConstant: self.view.frame.width - 48).isActive = true
        bmiCategoryView2.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        bmiCategoryView2.addSubview(bmiCategoryView2Label)
        bmiCategoryView2Label.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryView2Label.leadingAnchor.constraint(equalTo: bmiCategoryView2.leadingAnchor, constant: 0).isActive = true
        bmiCategoryView2Label.topAnchor.constraint(equalTo: bmiCategoryView2.topAnchor, constant: 0).isActive = true
        bmiCategoryView2Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        bmiCategoryView2Label.widthAnchor.constraint(equalToConstant: (self.view.frame.width - 48)/2).isActive = true
        
        bmiCategoryView2.addSubview(bmiCategoryValueView2Label)
        bmiCategoryValueView2Label.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryValueView2Label.trailingAnchor.constraint(equalTo: bmiCategoryView2.trailingAnchor, constant: 0).isActive = true
        bmiCategoryValueView2Label.topAnchor.constraint(equalTo: bmiCategoryView2.topAnchor, constant: 0).isActive = true
        bmiCategoryValueView2Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        bmiCategoryValueView2Label.widthAnchor.constraint(equalToConstant: ((self.view.frame.width - 48)/2)-1).isActive = true
        
        
        //Sub view 3
        resultView.addSubview(bmiCategoryView3)
        bmiCategoryView3.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryView3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bmiCategoryView3.topAnchor.constraint(equalTo: bmiCategoryView2.bottomAnchor, constant: -1).isActive = true
        bmiCategoryView3.widthAnchor.constraint(equalToConstant: self.view.frame.width - 48).isActive = true
        bmiCategoryView3.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        bmiCategoryView3.addSubview(bmiCategoryView3Label)
        bmiCategoryView3Label.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryView3Label.leadingAnchor.constraint(equalTo: bmiCategoryView3.leadingAnchor, constant: 0).isActive = true
        bmiCategoryView3Label.topAnchor.constraint(equalTo: bmiCategoryView3.topAnchor, constant: 0).isActive = true
        bmiCategoryView3Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        bmiCategoryView3Label.widthAnchor.constraint(equalToConstant: (self.view.frame.width - 48)/2).isActive = true
        
        bmiCategoryView3.addSubview(bmiCategoryValueView3Label)
        bmiCategoryValueView3Label.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryValueView3Label.trailingAnchor.constraint(equalTo: bmiCategoryView3.trailingAnchor, constant: 0).isActive = true
        bmiCategoryValueView3Label.topAnchor.constraint(equalTo: bmiCategoryView3.topAnchor, constant: 0).isActive = true
        bmiCategoryValueView3Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        bmiCategoryValueView3Label.widthAnchor.constraint(equalToConstant: ((self.view.frame.width - 48)/2)-1).isActive = true
        
        
        //Sub view 4
        resultView.addSubview(bmiCategoryView4)
        bmiCategoryView4.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryView4.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bmiCategoryView4.topAnchor.constraint(equalTo: bmiCategoryView3.bottomAnchor, constant: -1).isActive = true
        bmiCategoryView4.widthAnchor.constraint(equalToConstant: self.view.frame.width - 48).isActive = true
        bmiCategoryView4.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        bmiCategoryView4.addSubview(bmiCategoryView4Label)
        bmiCategoryView4Label.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryView4Label.leadingAnchor.constraint(equalTo: bmiCategoryView4.leadingAnchor, constant: 0).isActive = true
        bmiCategoryView4Label.topAnchor.constraint(equalTo: bmiCategoryView4.topAnchor, constant: 0).isActive = true
        bmiCategoryView4Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        bmiCategoryView4Label.widthAnchor.constraint(equalToConstant: (self.view.frame.width - 48)/2).isActive = true
        
        bmiCategoryView4.addSubview(bmiCategoryValueView4Label)
        bmiCategoryValueView4Label.translatesAutoresizingMaskIntoConstraints = false
        bmiCategoryValueView4Label.trailingAnchor.constraint(equalTo: bmiCategoryView4.trailingAnchor, constant: 0).isActive = true
        bmiCategoryValueView4Label.topAnchor.constraint(equalTo: bmiCategoryView4.topAnchor, constant: 0).isActive = true
        bmiCategoryValueView4Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        bmiCategoryValueView4Label.widthAnchor.constraint(equalToConstant: ((self.view.frame.width - 48)/2)-1).isActive = true
        
        
        
        //OK Buton
        resultView.addSubview(okButtonResultView)
        okButtonResultView.translatesAutoresizingMaskIntoConstraints = false
        okButtonResultView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        okButtonResultView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        okButtonResultView.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: 8).isActive = true
        okButtonResultView.topAnchor.constraint(equalTo: bmiCategoryView4.bottomAnchor, constant: 24).isActive = true
        okButtonResultView.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -16).isActive = true
        okButtonResultView.addTarget(self, action: #selector(okButtonResultViewPressed), for: .touchUpInside)
    }
    
  
    //MARK: - Action handle
    
    @IBAction func selectValueOfSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            metricStackView.isHidden = false
            imperialStackView.isHidden = true
        }else {
            metricStackView.isHidden = true
            imperialStackView.isHidden = false
        }
    }
    
    @objc func okButtonResultViewPressed() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.resultView.alpha = 0
            self.inpurView.alpha = 1
        }, completion: { finished in
            self.resultView.isHidden = true
            self.inpurView.isHidden = false
            self.backButton.isHidden = true
        })
        
            bmiCategoryView1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            bmiCategoryView1Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryValueView1Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryView2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            bmiCategoryView2Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryValueView2Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryView3.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            bmiCategoryView3Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryValueView3Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryView4.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            bmiCategoryView4Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryValueView4Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    func bmiDisplayCategory(bmiValue:Float) {
        if bmiValue <= 18.5 {
            bmiCategoryView1.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryView1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            bmiCategoryValueView1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if 18.5 < bmiValue && bmiValue <= 25 {
            bmiCategoryView2.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryView2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            bmiCategoryValueView2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else if 25 < bmiValue && bmiValue <= 30 {
            bmiCategoryView3.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryView3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            bmiCategoryValueView3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else {
            bmiCategoryView4.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmiCategoryView4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            bmiCategoryValueView4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okPressed(_ sender: UIButton) {
        
        if segmentUnit.selectedSegmentIndex == 0 {
            if weightTextfield.text == "" || heightTextfield.text == ""  {
                print("Co nhap weight gi dau ma'")
                AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type of weight or height.")
            }else {
                let w = weightTextfield.text!.replacingOccurrences(of: ",", with: ".")
                if let weight = Float(w) , var height = Float(heightTextfield.text!) {
                    if (weight > 1 && weight < 400) && (height > 30 && height < 250) {
                        
                        //Calculate the BMI value
                        height = height/100
                        
                        var bmiValue = weight / (height*height)
                        bmiValue = round(bmiValue*100)/100
                        bmiResultValueLabel.text = String(bmiValue)
                        
                       bmiDisplayCategory(bmiValue: bmiValue)
                        
                        
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                            self.resultView.alpha = 1
                            self.inpurView.alpha = 0
                        }, completion: { finished in
                            self.resultView.isHidden = false
                            self.inpurView.isHidden = true
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
        }else {
            print("Chua co code dong nao ong oi !")
            if weightInLbsTextfield.text == "" || ftTextfield.text == "" || inTextfield.text == "" {
                print("Co nhap weight gi dau ma'")
                AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type of weight or height.")
            }else {
                let w = weightInLbsTextfield.text!.replacingOccurrences(of: ",", with: ".")
                let iH = inTextfield.text!.replacingOccurrences(of: ",", with: ".")
                if let weight = Float(w) , let ftHeight = Float(ftTextfield.text!) , let inHeight = Float(iH){
                    if (weight > 10 && weight < 800) && (ftHeight > 0 && ftHeight < 11) && (inHeight >= 0 && inHeight < 100) {
                        
                        //Calculate the BMI value
                        var height = ftHeight * 30.48 + inHeight * 2.54
                        height = height/100
                        
                        var bmiValue = (weight * 0.45359237) / (height*height)
                        bmiValue = round(bmiValue*100)/100
                        bmiResultValueLabel.text = String(bmiValue)
                        
                        bmiDisplayCategory(bmiValue: bmiValue)
                        
                        
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                            self.resultView.alpha = 1
                            self.inpurView.alpha = 0
                        }, completion: { finished in
                            self.resultView.isHidden = false
                            self.inpurView.isHidden = true
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
       
      
        
       
       
    }
    
    func setUpBeginEditTF() {
        self.backButton.isHidden = true
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

    @IBAction func beginEditingWeightTextfield(_ sender: UITextField) {
        setUpBeginEditTF()
    }

    @IBAction func beginEditingHeightTextfield(_ sender: UITextField) {
        setUpBeginEditTF()
    }
    
    // Imperial edit
    @IBAction func beginEditingImperialHeightTextfield(_ sender: UITextField) {
        setUpBeginEditTF()
    }
    
    @IBAction func beginEditingImperialFtTextfield(_ sender: UITextField) {
        setUpBeginEditTF()
    }
    
    @IBAction func beginEditingImperialTextfield(_ sender: UITextField) {
        setUpBeginEditTF()
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        bottomInputView.constant = -20
        self.topViewAnchorConstant.constant = 213
        self.cancelButton.isHidden = true
        self.okButton.isHidden = true
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.weightTextfield.text = ""
            self.heightTextfield.text = ""
            self.backButton.isHidden = false
            
            self.inTextfield.text = ""
            self.ftTextfield.text = ""
            self.weightInLbsTextfield.text = ""
        })
         self.blurView.isHidden = true
        view.endEditing(true)
    }
   

}
