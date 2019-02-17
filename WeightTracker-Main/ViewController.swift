//
//  ViewController.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 2/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    var iconColectionViewArray = ["scaleIcon","diagramIcon","historyIcon"]
    
    @IBOutlet weak var leadingOfNarBarBottom: NSLayoutConstraint!
    @IBOutlet weak var widthOfNarBarBottom: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        widthOfNarBarBottom.constant = collectionView.frame.width/3
        
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        if let flowLayout = tabCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //auto selected 1st item
        let indexPathForFirstRow = IndexPath(row: 0, section: 0)
        self.collectionView?.selectItem(at: indexPathForFirstRow, animated: true, scrollPosition: .top)
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
            cell.backgroundColor = #colorLiteral(red: 0.5298348069, green: 0.4216188788, blue: 1, alpha: 1)
            
            return cell
        }else if collectionView == self.tabCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath)
            
            let colors:[UIColor] = [UIColor.blue, UIColor.red, UIColor.green]
            
          
            cell.backgroundColor = colors[indexPath.row]
            
            return cell
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
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self.leadingOfNarBarBottom.constant = collectionView.frame.width/3 * CGFloat(indexPath.row)
//
//
//                self.view.layoutIfNeeded()
//            }, completion: nil)
            self.tabCollectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        }
        
    }
    
    //MARK: - Menu handle


}

