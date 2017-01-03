//
//  SidebarTableViewCell.h
//  State Election Commission
//
//  Created by admin on 05/08/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *settingsView;
@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UIButton *btSettingAction;

@end
