//
//  Sub4ViewController.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 3/20/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class Sub4ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate{
   
    
    
    //MARK: - Outlet variable
    @IBOutlet weak var topViewAnchorConstant: NSLayoutConstraint!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var inpurView: UIView!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var bottomInputView: NSLayoutConstraint!
    @IBOutlet weak var genderTextfield: UITextField!
    @IBOutlet weak var waistTextfield: UITextField!
    @IBOutlet weak var hipTextfield: UITextField!
    
    //Segment setup
    
    @IBOutlet weak var segmentUnit: UISegmentedControl!
    @IBOutlet weak var metricStackView: UIStackView!
    @IBOutlet weak var imperialStackView: UIStackView!
    
    // Outlet in imperial Unit
    @IBOutlet weak var inWaistTextfield: UITextField!
    @IBOutlet weak var inHipWeightTextField: UITextField!
    @IBOutlet weak var genderInImperialTextfield: UITextField!
    
    
    var genderIndex = 0
    var genderArray = ["Female","Male"]
    var textFieldIsChange = UITextField()
    var viewHeight:CGFloat = 0
    var inputViewHeight:CGFloat = 0
    
    
    //MARK: - Picker setup
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
        genderInImperialTextfield.text = genderArray[row]
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
    
    let whrResultView:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    let whrResultLabel: UILabel = {
        let l = UILabel()
        l.text = "WHR"
        l.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return l
    }()
    
    let whrResultValueLabel: UILabel = {
        let l = UILabel()
        l.text = " 0.8"
        l.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        l.layer.cornerRadius = 10.0
        l.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return l
    }()
    
    
    
    let WHRNormsLabel: UILabel = {
        let l = UILabel()
        l.text = "Waist-to-Hip Ratio Norms"
        l.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return l
    }()
    
    //Sub view
    
    let whrCategoryView1:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return v
    }()
    let whrCategoryView1Label: UILabel = {
        let l = UILabel()
        l.text = "WHR < 0.7"
        l.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    let whrCategoryValueView1Label: UILabel = {
        let l = UILabel()
        l.text = "Excellent"
        l.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    
    let whrCategoryView2:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return v
    }()
    let whrCategoryView2Label: UILabel = {
        let l = UILabel()
        l.text = "0.7 ≤ WHR < 0.8 "
        l.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    let whrCategoryValueView2Label: UILabel = {
        let l = UILabel()
        l.text = "Good"
        l.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    
    
    let whrCategoryView3:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return v
    }()
    let whrCategoryView3Label: UILabel = {
        let l = UILabel()
        l.text = "0.8 ≤ WHR < 0.85"
        l.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    let whrCategoryValueView3Label: UILabel = {
        let l = UILabel()
        l.text = "Average"
        l.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    
    
    let whrCategoryView4:UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return v
    }()
    let whrCategoryView4Label: UILabel = {
        let l = UILabel()
        l.text = "0.85 ≤ WHR"
        l.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return l
    }()
    let whrCategoryValueView4Label: UILabel = {
        let l = UILabel()
        l.text = "At Risk"
        l.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.clear
        l.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
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
        resultLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 8).isActive = true
        
        resultView.addSubview(whrResultView)
        whrResultView.translatesAutoresizingMaskIntoConstraints = false
        whrResultView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        whrResultView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 12).isActive = true
        whrResultView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 96).isActive = true
        whrResultView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        
        
        whrResultView.addSubview(whrResultValueLabel)
        whrResultValueLabel.translatesAutoresizingMaskIntoConstraints = false
        whrResultValueLabel.trailingAnchor.constraint(equalTo: whrResultView.trailingAnchor, constant: 0).isActive = true
        whrResultValueLabel.leadingAnchor.constraint(equalTo: whrResultView.leadingAnchor, constant: 72).isActive = true
        whrResultValueLabel.topAnchor.constraint(equalTo: whrResultView.topAnchor, constant: 0).isActive = true
        whrResultValueLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        whrResultView.addSubview(whrResultLabel)
        whrResultLabel.translatesAutoresizingMaskIntoConstraints = false
        whrResultLabel.leadingAnchor.constraint(equalTo: whrResultView.leadingAnchor, constant: 0).isActive = true
        whrResultLabel.topAnchor.constraint(equalTo: whrResultView.topAnchor, constant: 0).isActive = true
        whrResultLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        whrResultLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
      
        
        resultView.addSubview(WHRNormsLabel)
        WHRNormsLabel.translatesAutoresizingMaskIntoConstraints = false
        WHRNormsLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 8).isActive = true
        WHRNormsLabel.topAnchor.constraint(equalTo: whrResultLabel.bottomAnchor, constant: 16).isActive = true
        
        //Sub result View
        
        //Sub view 1
        resultView.addSubview(whrCategoryView1)
        whrCategoryView1.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryView1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        whrCategoryView1.topAnchor.constraint(equalTo: WHRNormsLabel.bottomAnchor, constant: 8).isActive = true
        whrCategoryView1.widthAnchor.constraint(equalToConstant: self.view.frame.width - 48).isActive = true
        whrCategoryView1.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        whrCategoryView1.addSubview(whrCategoryView1Label)
        whrCategoryView1Label.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryView1Label.leadingAnchor.constraint(equalTo: whrCategoryView1.leadingAnchor, constant: 0).isActive = true
        whrCategoryView1Label.topAnchor.constraint(equalTo: whrCategoryView1.topAnchor, constant: 0).isActive = true
        whrCategoryView1Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whrCategoryView1Label.widthAnchor.constraint(equalToConstant: (self.view.frame.width - 48)/2).isActive = true
        
        whrCategoryView1.addSubview(whrCategoryValueView1Label)
        whrCategoryValueView1Label.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryValueView1Label.trailingAnchor.constraint(equalTo: whrCategoryView1.trailingAnchor, constant: 0).isActive = true
        whrCategoryValueView1Label.topAnchor.constraint(equalTo: whrCategoryView1.topAnchor, constant: 0).isActive = true
        whrCategoryValueView1Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whrCategoryValueView1Label.widthAnchor.constraint(equalToConstant: ((self.view.frame.width - 48)/2)).isActive = true
        
        
        //Sub view 2
        resultView.addSubview(whrCategoryView2)
        whrCategoryView2.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryView2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        whrCategoryView2.topAnchor.constraint(equalTo: whrCategoryView1.bottomAnchor, constant: -1).isActive = true
        whrCategoryView2.widthAnchor.constraint(equalToConstant: self.view.frame.width - 48).isActive = true
        whrCategoryView2.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        whrCategoryView2.addSubview(whrCategoryView2Label)
        whrCategoryView2Label.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryView2Label.leadingAnchor.constraint(equalTo: whrCategoryView2.leadingAnchor, constant: 0).isActive = true
        whrCategoryView2Label.topAnchor.constraint(equalTo: whrCategoryView2.topAnchor, constant: 0).isActive = true
        whrCategoryView2Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whrCategoryView2Label.widthAnchor.constraint(equalToConstant: (self.view.frame.width - 48)/2).isActive = true
        
        whrCategoryView2.addSubview(whrCategoryValueView2Label)
        whrCategoryValueView2Label.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryValueView2Label.trailingAnchor.constraint(equalTo: whrCategoryView2.trailingAnchor, constant: 0).isActive = true
        whrCategoryValueView2Label.topAnchor.constraint(equalTo: whrCategoryView2.topAnchor, constant: 0).isActive = true
        whrCategoryValueView2Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whrCategoryValueView2Label.widthAnchor.constraint(equalToConstant: ((self.view.frame.width - 48)/2)).isActive = true
        
        
        //Sub view 3
        resultView.addSubview(whrCategoryView3)
        whrCategoryView3.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryView3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        whrCategoryView3.topAnchor.constraint(equalTo: whrCategoryView2.bottomAnchor, constant: -1).isActive = true
        whrCategoryView3.widthAnchor.constraint(equalToConstant: self.view.frame.width - 48).isActive = true
        whrCategoryView3.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        whrCategoryView3.addSubview(whrCategoryView3Label)
        whrCategoryView3Label.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryView3Label.leadingAnchor.constraint(equalTo: whrCategoryView3.leadingAnchor, constant: 0).isActive = true
        whrCategoryView3Label.topAnchor.constraint(equalTo: whrCategoryView3.topAnchor, constant: 0).isActive = true
        whrCategoryView3Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whrCategoryView3Label.widthAnchor.constraint(equalToConstant: (self.view.frame.width - 48)/2).isActive = true
        
        whrCategoryView3.addSubview(whrCategoryValueView3Label)
        whrCategoryValueView3Label.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryValueView3Label.trailingAnchor.constraint(equalTo: whrCategoryView3.trailingAnchor, constant: 0).isActive = true
        whrCategoryValueView3Label.topAnchor.constraint(equalTo: whrCategoryView3.topAnchor, constant: 0).isActive = true
        whrCategoryValueView3Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whrCategoryValueView3Label.widthAnchor.constraint(equalToConstant: ((self.view.frame.width - 48)/2)).isActive = true
        
        
        //Sub view 4
        resultView.addSubview(whrCategoryView4)
        whrCategoryView4.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryView4.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        whrCategoryView4.topAnchor.constraint(equalTo: whrCategoryView3.bottomAnchor, constant: -1).isActive = true
        whrCategoryView4.widthAnchor.constraint(equalToConstant: self.view.frame.width - 48).isActive = true
        whrCategoryView4.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        whrCategoryView4.addSubview(whrCategoryView4Label)
        whrCategoryView4Label.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryView4Label.leadingAnchor.constraint(equalTo: whrCategoryView4.leadingAnchor, constant: 0).isActive = true
        whrCategoryView4Label.topAnchor.constraint(equalTo: whrCategoryView4.topAnchor, constant: 0).isActive = true
        whrCategoryView4Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whrCategoryView4Label.widthAnchor.constraint(equalToConstant: (self.view.frame.width - 48)/2).isActive = true
        
        whrCategoryView4.addSubview(whrCategoryValueView4Label)
        whrCategoryValueView4Label.translatesAutoresizingMaskIntoConstraints = false
        whrCategoryValueView4Label.trailingAnchor.constraint(equalTo: whrCategoryView4.trailingAnchor, constant: 0).isActive = true
        whrCategoryValueView4Label.topAnchor.constraint(equalTo: whrCategoryView4.topAnchor, constant: 0).isActive = true
        whrCategoryValueView4Label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whrCategoryValueView4Label.widthAnchor.constraint(equalToConstant: ((self.view.frame.width - 48)/2)).isActive = true
        
        //OK Buton
        resultView.addSubview(okButtonResultView)
        okButtonResultView.translatesAutoresizingMaskIntoConstraints = false
        okButtonResultView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        okButtonResultView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        okButtonResultView.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: 8).isActive = true
        okButtonResultView.topAnchor.constraint(equalTo: whrCategoryView4.bottomAnchor, constant: 18).isActive = true
        okButtonResultView.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -16).isActive = true
        okButtonResultView.addTarget(self, action: #selector(okButtonResultViewPressed), for: .touchUpInside)
    }
    
    
    //MARK: - Action handle
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            metricStackView.isHidden = false
            imperialStackView.isHidden = true
            genderPicker.selectRow(0, inComponent: 0, animated: true)
            genderTextfield.text = genderArray[0]
        }else {
            metricStackView.isHidden = true
            imperialStackView.isHidden = false
            genderPicker.selectRow(0, inComponent: 0, animated: true)
            genderInImperialTextfield.text = genderArray[0]
        }
    }
    
    
    @objc func okButtonResultViewPressed() {
        
        whrCategoryView1Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        whrCategoryValueView1Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        whrCategoryView1Label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        whrCategoryValueView1Label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        whrCategoryView2Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        whrCategoryValueView2Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        whrCategoryView2Label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        whrCategoryValueView2Label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        whrCategoryView3Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        whrCategoryValueView3Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        whrCategoryView3Label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        whrCategoryValueView3Label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        whrCategoryView4Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        whrCategoryValueView4Label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        whrCategoryView4Label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        whrCategoryValueView4Label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.resultView.alpha = 0
            self.inpurView.alpha = 1
        }, completion: { finished in
            self.resultView.isHidden = true
            self.inpurView.isHidden = false
            self.backButton.isHidden = true
        })
        
    }
    
    func textfielDidBegin() {
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
    
    @IBAction func waistDidBegin(_ sender: UITextField) {
       textfielDidBegin()
    }
    
    @IBAction func hipDidBegin(_ sender: UITextField) {
        textfielDidBegin()
    }
    
    @IBAction func genderDidBegin(_ sender: UITextField) {
        self.backButton.isHidden = true
        bottomInputView.constant = 10
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
    
    @IBAction func waistInImperialTextfieldDidBegin(_ sender: UITextField) {
        textfielDidBegin()
    }
    
    @IBAction func hipInImperialTextfieldDidBegin(_ sender: UITextField) {
        textfielDidBegin()
    }
    @IBAction func genderInImperialDidBegin(_ sender: UITextField) {
        self.backButton.isHidden = true
        bottomInputView.constant = 10
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
    
    
    func displayAfterOKButtonPressed(WHR: Double) {
        if genderIndex == 0 {
            
            whrCategoryView1Label.text = "WHR < 0.7"
            whrCategoryView2Label.text = "0.7 ≤ WHR < 0.8"
            whrCategoryView3Label.text = "0.8 ≤ WHR < 0.85"
            whrCategoryView4Label.text = "0.85 ≤ WHR"
            
            if WHR < 0.7 {
                whrCategoryView1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                whrCategoryValueView1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                whrCategoryView1Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                whrCategoryValueView1Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else if 0.7 <= WHR && WHR < 0.8 {
                whrCategoryView2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                whrCategoryValueView2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                whrCategoryView2Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                whrCategoryValueView2Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else if 0.8 <= WHR && WHR < 0.85 {
                whrCategoryView3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                whrCategoryValueView3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                whrCategoryView3Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                whrCategoryValueView3Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else if 0.85 <= WHR {
                whrCategoryView4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                whrCategoryValueView4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                whrCategoryView4Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                whrCategoryValueView4Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            
            
        }else if genderIndex == 1 {
            whrCategoryView1Label.text = "WHR < 0.9"
            whrCategoryView2Label.text = "0.9 ≤ WHR < 0.95"
            whrCategoryView3Label.text = "0.95 ≤ WHR < 1"
            whrCategoryView4Label.text = "1 ≤ WHR"
            
            if WHR < 0.9 {
                whrCategoryView1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                whrCategoryValueView1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                whrCategoryView1Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                whrCategoryValueView1Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else if 0.9 <= WHR && WHR < 0.95 {
                whrCategoryView2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                whrCategoryValueView2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                whrCategoryView2Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                whrCategoryValueView2Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else if 0.95 <= WHR && WHR < 1 {
                whrCategoryView3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                whrCategoryValueView3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                whrCategoryView3Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                whrCategoryValueView3Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else if 1 <= WHR {
                whrCategoryView4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                whrCategoryValueView4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                whrCategoryView4Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                whrCategoryValueView4Label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
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
    }
    
    @IBAction func okPressed(_ sender: UIButton) {
        
        if segmentUnit.selectedSegmentIndex == 0 {
            if hipTextfield.text == "" || waistTextfield.text == ""  {
                print("Co nhap weight gi dau ma'")
                AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type.")
            }else {
                if let hip = Double(hipTextfield.text!) , let waist = Double(waistTextfield.text!) {
                    if (hip > 30 && hip < 400) && (waist > 30 && waist < 300) {
                        var WHR  = waist / hip
                        WHR = round(WHR * 100) / 100
                        
                        whrResultValueLabel.text = String(WHR)
                        displayAfterOKButtonPressed(WHR: WHR)
                        
                    }else {
                        AlertController.showAlert(inController: self, tilte: "Something is not reasonable", message: "It looks like you entered an unreasonable value 🙄 ")
                    }
                    
                }else {
                    AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type .")
                }
            }
        }else {
            if inHipWeightTextField.text == "" || inWaistTextfield.text == ""  {
                print("Co nhap weight gi dau ma'")
                AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type.")
            }else {
                let iH = inHipWeightTextField.text!.replacingOccurrences(of: ",", with: ".")
                let iW = inWaistTextfield.text!.replacingOccurrences(of: ",", with: ".")
                if let hip = Double(iH) , let waist = Double(iW) {
                    if (hip > 1 && hip < 200) && (waist > 1 && waist < 200) {
                        var WHR  = waist / hip
                        WHR = round(WHR * 100) / 100
                        
                        whrResultValueLabel.text = String(WHR)
                        displayAfterOKButtonPressed(WHR: WHR)
                        
                    }else {
                        AlertController.showAlert(inController: self, tilte: "Something is not reasonable", message: "It looks like you entered an unreasonable value 🙄 ")
                    }
                    
                }else {
                    AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type .")
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
            self.genderPicker.isHidden = true
            self.waistTextfield.text = ""
            self.hipTextfield.text = ""
            self.inWaistTextfield.text = ""
            self.inHipWeightTextField.text = ""
            self.backButton.isHidden = false
        })
        self.blurView.isHidden = true
        view.endEditing(true)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
}
