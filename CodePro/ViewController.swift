//
//  ViewController.swift
//  CodePro
//
//  Created by MacStudent on 2018-11-08.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var currentIndex: Int?
    var pageViewController : UIPageViewController?
    var pageControl: UIPageControl?
    
    let images = ["one","two","three","four","five","six","seven","eight","nine","ten"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        createPageViewController()
        setupPageControl()
        
       let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        currentIndex = 0
        
        
        Timer.scheduledTimer(timeInterval: 2,
                             target: self,
                             selector: #selector(self.next(_:)),
                             userInfo: nil,
                             repeats: true)
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
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index: Int = (viewController as! ItemViewController).itemIndex
        if index == 0 || index == NSNotFound{
            index = self.images.count
        }
        index = index-1
        return getItemController(index)
    }
//        let itemController = viewController as! ItemViewController
//        if itemController.itemIndex > 0 {
//            return getItemController(itemController.itemIndex-1)
//        }
//        return nil
//    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index: Int = (viewController as! ItemViewController).itemIndex
        if index == NSNotFound{
         return nil
        }
        index = index+1
        if index == self.images.count{
         index = 0
        }
        return getItemController(index)
    }
//        let itemController = viewController as! ItemViewController
//
//        if itemController.itemIndex+1 < images.count {
//            return getItemController(itemController.itemIndex+1)
//        }
//        return nil
//    }
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
    @objc func next(_ timer: Timer) {
        pageViewController?.goToNextPage()
        currentIndex = currentIndex! + 1
        if currentIndex == pageControl?.numberOfPages{
            currentIndex = 0
        }
        pageControl?.currentPage = currentIndex!
        setupPageControl()
    }
    
    func getItemController(_ itemIndex: Int) -> ItemViewController?{
        if itemIndex < images.count{
            let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: "ItemController") as! ItemViewController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = images[itemIndex]
            return pageItemController
        }
        return nil
    }
    func setupPageControl(){
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
        
    }
    
}
extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
            }
        }
}
}
