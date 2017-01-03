//
//  SearchBarViewController.m
//  Cheers
//
//  Created by Abhishek on 12/26/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "SearchBarViewController.h"
#import "VenueListTableViewCell.h"
#import <MRProgress.h>
#import "AccessApi.h"
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"
#import "Support.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface SearchBarViewController (){
    
    NSArray *tableData;
    NSArray *searchResults;
    
    NSArray * title;
    NSMutableArray *object;
    NSMutableArray *serverObject;
    NSMutableArray *favObject;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    UIView *addButtonView;
    NSString *latitude;
    NSString *longitude;
    NSString *searchStringValue;
    
    BOOL ishitAPI;
    
    
    
    
    BOOL isFav;
    int index;
}

@property CLLocationManager* locationManager;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    
    object =[[NSMutableArray alloc] init];
    ishitAPI = true;
    [self CurrentLocationIdentifier];
    
}


-(void)CurrentLocationIdentifier{
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];
    
    
}




#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if(ishitAPI){
        
        NSLog(@"didUpdateToLocation: %@", newLocation);
        CLLocation *currentLocation = newLocation;
        
        if (currentLocation != nil) {
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude] forKey:@"longitude"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude] forKey:@"latitude"];
            
            
            latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
            longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];

            ishitAPI = false;
            
            NSLog(@" longitude = %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
            NSLog(@"latitude  = %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        }
    }
}


-(void)SignUpuserService{
    [self showLoadingMode];
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"uid": [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],
                            @"vname": searchStringValue
                            }
                    };
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        
    {
        [Support showAlert:@"Please Check Your Internet Connection"];

        
    }else{
    [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"%@viewVenues",BASE_URL] parameters:parameters reqCode:1] execute];
    }
}

-(void) onDone:(int)statusCode andData:(NSData *)data andReqCode:(int)reqCode{
    
    if(data!=nil){
        
        

    //    switch (reqCode) {
    if(reqCode == 1){ //1://REQUEST_SIGNIN:
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             
             searchResults = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             NSLog(@"Data is s%@",searchResults);
            
             
             object = [[NSMutableArray alloc]initWithArray:searchResults copyItems:YES];
             
              [self.searchDisplayController setActive:NO animated:YES];
             [self hideLoadingView];
         
             
             [self.tableView reloadData];
             
         }];
    }
    }else{
        [self hideLoadingView];
        [Support showAlert:@"please check your internet connection"];
    }
    
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [tableData filteredArrayUsingPredicate:resultPredicate];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    NSLog(@"%@",searchStringValue);
    [self SignUpuserService];
    [searchBar resignFirstResponder];
    // Do the search...
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    
   
    searchStringValue = searchString;
    
    return YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    NSLog(@"%d",object.count);
    return [object count];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  246;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    static NSString *simpleTable = @"SimpleTable";
    
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
    
        VenueListTableViewCell *cell = (VenueListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTable];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VenueListTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        NSString *url = [NSString stringWithFormat:@"http://ritusha.in/manage/services/venueimg/%@",object[indexPath.row][@"ImageUrl1"]];
        
    
    
    cell.ivBannerImageOutlet.amendURL =   [NSURL URLWithString:url];
        
        
        CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
        
        CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[object[indexPath.row][@"Latitude"] doubleValue] longitude:[object[indexPath.row][@"Longitude"] doubleValue]];
        CLLocationDistance distance = [startLocation distanceFromLocation:endLocation]; // aka double
        
        cell.lbDistanceOutlet.text = [NSString stringWithFormat:@"%.2f Miles",(0.621371 * distance)];
        cell.lbReviewListOutlet.text = [NSString stringWithFormat:@"0 Review"];
        
        cell.lbplaceNameOutlet.text = [NSString stringWithFormat:@"%@ , %@",object[indexPath.row][@"Name"],object[indexPath.row][@"Address"]];
        
        
        
        [cell.btLikedOutlet addTarget:self action:@selector(btLikedOutletAction:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *IsFavorite =  [NSString stringWithFormat:@"%@",object[indexPath.row][@"IsFavorite"]];
        if([IsFavorite isEqualToString:@"<null>"] || [IsFavorite isEqualToString:@"0"] ){
            
            cell.btLikedOutlet.tag = indexPath.row;
            UIImage *btnImage = [UIImage imageNamed:@"like.png"];
            [cell.btLikedOutlet setImage:btnImage forState:UIControlStateNormal];
            
        }else{
            cell.btLikedOutlet.tag = indexPath.row * 1000 ;
            UIImage *btnImage = [UIImage imageNamed:@"liked.png"];
            [cell.btLikedOutlet setImage:btnImage forState:UIControlStateNormal];
        }
        
        [cell.btLikedOutlet setTitle:[NSString stringWithFormat:@"%d",object[indexPath.row][@"Id"]] forState:UIControlStateNormal];
        
        NSString *ratingValue = [NSString stringWithFormat:@"%@",object[indexPath.row][@"Rating"]];
        
        if([ratingValue isEqualToString:@"<null>"] || [ratingValue isEqualToString:@"0"] ){
            cell.vStarViewOutlet.value =  0;
        }else{
            cell.vStarViewOutlet.value = [object[indexPath.row][@"Rating"] doubleValue];
        }
        cell.vStarViewOutlet.tintColor= [UIColor yellowColor];
    
        return cell;
    }
//    return nil;
//    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}
    
@end
