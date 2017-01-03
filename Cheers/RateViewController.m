//
//  RateViewController.m
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "RateViewController.h"
#import "UIView+Toast.h"


@interface RateViewController ()

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)viewDidAppear:(BOOL)animated{
 
    [self showAlert];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showAlert{

    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Dont care what goes here, since we're about to change below" message:@"\nWe're so happy to hear that you love Calm! It would be really helpful if you rated us. Thanks so much for bringing more Calm into your life." preferredStyle:UIAlertControllerStyleAlert];
   
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"Thank You"];
    
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont boldSystemFontOfSize:24.0]
                  range:NSMakeRange(0, 9)
     ];
    
   
    
    [alertVC setValue:hogan forKey:@"attributedTitle"];
    
    
    NSMutableAttributedString *rate = [[NSMutableAttributedString alloc] initWithString:@"Rate Cheers"];
    
    [rate addAttribute:NSFontAttributeName
                  value:[UIFont boldSystemFontOfSize:24.0]
                  range:NSMakeRange(0, 9)
     ];

        UIAlertAction *RateCalmAction = [UIAlertAction actionWithTitle:@"Rate Cheers"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                  [self performSegueWithIdentifier:@"thankyoutodashboard" sender:nil];
                                                              }];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //[alertVC setValue:hogan forKey:@"attributedTitle"];

    
        UIAlertAction *remindMeLaterAction = [UIAlertAction actionWithTitle:@"Remind Me Later"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                  [self performSegueWithIdentifier:@"thankyoutodashboard" sender:nil];
                                                               }];
    
        UIAlertAction *noThanksAction = [UIAlertAction actionWithTitle:@"No Thanks"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                   [self performSegueWithIdentifier:@"thankyoutodashboard" sender:nil];                                                               }]; // 3
//    UIImage *accessoryImage = [UIImage imageNamed:@"hollowstar.png"];
//    [RateCalmAction setValue:accessoryImage forKey:@"image"];
     [alertVC addAction:RateCalmAction];
    [alertVC addAction:remindMeLaterAction];

    [alertVC addAction:noThanksAction];

    [self presentViewController:alertVC animated:YES completion:nil];
}
@end
