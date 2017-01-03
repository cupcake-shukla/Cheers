//
//  ComplimentaryViewController.m
//  Cheers
//
//  Created by macOS on 11/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "ComplimentaryViewController.h"
#import "Support.h"
#import "MRProgress.h"
#import "AccessApi.h"
#import "Reachability.h"
@interface ComplimentaryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timer;

@end

@implementation ComplimentaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:self.timer andTimerType:MZTimerLabelTypeTimer];
    [timer setCountDownTime:180];
    timer.timeFormat = @"mm:ss";
    
    timer.delegate = self;
    [timer start];
    // Do any additional setup after loading the view.

    // Do any additional setup after loading the view.
    
    self.borderView.layer.borderWidth = 0.5;
    UIColor *color= [Support colorWithHexString:@"3CB99E"];
    self.borderView.layer.borderColor = color.CGColor;
    
    
    NSString *dName = [[NSUserDefaults standardUserDefaults] objectForKey:@"dName"];
    
    NSString *dImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"dImage"];
    
    NSString *url = [NSString stringWithFormat:@"http://ritusha.in/manage/services/venueimg/%@",dImage];
    
    self.ivDrinkImageOutlet.amendURL = [NSURL URLWithString:url];
    self.lbDrinkNameOutlet.text = dName;
    
}

-(void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RedeemrinkAction:(id)sender {
    [self showLoadingMode];
    
    
    NSString *uid;
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"uid"]){
        uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    
   
    NSString *vid = [[NSUserDefaults standardUserDefaults] objectForKey:@"vid"];
    NSString *did = [[NSUserDefaults standardUserDefaults] objectForKey:@"did"];
    
    
    
    
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"uid": uid ,
                            @"vid": vid,
                            @"did": did,
                            @"rdate": [dateFormatter stringFromDate:[NSDate date]]
                            }
                    };
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        
    {
        [Support showAlert:@"Please Check Your Internet Connection"];

    }else{
    [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"%@redeemDrink",BASE_URL] parameters:parameters reqCode:1] execute];
    }

}

-(void) onDone:(int)statusCode andData:(NSData *)data andReqCode:(int)reqCode{
    
    if(data!=nil){
        
        

    
    switch (reqCode) {
        case 1://REQUEST_SIGNIN:
            [[NSOperationQueue mainQueue] addOperationWithBlock:^
             {
                 [self hideLoadingView];
                 
                 [self performSegueWithIdentifier:@"newReviewSegue" sender:nil];
                 
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
