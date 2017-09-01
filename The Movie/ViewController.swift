//
//  ViewController.swift
//  The Movie
//
//  Created by Ankur Nautiyal on 31/08/17.
//  Copyright © 2017 Impinge. All rights reserved.
//

import UIKit
import Alamofire

typealias CompletionHandler = (_ success:NSDictionary) -> Void


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var movieTableView: UITableView!
    @objc var getPoularArray = NSArray()
    @objc var newMovieArray = NSArray()
    @objc var topRatedMovieArray = NSMutableArray()
    
    var poplarCount = NSInteger()
    var topRatedCount = NSInteger()
    var latestCount = NSInteger()
    
    
    
    
    
    
    @objc var nameArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameArray = ["New in Theaters", "Popular","Highest Rated This Year"]
        
        
        // if we load more then one page take count
        poplarCount = 1
        topRatedCount = 1
        latestCount = 1
        
        // make url  string for hit api
        let popularApi:String = String(format:"%@%@%@%@%@%d",ConstantString.BaseUrl ,ConstantString.popularApi , "?api_key=", ConstantString.KEY, "&language=en-US&page=" ,poplarCount) //
        let topRated:String = String(format:"%@%@%@%@%@%d",ConstantString.BaseUrl ,ConstantString.topRated , "?api_key=", ConstantString.KEY, "&language=en-US&page=" ,topRatedCount) //formats the
        let latestMovie:String = String(format:"%@%@%@%@%@%d",ConstantString.BaseUrl ,ConstantString.latestMovie , "?api_key=", ConstantString.KEY, "&language=en-US&page=" ,latestCount) //formats
        //        call method
        self.fetchDataFormPopular(url: popularApi as NSString)
        sleep(1)
        self.dataTopRateApi(url: topRated as NSString)
        sleep(1)
        self.fetchDataFormMoviewLetestApi(url: latestMovie as NSString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Tableview delegate and datasource
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celltableContent = tableView.dequeueReusableCell(withIdentifier: "MovieTableCiewCell", for: indexPath as IndexPath) as! MovieTableCiewCell
        
        celltableContent.movieLabel.text=(nameArray.object(at: indexPath.row) as! NSString) as String
        celltableContent.movieCollectionView.tag=indexPath.row
        
        celltableContent.selectionStyle = UITableViewCellSelectionStyle.none
        return celltableContent
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 250.0
    }
    
    // MARK:- CollectionView delegate and datasource
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let dict : NSDictionary!
        if collectionView.tag == 0 {
            dict = self.newMovieArray[indexPath.row] as! NSDictionary
            
            // for load more items
//            if (indexPath.item + 1 == self.newMovieArray.count) {
//
//                poplarCount = poplarCount + 1
//                let popularApi:String = String(format:"%@%@%@%@%@%d",ConstantString.BaseUrl ,ConstantString.popularApi , "?api_key=", ConstantString.KEY, "&language=en-US&page=" ,poplarCount) //
//                self.fetchDataFormPopular(url: popularApi as NSString)
//            }
            
        }else if(collectionView.tag==1) {
            
            dict = self.getPoularArray[indexPath.row] as! NSDictionary
           
        }
        else {
            dict = self.topRatedMovieArray[indexPath.row] as! NSDictionary
            
        }
        
        print(dict .value(forKey: "vote_count") as Any)
        
        print(dict .value(forKey: "release_date") as Any)
        
        
        let profileString = dict.value(forKey: "backdrop_path") as? NSString
        if (profileString != nil) {
            let urlWithParams = "https://image.tmdb.org/t/p/w500/" + (profileString! as String)
            let profileurl = NSURL.fileURL(withPath: urlWithParams as String)
            let url = URL(string:urlWithParams)
            
            cell.MovieTitleLabel.text = (dict.value(forKey: "original_title") as! NSString) as String
            getDataFromUrl(url: url!) { (data, response, error)  in
                guard let data = data, error == nil else { return }
                print("Download Finished")
                DispatchQueue.main.async() { () -> Void in
                    cell.movieImageView.image = UIImage(data: data)
                }
            }
            print(profileurl as Any)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView.tag == 0 {
            return self.newMovieArray.count
        }else if(collectionView.tag==1){
            return self.getPoularArray.count
        }
        else {
            
            
            return self.topRatedMovieArray.count
        }
    }
    @objc func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    //MARK: - Hit ToptateApi
    @objc func dataTopRateApi(url:NSString) {
        let myUrl = NSURL(string: url as String)
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            // Check for error
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                if (try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary) != nil
                {
                    let jsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    print( jsonDict as Any )
                        let tempArray = jsonDict?.value(forKey: "results") as! NSArray
                        // check if vote less then 500
                        for var i in (0..<tempArray.count) {
                            let dictData =  tempArray[i] as! NSDictionary
                            let profileString = dictData.value(forKey: "vote_count") as? NSInteger
                            if (profileString! >= 500) {
                                self.topRatedMovieArray.add(dictData)
                            }
                        }
                        DispatchQueue.main.async { // Correct
                            self.movieTableView.reloadData()
                        }
                }
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    //MARK: - Hit LAtestMoviwAPI
    
    @objc func fetchDataFormMoviewLetestApi(url:NSString) {
        
        // download code.
        
        
        let myUrl = NSURL(string: url as String)
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "GET"
        
        
        // Excute HTTP Request
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            // Check for error
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            do {
                if (try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary) != nil
                {
                    let jsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                        self.newMovieArray = jsonDict?.value(forKey: "results") as! NSArray
                    DispatchQueue.main.async { // Correct
                        self.movieTableView.reloadData()
                    }
                }
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    //MARK: - Hit Popular Api
    
        @objc func fetchDataFormPopular(url:NSString) {
            let myUrl = NSURL(string: url as String)
            let request = NSMutableURLRequest(url:myUrl! as URL);
            request.httpMethod = "GET"
            // Excute HTTP Request
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                // Check for error
                if error != nil
                {
                    print("error=\(String(describing: error))")
                    return
                }
                do {
                    if (try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary) != nil
                    {
                        let jsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                        print( jsonDict as Any )
                        
                            self.getPoularArray = jsonDict?.value(forKey:"results" ) as! NSArray
                        DispatchQueue.main.async { // Correct
                            self.movieTableView.reloadData()
                        }
                    }
                }
                catch let error as NSError
                {
                    print(error.localizedDescription)
                }
            }
            task.resume()
    }
        @objc func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}

