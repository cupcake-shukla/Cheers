//
//  DrinkHistoryViewController.m
//  Cheers
//
//  Created by Abhishek on 12/30/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "DrinkHistoryViewController.h"
#import "Reachability.h"
#import "Support.h"
#import "AccessApi.h"
#import "MRProgress.h"
#import "DrinkHistoryTableViewCell.h"
@interface DrinkHistoryViewController ()
{
    NSMutableArray *object;
    
}
@end

@implementation DrinkHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDrinkHistoryFromServer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getDrinkHistoryFromServer{
    
    [self showLoadingMode];
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"uid": [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]
                           
                            }
                    };
    
//
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        
    {
        [Support showAlert:@"Please Check Your Internet Connection"];
        
    }else{
        [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"%@redeemUser",BASE_URL] parameters:parameters reqCode:1] execute];
    }
}
-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}
-(void) onDone:(int)statusCode andData:(NSData *)data andReqCode:(int)reqCode{
    
    if(data!=nil){
        
        

    //    switch (reqCode) {
    if(reqCode == 1){ //1://REQUEST_SIGNIN:
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             
             object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             [self hideLoadingView];
             [self.tableView reloadData];
             
         }];
    }
    }else{
        [self hideLoadingView];
        [Support showAlert:@"please check your internet connection"];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return object.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"DrinkHistoryTableViewCell";
    static NSString *simpleTable = @"DrinkHistoryTableViewCell";
    
    
        DrinkHistoryTableViewCell *cell = (DrinkHistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTable];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DrinkHistoryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    
    
    
    cell.VenueOutlet.text = object[indexPath.row][@"Venue"];
    cell.RedemptionDateOutlet.text =  [NSString stringWithFormat:@"%@",object[indexPath.row][@"RedemptionDate"]];
    cell.PriceOutlet.text= [NSString stringWithFormat:@"$%@",object[indexPath.row][@"Price"]];
    cell.DrinkNameOutlet.text=object[indexPath.row][@"DrinkName"];
    
    return cell;
        

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
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
