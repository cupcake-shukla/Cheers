//
//  DrinkRatingViewController.h
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"


@interface DrinkRatingViewController : UIViewController
@property (weak, nonatomic) IBOutlet HCSStarRatingView *barServiceRating;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *drinkRating;
- (IBAction)btSkipThis:(id)sender;

@end
