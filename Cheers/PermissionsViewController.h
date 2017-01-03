//
//  PermissionsViewController.h
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PermissionsViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *continueOutlet;
@property (weak, nonatomic) IBOutlet UIButton *allowContactOutlet;
@property (weak, nonatomic) IBOutlet UIButton *notificationOutlet;
@property (weak, nonatomic) IBOutlet UIButton *locationOutlet;

@end
