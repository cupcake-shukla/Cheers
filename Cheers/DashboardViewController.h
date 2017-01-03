//
//  DashboardViewController.h
//  Cheers
//
//  Created by macOS on 05/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MZTimerLabel.h>

@interface DashboardViewController : UIViewController<MZTimerLabelDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarbutton;

@end
