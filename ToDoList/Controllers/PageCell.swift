//
//  PageCell.swift
//  autolayout_lbta
//
//  Created by MSadri on 11/19/18.
//  Copyright © 2018 Lets Build That App. All rights reserved.
//

import Foundation
import UIKit

protocol AccessToPageCell {
    func resetPageIndex()
    
}


class PageCell : UICollectionViewCell, UITableViewDataSource, UITableViewDelegate, AccessToPageCell {
    
    
    func resetPageIndex(){
        pageIndex = currentGroup
    }
    var pageIndex : Int = 0 {
        didSet{
            itemsToBuildThisTables = wholeDate[pageIndex]
            print("PageNo. \(pageIndex)")
            //TalkToServer.sharedObject.dataModelPrinter()
            self.firstTable.reloadData()
        }
    }
    
    //var items : [String] = [""]
    var itemsToBuildThisTables : TabaleDataModel?{
        didSet{
            guard let unrappedData = itemsToBuildThisTables else { return }
            
            let attributedText = NSMutableAttributedString(string: "Group: ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.gray])
            
            attributedText.append(NSAttributedString(string: "\t\t" + unrappedData.groupData.groupName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]))
            
            descriptionTextView.attributedText = attributedText
            
            firstTable.reloadData()
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (itemsToBuildThisTables?.tasksData.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = firstTable.dequeueReusableCell(withIdentifier: "cellID") as! TableCell
       // guard let taskName = "   " + ((itemsToBuildThisTables?.tasksData[indexPath.row].taskName)!) else { return }
            cell.cellTextLabel.text = "   " + ((itemsToBuildThisTables?.tasksData[indexPath.row].taskName)!)
            return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { action, index in
            //remove From server
            TalkToServer.sharedObject.deleteTask(task_id: (self.itemsToBuildThisTables?.tasksData[editActionsForRowAt.row].taskID)!)
            //self.delegationFromSwipeController.reloadCollectionViews()
            //DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            let t = self.pageIndex
            self.pageIndex = t
            print("try to reload the table+++++")
            // self.pageIndex = (TalkToServer.sharedObject.placeOfRemovedItem?.group)!
            
            //}
            print("Remove button tapped")
        }
        remove.backgroundColor = .red
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            print("Edit button tapped")
        }
        edit.backgroundColor = .lightGray
        
        let done = UITableViewRowAction(style: .normal, title: "Done") { action, index in
            print("Done button tapped")
        }
        done.backgroundColor = .green
        
        return [done, edit, remove]
    }
    
    //Also implement this: (You can make it conditional, but here everything is editable)
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print((itemsToBuildThisTables?.tasksData[indexPath.row].taskDescription) ?? "No Cell" )
        firstTable.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.orange
        cell.selectedBackgroundView = backgroundView
    }
    
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
        thisTable.rowHeight = 60
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
        TalkToServer.sharedObject.accessToPageCellFromTalkToserver = self
        firstTable.dataSource = self as UITableViewDataSource
        firstTable.delegate = self as UITableViewDelegate
        
        firstTable.register(TableCell.self, forCellReuseIdentifier: "cellID")
        
        firstTable.allowsSelection = true
        
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
        
        topImageContainerView.topAnchor.constraint      (equalTo: self.topAnchor, constant: 50                    ).isActive = true
        topImageContainerView.leadingAnchor.constraint  (equalTo: self.leadingAnchor                ).isActive = true
        topImageContainerView.trailingAnchor.constraint (equalTo: self.trailingAnchor               ).isActive = true
        topImageContainerView.heightAnchor.constraint   (equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.backgroundColor = .white
        
        
        self.addSubview(descriptionTextView)
        
        descriptionTextView.topAnchor     .constraint(equalTo: topImageContainerView.safeAreaLayoutGuide.topAnchor, constant: self.bounds.height / 20 ).isActive = true
        descriptionTextView.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant:30).isActive = true
        //descriptionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant:-30).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        //descriptionTextView.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50          ).isActive = true
        descriptionTextView.backgroundColor = .white
        
    }
    
    func setupTableLayout() {
        
        self.addSubview(tableBackGround)
        self.addSubview(firstTable)
        
        firstTable.topAnchor.constraint(equalTo: tableBackGround.topAnchor, constant: 20).isActive = true
        firstTable.leftAnchor.constraint(equalTo: tableBackGround.leftAnchor, constant: 10).isActive = true
        firstTable.rightAnchor.constraint(equalTo: tableBackGround.rightAnchor, constant: -15).isActive = true
        firstTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -55).isActive = true
        
        firstTable.backgroundColor = .orange
        
        tableBackGround.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 5).isActive = true
        tableBackGround.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        tableBackGround.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        tableBackGround.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        UIView.animate(withDuration: 5.0, animations: {   })
        
    }
    
    
}
