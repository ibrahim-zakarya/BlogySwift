//
//  BlogDetailsViewController.swift
//  Blogy2
//
//  Created by admin on 29/09/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import ActionButton


class BlogDetailsViewController: UIViewController {

    var blog: [String: AnyObject]?
    
    
    let blogImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let blogTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "empty"
        lbl.numberOfLines = 2
        lbl.backgroundColor = .green
        return lbl
    }()
    
    let blogBody: UITextView = {
        let tv = UITextView()
        tv.text = "empty"
        tv.backgroundColor = .red
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let blog = blog {
            blogTitle.text = blog["title"] as? String
            blogBody.text = blog["body"] as? String
        }
        setupBlogViews()
        view.backgroundColor = .white
        
        setUpFloatingButton()
    }
    
    func setupBlogViews() {
        view.addSubview(blogImageView)
        view.addSubview(blogTitle)
        view.addSubview(blogBody)
        
        let tview = UIView()
        view.addSubview(tview)
        tview.backgroundColor = .clear
        tview.frame = (navigationController?.navigationBar.frame)!
        
        blogImageView.anchor(tview.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 210)
        blogTitle.anchor(blogImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        blogBody.anchor(blogTitle.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }
    
    var floatingButton: ActionButton!
    var share: ActionButtonItem!
    var email: ActionButtonItem!
    
    func setUpFloatingButton() {
        
        let floatingButtonView = UIView()
        floatingButtonView.backgroundColor = .white
        view.addSubview(floatingButtonView)
        floatingButtonView.anchor(nil, left: nil, bottom: self.view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 50, rightConstant: 8, widthConstant: 125, heightConstant: 175)
        
        let twitterImage = UIImage(named: "logo")!
        let plusImage = UIImage(named: "logo")!
        
        share = ActionButtonItem(title: "share", image: twitterImage)
        share.action = { item in print("Sharing...") }
        
        email = ActionButtonItem(title: "email", image: plusImage)
        email.action = { item in print("Email...") }
        
        floatingButton = ActionButton(attachedToView: floatingButtonView, items: [share, email])
        floatingButton.action = { button in button.toggleMenu() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
}
