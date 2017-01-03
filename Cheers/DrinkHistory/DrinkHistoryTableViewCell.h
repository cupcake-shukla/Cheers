//
//  DrinkHistoryTableViewCell.h
//  Cheers
//
//  Created by Abhishek on 12/30/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrinkHistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *VenueOutlet;


@property (weak, nonatomic) IBOutlet UILabel *DrinkNameOutlet;


@property (weak, nonatomic) IBOutlet UILabel *PriceOutlet;


@property (weak, nonatomic) IBOutlet UILabel *RedemptionDateOutlet;


@end
