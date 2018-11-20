//
//  SwipController.swift
//  autolayout_lbta
//
//  Created by MSadri on 11/19/18.
//  Copyright © 2018 Lets Build That App. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var myPinkColor = UIColor.init(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class SwipController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            
                self.collectionViewLayout.invalidateLayout()
                let thisIndexPath = IndexPath(item: self.pageController.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: thisIndexPath, at: .centeredHorizontally, animated: true)

            
        }) { (_) in
            //
        }
    }
    
    //let page = PageDataModel(imageName: <#T##String#>, headerText: <#T##String#>, bodyText: <#T##String#>)
    let pagesData : [PageDataModel] = [
        PageDataModel(imageName: "bear_first", headerText: "Join use today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        PageDataModel(imageName: "heart_second", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        PageDataModel(imageName: "leaf_third", headerText: "VIP members special services", bodyText: "")
    ]
    
    
    private let previouaseButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Prev", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.myPinkColor, for: .normal)
        button.addTarget(self, action: #selector(previouaseButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc private func previouaseButtonAction() {
        if pageController.currentPage > 0 {
            let prevIndexPage = pageController.currentPage - 1
            let thisIndexPath = IndexPath(item: prevIndexPage, section: 0)
            pageController.currentPage = prevIndexPage
            collectionView?.scrollToItem(at: thisIndexPath, at: .centeredHorizontally, animated: true)
            changeButtonState(input: nextButton, toWhat: .enable)
//            nextButton.isEnabled = true
//            nextButton.setTitleColor(.myPinkColor, for: .normal)
        }
        if pageController.currentPage == 0 {
            changeButtonState(input: previouaseButton, toWhat: .disable)
//            previouaseButton.isEnabled = false
//            previouaseButton.setTitleColor(.gray, for: .normal)
            
        } else {
            changeButtonState(input: previouaseButton, toWhat: .enable)
//            previouaseButton.isEnabled = true
//            previouaseButton.setTitleColor(.myPinkColor, for: .normal)
        }
    }
    
    private let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.myPinkColor, for: .normal)
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc private func nextButtonAction() {
        if pageController.currentPage + 1 < pageController.numberOfPages {
            let nextIndexPage = pageController.currentPage + 1
            let thisIndexPath = IndexPath(item: nextIndexPage, section: 0)
            pageController.currentPage = nextIndexPage
            collectionView?.scrollToItem(at: thisIndexPath, at: .centeredHorizontally, animated: true)
            changeButtonState(input: previouaseButton, toWhat: .enable)
//            previouaseButton.isEnabled = true
//            previouaseButton.setTitleColor(.myPinkColor, for: .normal)

        }
        if pageController.currentPage + 1 == pageController.numberOfPages {
            changeButtonState(input: nextButton, toWhat: .disable)
//            nextButton.isEnabled = false
//            nextButton.setTitleColor(.gray, for: .normal)

        } else {
            changeButtonState(input: nextButton, toWhat: .enable)
//            nextButton.isEnabled = true
//            nextButton.setTitleColor(.myPinkColor, for: .normal)

        }
    }
    
    private lazy var pageController : UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = pagesData.count
        pc.currentPage = 0
        pc.pageIndicatorTintColor = UIColor.init(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        pc.currentPageIndicatorTintColor = UIColor.myPinkColor
        return pc
    }()
    
    fileprivate func setupButtonControls() {
        
        let greenView  = UIView()
        greenView.backgroundColor = .white
        
        let bottomControllsStackView = UIStackView(arrangedSubviews: [previouaseButton,pageController,nextButton])
        bottomControllsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControllsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControllsStackView)
        
        NSLayoutConstraint.activate([
            bottomControllsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55),
            bottomControllsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            bottomControllsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControllsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)])
    }
    
    var previousPageNumber : Int?
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        previousPageNumber = pageController.currentPage
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageIndex = (targetContentOffset.pointee.x) / view.frame.width
        pageController.currentPage = Int(pageIndex)
        
        if pageController.currentPage == previousPageNumber {
            print("-----------")
            //attemping to fix iPhone X Bug on first and last page
        }
        
        if pageController.currentPage == 0 {
            changeButtonState(input: previouaseButton, toWhat: .disable)
        } else {
            changeButtonState(input: previouaseButton, toWhat: .enable)
        }
        
        if pageController.currentPage + 1 == pageController.numberOfPages {
            changeButtonState(input: nextButton, toWhat: .disable)
        } else {
            changeButtonState(input: nextButton, toWhat: .enable)
        }
        
        //set UITableView to the cell
        
    }
    
    //-----------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonControls()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "pageCell")
        changeButtonState(input: previouaseButton, toWhat: .disable)
        collectionView?.isPagingEnabled = true
//        collectionView.
        collectionView?.contentOffset = .zero
    }
    
    
    enum buttonState {
        case enable
        case disable
    }
    func changeButtonState (input: UIButton, toWhat: buttonState ) {
        
        let thisButton = input

        if toWhat == .disable {
            thisButton.isEnabled = false
            thisButton.setTitleColor(.gray, for: .normal)
        } else {
            thisButton.isEnabled = true
            thisButton.setTitleColor(.myPinkColor, for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagesData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pageCell", for: indexPath) as! PageCell
        cell.mayPage = pagesData[indexPath.item]
        //cell.backgroundColor = indexPath.item % 2 == 0 ? .yellow : .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    
}
