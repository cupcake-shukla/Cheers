//
//  ChoosePlanTableViewCell.h
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePlanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UITextView *lbContent;
@property (weak, nonatomic) IBOutlet UIButton *btPrice;

@end
