//
//  InputWeightCell.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 2/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView()
    {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder:) has been implemented")
    }
}

class InputWeightCell: BaseCell{
   
    
    let inputWeightTextfield :UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string:"Weight", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),NSAttributedString.Key.font :UIFont(name: "Arial", size: 50)!])
        tf.font = UIFont.systemFont(ofSize: 50)
        tf.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.textAlignment = .center
        tf.keyboardType = .decimalPad
        tf.isUserInteractionEnabled = true
        tf.setBottomBorder()
        return tf
    }()
    
    let kgLabel:UILabel = {
        let label = UILabel()
        label.text = "Kg."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()
    
    let enterButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        bt.setTitle("Enter", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name:"Arial", size: 30)
        bt.layer.cornerRadius = 25
        bt.layer.borderWidth = 2
        bt.layer.borderColor =  #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)

        return bt
    }()
    
    override func setUpView() {
        super.setUpView()
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubview(inputWeightTextfield)
        inputWeightTextfield.translatesAutoresizingMaskIntoConstraints = false
        inputWeightTextfield.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        inputWeightTextfield.topAnchor.constraint(equalTo: self.topAnchor, constant: 200.0).isActive = true
        inputWeightTextfield.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        inputWeightTextfield.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        
        
        addSubview(kgLabel)
        kgLabel.translatesAutoresizingMaskIntoConstraints = false
        kgLabel.topAnchor.constraint(equalTo: inputWeightTextfield.bottomAnchor, constant: 16).isActive = true
        kgLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
       addSubview(enterButton)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        enterButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -22).isActive = true
        enterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22).isActive = true
        enterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22).isActive = true
        enterButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        endEditing(true)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        inputWeightTextfield.text = ""
    }

}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
