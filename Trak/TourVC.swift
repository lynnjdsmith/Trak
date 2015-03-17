//
//  TourViewController.swift
//  Trak
//
//  Created by Lynn Smith on 2/22/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import UIKit


class TourVC: UIViewController, UIPageViewControllerDataSource {
  
  // MARK: - Variables
  private var pageViewController: UIPageViewController?
  
  // Initialize it right away here
  private let contentImages = ["icon_graph_300_bw.png",
    "helperBKG.png",
    "helperBKG.png",
    "helperBKG.png"];
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    createPageViewController()
    setupPageControl()
  }
  
  private func createPageViewController() {
    
    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let pageController = storyboard.instantiateViewControllerWithIdentifier("PageController") as UIPageViewController
    
    
    //self.presentViewController(vc, animated: true, completion: nil)
    
    //let pageController = self.storyboard?.instantiateViewControllerWithIdentifier("PageController") as UIPageViewController
    pageController.dataSource = self
    
    if contentImages.count > 0 {
      let firstController = getItemController(0)!
      let startingViewControllers: NSArray = [firstController]
      pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    pageViewController = pageController
    addChildViewController(pageViewController!)
    self.view.addSubview(pageViewController!.view)
    pageViewController!.didMoveToParentViewController(self)
  }
  
  private func setupPageControl() {
    let appearance = UIPageControl.appearance()
    appearance.pageIndicatorTintColor = UIColor.grayColor()
    appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
    appearance.backgroundColor = UIColor.darkGrayColor()
  }
  
  // MARK: - UIPageViewControllerDataSource
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    
    let itemController = viewController as PageItemController
    
    if itemController.itemIndex > 0 {
      return getItemController(itemController.itemIndex-1)
    }
    
    return nil
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
    let itemController = viewController as PageItemController
    
    if itemController.itemIndex+1 < contentImages.count {
      return getItemController(itemController.itemIndex+1)
    }
    
    return nil
  }
  
  private func getItemController(itemIndex: Int) -> PageItemController? {
    
    if itemIndex < contentImages.count {
      let piController :PageItemController = self.storyboard?.instantiateViewControllerWithIdentifier("ItemController") as PageItemController
      piController.itemIndex = itemIndex
      piController.imageName = contentImages[itemIndex]
      return piController
    }
    
    return nil
  }
  
  // MARK: - Page Indicator
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return contentImages.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return 0
  }
  
  
  @IBAction func skipButtonPressed(sender: AnyObject) {
    self.revealViewController()?.rightRevealToggle(sender)
    self.view.endEditing(true)
  }
  
  
}