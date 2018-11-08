//
//  ItemViewController.swift
//  CodePro
//
//  Created by MacStudent on 2018-11-08.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    var itemIndex: Int = 0
    var imageName: String = ""{
        didSet {
            if let imageView = uiImageView{
                imageView.image = UIImage(named:imageName)
            }
        }
    }
    
    
    
    
    
    
    
    @IBOutlet weak var uiImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiImageView.image = UIImage(named: imageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
