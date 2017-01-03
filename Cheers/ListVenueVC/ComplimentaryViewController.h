//
//  ComplimentaryViewController.h
//  Cheers
//
//  Created by macOS on 11/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmendImageView.h"
#import <MZTimerLabel.h>
@interface ComplimentaryViewController : UIViewController<MZTimerLabelDelegate>
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet AmendImageView *ivDrinkImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lbDrinkNameOutlet;


@property NSString  *drinkName;
@property NSString  *drinkImage;

@end
