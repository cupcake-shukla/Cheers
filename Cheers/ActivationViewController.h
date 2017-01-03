//
//  ActivationViewController.h
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivationViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfActivationCode;
@property (weak, nonatomic) IBOutlet UIButton *btResendActivationOutlet;
@property (weak, nonatomic) IBOutlet UITextField *tfMobileNumberOutlet;

@end
