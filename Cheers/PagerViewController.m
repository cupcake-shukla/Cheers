//
//  ViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "PagerViewController.h"

@interface PagerViewController ()
{
    int currentPageIndex;
}
- (IBAction)btActionSkip:(id)sender;
@end

@implementation PagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Create the data model
    _pageTitles = @[@"Discover Hidden Features",@"Over 200 Tips and Tricks",  @"Bookmark Favorite Tip"];
    _pageImages = @[@"page1.jpg", @"page2.jpg", @"page3.jpg"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(30, 50, self.view.frame.size.width-60, self.view.frame.size.height -100 );
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    currentPageIndex = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkthrough:(id)sender {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    currentPageIndex= index;
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


- (IBAction)btNextAction:(id)sender {
    
    if(currentPageIndex >3){
//        [self changePage:UIPageViewControllerNavigationDirectionForward];
  
        
//        PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
//        NSArray *viewControllers = @[startingViewController];
//        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
//        
//        // Change the size of page view controller
//        self.pageViewController.view.frame = CGRectMake(30, 50, self.view.frame.size.width-60, self.view.frame.size.height -100 );
//        
//        [self addChildViewController:_pageViewController];
//        [self.view addSubview:_pageViewController.view];
//        [self.pageViewController didMoveToParentViewController:self];
   
    }
}


//- (void)changePage:(UIPageViewControllerNavigationDirection)direction {
//    NSUInteger pageIndex = ((PagerViewController *) [_pageViewController.viewControllers objectAtIndex:0]).pageIndex;
//    if (direction == UIPageViewControllerNavigationDirectionForward){
//        pageIndex++;
//    }else {
//        pageIndex--;
//    }
//    PagerViewController *viewController = [self  viewControllerAtIndex:pageIndex];
//    if (viewController == nil) {
//        return;
//    }
//    [_pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:nil];
//}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (IBAction)btActionSkip:(id)sender {
    if([[NSUserDefaults standardUserDefaults]  objectForKey:@"permissions"]){
        [self performSegueWithIdentifier:@"permissions" sender:nil];
    }
    else{
        [self performSegueWithIdentifier:@"dashboard" sender:nil];
    }
}
@end
