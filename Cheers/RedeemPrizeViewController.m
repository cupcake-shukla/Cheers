//
//  RedeemPrizeViewController.m
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "RedeemPrizeViewController.h"
#include <Social/Social.h>

@interface RedeemPrizeViewController ()

@end

@implementation RedeemPrizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.outsideView.layer.cornerRadius=20;
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

- (IBAction)btShareTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText:@"Let's have a drink| Check out the CHEERS App and get a free drink a day for only $9.99/month! Enjoy your first month for only $1 by using this link"];
        [tweetSheet addURL:[NSURL URLWithString:@"https://bnc.it/2HAK/GchpGAjApx"]];
        [tweetSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    [self performSegueWithIdentifier:@"thankyou" sender:nil];
                    break;
                    
                default:
                    break;
            }
        }];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (IBAction)btShareFacebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Let's have a drink| Check out the CHEERS App and get a free drink a day for only $9.99/month! Enjoy your first month for only $1 by using this link"];
        [controller addURL:[NSURL URLWithString:@"https://bnc.it/2HAK/GchpGAjApx"]];
        
        [controller setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    [self performSegueWithIdentifier:@"thankyou" sender:nil];
                    break;
                    
                default:
                    break;
            }
        }];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
}





- (void)shareButton
{

}
@end
