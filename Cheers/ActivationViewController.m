//
//  ActivationViewController.m
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "ActivationViewController.h"
#import "AccessApi.h"
#import "MRProgress.h"
#import "Reachability.h"
#import "Support.h"
@interface ActivationViewController ()

@end

@implementation ActivationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.tfMobileNumberOutlet.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userMobileNumber"];
    

//     int fromSignUp =   [[NSUserDefaults standardUserDefaults] integerForKey:@"fromSignUp"];
//    
//    
//    if(fromSignUp == 1){
//        self.tfMobileNumberOutlet.userInteractionEnabled = false;
//        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"fromSignUp"];
//        
//    }
//    else{
    
//    }
    
    
    // Do any additional setup after loading the view.
    
    self.tfActivationCode.layer.cornerRadius=20;
    self.btResendActivationOutlet.layer.cornerRadius=20;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.tfActivationCode.delegate = self;
    self.tfMobileNumberOutlet.delegate = self;
}





-(void)dismissKeyboard {
  
    [self.tfActivationCode resignFirstResponder];
    [self.tfMobileNumberOutlet resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btActivationCodeAction:(id)sender {
//    [self showLoadingMode];
//    [self SignINuserService];
         [self verifyOTPService];
    
    
   
    
}
- (IBAction)getOTPActions:(id)sender {

    NSString *mobileNumber = self.tfMobileNumberOutlet.text;
    if([mobileNumber length]<10){
        [Support showAlert:@"mobile no can't be less than 10 character"];
    }else{
        [self getOTPService];
    }
    
}



-(void)verifyOTPService{
   
    [self showLoadingMode];
    
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"mobile": self.tfMobileNumberOutlet.text,
                            @"uid" : [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],
                            @"otp" : self.tfActivationCode.text
                            }
                    };
    
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable){
        
        [Support showAlert:@"Please Check Your Internet Connection"];
    }else{
        [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"http://cheersapp.com.au/services/clients.php/optVerify"] parameters:parameters reqCode:2] execute];
    }
    
    
    
    
}



-(void)getOTPService{
    [self showLoadingMode];
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"mobile": self.tfMobileNumberOutlet.text,
                            @"uid" : [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]
                            }
                    };
    
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable){
    
        [Support showAlert:@"Please Check Your Internet Connection"];
    }else{
        [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"http://cheersapp.com.au/services/clients.php/sendOTP"] parameters:parameters reqCode:1] execute];
    }
    
    
    
    
}
-(void) onDone:(int)statusCode andData:(NSData *)data andReqCode:(int)reqCode{
   
    [self hideLoadingView];
    
    switch (reqCode) {
        case 1://REQUEST_SIGNIN:
            if(data!=nil){
                
            [[NSOperationQueue mainQueue] addOperationWithBlock:^
             {
                 NSMutableDictionary *object =[[NSMutableDictionary alloc] init];
                 object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                 NSLog(@"Data is s%@",object);
                 if([object[@"id"] isEqualToString:@"OK"]){
                     [self hideLoadingView];
                 }
             }];
            }else{
                [self hideLoadingView];
                [Support showAlert:@"please check your internet connection"];
            }
            break;
        case 2:
            if(data!=nil){
            
                [[NSOperationQueue mainQueue] addOperationWithBlock:^
                 {
                     NSMutableDictionary *object =[[NSMutableDictionary alloc] init];
                     object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                     NSLog(@"Data is s%@",object);
                     if([object[@"id"] isEqualToString:@"OK"]){
                         [self hideLoadingView];
                          [self performSegueWithIdentifier:@"VerificationToTut" sender:nil];
                     }
                 }];
            }else{
                [self hideLoadingView];
                [Support showAlert:@"please check your internet connection"];
            }
            
    }

}

-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}

@end
