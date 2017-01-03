//
//  Terms&ConditionViewController.m
//  Cheers
//
//  Created by Abhishek on 12/18/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "PRIVACYPOLICYViewController.h"
#import <MRProgress.h>

@interface PRIVACYPOLICYViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *termsWebView;

@end

@implementation PRIVACYPOLICYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlText = @"https://www.cheersapp.com.au/privacy/";
    [self.termsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlText]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finish");
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error for WEBVIEW: %@", [error description]);
}
-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}

@end
