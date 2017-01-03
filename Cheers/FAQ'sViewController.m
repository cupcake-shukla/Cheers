//
//  FAQ'sViewController.m
//  Cheers
//
//  Created by Abhishek on 12/18/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "FAQ'sViewController.h"
#import <MRProgress.h>

@interface FAQ_sViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *FaqWebView;

@end

@implementation FAQ_sViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlText = @"https://www.cheersapp.com.au/support/";
    [self.FaqWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlText]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self showLoadingMode];
    NSLog(@"start");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideLoadingView];
    NSLog(@"finish");
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error for WEBVIEW: %@", [error description]);
    [self hideLoadingView];
}

-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}
@end
