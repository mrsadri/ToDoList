//
//  PageCell.swift
//  autolayout_lbta
//
//  Created by MSadri on 11/19/18.
//  Copyright © 2018 Lets Build That App. All rights reserved.
//

import Foundation
import UIKit

class PageCell : UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    let items = ["One", "Two", "Three", "Four", "Five" ,"Six", "Seven", "Eight", "Nine", "Ten"]

    var mayPage : PageDataModel? {
        didSet{
            guard let unwrappedPage = mayPage else { return }
            
            bearImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            
            attributedText.append(NSAttributedString(string: "\n\n" + unwrappedPage.bodyText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
            
            items
            
            //here is not proper place for these jangoolak baazies so I comment these
//            let red   = Float((arc4random() % 256)) / 255.0
//            let green = Float((arc4random() % 256)) / 255.0
//            let blue  = Float((arc4random() % 256)) / 255.0
//            let alpha = Float(1.0)
//
//            descriptionTextView.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
//            bearImageView.backgroundColor = UIColor.yellow
//
//            UIView.animate(withDuration: 10.0, delay: 0.0, animations: {
//                self.bearImageView.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha)) //(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
//            }, completion:nil)

        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = firstTable.dequeueReusableCell(withIdentifier: "cellID")
        cell?.textLabel?.text = items[indexPath.row]
        cell?.textLabel?.textAlignment = .left
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "bear_first")
        cell?.addSubview(iconImageView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.topAnchor.constraint(equalTo: (cell?.topAnchor)!, constant: 20).isActive = true
        iconImageView.rightAnchor.constraint(equalTo: (cell?.rightAnchor)!, constant: -40).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: (cell?.bottomAnchor)!).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: cell!.heightAnchor, constant: -20).isActive = true
        
        cell!.backgroundColor = UIColor.orange
        return cell!
    }
    
    let bearImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white//UIColor.black.withAlphaComponent(0.1)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let firstTable : UITableView = {
        let thisTable = UITableView()
        thisTable.translatesAutoresizingMaskIntoConstraints = false
        thisTable.isScrollEnabled = true
        thisTable.rowHeight = 50
        return thisTable
    }()
    
    let tableBackGround : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor.orange
        image.layer.cornerRadius = 45
        return image
    }()
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        firstTable.dataSource = self as UITableViewDataSource
        firstTable.delegate = self as UITableViewDelegate
        
        firstTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        setupLayout()
        setupTableLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        
        let topImageContainerView = UIView()

        self.addSubview(topImageContainerView)

        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint      (equalTo: self.topAnchor                    ).isActive = true
        topImageContainerView.leadingAnchor.constraint  (equalTo: self.leadingAnchor                ).isActive = true
        topImageContainerView.trailingAnchor.constraint (equalTo: self.trailingAnchor               ).isActive = true
        topImageContainerView.heightAnchor.constraint   (equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.backgroundColor = .white

        topImageContainerView.addSubview(bearImageView)

        bearImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor                 ).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor                 ).isActive = true
        bearImageView.heightAnchor .constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.9 ).isActive = true
        bearImageView.widthAnchor  .constraint(equalTo: topImageContainerView.widthAnchor , multiplier: 0.8 ).isActive = true
        //temp
        //bearImageView.backgroundColor = .red

        self.addSubview(descriptionTextView)
        
        descriptionTextView.topAnchor     .constraint(equalTo: bearImageView.bottomAnchor, constant: self.bounds.height / 15 ).isActive = true
        descriptionTextView.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant:30).isActive = true
        //descriptionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant:-30).isActive = true
        descriptionTextView.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50          ).isActive = true
        descriptionTextView.backgroundColor = .white
        
    }
    
    func setupTableLayout() {
        
        self.addSubview(tableBackGround)
        self.addSubview(firstTable)
        
        firstTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        firstTable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        firstTable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        firstTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        firstTable.backgroundColor = .orange
        
        tableBackGround.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -240).isActive = true
        tableBackGround.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        tableBackGround.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        tableBackGround.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        UIView.animate(withDuration: 5.0, animations: {   })
        
    }


}
