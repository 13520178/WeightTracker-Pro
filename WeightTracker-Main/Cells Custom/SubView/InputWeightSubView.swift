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
    let caption:UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        l.text = "asdasd"
        l.font = UIFont.systemFont(ofSize: 22)
        return l
    }()
    
    let content:UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        l.font = UIFont.systemFont(ofSize: 12)
        
        return l
    }()
    
    let imageView:UIImageView = {
        let i = UIImageView()
        i.contentMode = .center
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
        l.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        l.font = UIFont.systemFont(ofSize: 28)
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
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lineView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 2.5).isActive = true
        
        addSubview(caption)
        caption.translatesAutoresizingMaskIntoConstraints = false
        caption.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        caption.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 8).isActive = true
        
        addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor.constraint(equalTo: caption.bottomAnchor, constant: 0).isActive = true
        content.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 8).isActive = true
        
        addSubview(goLabel)
        goLabel.translatesAutoresizingMaskIntoConstraints = false
        goLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        goLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true

        
    }
    
    func setupProperty(captionText:String,contentText:String,imageName:String) {
        caption.text = captionText
        content.text = contentText
        imageView.image = UIImage(named: imageName)
    }


}
