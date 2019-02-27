//
//  ViewController.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 2/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit
import CoreData

protocol ResetTableViewDelegate {
    func resetTableView()
}

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {

    //MARK: - Outlet variable
    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leadingOfNarBarBottom: NSLayoutConstraint!
    @IBOutlet weak var widthOfNarBarBottom: NSLayoutConstraint!
    
    //MARK: - Variable
    var iconColectionViewArray = ["scaleIcon","diagramIcon","historyIcon"]
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request : NSFetchRequest<Person> = Person.fetchRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        tabCollectionViewSetup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //auto selected 1st item
        let indexPathForFirstRow = IndexPath(row: 0, section: 0)
        self.collectionView?.selectItem(at: indexPathForFirstRow, animated: true, scrollPosition: .top)
    }
    
    func tabCollectionViewSetup() {
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        tabCollectionView?.register(InputWeightCell.self, forCellWithReuseIdentifier: "InputWeightId")
        tabCollectionView?.register(DiagramCell.self, forCellWithReuseIdentifier: "DiagramId")
        tabCollectionView?.register(HistoryCell.self, forCellWithReuseIdentifier:
            "HistoryId")
        if let flowLayout = tabCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
    }
    
    //MARK: - ColectionView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        leadingOfNarBarBottom.constant = scrollView.contentOffset.x/3
    }
    

     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let indexPath = IndexPath(row: Int(targetContentOffset.pointee.x/view.frame.width), section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return 3
        }else if collectionView == self.tabCollectionView {
            return 3
        }else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! NarBarCollectionViewCell
            
            cell.image.image = UIImage(named: iconColectionViewArray[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            cell.backgroundColor = #colorLiteral(red: 0.5320518613, green: 0.2923432589, blue: 1, alpha: 1)
            
            return cell
        }else if collectionView == self.tabCollectionView {
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InputWeightId", for: indexPath) as? InputWeightCell
                cell?.delegate = self
                return cell!
            }else if indexPath.item == 1 {
                 let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "DiagramId", for: indexPath) as? DiagramCell
                do {
                    try cell?.people = context.fetch(request)
                } catch  {
                    print("Error to fetch Item data")
                }
                
                if  cell != nil , cell!.people.count >= 1 {
                    var sumOfDays = 0
                    var embedDateForCountInSumOfDay = ""
                    var monthss = [String]()
                    var unitsSolds = [Double]()
                    for i in 0..<cell!.people.count {
                        let subString = cell!.people[i].date?.prefix(5)
                        monthss.append(String(subString ?? ""))
                        unitsSolds.append(Double(cell!.people[i].weight))
                        
                        if(embedDateForCountInSumOfDay != cell!.people[i].date) {
                            sumOfDays += 1
                            embedDateForCountInSumOfDay = cell!.people[i].date!
                            
                        }
                    }
                    cell!.months = monthss
                    cell!.unitsSold = unitsSolds
                    cell!.setChart(dataEntryX: cell!.months, dataEntryY: cell!.unitsSold)
                    
                    cell!.startKgLabel.text = String(cell!.unitsSold[0]) + "Kg "
                    cell!.currentKgLabel.text = String(cell!.unitsSold.last!) + "Kg "
                    cell!.timeStartLabel.text = cell!.people[0].date
                    // sum of days
                    
                    cell!.totalDaysLabel.text = String(sumOfDays)
                }else {
                    cell!.startKgLabel.text = "No record"
                    cell!.currentKgLabel.text = "No record"
                    cell!.timeStartLabel.text = "No record"
                    cell!.totalDaysLabel.text = "0"
                }
                
                return cell!
                
            }else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryId", for: indexPath) as? HistoryCell
                do {
                    try cell?.people = context.fetch(request)
                } catch  {
                    print("Error to fetch Item data")
                }
                
                cell?.tableView.reloadData()
                return cell!
                
            }
            
        }else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height )
        }else {
            return CGSize(width: tabCollectionView.frame.width, height: tabCollectionView.frame.height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            self.tabCollectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        }
        
    }
    
    func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        widthOfNarBarBottom.constant = collectionView.frame.width/3
    }

}

//MARK: Protocol
extension ViewController: InputWeightCellDelegate {
    func changeAndUpdateCell(didChange: Bool, person:Person) {
        let indexPath = IndexPath(row: 2, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
         self.tabCollectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        collectionView.reloadData()
        tabCollectionView.reloadData()
    }
}
