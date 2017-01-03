//
//  ViewController.h
//  Cheers
//
//  Created by macOS on 05/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AccessApi.h"
@interface LoginViewController : UIViewController<FBSDKLoginButtonDelegate , UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btSignUpFbOutlet;

@property (weak, nonatomic) IBOutlet UIButton *btSignUpOutlet;

@property (weak, nonatomic) IBOutlet UIView *viewTextfield;
- (IBAction)btFbLoginAction:(id)sender;
@property (weak, nonatomic) IBOutlet id<FBSDKLoginButtonDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *lbEmailOutlet;
@property (weak, nonatomic) IBOutlet UITextField *lbPasswordOutlet;

- (IBAction)btSignInAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btSignInOutlet;
@property (weak, nonatomic) IBOutlet UIButton *btTermsOfServiceOutlet;
@property (weak, nonatomic) IBOutlet UIButton *btPrivacyPolicyOutlet;


@end

