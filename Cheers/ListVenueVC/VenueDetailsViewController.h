//
//  VenueDetailsViewController.h
//  Cheers
//
//  Created by Greyloft on 12/13/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmendImageView.h"

@interface VenueDetailsViewController :  UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property  NSDictionary *venueDetails;
@property (weak, nonatomic) IBOutlet UIView *vDrinkDetailsOutlet;
@property (weak, nonatomic) IBOutlet AmendImageView *vDrinkImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *vDrinkName;

@end
