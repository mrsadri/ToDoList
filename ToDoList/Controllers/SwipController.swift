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
                self.collectionView?.scrollToItem(at: thisIndexPath, at: .centeredVertically, animated: true)
            
        }) { (_) in
            //
        }
        
        
    }
    
    func reloadData() {
        //collectionView.reloadData()
    }
    
    let headerUI : UIView = {
        let thisView = HeaderUI()
        thisView.translatesAutoresizingMaskIntoConstraints = false
        return thisView
    }()
    
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
            collectionView?.scrollToItem(at: thisIndexPath, at: .centeredVertically, animated: true)
            changeButtonState(input: nextButton, toWhat: .enable)
        }
        if pageController.currentPage == 0 {
            changeButtonState(input: previouaseButton, toWhat: .disable)
            
        } else {
            changeButtonState(input: previouaseButton, toWhat: .enable)
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
            collectionView?.scrollToItem(at: thisIndexPath, at: .centeredVertically, animated: true)
            changeButtonState(input: previouaseButton, toWhat: .enable)
        }
        if pageController.currentPage + 1 == pageController.numberOfPages {
            changeButtonState(input: nextButton, toWhat: .disable)
        } else {
            changeButtonState(input: nextButton, toWhat: .enable)
        }
    }
    
    private lazy var pageController : UIPageControl = {
        let pc = UIPageControl()
        //pc.transform = pc.transform.rotated(by: .pi/2)
        pc.numberOfPages = wholeDate.count
        pc.currentPage = 0
        pc.pageIndicatorTintColor = UIColor.init(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        pc.currentPageIndicatorTintColor = UIColor.myPinkColor
        return pc
    }()
    
    let buttonsBackGround : UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = false
        thisView.backgroundColor = .white
        return thisView
    }()
    
    private let addNewTaskButton : UIButton = {
        let thisButton = UIButton()
        thisButton.translatesAutoresizingMaskIntoConstraints = false
        thisButton.backgroundColor = UIColor.myPinkColor
        thisButton.layer.cornerRadius = 25
        thisButton.addTarget(self, action: #selector(addNewTaskFunction), for: .touchUpInside)
        return thisButton
    }()
    
    @objc func addNewTaskFunction(){
        print("add button")
        self.newView.isHidden = !newView.isHidden
        currentGroup = pageController.currentPage
            }
    
    fileprivate func setupButtonControls() {
        
        let greenView  = UIView()
        greenView.backgroundColor = .white
        
        let bottomControllsStackView = UIStackView(arrangedSubviews: [previouaseButton,pageController,nextButton])
        bottomControllsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControllsStackView.distribution = .fillEqually
        
        view.addSubview(buttonsBackGround)
        buttonsBackGround.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -55).isActive = true
        buttonsBackGround.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        buttonsBackGround.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        buttonsBackGround.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        buttonsBackGround.layer.shadowColor = UIColor.black.cgColor
        buttonsBackGround.layer.shadowOpacity = 0.5
        buttonsBackGround.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        
        view.addSubview(addNewTaskButton)
        addNewTaskButton.bottomAnchor.constraint(equalTo: buttonsBackGround.topAnchor, constant: 5).isActive = true
        addNewTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        addNewTaskButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addNewTaskButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //buttonsBackGround.frame = CGRect(x: 0, y: view.frame.height-55, width: view.frame.width, height: 55)
        
        view.addSubview(bottomControllsStackView)

        NSLayoutConstraint.activate([
            bottomControllsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55),
            bottomControllsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            bottomControllsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControllsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)])
    }
    
    func setupHeaderViewLayout() {
        
        view.addSubview(headerUI)
        headerUI.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        headerUI.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        headerUI.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        headerUI.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    var previousPageNumber : Int?
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        previousPageNumber = pageController.currentPage
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // print("here: \(pageIndex)")
        let pageIndex = (targetContentOffset.pointee.y) / view.frame.height
        pageController.currentPage = Int(pageIndex)
        
        if pageController.currentPage == previousPageNumber {}
        
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
    let newView = AddNewTaskView()
//    : UIView = {
//        let thisView = UIView()
//        thisView.translatesAutoresizingMaskIntoConstraints = false
//        thisView.backgroundColor = .red
//        return thisView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //temp

        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newView.widthAnchor.constraint(equalToConstant: 330).isActive = true
        newView.heightAnchor.constraint(equalToConstant: 245).isActive = true
        newView.isHidden = true
        //

        self.collectionView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        
        setupButtonControls()
        
        setupHeaderViewLayout()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "pageCell")
        changeButtonState(input: previouaseButton, toWhat: .disable)
        collectionView?.isPagingEnabled = true
        
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
        return wholeDate.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pageCell", for: indexPath) as! PageCell
        TalkToServer.sharedObject.accessToPageCellFromTalkToserver = cell.self
        cell.pageIndex = indexPath.item
        cell.firstTable.reloadData()
        cell.backgroundColor = .none
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height )
    }
   
}
