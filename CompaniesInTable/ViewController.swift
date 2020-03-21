//
//  ViewController.swift
//  CompaniesInTable
//
//  Created by  mac on 3/18/20.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

struct cellData {
    let text: String!
    let color: UIColor!
}

class TableViewController: UITableViewController {
    
    var cellDatas: [cellData] = []
    var companies: [String] = []
    var colors: [UIColor] = [UIColor(red: 0/255, green: 191/255, blue: 255/255, alpha: 1),
                            UIColor(red: 0/255, green: 115/255, blue: 153/255, alpha: 1),
                            UIColor(red: 255/255, green: 0/255, blue: 255/255, alpha: 1),
                            UIColor(red: 0/255, green: 179/255, blue: 45/255, alpha: 1),
                            UIColor(red: 0/255, green: 134/255, blue: 179/255, alpha: 1),
                            UIColor(red: 77/255, green: 244/255, blue: 121/255, alpha: 1),
                            UIColor(red: 179/255, green: 135/255, blue: 181/255, alpha: 1),
                            UIColor(red: 204/255, green: 0/255, blue: 153/255, alpha: 1),
                            UIColor(red: 35/255, green: 92/255, blue: 49/255, alpha: 1),
                            UIColor(red: 255/255, green: 125/255, blue: 82/255, alpha: 1)]
    
    var dataManager = DataManager()

    override func viewDidLoad() {
        
        //READING JSON FROM FILE
//        self.companies = dataManager.fetchDataFromFile()!
//        for i in 0..<companies.count {
//            self.cellDatas.append(cellData(text: companies[i], color: self.colors[i]))
//        }
        
        
        //READING JSON FROM URL
        var _ = dataManager.fetchData { (companies, error) in
            DispatchQueue.main.async {
                self.companies = companies!
                for i in 0..<companies!.count {
                    self.cellDatas.append(cellData(text: companies![i], color: self.colors[i]))
                }
                self.tableView.reloadData()
            }
        }
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDatas.count
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
        cell.colorView.backgroundColor = cellDatas[indexPath.row].color
        cell.mainLabel.text = cellDatas[indexPath.row].text
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            self.cellDatas.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCell1
        let customize = UIContextualAction(style: .normal, title: "Customize") { (action, view, completion) in
            if cell?.animated == false {
                cell?.load(with: "https://media.giphy.com/media/l0MYResEdNIyniuL6/giphy.gif")
            }
            else {
                cell?.gifView.image = nil
            }
            cell?.animated = !cell!.animated
            completion(true)
        }
        
        customize.backgroundColor = cell!.animated ? UIColor(red: 0/255, green: 150/255, blue: 115/255, alpha: 1) : .gray
        customize.image = UIImage(systemName: "wand.and.stars")
        delete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [delete, customize])
    }
    
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let find = UIContextualAction(style: .normal, title: "Find") { (action, view, nil) in
            let search = self.cellDatas[indexPath.row].text
            if let url = URL(string: "https://www.google.com.au/search?client=safari&channel=ipad_bm&source=hp&ei=PSrkWqHVDYrc8QXp85zoAw&q=\(search!)&oq=example&gs_l=mobile-gws-wiz-hp.3..0l5.58620.59786..60164...0....334.1724.0j2j3j2..........1.......3..41j0i131.SurD5PmVspw%3D"){
                    UIApplication.shared.open(url)
                    print("default browser was successfully opened")
                }
        }
        find.image = UIImage(systemName: "safari")
        return UISwipeActionsConfiguration(actions: [find])
    }
}


