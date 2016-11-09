//
//  ViewController.swift
//  Parse Data test
//
//  Created by media-pt on 07.10.16.
//  Copyright © 2016 media-pt. All rights reserved.
//

import UIKit
import SDWebImage
import UIScrollView_InfiniteScroll

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    var nameArray = Array<String>()
    var userNameArray = Array<String>()
    var avatarUrlArray = Array<String>()
    
    //var refreshControl: UIRefreshControl!
    
    var limitCount = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        /*refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControlEvents.valueChanged)*/
        //table.addSubview(refreshControl)
        // Add infinite scroll handler
        
        
        table.infiniteScrollIndicatorStyle = .gray
        table.infiniteScrollIndicatorMargin = 30
        
        // Add infinite scroll handler
        table.addInfiniteScroll { (tableView) -> Void in
            
            self.limitCount += 10
            self.loadApi(limit: self.limitCount)
            
            let indexPaths = [NSIndexPath]()
            
            tableView.beginUpdates()
            tableView.insertRows(at: indexPaths as [IndexPath], with: .automatic)
            tableView.endUpdates()
        }
        
        self.loadApi(limit: 10)
    }
    
    /*func refresh(sender:AnyObject) {
        // Code to refresh table view
        print("refresh")
        refreshControl.endRefreshing()
    }*/
    
    
}

//MARK: - Api Load

extension ViewController {
    
    func loadApi(limit: Int) {
        let dict: NSDictionary = ["offset" : 0, "limit" : limit]
        DataRequest.getData(dictionaryData: dict, dictHttpBody: nil, methodName: MethodName.getFeed) { (succes: Bool, info: NSDictionary) in
            
            self.nameArray = info.value(forKey: "name") as! Array
            self.userNameArray = info.value(forKey: "userName") as! Array
            self.avatarUrlArray = info.value(forKey: "avatarUrl") as! Array
            DispatchQueue.main.async {
                self.table.reloadData()
                if limit >= 400 {
                    self.table.removeInfiniteScroll()
                    self.table.finishInfiniteScroll()
                } else {
                    self.table.finishInfiniteScroll()
                }
            }
        }
    }
}

//MARK: - Table Delegate

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CustomCell
        
        cell.title.text = nameArray[indexPath.row]
        cell.subTitle.text = userNameArray[indexPath.row]
        let url = URL(string: avatarUrlArray[indexPath.row])
        cell.imageCell.sd_setImage(with: url)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueWebViewController", sender: nil)
    }
}

