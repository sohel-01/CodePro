//
//  ViewController.swift
//  CodePro
//
//  Created by MacStudent on 2018-11-08.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController : UIPageViewController?
    
    let images = ["one","two","three","four","five","six","seven","eight","nine","ten"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        createPageViewController()
        setupPageControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createPageViewController(){
        let pageController = self.storyboard?.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if images.count > 0 {
            let firstController = getItemController(0)!
            let startingViewController = [firstController]
            
            pageController.setViewControllers(startingViewController, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        }
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController?.didMove(toParentViewController: self)
    }
    func setupPageControl(){
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! ItemViewController
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! ItemViewController
        
        if itemController.itemIndex+1 < images.count {
            return getItemController(itemController.itemIndex+1)
        }
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return images.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func currentControlIndex()-> Int {
        let pageItemController = self.currentControlIndex()
        if let controller = pageItemController as? ItemViewController{
            return controller.itemIndex
        }
        return -1
}
//    func  currentController() -> UIViewController {
//        if(self.pageViewController?.viewControllers?.count)! > 0 {
//            return (self.pageViewController?.viewControllers![0])!
//        }
//        return nil
//    }
    
    func getItemController(_ itemIndex: Int) -> ItemViewController?{
        if itemIndex < images.count{
            let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: "ItemController") as! ItemViewController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = images[itemIndex]
            return pageItemController
        }
        return nil
    }
    
}
