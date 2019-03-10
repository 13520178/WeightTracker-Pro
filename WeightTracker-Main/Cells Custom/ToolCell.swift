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
}


class ToolCell: BaseCell {
    
    var delegate: ToolCellDelegate?
    var people = [Person]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request : NSFetchRequest<Person> = Person.fetchRequest()
    
    let defaults = UserDefaults.standard
    var height: Double = -1
    var desiredWeight:Double = -1
    
    //MARK: - Input View Var
   
    
    let profileView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      
        return v
    }()
    
    let roundView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        v.layer.cornerRadius = 6.0
        v.layer.masksToBounds = true
        
        return v
    }()
    
    let profileLabel:UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()
    
    let cmLabel:UILabel = {
        let label = UILabel()
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
    
    //MARK: - DetailView var
    let detailView:UIView = {
       let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return v
    }()
    
    let changeProfileButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.roundedRect)
        bt.setTitle(" 🗒 Edit profile ", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name:"Avenir-Light", size: 15)
        bt.backgroundColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        
        return bt
    }()
    
    let heightLabel:UILabel = {
        let label = UILabel()
        label.text = "cm"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        return label
    }()

    
    
    //MARK: - Setup View
    override func setUpView() {
        super.setUpView()
        backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        setInputView()
        setDetailView()
        
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
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        endEditing(true)
    }
    
    //MARK: - Setup Detail View
    func setDetailView(){
        detailView.isHidden = true
        addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        detailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        detailView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        detailView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        //add profile label
      
        
        changeProfileButton.isHidden = true
        addSubview(changeProfileButton)
        changeProfileButton.translatesAutoresizingMaskIntoConstraints = false
        changeProfileButton.heightAnchor.constraint(equalToConstant: 17.0)
        changeProfileButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        changeProfileButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        changeProfileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        changeProfileButton.addTarget(self, action: #selector(editProfileButtonAction), for: .touchUpInside)
    }
    //MARK: - Setup Input View
    func setInputView(){

        profileView.layer.cornerRadius = 15.0
        profileView.clipsToBounds = true
        
        profileView.layer.cornerRadius = 6.0
        profileView.layer.masksToBounds = true

        addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 265.0).isActive = true
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
        profileLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 48.0).isActive = true
        profileLabel.widthAnchor.constraint(equalToConstant:  150.0).isActive = true
        
        //add height textField
        addSubview(inputHeightTextfield)
        inputHeightTextfield.translatesAutoresizingMaskIntoConstraints = false
        inputHeightTextfield.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 22.0).isActive = true
        inputHeightTextfield.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 45.0).isActive = true
        inputHeightTextfield.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -45.0).isActive = true


        
        //add cm label
        addSubview(cmLabel)
        cmLabel.translatesAutoresizingMaskIntoConstraints = false
        cmLabel.topAnchor.constraint(equalTo: inputHeightTextfield.bottomAnchor, constant: 3.0).isActive = true
        cmLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -24.0).isActive = true
        cmLabel.widthAnchor.constraint(equalToConstant:  50.0).isActive = true
        
        
        //add desired weight
        addSubview(desiredWeightTextfield)
        desiredWeightTextfield.translatesAutoresizingMaskIntoConstraints = false
        desiredWeightTextfield.topAnchor.constraint(equalTo: cmLabel.bottomAnchor, constant: 20.0).isActive = true
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
        enterButton.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -22).isActive = true
        enterButton.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 56).isActive = true
        enterButton.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -56).isActive = true
        enterButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
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
            if let h = inputHeightTextfield.text {
                if let _ = Float(h) {
                   isHeightOK = true
                }else {
                    print("height wrong !")
                }
            }
        }else {
            print("Blank")
        }
        
        if desiredWeightTextfield.text != ""
        {
            if let w = desiredWeightTextfield.text {
                if let _ = Float(w) {
                    isWeightOk = true
                }else {
                    print("height wrong !")
                }
            }
        }else {
            print("Blank")
        }
        
        if isHeightOK , isWeightOk {
            if(people.count > 0) {
                UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseInOut],
                               animations: {
                                self.profileView.isHidden = true
                                self.cmLabel.isHidden = true
                                self.profileLabel.isHidden = true
                                self.kgLabel.isHidden = true
                                self.inputHeightTextfield.isHidden = true
                                self.desiredWeightTextfield.isHidden = true
                                self.roundView.isHidden = true
                                self.enterButton.isHidden = true
                                self.profileView.layoutIfNeeded()
                                
                },  completion: {(_ completed: Bool) -> Void in
                    self.detailView.isHidden = false
                    self.changeProfileButton.isHidden = false
                })
                defaults.set(true, forKey: "wasShowInput")
                defaults.set(Double(inputHeightTextfield.text!), forKey: "height")
                defaults.set(Double(desiredWeightTextfield.text!), forKey: "desizedWeight")
                
            }else {
                delegate?.enterWeightFirst()
            }
           
        }else {
            delegate?.checkIfWrongInputToolCell()
        }
      
    }


    //MARK: - editProfile Button Action
    @objc func editProfileButtonAction() {
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut],
                       animations: {
                        self.detailView.isHidden = true
                        self.changeProfileButton.isHidden = true
                        self.profileView.isHidden = false
                        self.cmLabel.isHidden = false
                        self.profileLabel.isHidden = false
                        self.kgLabel.isHidden = false
                        self.inputHeightTextfield.isHidden = false
                        self.desiredWeightTextfield.isHidden = false
                        self.roundView.isHidden = false
                        self.enterButton.isHidden = false
                        self.profileView.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            
        })
    }
    
    func setProfileViewPosition() {
        UIView.animate(withDuration: 0, delay: 0, options: [.curveEaseInOut],
                       animations: {
                        self.profileView.isHidden = true
                        self.cmLabel.isHidden = true
                        self.profileLabel.isHidden = true
                        self.kgLabel.isHidden = true
                        self.inputHeightTextfield.isHidden = true
                        self.desiredWeightTextfield.isHidden = true
                        self.roundView.isHidden = true
                        self.enterButton.isHidden = true
                        self.profileView.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.detailView.isHidden = false
            self.changeProfileButton.isHidden = false
        })
    }
}
