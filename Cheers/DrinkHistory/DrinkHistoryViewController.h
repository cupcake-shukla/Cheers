//
//  DrinkHistoryViewController.h
//  Cheers
//
//  Created by Abhishek on 12/30/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrinkHistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
