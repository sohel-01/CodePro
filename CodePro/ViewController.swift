//
//  ViewController.swift
//  CodePro
//
//  Created by MacStudent on 2018-11-08.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageViewController : UIPageViewController?
    let pageControl =  UIPageControl.appearance()
    
    let images = ["one","two","three","four","five","six","seven","eight","nine","ten"]
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        createPageViewController()
        setupPageControl()
        let tap = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap1.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap1)
        
        timer = Timer.scheduledTimer(timeInterval: 3,target: self,selector: #selector(self.next(_:)),userInfo: nil,repeats: true)
        
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
    @objc func singleTapped() {
        timer.invalidate()
        
    }
    @objc func doubleTapped() {
    Timer.scheduledTimer(timeInterval: 3,target: self,selector: #selector(self.next(_:)),userInfo: nil,repeats: true)
    }
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
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return images.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    @objc func next(_ timer: Timer) {
        pageViewController?.goToNextPage()
        
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
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.backgroundColor = UIColor.red

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
