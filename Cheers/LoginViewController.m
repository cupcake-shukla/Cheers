//
//  ViewController.m
//  Cheers
//
//  Created by macOS on 05/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MRProgress.h"
#import "Support.h"
#import "Reachability.h"

@interface LoginViewController (){
    
    NSUserDefaults *defaults;
    NSString *accessToken;
    NSString * socialId;
    NSString * name;
    NSString * firstName;
    NSString * lastName;
    NSString * imageUrl;
    NSString *email, *authType,*userPassword;
    
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"" forKey:@"uImageUrl"];
    
    
    self.btSignUpFbOutlet.layer.cornerRadius= 15;
    self.btSignUpFbOutlet.clipsToBounds = YES;
    
    self.btSignInOutlet.layer.cornerRadius=15;
    self.btSignInOutlet.clipsToBounds=YES;
    
    self.viewTextfield.layer.cornerRadius= 15;
    self.viewTextfield.clipsToBounds = YES;
    
    self.btSignUpOutlet.titleLabel.adjustsFontSizeToFitWidth=YES;
    self.btPrivacyPolicyOutlet.titleLabel.adjustsFontSizeToFitWidth=YES;
    self.btTermsOfServiceOutlet.titleLabel.adjustsFontSizeToFitWidth=YES;
    
    self.lbEmailOutlet.delegate = self;
    self.lbPasswordOutlet.delegate = self;
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)dismissKeyboard {
    [self.lbEmailOutlet resignFirstResponder];
    [self.lbPasswordOutlet resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btFbLoginAction:(id)sender {
    
    [self showLoadingMode];
    [self loginButtonClicked];
    
    int facebookLogin=1;
    
    [defaults setInteger:facebookLogin forKey:@"NSUDfacebookLogin"];
    [defaults synchronize];
    
}

-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
                 fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                      [self hideLoadingView];
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                      [self hideLoadingView];
                                } else {
                                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, first_name, last_name, email,picture, birthday"}]
                                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                         if (!error) {
                                             NSLog(@"fetched user:%@", result);
                                             
                                             NSLog(@"%@",result[@"email"]);
                                             NSLog(@"%@",result[@"name"]);
                                             NSLog(@"%@",result[@"id"]);
                                             accessToken = [FBSDKAccessToken currentAccessToken].tokenString;
                                             name =result[@"name"];
                                             socialId =result[@"id"];
                                             email = result[@"email"];
                                             imageUrl = result[@"picture"][@"data"][@"url"];
                                             authType=@"Facebook";
                                             firstName = result[@"first_name"];
                                             lastName = result[@"last_name"];
                                             
                                             [defaults setValue:authType forKey:@"NSUDAuthType"];
                                             
                                             [defaults setObject:result forKey:@"resultFB"];

                                             
//                                             if(![imageUrl isEqualToString:@"<null>"] || ![imageUrl isEqualToString:@""]){
//                                             
//                                             
////                                             NSData *data = [imageUrl dataUsingEncoding:NSUTF8StringEncoding];
//                                               [defaults setObject:imageUrl forKey:@"uImageUrl"];
//                                             }
//                                            
//                                              NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:@"uImageUrl"];
                                             
                                             
//                                             NSString* myString;

//                                             myString = [[NSString alloc] initWithData:url encoding:NSASCIIStringEncoding];
                                             
                                            
                                             
                                             [[NSUserDefaults standardUserDefaults] setObject:name  forKey:@"uname"];
                                             
                                             [self SignINUsingFacebookuserService];
                                             
//                                             [[NSUsersDefaults standardUserDefaults] setObject:@"1"  forKey:@"uid"];
                                             //
//                                             [self performSegueWithIdentifier:@"toDashboard" sender:nil];
                                             
                                             //[self performSignin];
                                             [self hideLoadingView];
                                         }
                                         else{
                                             NSLog(@"Failed with Error");
                                         }
                                     }];
                                    
                                }
                            }];
}
- (IBAction)btSignInAction:(id)sender {
    email = self.lbEmailOutlet.text;
    email = [Support trim:email];
    userPassword=self.lbPasswordOutlet.text;
    
    if(email.length==0){
        [Support showAlert:@"Please enter email id"];
    }
    
    else if(![Support isValidEmail:email]){
        [Support showAlert:@"Please enter valid email id"];
    }
    
    else if([Support trim:userPassword].length == 0){
        [Support showAlert:@"Please enter password"];
    }
    
//    else if([userPassword length]<5){
//        [Support showAlert:@"Password can't be less than 6 character"];
//    }
    
    else{
//        userPassword = [Support md5:userPassword];
        [self.view endEditing:YES];
        authType=@"Normal";
        [self showLoadingMode];
        [self SignINuserService];

        
    }
    
}


-(void)SignINuserService{
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"email": email,
                            @"password": userPassword
                            }
                    };
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        
    {
        [Support showAlert:@"Please Check Your Internet Connection"];

        
    }else{
    [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"%@userLogin",BASE_URL] parameters:parameters reqCode:1] execute];
    }
}



-(void)SignINUsingFacebookuserService{
  
    [self showLoadingMode];
    
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"email": email,
                            @"first_name": firstName,
                            @"last_name" : lastName,
                                @"id" : socialId,
                                @"picture" : imageUrl
                                
                            }
                    };
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        
    {
        
        [Support showAlert:@"Please Check Your Internet Connection"];

    }else{
    [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"%@facebookSigninup",BASE_URL] parameters:parameters reqCode:1] execute];
    }
}
-(void) onDone:(int)statusCode andData:(NSData *)data andReqCode:(int)reqCode{
    
    if(data!=nil){
        
        

    switch (reqCode) {
        case 1://REQUEST_SIGNIN:
            [[NSOperationQueue mainQueue] addOperationWithBlock:^
             {
                 NSMutableDictionary *object =[[NSMutableDictionary alloc] init];
                 object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                 NSLog(@"Data is s%@",object);
                 if([object[@"id"] isEqualToString:@"OK"]){
                     [[NSUserDefaults standardUserDefaults] setObject:object[@"uid"]  forKey:@"uid"];
                  
                     
                     
                     
                     
                     if(object[@"uname"] != [NSNull null]){
                     NSString *uName = object[@"uname"];
                     if(  uName.length != 0){
                     [[NSUserDefaults standardUserDefaults] setObject:object[@"uname"]  forKey:@"uname"];
                     }
                     }
                     if(![imageUrl isEqualToString:@"<null>"] || ![imageUrl isEqualToString:@""]){
                         [defaults setObject:imageUrl forKey:@"uImageUrl"];
                     }
                     
                     [defaults synchronize];
                     
//                     NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:@"uImageUrl"];
                     
                     NSDictionary *resultFB = [[NSUserDefaults standardUserDefaults] objectForKey:@"resultFB"];
                     
                     
                     
                     NSLog(@"%@",resultFB);
                     
                     [self performSegueWithIdentifier:@"toDashboard" sender:nil];
                     [self hideLoadingView];
                 }else{
                     
                     [self hideLoadingView];
                     [Support showAlert:@"You email or password is incorrect"];
                 }
             }];
    }
    }else{
        [self hideLoadingView];
        [Support showAlert:@"please check your internet connection"];
    }
}
-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];

}
@end
