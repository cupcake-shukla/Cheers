//
//  SideBarViewController.m
//  Cheers
//
//  Created by macOS on 05/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "SideBarViewController.h"
#import "SideBarFirstTableViewCell.h"
#import "SideBarSecondTableViewCell.h"
#import "LoginViewController.h"
#import <objc/runtime.h>

#import <MessageUI/MessageUI.h>
@interface SideBarViewController () <MFMailComposeViewControllerDelegate>
{
    NSArray *tableData;
    NSArray *sideBarImages;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.backgroundColor = [UIColor clearColor];
//    //    self.tableView.opaque = NO;
//    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];

    
//    tableData = [NSArray arrayWithObjects:@"VIEW ACCOUNT", @"RATE US", @"PLANS & BILL", @"EARN FREE MONTHS", @"TUTORIAL", @"FAQ", @"TERMS & CONDITIONS", @"CONTACT US", @"FREE DAYS", @"LOGOUT",nil];
    
    
        tableData = [NSArray arrayWithObjects: @"VIEW ACCOUNT", @"PLANS & BILL", @"EARN FREE MONTHS", @"RATE US",@"DRINK HISTORY" , @"FAQ", @"TERMS & CONDITIONS", @"TUTORIAL", @"CONTACT US", @"FREE DAYS", @"FAVORITIES",@"LOGOUT",nil];
    
    
    sideBarImages = [NSArray arrayWithObjects:@"viewaccount.png",@"plansandbills.png",@"earnfreemonths.png",@"hollowstar.png",@"logout.png",@"faq.png",@"termsandconditions.png",@"tutorial.png",@"contactus.png",@"earnfreemonths.png",@"like.png",@"logout.png",nil];
    
//    sideBarImages = [NSArray arrayWithObjects:@"viewaccount.png",@"hollowstar.png",@"plansandbills.png",@"earnfreemonths.png",@"tutorial.png",@"faq.png",@"termsandconditions.png",@"contactus.png",@"earnfreemonths.png",@"logout.png",nil];
    
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row != 0){
        static NSString *simpleTableIdentifier = @"SideBarSecondTableViewCell";
        
        SideBarSecondTableViewCell *cell = (SideBarSecondTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SideBarSecondTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.lbSidebar.text=[tableData objectAtIndex:indexPath.row];
            cell.ivSidebar.image=[UIImage imageNamed:[sideBarImages objectAtIndex:indexPath.row]];
        }
        return cell;
    }else{
        
        static NSString *simpleTableIdentifier = @"SideBarFirstTableViewCell";
        
        SideBarFirstTableViewCell *cell = (SideBarFirstTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SideBarFirstTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.ivUserImage.layer.cornerRadius=10;
            cell.ivUserImage.clipsToBounds=YES;
            
            
            NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:@"uImageUrl"];
            
           
            
            
            cell.ivUserImage.amendURL = [NSURL URLWithString:url];

//            cell.ivUserImage.image=[UIImage imageNamed:@"profile.png"];
            
            cell.lbUserName.text= [[NSUserDefaults standardUserDefaults] objectForKey:@"uname"];
            NSString *srff=[[NSUserDefaults standardUserDefaults] objectForKey:@"uname"];
            cell.lbOpenAccount.text=@"View Accounts ";
        }
        
        return cell;
        
        //        cell.lbUserName.text = [tableData objectAtIndex:indexPath.row];
        //        cell.lbOpenAccount.text = [tableData objectAtIndex:indexPath.row];
        //        cell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0){
        return 44;
    }else{
        return 200;
    }
    
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row == 3){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Please Rate Us on the App Store"
                                                                preferredStyle:UIAlertControllerStyleAlert]; // 1
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Rate us"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                  NSLog(@"You pressed button one");
                                                                  NSURL *url = [ [ NSURL alloc ] initWithString: @"http://www.cnn.com" ];
                                                                  
                                                                  [[UIApplication sharedApplication] openURL:url];
                                                              }]; // 2
        
        
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Remind me later"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                   NSLog(@"You pressed button two");
                                                               }]; // 3
        
        
        UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"Not thanks"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                   NSLog(@"You pressed button two");
                                                               }]; // 3
        
      
        
        [alert addAction:firstAction]; // 4
        [alert addAction:secondAction]; // 5
        [alert addAction:thirdAction]; // 5
        
        [self presentViewController:alert animated:YES completion:nil];
    }else if(indexPath.row == 1){
        [self performSegueWithIdentifier:@"choosePlan" sender:nil];
    }else if(indexPath.row == 2){
        [self performSegueWithIdentifier:@"MessageSubmit" sender:nil];
    }
    
    else if(indexPath.row == 7){
        [self performSegueWithIdentifier:@"TutorialSegue" sender:nil];
    }

    if(indexPath.row == 11){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uid"];
     [self performSegueWithIdentifier:@"MenuTOLogin" sender:nil];
        
        
    }else if(indexPath.row == 5){
        [self performSegueWithIdentifier:@"FAQ_sViewSegue" sender:nil];
        
    }else if(indexPath.row == 10){
        [self performSegueWithIdentifier:@"favSegue" sender:nil];
        
    }else if(indexPath.row == 4){
        [self performSegueWithIdentifier:@"DrinkHistory" sender:nil];
        
    }
    
    else if(indexPath.row == 6){
        
        [self performSegueWithIdentifier:@"termsNConditionSegue" sender:nil];
        
    } else if(indexPath.row == 8){
        
        
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

        
//        [self performSegueWithIdentifier:@"contactSegue" sender:nil];
        
    }
    else if(indexPath.row == 9){
        [self performSegueWithIdentifier:@"FreeweelSegue" sender:nil];
        
    }

}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
