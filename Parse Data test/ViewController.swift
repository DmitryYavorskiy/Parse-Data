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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var nameArray = NSArray()
    var userNameArray = NSArray()
    var avatarUrlArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("load")
        // Do any additional setup after loading the view, typically from a nib.
        
        table.infiniteScrollIndicatorStyle = .gray
        
        // Add infinite scroll handler
        table.addInfiniteScroll { (tableView) -> Void in
            //
            // fetch your data here, can be async operation,
            // just make sure to call finishInfiniteScroll in the end
            //
            print("load")
            let indexPaths = [NSIndexPath]() // index paths of updated rows
            
            // make sure you update tableView before calling -finishInfiniteScroll
            self.table.beginUpdates()
            self.table.insertRows(at: indexPaths as [IndexPath], with: .automatic)
            self.table.endUpdates()
            
            // finish infinite scroll animation
            self.table.finishInfiniteScroll()
        }
        
        let dict: NSDictionary = ["offset" : 0, "limit" : 10]
        DataRequest.getData(dictionaryDta: dict, methodName: MethodName.getFeed) { (succes: Bool, info: NSDictionary) in
            
            self.nameArray = info.value(forKey: "name") as! NSArray
            self.userNameArray = info.value(forKey: "userName") as! NSArray
            self.avatarUrlArray = info.value(forKey: "avatarUrl") as! NSArray
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
        
    }
    
    //MARK: - Table Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CustomCell
        
        cell.title.text = nameArray.object(at: indexPath.row) as? String
        cell.subTitle.text = userNameArray.object(at: indexPath.row) as? String
        let url = NSURL(string: avatarUrlArray.object(at: indexPath.row) as! String)
        cell.imageCell.sd_setImage(with: url! as URL!)
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

