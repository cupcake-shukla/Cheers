//
//  SignUpViewController.h
//  Cheers
//
//  Created by macOS on 11/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewSignUP;

@property (weak, nonatomic) IBOutlet UITextField *tfFirstNameOutlet;
@property (weak, nonatomic) IBOutlet UITextField *tfLastNameOutlet;
@property (weak, nonatomic) IBOutlet UITextField *tfMobileOutlet;
@property (weak, nonatomic) IBOutlet UITextField *tfEmailOutlet;
@property (weak, nonatomic) IBOutlet UITextField *tfPasswordOutlet;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPasswordOutlet;

- (IBAction)btSignUPAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btSignUpOutlet;
@property (weak, nonatomic) IBOutlet UIButton *lbTermsAndConditionOutlet;
@property (weak, nonatomic) IBOutlet UIButton *lbPrivacyPolicyOutlet;

@end
