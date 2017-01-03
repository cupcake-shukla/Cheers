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
@interface VenueListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet AmendImageView *ivBannerImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lbplaceNameOutlet;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *vStarViewOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lbReviewListOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lbDistanceOutlet;
@property (weak, nonatomic) IBOutlet UIButton *btLikedOutlet;

@end
