//
//  ViewController.swift
//  GifsFinderS
//
//  Created by Johnson Liu on 9/16/15.
//  Copyright (c) 2015 HomeOffice. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, ImagesLoaderDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var innerView: UIView!
    
    
    var rowsArray: [AnyObject] = []
    var gifRowsArray: [AnyObject] = []
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if ConnectionHelper.isConnectedToNetwork() == false {
            DisplayMessageHelper.alertMessage(self, alertTitle: "Warning", alertBody: "Internet connection is not available now.  Please try again when it resumes.")
            return
        }
        
        self.innerView.hidden = false
        self.view.bringSubviewToFront(self.innerView)
        
        
        self.rowsArray = NSArray()
        var trendingLink = "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC";
        
        var loader : ImagesLoader = ImagesLoader()
        loader.delegate = self
        loader.gifsWithLink(trendingLink)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return navigationController?.navigationBarHidden == true
    }
    
    // MARK: - TableView DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowsArray.count
        //return self.gifRowsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:ImageCell? = self.tableView?.dequeueReusableCellWithIdentifier("cellId") as? ImageCell
        if (cell == nil) {
            self.tableView?.registerNib(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "cellId")
            cell = self.tableView?.dequeueReusableCellWithIdentifier("cellId") as? ImageCell
        }
        
        var item : NSDictionary = self.rowsArray[indexPath.row] as NSDictionary
        var gifImage : UIImage? = item.objectForKey("image") as? UIImage
        var imageId : String? = item.objectForKey("imageId") as? String
        
        if (gifImage == nil) {
            cell!.gifImageView.backgroundColor = UIColor.lightGrayColor()
        }
        else {
            cell!.gifImageView.image = gifImage
        }
        
        if (imageId == nil || imageId! == "") {
            cell!.gifDescLabel.text = "(no image)"
        }
        else {
            cell!.gifDescLabel.text = "Image ID : \(imageId!)"
        }
        
        return cell!
    }
    
    // MARK: - TableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK: - Image Loader delegate
    
    func didReceiveImagesArray(array: [AnyObject]!) {
        
        if let imagesArray = array {
            
            if (imagesArray.count == 0) {
                return
            }
            
            self.innerView.hidden = true
            self.view.sendSubviewToBack(self.innerView)
            
            var helper : ImageHelper = ImageHelper()
            self.rowsArray = helper.displayImageListFrom(imagesArray)
            self.tableView.reloadData()
        }
    }
}

