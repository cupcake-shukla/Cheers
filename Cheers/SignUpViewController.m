//
//  SignUpViewController.m
//  Cheers
//
//  Created by macOS on 11/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "SignUpViewController.h"
#import "AccessApi.h"
#import "MRProgress.h"
#import "Support.h"
#import "Reachability.h"
@interface SignUpViewController (){
   
    NSString *firstName;
    NSString *lastName;
    NSString *mobileNo;
    NSString *email;
    NSString *password;
    NSString *confirmPassword;

}


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewSignUP.layer.cornerRadius=10;
    self.btSignUpOutlet.layer.cornerRadius=10;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.tfEmailOutlet.delegate = self;
    self.tfMobileOutlet.delegate = self;
//    self.tfMobileOutlet.delegate = self;
    self.tfLastNameOutlet.delegate = self;
    self.tfFirstNameOutlet.delegate = self;
    self.tfPasswordOutlet.delegate = self;
    self.tfConfirmPasswordOutlet.delegate = self;
    
    
    // Do any additional setup after loading the view.
}

-(void)dismissKeyboard {
    [self.tfEmailOutlet resignFirstResponder];
    [self.tfMobileOutlet resignFirstResponder];
    [self.tfLastNameOutlet resignFirstResponder];
    [self.tfFirstNameOutlet resignFirstResponder];
    [self.tfConfirmPasswordOutlet resignFirstResponder];
    [self.tfPasswordOutlet resignFirstResponder];
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


#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
-(void)SignUpuserService{
//
//    [[NSUserDefaults standardUserDefaults] setObject:self.tfMobileOutlet.text forKey:@"userMobileNumber"];
    
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"email": self.tfEmailOutlet.text,
                            @"password": self.tfPasswordOutlet.text,
                            @"name" : self.tfFirstNameOutlet.text
                            }
                    };
    
//    @"mobile" : self.tfMobileOutlet.text
    
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        
    {
        [Support showAlert:@"Please Check Your Internet Connection"];

    }else{
    [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"%@userRegister",BASE_URL] parameters:parameters reqCode:1] execute];
    }
}


-(void) onDone:(int)statusCode andData:(NSData *)data andReqCode:(int)reqCode{
    
    if(data!=nil){
        
        

    switch (reqCode) {
        case 1://REQUEST_SIGNIN:
            [[NSOperationQueue mainQueue] addOperationWithBlock:^
             {
                 
                 [self hideLoadingView];
                 
                 NSMutableDictionary *object =[[NSMutableDictionary alloc] init];
            
                 
                 object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                 NSLog(@"Data is s%@",object);
                 
                 if([object[@"id"] isEqualToString:@"OK"]){
                     
                     [[NSUserDefaults standardUserDefaults] setObject:object[@"uid"]  forKey:@"uid"];
                     [[NSUserDefaults standardUserDefaults] setObject:self.tfFirstNameOutlet.text  forKey:@"uname"];
                     [[NSUserDefaults standardUserDefaults] setObject:self.tfMobileOutlet.text  forKey:@"userMobileNumber"];
                     [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"fromSignUp"];
                     NSLog(@"%@",object[@"uid"]);
                     [self hideLoadingView];
                     
                     [self performSegueWithIdentifier:@"SignUpToOTP" sender:self];
                     
                     
                 }else{
                     NSString *error;
                     if(object[@"msg"]!=nil){
                         error=object[@"msg"];
                     }else{
                        error=@"your id or password is incorrect";
                     }
                     
                     [[[UIAlertView alloc] initWithTitle:@"Alert!" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                 }
             }];
    }}else{
        [self hideLoadingView];
        [Support showAlert:@"please check your internet connection"];
    }
}
- (IBAction)btSignUPAction:(id)sender {
    
    firstName = self.tfFirstNameOutlet.text;
    lastName= self.tfLastNameOutlet.text;
    mobileNo=self.tfMobileOutlet.text;
    email=self.tfEmailOutlet.text;
    password=self.tfPasswordOutlet.text;
    confirmPassword=self.tfConfirmPasswordOutlet.text;
    
    
    [Support trim:email];
    
    if([firstName length]<1){
        
        [Support showAlert:@"Please enter first name"];

    }
//    else if([lastName length]<1){
//        
//        [Support showAlert:@"Please enter last name"];
//
//    }
//    else if([mobileNo length]<10){
//    
//        [Support showAlert:@"mobile no can't be less than 10 character"];
//    }
    else if(email.length==0){
        [Support showAlert:@"Please enter email id"];
    }
    
    else if(![Support isValidEmail:email]){
        [Support showAlert:@"Please enter valid email id"];
    }
    
    else if([Support trim:password].length == 0){
        [Support showAlert:@"Please enter password"];
    }
    
    else if([password length]<6){
        [Support showAlert:@"Password can't be less than 6 character"];
    }
   
//    else if(![password isEqualToString:confirmPassword]){
//        
//        [Support showAlert:@"Password can't be less than 6 character"];
//
//    }
    
    else{
        
        [self.view endEditing:YES];
        [self showLoadingMode];
        [self SignUpuserService];
        
        
    }

   }

-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}

 
@end
