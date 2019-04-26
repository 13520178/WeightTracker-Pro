//
//  InputWeightSubView.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 3/19/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class InputWeightSubView: UIView {

    //MARK: - Variable
    
    let mainView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    let caption:UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.text = "asdasd"
        l.font = UIFont.systemFont(ofSize: 22)
        return l
    }()
    
    let content:UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        l.font = UIFont(name:"TrebuchetMS", size: 12)
        
        return l
    }()
    
    let imageView:UIImageView = {
        let i = UIImageView()
        i.contentMode = .center
        i.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        i.layer.cornerRadius = 25
        return i
    }()
    
    var backgroundView:UIImageView = {
        let i = UIImageView()
        i.contentMode = .center
        i.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return i
    }()
    
    let lineView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return v
    }()
    
    let goLabel:UILabel = {
        let l = UILabel()
        l.text = "›"
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont.systemFont(ofSize: 40)
        return l
    }()
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowOpacity = 0
        layer.shadowRadius = 10
        layer.masksToBounds = false
        
        self.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
        let backgroundImage = UIImage(named: "green")
        backgroundView = UIImageView(image: backgroundImage)
        backgroundView.contentMode = .scaleToFill
        
        mainView.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        imageView.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        mainView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        lineView.isHidden = true
        mainView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lineView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -2).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 2.5).isActive = true
        
        mainView.addSubview(caption)
        caption.translatesAutoresizingMaskIntoConstraints = false
        caption.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        caption.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 8).isActive = true
        
        mainView.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor.constraint(equalTo: caption.bottomAnchor, constant: 0).isActive = true
        content.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 8).isActive = true
        
        mainView.addSubview(goLabel)
        goLabel.translatesAutoresizingMaskIntoConstraints = false
        goLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        goLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true

        
    }
    
    func setupProperty(captionText:String,contentText:String,imageName:String, imageBackGround:String) {
        caption.text = captionText
        content.text = contentText
        imageView.image = UIImage(named: imageName)
        backgroundView.image = UIImage(named: imageBackGround)
        
    }


}
