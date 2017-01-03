
//
//  SplashViewController.m
//  Cheers
//
//  Created by Abhishek on 12/15/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:true];
    
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"uid"]){
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
        int idInt = [uid intValue];
        if(idInt >0){
            [self performSegueWithIdentifier:@"SplashToRevelview" sender:nil];
        }
    }else{
        [self performSegueWithIdentifier:@"splashToLoginViewController" sender:nil];
        
    }

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
