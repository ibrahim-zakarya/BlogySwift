//
//  PopularFeedCollectionViewCell.swift
//  Blogy2
//
//  Created by admin on 30/09/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Alamofire

class PopularFeedCollectionViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var popularFeedCollectionView: UICollectionView!
    
    var blogs: [[String: AnyObject]]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async(execute: {
            self.downloadAllBlogsData()
        })
        
        popularFeedCollectionView.dataSource = self
        popularFeedCollectionView.delegate = self
        popularFeedCollectionView.register(UINib(nibName: "BlogCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
        popularFeedCollectionView.register(UINib(nibName: "TopBlogCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellId1")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: self.frame.width, height: 224)
        }
        return CGSize(width: self.frame.width / 2 - 5, height: 208)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return blogs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId1", for: indexPath) as! TopBlogCollectionViewCell
            if let blog = blogs?[indexPath.row]{
                cell.blogTitleLabel.text = blog["title"] as? String
//                cell.blogImageView.loadImage(urlString: post[""] as! String)
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! BlogCollectionViewCell
        if let blog = blogs?[indexPath.row] {
            cell.blogTitleLabel.text = blog["title"] as? String
//            cell.blogImageView.loadImage(urlString: post[""] as! String)
        }
        return cell
    }
    
    
    var viewController: ViewController?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let blog = blogs?[indexPath.row] {
            let blogDetailsVC = BlogDetailsViewController()
            blogDetailsVC.blog = blog
            
            viewController?.showBlogDetails(viewController: blogDetailsVC)
        }
    }
    
    func downloadAllBlogsData() {
        let url = "https://jsonplaceholder.typicode.com/posts"
        Alamofire.request(url, method: .get).responseJSON { response in
            //            print("Result: \(response.result)")
            
            if "\(response.result)" == "FAILURE" {
                print("download faild")
            }
            if let json = response.result.value  as? [[String: AnyObject]] {
                //                print("JSON: \(json[0])") // serialized json response
                self.blogs = json
                self.popularFeedCollectionView.reloadData()
            }
        }
    }
}
