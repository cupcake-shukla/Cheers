//
//  SearchBarViewController.h
//  Cheers
//
//  Created by Abhishek on 12/26/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchBarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>



//@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UISearchBar *sbSearchBarOutlet;

@end
