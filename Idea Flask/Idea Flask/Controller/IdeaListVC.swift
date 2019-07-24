//
//  ViewController.swift
//  Idea Flask
//
//  Created by Allbee, Eamon on 7/21/19.
//  Copyright © 2019 Allbee, Eamon. All rights reserved.
//

import UIKit

class IdeaListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ideasList: UITableView!
    
    @IBOutlet weak var searchIdeas: UISearchBar!
    
    var allIdeas = [Idea]()
    let refreshControl = UIRefreshControl()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allIdeas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ideaCell") as? IdeaCell {
            let ideaItem = allIdeas[indexPath.row]
            cell.updateViews(idea: ideaItem)
            return cell
        }
        else {
            return IdeaCell()
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            DataService.instance.deleteIdea(idea: self.allIdeas[indexPath.row])
            self.allIdeas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return [delete]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        ideasList.delegate = self
        ideasList.dataSource = self
        searchIdeas.delegate = self
        allIdeas = DataService.instance.getAllIdeas()
    }


    @objc func reload() {
        ideasList.reloadData()
        refreshControl.endRefreshing()
    }
    
}

//MARK: - Search bar methods
extension IdeaListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        allIdeas = DataService.instance.searchIdeas(searchText: searchBar.text!)
        ideasList.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            allIdeas = DataService.instance.getAllIdeas()
            ideasList.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

