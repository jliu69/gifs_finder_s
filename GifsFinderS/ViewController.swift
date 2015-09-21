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
    
    var gifsImageArray: [AnyObject] = []
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
        
        self.innerView.layer.cornerRadius = 10
        self.innerView.clipsToBounds = true
        
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
    
    //MARK: - search bar delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.text = nil
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.text = nil
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        self.searchBar.resignFirstResponder()
        
        self.innerView.hidden = false
        self.view.bringSubviewToFront(self.innerView)
        
        var searchContent : String? = self.searchBar.text
        if (searchContent == nil) {
            searchContent = ""
        }
        
        searchContent!.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        var searchLink = "http://api.giphy.com/v1/gifs/search?api_key=dc6zaTOxFJmzC&q=\(searchContent!)"
        
        var loader : ImagesLoader = ImagesLoader()
        loader.delegate = self
        loader.gifsWithLink(searchLink)
    }
    
    //MARK: - Image Loader delegate
    
    func didReceiveImagesArray(array: [AnyObject]!) {
        
        if let imagesArray = array {
            
            self.innerView.hidden = true
            self.view.sendSubviewToBack(self.innerView)
            
            if (imagesArray.count == 0) {
                return
            }
            
            self.gifsImageArray = imagesArray
            print("return image array size = \(imagesArray.count) \n")
            print("gifs image array size = \(self.gifsImageArray.count) \n")
            
            var helper : ImageHelper = ImageHelper()
            self.rowsArray = helper.displayImageListFrom(self.gifsImageArray)
            self.tableView.reloadData()
        }
    }
}

