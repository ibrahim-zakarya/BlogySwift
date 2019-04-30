//
//  ViewController.swift
//  Blogy
//
//  Created by admin on 22/09/2017.
//  Copyright © 2017 malekmouzayen. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    static var sharedInstance = ViewController()
    
    @IBOutlet weak var topMenuBarCollectionView: UICollectionView!
    @IBOutlet weak var blogsFeedCollectionView: UICollectionView!
    @IBOutlet weak var topMenuView: UIView!
    //    @IBOutlet weak var topCollectionView: UICollectionView!
    
    var posts: [[String: AnyObject]]?
//    let topMenuTitles = ["Popular", "Recent", "Suggested"]
    
    let topMenuTitles : [Setting] = {
        let stn1 = Setting(name: "Popular")
        let stn2 = Setting(name: "Recent")
        let stn3 = Setting(name: "Suggested")
        return [stn1, stn2, stn3]
    }()
    
    func setupFlowLayou() {
        if let flowLayout = topMenuBarCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        if let flowLayout = blogsFeedCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
    }
    
    func sideMenus() {
        
        if revealViewController() != nil {
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            
            
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
//        DispatchQueue.main.async(execute: {
//            self.downloadAllBlogsData()
//        })
        blogsFeedCollectionView.delegate = self
        blogsFeedCollectionView.dataSource = self
        blogsFeedCollectionView.isPagingEnabled = true
        blogsFeedCollectionView.showsHorizontalScrollIndicator = false
        
        
        topMenuBarCollectionView.delegate = self
        topMenuBarCollectionView.dataSource = self
        topMenuBarCollectionView.isPagingEnabled = true
        
        setupFlowLayou()
        
        blogsFeedCollectionView.register(UINib(nibName: "PopularFeedCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "cellId")
        blogsFeedCollectionView.register(RecentFeedCollectionViewCell.self, forCellWithReuseIdentifier: "recentCellId")
        topMenuBarCollectionView.register(TopMenuCell.self, forCellWithReuseIdentifier: "cellId2")
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        topMenuBarCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())

        setupHorizontalBar()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topMenuBarCollectionView {
            return 3
        } else if collectionView == blogsFeedCollectionView {
            return 3
        }
        return posts?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topMenuBarCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId2", for: indexPath) as! TopMenuCell
            let setting = topMenuTitles[indexPath.row]
            cell.setting = setting
            return cell
        } else if collectionView == blogsFeedCollectionView {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PopularFeedCollectionViewCell
                cell.viewController = self
                return cell
            } else if indexPath.row == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCellId", for: indexPath) as! RecentFeedCollectionViewCell
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PopularFeedCollectionViewCell
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PopularFeedCollectionViewCell
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let blogDetailsVC = segue.destination as? BlogDetailsViewController {
//            blogDetailsVC.blog =
//        }
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topMenuBarCollectionView {
            scrollToMenuIndex(indexPath.item)
            return
        }
        performSegue(withIdentifier: "blogDetails", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topMenuBarCollectionView {
            return CGSize(width: topMenuView.frame.width / 4, height: 23)
        } else if collectionView == blogsFeedCollectionView {
            return CGSize(width: blogsFeedCollectionView.frame.width, height: blogsFeedCollectionView.frame.height)
        }
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 224)
        }
        return CGSize(width: view.frame.width / 2 - 5, height: 208)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(red: 73/255, green: 220/255, blue: 144/255, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        topMenuView.addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: topMenuView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: topMenuView.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        topMenuBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
    }

    func scrollToMenuIndex(_ menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        blogsFeedCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
    
    
    
    func showBlogDetails(viewController: UIViewController) {
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
//    func downloadAllBlogsData() {
//        let url = "https://jsonplaceholder.typicode.com/posts"
//        Alamofire.request(url, method: .get).responseJSON { response in
//            //            print("Result: \(response.result)")
//            
//            if "\(response.result)" == "FAILURE" {
//                print("download faild")
//            }
//            if let json = response.result.value  as? [[String: AnyObject]] {
//                //                print("JSON: \(json[0])") // serialized json response
//                self.posts = json
//                self.blogsFeedCollectionView.reloadData()
//            }
//        }
//    }
    
}

