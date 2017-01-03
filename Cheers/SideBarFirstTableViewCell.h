//
//  SideBarFirstTableViewCell.h
//  Cheers
//
//  Created by macOS on 05/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmendImageView.h"
@interface SideBarFirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AmendImageView *ivUserImage;
@property (weak, nonatomic) IBOutlet UILabel *lbUserName;
@property (weak, nonatomic) IBOutlet UILabel *lbOpenAccount;

@end
