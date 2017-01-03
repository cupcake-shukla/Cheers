//
//  FREEWEEKViewController.m
//  Cheers
//
//  Created by Abhishek on 12/26/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "FREEWEEKViewController.h"
#include <Social/Social.h>

#import <MessageUI/MessageUI.h>
@interface FREEWEEKViewController ()
- (IBAction)btCloseAction:(id)sender;
- (IBAction)btTextAction:(id)sender;

- (IBAction)btFBAction:(id)sender;
- (IBAction)btEmailAction:(id)sender;
- (IBAction)btShareAction:(id)sender;
- (IBAction)btOtherAction:(id)sender;

- (IBAction)btSubmitActionDialogSec:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tfVenueName;
@property (weak, nonatomic) IBOutlet UITextField *tfAmountName;
@property (weak, nonatomic) IBOutlet UITextField *tfSecondAmount;


@end

@implementation FREEWEEKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tfVenueName setBackgroundColor:[UIColor whiteColor]];
    [self.tfVenueName.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.tfVenueName.layer setBorderWidth:1.0];
    self.tfVenueName.layer.cornerRadius=10;
    
    [self.tfAmountName setBackgroundColor:[UIColor whiteColor]];
    [self.tfAmountName.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.tfAmountName.layer setBorderWidth:1.0];
    self.tfAmountName.layer.cornerRadius=10;
    
    [self.tfSecondAmount setBackgroundColor:[UIColor whiteColor]];
    [self.tfSecondAmount.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.tfSecondAmount.layer setBorderWidth:1.0];
    self.tfSecondAmount.layer.cornerRadius=10;

    // Do any additional setup after loading the view.
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

- (IBAction)btCloseAction:(id)sender {
}

- (IBAction)btTextAction:(id)sender {
    
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setSubject:@"Contact/Feedback"];
        [mailCont setToRecipients:[NSArray arrayWithObject:@"Support@cheersapp.com.au"]];
        [mailCont setMessageBody:@"" isHTML:NO];
        
        [self presentModalViewController:mailCont animated:YES];
        
    }
    else{
        
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please configure the mail." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        //            [Support showAlert:];
    }

}

- (IBAction)btFBAction:(id)sender {
   
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"First post from my iPhone app"];
        [controller addURL:[NSURL URLWithString:@"http://www.appcoda.com"]];
        [controller addImage:[UIImage imageNamed:@"socialsharing-facebook-image.jpg"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }

}

- (IBAction)btEmailAction:(id)sender {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setSubject:@"Contact/Feedback"];
        [mailCont setToRecipients:[NSArray arrayWithObject:@"Support@cheersapp.com.au"]];
        [mailCont setMessageBody:@"" isHTML:NO];
        
        [self presentModalViewController:mailCont animated:YES];
        
    }
    else{
        
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please configure the mail." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        //            [Support showAlert:];
    }

}

- (IBAction)btShareAction:(id)sender {
    
}

- (IBAction)btOtherAction:(id)sender {
    
    
    NSString *description = @"Let's have a drink| Check out the CHEERS App and get a free drink a day for only $9.99/month! Enjoy your first month for only $1 by using this link https://bnc.it/2HAK/GchpGAjApx";
    NSArray *activityItems = @[description];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [activityVC setValue:@"Cheers" forKey:@"subject"];
    
    
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityVC];
        [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4-100, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }

}

- (IBAction)btSubmitActionDialogSec:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
