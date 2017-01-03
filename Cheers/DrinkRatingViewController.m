//
//  DrinkRatingViewController.m
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "DrinkRatingViewController.h"
#import "AccessApi.h"
#import "MRProgress.h"
#import "Reachability.h"
#import "Support.h"
@interface DrinkRatingViewController ()

@end

@implementation DrinkRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.barServiceRating.maximumValue = 5;
    self.barServiceRating.minimumValue = 0;
    self.barServiceRating.value = 0;
    self.barServiceRating.tintColor = [UIColor redColor];
    [self.barServiceRating addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    self.barServiceRating.emptyStarImage = [UIImage imageNamed:@"hollowratingstar.png"];
    self.barServiceRating.filledStarImage = [UIImage imageNamed:@"filledratingstar.png"];
    
    self.drinkRating.maximumValue = 5;
    self.drinkRating.minimumValue = 0;
    self.drinkRating.value = 0;
    self.drinkRating.tintColor = [UIColor redColor];
    [self.drinkRating addTarget:self action:@selector(didChange:) forControlEvents:UIControlEventValueChanged];
    
    self.drinkRating.emptyStarImage = [UIImage imageNamed:@"hollowratingstar.png"];
    self.drinkRating.filledStarImage = [UIImage imageNamed:@"filledratingstar.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SubmitRatingAction:(id)sender {
    
    int thebarService =   self.barServiceRating.value;
    int drinkRating =   self.drinkRating.value;
  
    int totalRating = (thebarService+drinkRating)/2;
    if(totalRating<0){
        totalRating= 0;
    }
    [self showLoadingMode];
    [self SignUpuserService:[NSString stringWithFormat:@"%d",totalRating]];
    
}
-(void)SignUpuserService:(NSString *)rating{
    
    NSString *uid;
    NSString *vid;
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"uid"]){
        uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
        vid = [[NSUserDefaults standardUserDefaults] objectForKey:@"vid"];
    }
    
    
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"uid": uid ,
                            @"vid": vid,
                            @"rating": rating,
                            @"comment": @"Comment Section"
                            }
                    };
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        
    {
        [Support showAlert:@"Please Check Your Internet Connection"];
   
    }else{
    [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"%@RatingComments",BASE_URL] parameters:parameters reqCode:1] execute];
    }
}

-(void) onDone:(int)statusCode andData:(NSData *)data andReqCode:(int)reqCode{
    
    if(data!=nil){
        
    switch (reqCode) {
        case 1://REQUEST_SIGNIN:
            [[NSOperationQueue mainQueue] addOperationWithBlock:^
             {
                 [self performSegueWithIdentifier:@"RatingDrinkToShare" sender:nil];
                 [self hideLoadingView];
                 
             }];
    }
    }else{
        [self hideLoadingView];
        [Support showAlert:@"please check your internet connection"];
    }
}


-(IBAction)didChangeValue:(id)sender{
    
    NSLog(@"sdvs");
}


-(IBAction)didChange:(id)sender{
 
    NSLog(@"sdvs");
}


-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}

- (IBAction)btSkipThis:(id)sender {
}
@end
