//
//  ImageDetailsViewController.swift
//  GifsFinderS
//
//  Created by Johnson Liu on 9/21/15.
//  Copyright (c) 2015 HomeOffice. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedGif : GifObject?
    var rowsArray: [AnyObject] = []
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Init
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:DetailsCell? = self.tableView?.dequeueReusableCellWithIdentifier("cellId") as? DetailsCell
        if (cell == nil) {
            self.tableView?.registerNib(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "cellId")
            cell = self.tableView?.dequeueReusableCellWithIdentifier("cellId") as? DetailsCell
        }
        
        cell!.gifsDesc.text = ""
        cell!.gifsImageView.image = nil;
        
        return cell!
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
