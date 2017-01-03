//
//  VenueDetailsViewController.m
//  Cheers
//
//  Created by Greyloft on 12/13/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "VenueDetailsViewController.h"
#import "VenueDetailsImageViewCell.h"
#import "VenueDetailsTitleLabelViewCell.h"
#import "VenueDetailsDescriptionViewCell.h"
#import "VenueDetailsRedeemableViewCell.h"
#import "AccessApi.h"
#import "MRProgress.h"
#import "Reachability.h"
#import "Support.h"
@interface VenueDetailsViewController ()
{
    NSMutableArray *serverObject;
    
}
@end

@implementation VenueDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.vDrinkDetailsOutlet.hidden = true;
    NSLog(@"venueDetails  : %@",self.venueDetails);
    
    [self showLoadingMode];
    [self getDrinksFromAPI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 + (serverObject.count/2);
}
- (IBAction)hideDrinkDetails:(id)sender {
    
    self.vDrinkDetailsOutlet.hidden = true;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    
    if(indexPath.row ==0){
        NSString *simpleTable = @"VenueDetailsImageViewCell";
        
        VenueDetailsImageViewCell *cell = (VenueDetailsImageViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTable];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VenueDetailsImageViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        NSString *url = [NSString stringWithFormat:@"http://ritusha.in/manage/services/venueimg/%@",self.venueDetails[@"ImageUrl1"]];
        cell.ivBannerImageOutlet.amendURL =  [NSURL URLWithString:url];
        cell.userInteractionEnabled = false;
        return cell;
        
    }else  if(indexPath.row == 1 ){
        NSString *simpleTable = @"VenueDetailsTitleLabelViewCell";
        
        VenueDetailsTitleLabelViewCell *cell = (VenueDetailsTitleLabelViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTable];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VenueDetailsTitleLabelViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        cell.lbTitle.text = self.venueDetails[@"Name"];
        cell.lbAddress.text = self.venueDetails[@"Address"];
        cell.LbredeemTime.text = @"Mon 12 - 3 PM";
        cell.lbOpeingHours.text = self.venueDetails[@"OpenTimings"];
        
        [cell.btviewOnMapOutlet addTarget:self action:@selector(getDirectionViaMap:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btGetDirectionOutlet addTarget:self action:@selector(getDirectionViaMap:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    
    else  if(indexPath.row == 2 ){
        NSString *simpleTable = @"VenueDetailsDescriptionViewCell";
        
        VenueDetailsDescriptionViewCell *cell = (VenueDetailsDescriptionViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTable];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VenueDetailsDescriptionViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        cell.lbTitle.text = @"Venue Description";
        cell.lbDescription.text = self.venueDetails[@"Description"];
        
        
        cell.userInteractionEnabled = false;
        
        
        //        cell.userInteractionEnabled = false;
        
        return cell;
        
    }
    
    else {
        NSString *simpleTable = @"VenueDetailsRedeemableViewCell";
        
        VenueDetailsRedeemableViewCell *cell = (VenueDetailsRedeemableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTable];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VenueDetailsRedeemableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
        NSString *url = [NSString stringWithFormat:@"http://ritusha.in/manage/services/venueimg/%@",serverObject[0][@"Images"]];
        
        
        cell.ivDrinkOne.amendURL = [NSURL URLWithString:url];
        cell.ivDrinNameone.text = serverObject[0][@"DrinkName"];
        url = [NSString stringWithFormat:@"http://ritusha.in/manage/services/venueimg/%@",serverObject[1][@"Images"]];
        cell.ivDrinkTwo.amendURL = [NSURL URLWithString:url];
        
        cell.ivDrinNameTwo.text = serverObject[1][@"DrinkName"];
        
        
        cell.drink1.tag =  [serverObject[0][@"Id"] intValue];
        cell.drink2.tag =  [serverObject[1][@"Id"] intValue];
        
        [cell.drink1 addTarget:self action:@selector(redeemDrink1Action:) forControlEvents:UIControlEventTouchUpInside];
        [cell.drink2 addTarget:self action:@selector(redeemDrink1Action:) forControlEvents:UIControlEventTouchUpInside];
        //        [cell.redeemDrinkOutlet addTarget:self action:@selector(redeemDrinkAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
        
    }
    return nil;
}

-(void)getDrinksFromAPI{
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"vid": self.venueDetails[@"Id"]
                            }
                    };
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        
    {
        [Support showAlert:@"Please Check Your Internet Connection"];

        
    }else{
    [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"%@venueDrinks",BASE_URL] parameters:parameters reqCode:1] execute];
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
             [self.tableView reloadData];
             
         }];
    }}else{
        [self hideLoadingView];
        [Support showAlert:@"please check your internet connection"];
    }
}
-(void)getDirectionViaMap:(id)sender{
    [self performSegueWithIdentifier:@"DetailToMap" sender:nil];
    
}


-(void)redeemDrink1Action:(id)sender{
    
    int drinkId = [sender tag];
//    [self showLoadingMode];
    [self redeemDrinkServcie:drinkId];
    
    
}

-(void)redeemDrinkServcie :(int)DrinkId{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.venueDetails[@"Id"] forKey:@"vid"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",DrinkId]forKey:@"did"];
    
    
    
    for (int i=0; i< [serverObject count] ; i++) {
        
        if([serverObject[i][@"Id"] intValue] == DrinkId)
        {
            [[NSUserDefaults standardUserDefaults] setObject:serverObject[i][@"DrinkName"] forKey:@"dName"];
            [[NSUserDefaults standardUserDefaults] setObject:serverObject[i][@"Images"] forKey:@"dImage"];
           
            NSString *url = [NSString stringWithFormat:@"http://ritusha.in/manage/services/venueimg/%@",serverObject[i][@"Images"]];
            self.vDrinkImageOutlet.amendURL = [NSURL URLWithString:url];
            
            self.vDrinkName.text = serverObject[i][@"DrinkName"];
            break;
        }
    }
 
    
    
    
      self.vDrinkDetailsOutlet.hidden = false;
//    [self performSegueWithIdentifier:@"DrinkRedeemded" sender:nil];
    
//
    
}
- (IBAction)openDrinkRedeemView:(id)sender {
    [self performSegueWithIdentifier:@"DrinkRedeemded" sender:nil];
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 203;
    }else if(indexPath.row == 1){
        
        return 219;
    }else if(indexPath.row == 2){
        
        return 226;
    }else if(indexPath.row == 3){
        
        return 99;
    }
    return 0;
}

-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}
@end
