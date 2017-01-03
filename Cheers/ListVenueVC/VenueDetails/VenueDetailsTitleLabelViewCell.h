//
//  VenueListTableViewCell.h
//  Cheers
//
//  Created by macOS on 11/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmendImageView.h"
#import "HCSStarRatingView.h"
@interface VenueDetailsTitleLabelViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UILabel *LbredeemTime;
@property (weak, nonatomic) IBOutlet UILabel *lbOpeingHours;
@property (weak, nonatomic) IBOutlet UIButton *btviewOnMapOutlet;
@property (weak, nonatomic) IBOutlet UIButton *btGetDirectionOutlet;

@end
