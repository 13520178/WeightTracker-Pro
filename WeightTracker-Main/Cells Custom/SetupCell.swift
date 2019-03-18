//
//  SetupCell.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 3/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

protocol SetupCellDelegate {
    func sentMail()
    
}

class SetupCell: BaseCell, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate {
    
    //MARK: - Variable
     var delegate: SetupCellDelegate?
    var contactStackView: UIStackView!
    
    let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        let fbImage = UIImage(named: "facebookIcon")
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.setImage(fbImage, for: UIControl.State.normal)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        
        return button
    }()
    
    let gmailButton: UIButton = {
        let button = UIButton()
        let fbImage = UIImage(named: "gmailIcon")
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.setImage(fbImage, for: UIControl.State.normal)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        return button
    }()
    
    let savingMoneyButton: UIButton = {
        let button = UIButton()
        let fbImage = UIImage(named: "savingMoneyIcon")
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.setImage(fbImage, for: UIControl.State.normal)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
        button.clipsToBounds = true
        return button
    }()
    
    let lineFirstView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let lineSecondView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let lineThirdView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let contactView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let otherAppView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "WeChart"
        label.font = UIFont.systemFont(ofSize:32, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let appVersionLabel: UILabel = {
        let label = UILabel()
        label.text = "Version: 1.1.0"
        label.font = UIFont.systemFont(ofSize:13, weight: UIFont.Weight.light)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let appCopyrightLabel: UILabel = {
        let label = UILabel()
        label.text = "Copyright © 2019 PhanDang"
        label.font = UIFont.systemFont(ofSize:13, weight: UIFont.Weight.light)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize:20, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let contactUsLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact me"
        label.font = UIFont.systemFont(ofSize:20, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let otherAppLabel: UILabel = {
        let label = UILabel()
        label.text = "My other app"
        label.font = UIFont.systemFont(ofSize:20, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let savingMoneyLabel: UILabel = {
        let label = UILabel()
        label.text = "Saving Money SV"
        label.font = UIFont.systemFont(ofSize:16, weight: UIFont.Weight.medium)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return label
    }()
    let savingMoneyDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "Great way to calculate savings!"
        label.font = UIFont.systemFont(ofSize:13, weight: UIFont.Weight.light)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    
    
    
    var tableView: UITableView = {
        var tb = UITableView()
        return tb
    }()
    
    //MARK: - setUpView()
    override func setUpView() {
        super.setUpView()
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyCellSetup.self, forCellReuseIdentifier: "cellSetupId")
        tableView.isScrollEnabled = false;
        
        setupSetupView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openSavingMoneySVApp))
        otherAppView.addGestureRecognizer(tap)
        
        

    }

    
    //MARK: - setupSetupView()
    func setupSetupView() {
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
        
        self.addSubview(appNameLabel)
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        appNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(appVersionLabel)
        appVersionLabel.translatesAutoresizingMaskIntoConstraints = false
        appVersionLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: -4).isActive = true
        appVersionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addSubview(appCopyrightLabel)
        appCopyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        appCopyrightLabel.topAnchor.constraint(equalTo: appVersionLabel.bottomAnchor, constant: 0).isActive = true
        appCopyrightLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        

        
        self.addSubview(lineFirstView)
        lineFirstView.translatesAutoresizingMaskIntoConstraints = false
        lineFirstView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        lineFirstView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lineFirstView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        lineFirstView.widthAnchor.constraint(equalToConstant: self.layer.frame.width - 32).isActive = true
        

        self.addSubview(settingLabel)
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.topAnchor.constraint(equalTo: lineFirstView.bottomAnchor, constant: 16).isActive = true
        settingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        
        self.addSubview(lineSecondView)
        lineSecondView.translatesAutoresizingMaskIntoConstraints = false
        lineSecondView.topAnchor.constraint(equalTo: settingLabel.bottomAnchor, constant: 4.0).isActive = true
        lineSecondView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lineSecondView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        lineSecondView.widthAnchor.constraint(equalToConstant: self.layer.frame.width).isActive = true
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: lineSecondView.bottomAnchor, constant: 0.0).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
       
        
        self.addSubview(contactUsLabel)
        contactUsLabel.translatesAutoresizingMaskIntoConstraints = false
        contactUsLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16).isActive = true
        contactUsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        
        
        self.addSubview(contactView)
        contactView.translatesAutoresizingMaskIntoConstraints = false
        contactView.topAnchor.constraint(equalTo: contactUsLabel.bottomAnchor, constant: 4).isActive = true
        contactView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contactView.heightAnchor.constraint(equalToConstant: 96.0).isActive = true
        contactView.widthAnchor.constraint(equalToConstant: self.layer.frame.width).isActive = true
        
        self.addSubview(otherAppLabel)
        otherAppLabel.translatesAutoresizingMaskIntoConstraints = false
        otherAppLabel.topAnchor.constraint(equalTo: contactView.bottomAnchor, constant: 16).isActive = true
        otherAppLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        
        self.addSubview(otherAppView)
        otherAppView.translatesAutoresizingMaskIntoConstraints = false
        otherAppView.topAnchor.constraint(equalTo: otherAppLabel.bottomAnchor, constant: 4).isActive = true
        otherAppView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        otherAppView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        otherAppView.widthAnchor.constraint(equalToConstant: self.layer.frame.width).isActive = true
        
        self.addSubview(savingMoneyButton)
        savingMoneyButton.translatesAutoresizingMaskIntoConstraints = false
        savingMoneyButton.centerYAnchor.constraint(equalTo: otherAppView.centerYAnchor).isActive = true
        savingMoneyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        savingMoneyButton.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        savingMoneyButton.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        savingMoneyButton.addTarget(self, action: #selector(openSavingMoneySVApp), for: .touchUpInside)
        
        self.addSubview(savingMoneyLabel)
        savingMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        savingMoneyLabel.topAnchor.constraint(equalTo: otherAppView.topAnchor, constant: 28).isActive = true
        savingMoneyLabel.leadingAnchor.constraint(equalTo: savingMoneyButton.trailingAnchor, constant: 16).isActive = true
        
        self.addSubview(savingMoneyDetailLabel)
        savingMoneyDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        savingMoneyDetailLabel.topAnchor.constraint(equalTo: savingMoneyLabel.bottomAnchor, constant: 4).isActive = true
        savingMoneyDetailLabel.leadingAnchor.constraint(equalTo: savingMoneyButton.trailingAnchor, constant: 16).isActive = true
        
        //Contact us StackView
        let facebookView = UIView()
        
        let gmailView = UIView()
        
        contactStackView = UIStackView(arrangedSubviews: [facebookView,gmailView])
        contactStackView.axis = .horizontal
        contactStackView.distribution = .fillEqually
        
        addSubview(contactStackView)
        contactStackView.translatesAutoresizingMaskIntoConstraints = false
        contactStackView.topAnchor.constraint(equalTo: contactView.topAnchor, constant: 0.0).isActive = true
        contactStackView.leadingAnchor.constraint(equalTo: contactView.leadingAnchor, constant: 32).isActive = true
        contactStackView.trailingAnchor.constraint(equalTo: contactView.trailingAnchor, constant: -32).isActive = true
        contactStackView.bottomAnchor.constraint(equalTo: contactView.bottomAnchor, constant: 0.0).isActive = true
        
        addSubview(facebookButton)
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.centerXAnchor.constraint(equalTo: facebookView.centerXAnchor).isActive = true
        facebookButton.centerYAnchor.constraint(equalTo: facebookView.centerYAnchor).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        facebookButton.addTarget(self, action: #selector(openMyFacebook), for: .touchUpInside)

        
        addSubview(gmailButton)
        gmailButton.translatesAutoresizingMaskIntoConstraints = false
        gmailButton.centerXAnchor.constraint(equalTo: gmailView.centerXAnchor).isActive = true
        gmailButton.centerYAnchor.constraint(equalTo: gmailView.centerYAnchor).isActive = true
        gmailButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        gmailButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        gmailButton.addTarget(self, action: #selector(openMail), for: .touchUpInside)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSetupId", for: indexPath) as! MyCellSetup
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       
    }
    
    @objc func openSavingMoneySVApp() {
        if let url = URL(string: "https://itunes.apple.com/vn/app/saving-money-sv/id1437390099?l=vi&mt=8&fbclid=IwAR03K9tS0qYDVX9BV5cGLzKgZJn4zg71Xi6KMmWX5_aG-WesCq_4ASJp7CU"),
            UIApplication.shared.canOpenURL(url)
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc func openMyFacebook() {
        let Username =  "100004649166180"
        let appURL = URL(string: "fb://profile?app_scoped_user_id=\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://facebook.com/\(Username)")!
            application.open(webURL)
        }
    }
    
    @objc func openMail() {
        delegate?.sentMail()
    }
    
}


class MyCellSetup:UITableViewCell {
    
    var weightStackView: UIStackView!
    var weightLabel: UILabel = {
        var lb = UILabel()
        lb.text = "Kg"
        lb.font = lb.font.withSize(18.0)
        lb.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return lb
    }()
    
    var dateLabel: UILabel = {
        var lb = UILabel()
        lb.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lb.text = "Weight Unit"
        lb.font = UIFont.systemFont(ofSize:20, weight: UIFont.Weight.light)
        return lb
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView() {
        let weightTitleLabelView = UIView()
        
        let weightLabelView = UIView()
        
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
        dateLabel.topAnchor.constraint(equalTo: weightTitleLabelView.topAnchor, constant: 3.0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: weightTitleLabelView.leadingAnchor, constant: 35.0).isActive = true
        
        addSubview(weightLabel)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.topAnchor.constraint(equalTo: weightLabelView.topAnchor, constant: 3.0).isActive = true
        weightLabel.trailingAnchor.constraint(equalTo: weightLabelView.trailingAnchor, constant: -20).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
