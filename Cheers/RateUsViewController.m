//
//  RateUsViewController.m
//  Cheers
//
//  Created by Abhishek on 12/20/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "RateUsViewController.h"
#import <MRProgress.h>

@interface RateUsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *wvRateUs;

@end

@implementation RateUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlText = @"http://www.imdb.com/title/tt0083399/";
    
    [self.wvRateUs loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlText]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self showLoadingMode];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hideLoadingView];
}

-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}
@end
