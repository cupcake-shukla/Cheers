//
//  ChoosePlanViewController.m
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "ChoosePlanViewController.h"
#import "ChoosePlanTableViewCell.h"
#import "ChoosePlanSecondTableViewCell.h"
#import "AccessApi.h"

#import "MRProgress.h"
#import "Reachability.h"
#import "Support.h"
#import "UIView+Toast.h"

@interface ChoosePlanViewController (){
    
    NSArray *title;
    NSArray *Content;
    NSArray *price;
    int tableCount;
    
    NSMutableArray *serverObject;
    
}
- (IBAction)btSkipAction:(id)sender;

@end

@implementation ChoosePlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableCount= 0;
    
    title=[[NSArray alloc] init];
    Content=[[NSArray alloc] init];
    
    self.vBillDetailsOutlet.hidden  =true;
    
    title = [NSArray arrayWithObjects:@"Cheer Monthly",
     @"Cheer Annual", nil];
    
    Content = [NSArray arrayWithObjects:@"Cheer Monthly",
             @"Cheer Annual", nil];
    
    price = [NSArray arrayWithObjects:@"$8.33",
               @"$9.99", nil];

    [self getPlansAndBillsFromAPI];
    
    
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getPlansAndBillsFromAPI{
    [self showLoadingMode];
   
    
    
    NSString *uid;
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"uid"]){
        uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    }
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"uid": uid
                            }
                    };
    
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable){
        
        [Support showAlert:@"Please Check Your Internet Connection"];

    }else{
    [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"%@Packages",BASE_URL] parameters:parameters reqCode:1] execute];

    }
}
-(void) onDone:(int)statusCode andData:(NSData *)data andReqCode:(int)reqCode{
    
    if(data!=nil){
        
        

    //    switch (reqCode) {
    if(reqCode == 1){ //1://REQUEST_SIGNIN:
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             
             serverObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             NSLog(@"Data is s%@",serverObject);
             [self hideLoadingView];
             
             tableCount = serverObject.count;
             [self.tableView reloadData];
             
         }];
    }
    }else{
        [self hideLoadingView];
        [Support showAlert:@"please check your interent connection"];
    }
}
- (IBAction)btHideBillDetailsAction:(id)sender {
    
    self.vBillDetailsOutlet.hidden  =true;

}
-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 + tableCount;
}


-(void)btViewBillingDetailsAction:(id)sender{
    
    self.vBillDetailsOutlet.hidden  =false;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    static NSString *simpleTable = @"SimpleTable";

    
    
    if(indexPath.row > tableCount-1){
        ChoosePlanSecondTableViewCell *cell = (ChoosePlanSecondTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTable];
        
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Chooseplansecond" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        
        cell.tfInviteCode.layer.cornerRadius=10;
        
        [cell.btViewBillingDetails addTarget:self action:@selector(btViewBillingDetailsAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        

        return cell;
        
    }else{
        
        ChoosePlanTableViewCell *cell = (ChoosePlanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChoosePlanTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        
        cell.lbtitle.text = serverObject[indexPath.row][@"PackageName"];
        cell.lbContent.text = serverObject[indexPath.row][@"Description"];
        [cell.btPrice setTitle:[NSString stringWithFormat:@"%@",serverObject[indexPath.row][@"Amount"]] forState:UIControlStateNormal];
        
        return cell;
    }
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row > tableCount-1){
        
        return 243;
    }else{
       
        return 88;

    }
}

- (IBAction)btSkipAction:(id)sender {
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Sure you want to skip?\n Subscribe to enjoy 30 drinks for the price of one cocktail!"
                                  message:@""
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"SKIP FOR NOW"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self performSegueWithIdentifier:@"skiptodashboard" sender:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"SUBSCRIBE"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.view makeToast:@"Coming Soon"];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
