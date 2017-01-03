//
//  ChoosePlanViewController.h
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePlanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *vBillDetailsOutlet;

@end
