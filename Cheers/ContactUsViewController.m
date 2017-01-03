//
//  ContactUsViewController.m
//  Cheers
//
//  Created by Abhishek on 12/18/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "ContactUsViewController.h"
#import <MRProgress.h>

@interface ContactUsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *contactWebView;

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlText = @"http://www.imdb.com/title/tt0083399/";

    [self.contactWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlText]]];
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
