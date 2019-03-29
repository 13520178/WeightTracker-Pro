//
//  HistoryDetailVC.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 3/16/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit
import CoreData



class HistoryDetailVC: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var bottomBackgroundImage: NSLayoutConstraint!
    @IBOutlet weak var detailViewTopConstrant: NSLayoutConstraint!
    
    
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weightTextfield: UITextField!
    @IBOutlet weak var weightUnitLabel: UILabel!
    
    var indexOfPeople = -1
    var weightUnit = ""
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request : NSFetchRequest<Person> = Person.fetchRequest()
    var people:[Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
   
        saveButton.layer.cornerRadius = 5.0
        saveButton.clipsToBounds = true
        
        detailView.layer.cornerRadius = 15
        
        detailView.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        detailView.layer.borderWidth = 1.5
        
        let viewHeight = self.view.layer.frame.height
        
        //bottomBackgroundImage.constant = (viewHeight-85)/2
        bottomBackgroundImage.constant = 0
        detailViewTopConstrant.constant = (viewHeight - detailView.layer.frame.height-85)/2
        weightTextfield.setBottomBorder()
        
        do {
            try people = context.fetch(request)
        } catch  {
            print("Error to fetch Item data")
        }
        if indexOfPeople != -1 {
            let historyInfo = people[people.count - indexOfPeople - 1]
            print(historyInfo)
            
            dateLabel.text = historyInfo.date
            timeLabel.text = historyInfo.time
            weightTextfield.text = String(historyInfo.weight)
            noteTextView.text = historyInfo.note
        }
        
        weightUnitLabel.text = weightUnit
       
        
        //Set View tab to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    

    
    @objc func editWeight() {
         AlertController.showAlert(inController: self, tilte: "Almost done 😜", message: "Please enter your current weight.")
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
       
        if weightTextfield.text != ""
        {
            if let w = weightTextfield.text {
                if let w = Float(w) {
                    if w > 1 && w <= 400 {
                        people[people.count - indexOfPeople - 1].weight  = w
                        people[people.count - indexOfPeople - 1].note = noteTextView.text!
                        savePerson()
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
                        dismiss(animated: true, completion: nil)
                        
                    }else {
                        checkIfOverInput()
                    }
                }else {
                    checkIfWrongInput()
                }
            }
        }else {
            checkIfWrongInput()
        }
    }
    
    @IBAction func deleteButonPressed(_ sender: UIButton) {
        if let result = try? self.context.fetch(self.request) {
            self.context.delete(result[people.count - indexOfPeople - 1])
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
            dismiss(animated: true, completion: nil)
        }
        do {
            try self.context.save()
            
        } catch {
            print("Co xoa duoc dau ma xoa")
        }
    }
    
    func savePerson() {
        do {
            try context.save()
        } catch  {
            print("Error to saving data")
        }
    }
    func checkIfWrongInput() {
        AlertController.showAlert(inController: self, tilte: "Something is wrong", message: "You entered the wrong type of weight")
    }
    
    func checkIfOverInput() {
        AlertController.showAlert(inController: self, tilte: "Something is not reasonable", message: "It looks like you entered an unreasonable value 🙄 ")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


