//
//  ToolCell.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 3/6/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ToolCellDelegate {
    func checkIfWrongInputToolCell()
    func enterWeightFirst()
    func enterInitialWeight()
    func enterDesiredWeight(dWeight:Double)
}


class ToolCell: BaseCell,UITextFieldDelegate {
    
    var delegate: ToolCellDelegate?
    var people = [Person]()
    var weightUnit = ""
    var heightUnit = ""
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request : NSFetchRequest<Person> = Person.fetchRequest()
    
    let defaults = UserDefaults.standard
    var height: Double = -1
    var ftHeight:Double = -1
    var inHeight:Double = -1
    var desiredWeight:Double = -1
    var completedRate: Double = 0.0
    
    //MARK: - Input View Var
   
    
    let profileView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      
        return v
    }()
    

    
    let roundView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.839170162, green: 0.7727752205, blue: 0.9737234748, alpha: 0.799091737)
        v.layer.cornerRadius = 6.0
        v.layer.masksToBounds = true
        
        return v
    }()
    
    let profileLabel:UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.text = "( This table only appears when you start or want to change your weight goal. )"
        label.font = UIFont(name:"TrebuchetMS-Italic", size: 15)
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    let cmLabel:UILabel = {
        let label = UILabel()
        label.text = "cm"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()
    
    let kgLabel:UILabel = {
        let label = UILabel()
        label.text = "kg"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()
    
    let enterButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        bt.setTitle("Let's go !!!", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name:"Avenir-Light", size: 20)
        bt.layer.cornerRadius = 18
        bt.layer.borderWidth = 1.5
        bt.layer.borderColor =  #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        
        return bt
    }()
    
    let inputHeightTextfield :UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string:"Your height ", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),NSAttributedString.Key.font :UIFont(name: "Arial", size: 18)!])
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.isUserInteractionEnabled = true
        tf.setBottomBorder()
        return tf
    }()
    
    // ft vs in input
    let inputFtHeightTextfield :UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string:" ", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),NSAttributedString.Key.font :UIFont(name: "Arial", size: 18)!])
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.isUserInteractionEnabled = true
        tf.setBottomBorder()
        return tf
    }()
    
    let inputInHeightTextfield :UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string:" ", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),NSAttributedString.Key.font :UIFont(name: "Arial", size: 18)!])
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.textAlignment = .center
        tf.keyboardType = .decimalPad
        tf.isUserInteractionEnabled = true
        tf.setBottomBorder()
        return tf
    }()
    
    let ftLabel:UILabel = {
        let label = UILabel()
        label.text = "ft"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()
    
    let inLabel:UILabel = {
        let label = UILabel()
        label.text = "in"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()
    
    let desiredWeightTextfield :UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string:"Your desired weight", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),NSAttributedString.Key.font :UIFont(name: "Arial", size: 18)!])
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.textAlignment = .center
        tf.keyboardType = .decimalPad
        tf.isUserInteractionEnabled = true
        tf.setBottomBorder()
        return tf
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()
    
    let targetWeightLabel: UILabel = {
        let label = UILabel()
        label.text = "Desired weight"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()
    
    //MARK: - DetailView var
    let scrollView : UIScrollView = {
        let sV = UIScrollView()
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.contentSize.height = 580
        
        return sV
    }()
    
    let detailView:UIView = {
       let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        return v
    }()
    
    let progressView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        v.layer.cornerRadius = 12.0
        v.layer.borderWidth = 1.5
        v.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.layer.masksToBounds = true
        return v
    }()
    
    let progressTitleView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        v.layer.masksToBounds = true
        return v
    }()
    
    let changeProfileImageButton: UIImageView =  {
        let image = UIImage(named: "enterButtonImage")
        let ui = UIImageView(image: image)
        ui.layer.cornerRadius = 12
        ui.clipsToBounds = true
        
        return ui
    }()
    
    let changeProfileButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        bt.setTitle("Set target  ", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name:"TrebuchetMS", size: 18)
        bt.layer.cornerRadius = 12
        bt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        return bt
    }()
    
    let BMILabel:UILabel = {
        let label = UILabel()
        label.text = "BMI"
        label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        label.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return label
    }()
    
    let BMIValueLabel:UILabel = {
        let label = UILabel()
        label.text = "20.54"
        label.font = UIFont.systemFont(ofSize: 52, weight: UIFont.Weight.bold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        label.layer.borderWidth = 1.5
        label.layer.cornerRadius = 5.0
        return label
    }()
    
    let kgValueLabel:UILabel = {
        let label = UILabel()
        label.text = "65 kg"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return label
    }()
    
    let cmValueLabel:UILabel = {
        let label = UILabel()
        label.text = "168 cm"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return label
    }()
    
    var kgCmStackView = UIStackView()

    let lineDetailView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9991492523)
        
        return v
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return label
    }()
    
    let categoryValueLabel:UILabel = {
        let label = UILabel()
        label.text = "Normal (healthy weight)"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let riskLabel:UILabel = {
        let label = UILabel()
        label.text = "Risks of diseases (obesity)"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return label
    }()
    
    let riskValueLabel:UILabel = {
        let label = UILabel()
        label.text = "Medium"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    //Progress View
    var shapeLayer: CAShapeLayer!
    var backgoundShapeLayer:CAShapeLayer!
    var lineShapeLayer:CAShapeLayer!
    var borderBackgoundShapeLayer:CAShapeLayer!
    let percentlabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
        l.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return l
    }()
    
    let currentWeightlabel : UILabel = {
        let l = UILabel()
        l.text = "Current weight: 64 kg"
        l.font = UIFont(name:"TrebuchetMS", size: 16)
        l.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return l
    }()
    
    let progressTitlelabel : UILabel = {
        let l = UILabel()
        l.text = "Weight change process"
        l.font = UIFont(name:"TrebuchetMS", size: 18)
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return l
    }()
    
    let initWeightlabel : UILabel = {
        let l = UILabel()
        l.text = "70.0 kg"
        l.font = UIFont.systemFont(ofSize: 17)
        l.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return l
    }()
    
    let initWeightButton : UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "resetIcon")
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 1
        btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.clipsToBounds = true
        btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6512054256)
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    let targetWeightlabel : UILabel = {
        let l = UILabel()
        l.text = "60.0 kg"
        l.font = UIFont.systemFont(ofSize: 17)
        l.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return l
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField ==  inputFtHeightTextfield {
            return range.location <= 1
        } else if textField ==  inputInHeightTextfield {
            return range.location <= 2
        }
        else {
            return range.location <= 10
        }
    }
    
    //MARK: - Setup View
    override func setUpView() {
        super.setUpView()
        backgroundColor = #colorLiteral(red: 0.839170162, green: 0.7727752205, blue: 0.9737234748, alpha: 0.799091737)
        
        inputInHeightTextfield.delegate = self
        inputFtHeightTextfield.delegate = self
        
        setInputView()
        setDetailView()
        setProgressView()
       
        
        do {
            try people = context.fetch(request)
        } catch  {
            print("Error to fetch Item data")
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
        
        if defaults.bool(forKey: "wasShowInput") == true {
            setProfileViewPosition()
          
        }
        
        if people.count != 0 {
            calculateAndShowBMIValue()
        }
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        endEditing(true)
    }
    //MARK: - ProgressView SETUP
    func setProgressView() {
        borderBackgoundShapeLayer = initialChart(withStrokeColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), withLineWidth: 9, byFillColor: UIColor.clear.cgColor, withStrokeEnd: 1)
        
        backgoundShapeLayer = initialChart(withStrokeColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1), withLineWidth: 8, byFillColor: UIColor.clear.cgColor, withStrokeEnd: 1)
        
         lineShapeLayer = initialChart(withStrokeColor: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), withLineWidth: 1, byFillColor: UIColor.clear.cgColor, withStrokeEnd: 1)
        
        shapeLayer = initialChart(withStrokeColor: UIColor.red.cgColor, withLineWidth: 6, byFillColor: UIColor.clear.cgColor, withStrokeEnd: 0)
        
        progressView.layer.addSublayer(borderBackgoundShapeLayer)
        progressView.layer.addSublayer(backgoundShapeLayer)
        progressView.layer.addSublayer(lineShapeLayer)
        progressView.layer.addSublayer(shapeLayer)
        
        //Add % Label
        progressView.addSubview(percentlabel)
        percentlabel.translatesAutoresizingMaskIntoConstraints = false
        percentlabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        percentlabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor, constant: 5).isActive = true
        
        
        // Add currentWeightlabel
        progressView.addSubview(currentWeightlabel)
        currentWeightlabel.translatesAutoresizingMaskIntoConstraints = false
        currentWeightlabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 12.0).isActive = true
        currentWeightlabel.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -5.0).isActive = true
        
        progressView.addSubview(progressTitlelabel)
        progressTitlelabel.translatesAutoresizingMaskIntoConstraints = false
        progressTitlelabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 10.0).isActive = true
        progressTitlelabel.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 3.0).isActive = true
        
        // Add currentWeightlabel
        progressView.addSubview(initWeightlabel)
        initWeightlabel.translatesAutoresizingMaskIntoConstraints = false
        initWeightlabel.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -28).isActive = true
        initWeightlabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor, constant: -70.0).isActive = true
        
        
        progressView.addSubview(initWeightButton)
        initWeightButton.translatesAutoresizingMaskIntoConstraints = false
        initWeightButton.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -25).isActive = true
        initWeightButton.trailingAnchor.constraint(equalTo: initWeightlabel.leadingAnchor, constant: -5.0).isActive = true
        initWeightButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        initWeightButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        initWeightButton.addTarget(self, action: #selector(seInitialWeight), for: .touchUpInside)
        
        
        
        
        
        // Add targetWeightlabel
        progressView.addSubview(targetWeightlabel)
        targetWeightlabel.translatesAutoresizingMaskIntoConstraints = false
        targetWeightlabel.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -28.0).isActive = true
        targetWeightlabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor, constant: 70).isActive = true
        
        startChart()
    }
    
    
    
    //MARK: - Chart SETUP
    func startChart() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = completedRate
        basicAnimation.duration = 2

        //percentlabel.text = String(round(10*(completedRate*100))/10) + "%"

        shapeLayer.strokeColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    func initialChart(withStrokeColor strokeColor: CGColor, withLineWidth lineWidth:CGFloat, byFillColor fillColor: CGColor, withStrokeEnd strockEnd:CGFloat)->CAShapeLayer {
        
        let centerpoint = CGPoint.zero
        let circularPath = UIBezierPath(arcCenter: centerpoint, radius: 85, startAngle: 0.9 * CGFloat.pi, endAngle: 2.1 * CGFloat.pi, clockwise: true)
        
        let chart = CAShapeLayer()
        
        chart.path = circularPath.cgPath
        chart.strokeColor = strokeColor
        chart.lineWidth = lineWidth
        chart.fillColor = fillColor
        chart.lineCap = CAShapeLayerLineCap.round
        chart.strokeEnd = strockEnd
        chart.position = CGPoint(x: self.frame.width/2 - 55/3, y: 120.0)
        chart.name = "myLayer"
        print(self.frame.height/2)
        
        return chart
    }
    
    @objc func seInitialWeight() {
        delegate?.enterInitialWeight()
    }
    
    
    //MARK: - Setup Detail View
    func setDetailView(){
        
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        // add image to Detail View
        let backgroundImage = UIImage(named: "toolCellBackground")
        let backgroundView = UIImageView(image: backgroundImage)
        backgroundView.contentMode = .scaleToFill
        
        
        scrollView.isHidden = true
        self.scrollView.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
        scrollView.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        detailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        detailView.widthAnchor.constraint(equalToConstant: self.layer.frame.width).isActive = true
        //detailView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        detailView.heightAnchor.constraint(equalToConstant: 580).isActive = true
        
        
        
        
        // add image to Progress View
        let backgroundProgressImage = UIImage(named: "progressBackground")
        let backgroundProgressView = UIImageView(image: backgroundProgressImage)
        backgroundProgressView.contentMode = .scaleToFill
        


        
        self.detailView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 20).isActive = true
        progressView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 16).isActive = true
        progressView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -16).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        
        self.progressView.addSubview(backgroundProgressView)
        backgroundProgressView.translatesAutoresizingMaskIntoConstraints = false
        backgroundProgressView.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 0).isActive = true
        backgroundProgressView.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 0).isActive = true
        backgroundProgressView.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 0).isActive = true
        backgroundProgressView.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 0).isActive = true
        
        progressView.addSubview(progressTitleView)
        progressTitleView.translatesAutoresizingMaskIntoConstraints = false
        progressTitleView.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 0).isActive = true
        progressTitleView.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 0).isActive = true
        progressTitleView.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 0).isActive = true
        progressTitleView.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        self.detailView.addSubview(BMILabel)
        BMILabel.translatesAutoresizingMaskIntoConstraints = false
        BMILabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 15).isActive = true
        BMILabel.centerXAnchor.constraint(equalTo: detailView.centerXAnchor).isActive = true
        
        self.detailView.addSubview(BMIValueLabel)
        BMIValueLabel.translatesAutoresizingMaskIntoConstraints = false
        BMIValueLabel.topAnchor.constraint(equalTo: BMILabel.bottomAnchor, constant: 0).isActive = true
        BMIValueLabel.centerXAnchor.constraint(equalTo: detailView.centerXAnchor).isActive = true
       
        
        //Set kgCmStackView
        let kgLabelView = UIView()
        let cmLabelView = UIView()
        
        kgCmStackView = UIStackView(arrangedSubviews: [kgLabelView,cmLabelView])
        kgCmStackView.axis = .vertical
        kgCmStackView.distribution = .fillEqually
        
        self.detailView.addSubview(kgCmStackView)
        kgCmStackView.translatesAutoresizingMaskIntoConstraints = false
        kgCmStackView.topAnchor.constraint(equalTo: BMIValueLabel.bottomAnchor, constant: -10.0).isActive = true
        kgCmStackView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -12.0).isActive = true
        kgCmStackView.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        kgCmStackView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        self.detailView.addSubview(kgValueLabel)
        kgValueLabel.translatesAutoresizingMaskIntoConstraints = false
        kgValueLabel.topAnchor.constraint(equalTo: kgLabelView.topAnchor, constant: 0.0).isActive = true
        kgValueLabel.leadingAnchor.constraint(equalTo: kgLabelView.leadingAnchor, constant: 0.0).isActive = true

        self.detailView.addSubview(cmValueLabel)
        cmValueLabel.translatesAutoresizingMaskIntoConstraints = false
        cmValueLabel.topAnchor.constraint(equalTo: cmLabelView.topAnchor, constant: 0.0).isActive = true
        cmValueLabel.leadingAnchor.constraint(equalTo: cmLabelView.leadingAnchor, constant: 0.0).isActive = true
        
        self.detailView.addSubview(lineDetailView)
        lineDetailView.translatesAutoresizingMaskIntoConstraints = false
        lineDetailView.topAnchor.constraint(equalTo: kgCmStackView.bottomAnchor, constant: 15.0).isActive = true
        lineDetailView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 32.0).isActive = true
        lineDetailView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -32.0).isActive = true
        lineDetailView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        self.detailView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.topAnchor.constraint(equalTo: lineDetailView.topAnchor, constant: 16.0).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32.0).isActive = true
        
        self.detailView.addSubview(categoryValueLabel)
        categoryValueLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryValueLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 6.0).isActive = true
        categoryValueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.detailView.addSubview(riskLabel)
        riskLabel.translatesAutoresizingMaskIntoConstraints = false
        riskLabel.topAnchor.constraint(equalTo: categoryValueLabel.bottomAnchor, constant: 16.0).isActive = true
        riskLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32.0).isActive = true

        self.detailView.addSubview(riskValueLabel)
        riskValueLabel.translatesAutoresizingMaskIntoConstraints = false
        riskValueLabel.topAnchor.constraint(equalTo: riskLabel.bottomAnchor, constant: 6.0).isActive = true
        riskValueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        if #available(iOS 11.0, *) {
            let safeErea = self.safeAreaLayoutGuide
            
            //add image Button
            changeProfileImageButton.isHidden = true
            addSubview(changeProfileImageButton)
            changeProfileImageButton.translatesAutoresizingMaskIntoConstraints = false
            changeProfileImageButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            changeProfileImageButton.widthAnchor.constraint(equalToConstant: 104).isActive = true
            
            changeProfileImageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
            changeProfileImageButton.bottomAnchor.constraint(equalTo: safeErea.bottomAnchor, constant: -23).isActive = true
            
            
            //add profile Button
            changeProfileButton.isHidden = true
            addSubview(changeProfileButton)
            changeProfileButton.translatesAutoresizingMaskIntoConstraints = false
            changeProfileButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            changeProfileButton.widthAnchor.constraint(equalToConstant: 104).isActive = true
            
            changeProfileButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
            changeProfileButton.bottomAnchor.constraint(equalTo: safeErea.bottomAnchor, constant: -23).isActive = true
            changeProfileButton.addTarget(self, action: #selector(editProfileButtonAction), for: .touchUpInside)
        } else {
            //add image Button
            changeProfileImageButton.isHidden = true
            addSubview(changeProfileImageButton)
            changeProfileImageButton.translatesAutoresizingMaskIntoConstraints = false
            changeProfileImageButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            changeProfileImageButton.widthAnchor.constraint(equalToConstant: 104).isActive = true
            
            changeProfileImageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
            changeProfileImageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23).isActive = true
            
            
            //add profile Button
            changeProfileButton.isHidden = true
            addSubview(changeProfileButton)
            changeProfileButton.translatesAutoresizingMaskIntoConstraints = false
            changeProfileButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            changeProfileButton.widthAnchor.constraint(equalToConstant: 104).isActive = true
            
            changeProfileButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
            changeProfileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23).isActive = true
            changeProfileButton.addTarget(self, action: #selector(editProfileButtonAction), for: .touchUpInside)
        }
        
        
    }
    
    func calculateAndShowBMIValue() {
        let weight = people.last?.weight
        let height = defaults.double(forKey: "height")
        let ftHeight =  defaults.integer(forKey: "ftHeight")
        let inHeight =  defaults.double(forKey: "inHeight")
        
        if var  weight = weight {
            weight = round(weight*100)/100
            var height2 = (height*height)/10000
            if heightUnit == "ft:in" {
                let heightToCm = Double(ftHeight) * 30.48 + inHeight * 2.54
                height2 = (heightToCm*heightToCm)/10000
            }
            
            var BMI = Double(weight) / (height2)
            BMI = round(BMI * 100)/100
            if weightUnit == "lbs" {
                BMI = BMI * 0.45359237
                BMI = round(BMI * 100)/100
            }
    
            BMIValueLabel.text = " \(BMI) "
            kgValueLabel.text = "\(weight) \(weightUnit)"

            
            kgLabel.text = "\(weightUnit)"
            
            if heightUnit == "cm" {
                cmValueLabel.text = "\(height) cm"
            }else if heightUnit == "ft:in" {
                cmValueLabel.text = "\(ftHeight) ft \(inHeight) in"
            }else {
                cmValueLabel.text = "\(height) cm"
            }
            
            if 0 <= BMI && BMI < 15 {
                categoryValueLabel.text = "Very severely underweight"
                riskValueLabel.text = "Low"
            }else if 15 <= BMI && BMI < 16 {
                categoryValueLabel.text = "Severely underweight"
                riskValueLabel.text = "Low"
            }else if 16 <= BMI && BMI < 18.5 {
                categoryValueLabel.text = "Underweight"
                riskValueLabel.text = "Low"
            }else if 18.5 <= BMI && BMI < 25 {
                categoryValueLabel.text = "Normal (healthy weight)"
                riskValueLabel.text = "Medium"
            }else if 25 <= BMI && BMI < 30 {
                categoryValueLabel.text = "Overweight"
                riskValueLabel.text = "High"
            }else if 30 <= BMI && BMI < 35 {
                categoryValueLabel.text = "Obese Class I (Moderately obese)"
                riskValueLabel.text = "High"
            }else if 35 <= BMI && BMI < 40 {
                categoryValueLabel.text = "Obese Class II (Severely obese)"
                riskValueLabel.text = "Very high"
            }else if 40 <= BMI && BMI < 45 {
                categoryValueLabel.text = "Obese Class III (Very severely obese)"
                riskValueLabel.text = "Emergency"
            }else if 45 <= BMI && BMI < 50 {
                categoryValueLabel.text = "Obese Class IV (Morbidly Obese)"
                riskValueLabel.text = "Emergency"
            }else if 50 <= BMI && BMI < 60 {
                categoryValueLabel.text = "Obese Class V (Super Obese)"
                riskValueLabel.text = "Emergency"
            }else if 60 < BMI {
                categoryValueLabel.text = "Obese Class VI (Hyper Obese)"
                riskValueLabel.text = "Emergency"
            }
            
            var targetWeight = defaults.float(forKey: "desizedWeight")
            targetWeight = round(targetWeight*100)/100
            currentWeightlabel.text = "Current weight: \(weight) \(weightUnit)"

            targetWeightlabel.text = "\(targetWeight) \(weightUnit)"
            if let iw = people.first?.weight {
                initWeightlabel.text = "\(iw) \(weightUnit)"
                //set chart and percent
                if iw > targetWeight {
                    // Loss weihgt
                    if (targetWeight <= weight) {
                        if(iw >= weight) {
                            var percent = ((iw - weight)/(iw - targetWeight)) * 100
                            completedRate = Double((iw - weight)/(iw - targetWeight))
                            startChart()
                            percent = round(percent * 100)/100
                            percentlabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
                            percentlabel.text = "\(percent) %"
                        }else {
                            percentlabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
                            percentlabel.text = "0.0 % "
                            completedRate = 0
                            startChart()
                        }
                    }else {
                        percentlabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
                        percentlabel.text = "100.0 % "
                        completedRate = 1
                        startChart()
                    }
                }else if iw < targetWeight {
                    if (targetWeight >= weight) {
                        if(iw <= weight) {
                            var percent = ((weight - iw)/(targetWeight - iw)) * 100
                            completedRate = Double((weight - iw)/(targetWeight - iw))
                            startChart()
                            percent = round(percent * 100)/100
                            percentlabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
                            percentlabel.text = "\(percent) %"
                        }else {
                            completedRate = 0
                            percentlabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
                            percentlabel.text = "0.0 % "
                            startChart()
                        }
                    }else {
                        percentlabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
                        percentlabel.text = "100.0 % "
                        completedRate = 1
                        startChart()
                    }
                }else {
                    percentlabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
                    percentlabel.text = "100.0 %"
                    completedRate = 1
                    startChart()
                }
               
            }
        }
    }
    
    //MARK: - Setup Input View
    func setInputView(){
        
        

        profileView.layer.cornerRadius = 15.0
        profileView.clipsToBounds = true
        

        addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -42.0).isActive = true
        profileView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 350.0).isActive = true
        profileView.widthAnchor.constraint(equalToConstant: self.frame.width - 48.0).isActive = true
        
        //add round to input view
        addSubview(roundView)
        roundView.translatesAutoresizingMaskIntoConstraints = false
        roundView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 16.0).isActive = true
         roundView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 16.0).isActive = true
        roundView.heightAnchor.constraint(equalToConstant: 12.0).isActive = true
        roundView.widthAnchor.constraint(equalToConstant:  12.0).isActive = true
        
        //add profile label
        addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 12.0).isActive = true
        profileLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        
        
        //add height label
        addSubview(heightLabel)
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 12.0).isActive = true
        heightLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 48.0).isActive = true
        heightLabel.widthAnchor.constraint(equalToConstant:  150.0).isActive = true
        
        
        //add height textField
        addSubview(inputHeightTextfield)
        inputHeightTextfield.translatesAutoresizingMaskIntoConstraints = false
        inputHeightTextfield.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 8.0).isActive = true
        inputHeightTextfield.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 45.0).isActive = true
        inputHeightTextfield.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -45.0).isActive = true


        
        //add cm label
        addSubview(cmLabel)
        cmLabel.translatesAutoresizingMaskIntoConstraints = false
        cmLabel.topAnchor.constraint(equalTo: inputHeightTextfield.bottomAnchor, constant: 3.0).isActive = true
        cmLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -24.0).isActive = true
        cmLabel.widthAnchor.constraint(equalToConstant:  50.0).isActive = true
        
        //add ft height textfield
        inputFtHeightTextfield.isHidden = true
        addSubview(inputFtHeightTextfield)
        inputFtHeightTextfield.translatesAutoresizingMaskIntoConstraints = false
        inputFtHeightTextfield.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 8.0).isActive = true
        inputFtHeightTextfield.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 45.0).isActive = true
        inputFtHeightTextfield.widthAnchor.constraint(equalToConstant: self.layer.frame.height/4 - 60).isActive = true
        
        //add ft label
        ftLabel.isHidden = true
        addSubview(ftLabel)
        ftLabel.translatesAutoresizingMaskIntoConstraints = false
        ftLabel.topAnchor.constraint(equalTo: inputFtHeightTextfield.bottomAnchor, constant: 3.0).isActive = true
        ftLabel.leadingAnchor.constraint(equalTo: inputFtHeightTextfield.trailingAnchor, constant: 0.0).isActive = true
        ftLabel.widthAnchor.constraint(equalToConstant:  30.0).isActive = true
        
        
        //add in height textfield
        inputInHeightTextfield.isHidden = true
        addSubview(inputInHeightTextfield)
        inputInHeightTextfield.translatesAutoresizingMaskIntoConstraints = false
        inputInHeightTextfield.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 8.0).isActive = true
        inputInHeightTextfield.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -45.0).isActive = true
        inputInHeightTextfield.widthAnchor.constraint(equalToConstant: self.layer.frame.height/4 - 60).isActive = true
        
        //add in label
        inLabel.isHidden = true
        addSubview(inLabel)
        inLabel.translatesAutoresizingMaskIntoConstraints = false
        inLabel.topAnchor.constraint(equalTo: inputFtHeightTextfield.bottomAnchor, constant: 3.0).isActive = true
        inLabel.leadingAnchor.constraint(equalTo: inputInHeightTextfield.trailingAnchor, constant: 0.0).isActive = true
        inLabel.widthAnchor.constraint(equalToConstant:  30.0).isActive = true
        
        
        //add targetWeightLabel
        addSubview(targetWeightLabel)
        targetWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        targetWeightLabel.topAnchor.constraint(equalTo: cmLabel.bottomAnchor, constant: 12.0).isActive = true
        targetWeightLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 48.0).isActive = true
        targetWeightLabel.widthAnchor.constraint(equalToConstant:  150.0).isActive = true
        
        //add desired weight
        addSubview(desiredWeightTextfield)
        desiredWeightTextfield.translatesAutoresizingMaskIntoConstraints = false
        desiredWeightTextfield.topAnchor.constraint(equalTo: targetWeightLabel.bottomAnchor, constant: 8.0).isActive = true
        desiredWeightTextfield.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 45.0).isActive = true
        desiredWeightTextfield.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -45.0).isActive = true
        
        
        //add kg label
        addSubview(kgLabel)
        kgLabel.translatesAutoresizingMaskIntoConstraints = false
        kgLabel.topAnchor.constraint(equalTo: desiredWeightTextfield.bottomAnchor, constant: 3.0).isActive = true
        kgLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -24.0).isActive = true
        kgLabel.widthAnchor.constraint(equalToConstant:  50.0).isActive = true
        
        //add "let's go" button
        addSubview(enterButton)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        enterButton.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -72).isActive = true
        enterButton.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 56).isActive = true
        enterButton.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -56).isActive = true
        enterButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -12).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 18).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -18).isActive = true
    }
    
    //MARK: - "Let's go" Button Action
    @objc func buttonAction(sender: UIButton!) {
        var isHeightOK = false
        var isWeightOk = false
        do {
            try people = context.fetch(request)
        } catch  {
            print("Error to fetch Item data")
        }
        
        if inputHeightTextfield.text != ""
        {
            if heightUnit == "cm" {
                if var h = inputHeightTextfield.text {
                    h = h.replacingOccurrences(of: ",", with: ".")
                    if let h = Float(h) {
                        if h >= 30 && h <= 300 {
                            isHeightOK = true
                        }
                    }else {
                        print("height wrong !")
                    }
                }
            }else if heightUnit == "ft:in" {
                if let ftH = inputFtHeightTextfield.text , var inH = inputInHeightTextfield.text {
                    inH = inH.replacingOccurrences(of: ",", with: ".")
                    if let ftH = Float(ftH) ,let inH = Float(inH) {
                        if ftH > 0 && ftH < 11 && inH >= 0 && inH <= 20 {
                            isHeightOK = true
                        }
                    }else {
                        print("height wrong !")
                    }

                }
            }else {
                if var h = inputHeightTextfield.text {
                    h = h.replacingOccurrences(of: ",", with: ".")
                    if let h = Float(h) {
                        if h >= 30 && h <= 300 {
                            isHeightOK = true
                        }
                    }else {
                        print("height wrong !")
                    }
                }
            }
            
        }else {
            print("Blank")
        }
        
        if desiredWeightTextfield.text != ""
        {
            if var w = desiredWeightTextfield.text {
                w = w.replacingOccurrences(of: ",", with: ".")
                if let w = Float(w) {
                    if w >= 1 && w <= 400 {
                        isWeightOk = true
                    }
                }else {
                    print("weight wrong !")
                }
            }
        }else {
            print("Blank")
        }
        
        if isHeightOK , isWeightOk {
            if(people.count > 0) {
                dismissKeyboard()
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut],
                               animations: {
                                
                            
                                self.scrollView.alpha = 1
                                self.changeProfileButton.alpha = 1
                                self.changeProfileImageButton.alpha = 1
                                self.profileView.alpha = 0
                                self.cmLabel.alpha = 0
                                self.ftLabel.alpha = 0
                                self.inLabel.alpha = 0
                                self.profileLabel.alpha = 0
                                self.kgLabel.alpha = 0
                                self.heightLabel.alpha = 0
                                self.targetWeightLabel.alpha = 0
                                self.inputHeightTextfield.alpha = 0
                                self.inputFtHeightTextfield.alpha = 0
                                self.inputInHeightTextfield.alpha = 0
                                self.desiredWeightTextfield.alpha = 0
                                self.roundView.alpha = 0
                                self.enterButton.alpha = 0
                                self.layoutIfNeeded()
                                
                },  completion: {(_ completed: Bool) -> Void in
                    self.scrollView.isHidden = false
                    self.changeProfileButton.isHidden = false
                    self.changeProfileImageButton.isHidden  = false
                    
                    self.profileView.isHidden = true
                    self.cmLabel.isHidden = true
                    self.ftLabel.isHidden = true
                    self.inLabel.isHidden = true
                    self.profileLabel.isHidden = true
                    self.kgLabel.isHidden = true
                    self.inputHeightTextfield.isHidden = true
                    self.inputFtHeightTextfield.isHidden = true
                    self.inputInHeightTextfield.isHidden = true
                    self.desiredWeightTextfield.isHidden = true
                    self.targetWeightLabel.isHidden = true
                    self.roundView.isHidden = true
                    self.enterButton.isHidden = true
                    self.layoutIfNeeded()
                })
                defaults.set(true, forKey: "wasShowInput")
                defaults.set(Double(inputHeightTextfield.text!), forKey: "height")
                defaults.set(Int(inputFtHeightTextfield.text!), forKey: "ftHeight")
                defaults.set(Double(inputInHeightTextfield.text!), forKey: "inHeight")
                defaults.set(Double(desiredWeightTextfield.text!), forKey: "desizedWeight")
                startChart()
                calculateAndShowBMIValue()
                delegate?.enterDesiredWeight(dWeight: Double(desiredWeightTextfield.text!)!)
                
            }else {
                delegate?.enterWeightFirst()
            }
           
        }else {
            delegate?.checkIfWrongInputToolCell()
        }
      
    }


    //MARK: - editProfile Button Action
    @objc func editProfileButtonAction() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut],
                       animations: {
                        
                        self.scrollView.alpha = 0
                        self.changeProfileButton.alpha = 0
                        self.changeProfileImageButton.alpha = 0
                        if self.heightUnit == "cm" {
                            self.cmLabel.alpha = 1
                            self.inputHeightTextfield.alpha = 1
                        }else if self.heightUnit == "ft:in" {
                            self.ftLabel.alpha = 1
                            self.inLabel.alpha = 1
                            self.inputFtHeightTextfield.alpha = 1
                            self.inputInHeightTextfield.alpha = 1
                        }else {
                            self.cmLabel.alpha = 1
                            self.inputHeightTextfield.alpha = 1
                        }
                        self.profileView.alpha = 1
                        
                        self.profileLabel.alpha = 1
                        self.kgLabel.alpha = 1
                        self.heightLabel.alpha = 1
                        self.targetWeightLabel.alpha = 1
                        
                        self.desiredWeightTextfield.alpha = 1
                        self.roundView.alpha = 1
                        self.enterButton.alpha = 1
                        self.layoutIfNeeded()
                    
                        
            },  completion: {(_ completed: Bool) -> Void in
                self.scrollView.isHidden = true
                self.changeProfileButton.isHidden = true
                self.changeProfileImageButton.isHidden = true
                
                if self.heightUnit == "cm" {
                    self.cmLabel.isHidden = false
                    self.inputHeightTextfield.isHidden = false
                }else if self.heightUnit == "ft:in" {
                    self.ftLabel.isHidden = false
                    self.inLabel.isHidden = false
                    self.inputFtHeightTextfield.isHidden = false
                    self.inputInHeightTextfield.isHidden = false
                }else {
                    self.cmLabel.isHidden = false
                    self.inputHeightTextfield.isHidden = false
                }
                
                self.profileView.isHidden = false
                self.profileLabel.isHidden = false
                self.kgLabel.isHidden = false
                self.desiredWeightTextfield.isHidden = false
                self.roundView.isHidden = false
                self.enterButton.isHidden = false
                self.heightLabel.isHidden = false
                self.targetWeightLabel.isHidden = false
                
                self.desiredWeightTextfield.text! = String(self.defaults.double(forKey: "desizedWeight"))
                self.inputHeightTextfield.text! = String(self.defaults.double(forKey: "height"))
                
                self.layoutIfNeeded()
                
            })
    }
    
    func setProfileViewPosition() {
        self.scrollView.isHidden = false
        self.changeProfileButton.isHidden = false
        self.changeProfileImageButton.isHidden = false
        
        
        if self.heightUnit == "cm" {
            self.cmLabel.isHidden = false
            self.inputHeightTextfield.isHidden = false
        }else if self.heightUnit == "ft:in" {
            self.ftLabel.isHidden = false
            self.inLabel.isHidden = false
            self.inputFtHeightTextfield.isHidden = false
            self.inputInHeightTextfield.isHidden = false
        }else {
            self.cmLabel.isHidden = false
            self.inputHeightTextfield.isHidden = false
        }
        
        self.profileView.isHidden = true
        self.profileLabel.isHidden = true
        self.kgLabel.isHidden = true
        self.desiredWeightTextfield.isHidden = true
        self.roundView.isHidden = true
        self.enterButton.isHidden = true
        self.heightLabel.isHidden = true
        self.targetWeightLabel.isHidden = true
        
        self.layoutIfNeeded()
    }
}
