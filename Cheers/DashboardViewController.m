//
//  DashboardViewController.m
//  Cheers
//
//  Created by macOS on 05/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "DashboardViewController.h"
#import "SWRevealViewController.h"

@interface DashboardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timer;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MZTimerLabel *timerr = [[MZTimerLabel alloc] initWithLabel:self.timer andTimerType:MZTimerLabelTypeTimer];
    [timerr setCountDownTime:518400];
    timerr.timeFormat = @"dd HH:mm:ss";
    
    timerr.delegate = self;
    
    
    [timerr start];

    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarbutton setTarget: self.revealViewController];
        [self.sidebarbutton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    //time is up, what should I do master?
}
- (IBAction)btLogoutAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uid"];
    [self performSegueWithIdentifier:@"dashboardToLogin" sender:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
