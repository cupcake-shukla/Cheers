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
@interface VenueDetailsRedeemableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet AmendImageView *ivDrinkOne;

@property (weak, nonatomic) IBOutlet UIButton *redeemDrinkOutlet;
@property (weak, nonatomic) IBOutlet UILabel *ivDrinNameone;
@property (weak, nonatomic) IBOutlet AmendImageView *ivDrinkTwo;
@property (weak, nonatomic) IBOutlet UILabel *ivDrinNameTwo;
@property (weak, nonatomic) IBOutlet UIButton *drink1;
@property (weak, nonatomic) IBOutlet UIButton *drink2;
@end
