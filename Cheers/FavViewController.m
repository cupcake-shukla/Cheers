//
//  VenueListViewController.m
//  Cheers
//
//  Created by macOS on 11/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//
#import "FavViewController.h"
#import "VenueListViewController.h"
#import "VenueListTableViewCell.h"
#import "HeaderListViewTableViewCell.h"
#import "AccessApi.h"
#import "HCSStarRatingView.h"
#import <CoreLocation/CoreLocation.h>
#import "VenueDetailsViewController.h"
#import "MRProgress.h"
#import "SWRevealViewController.h"
#import "Support.h"
#import "MapViewController.h"
#import "Reachability.h"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface FavViewController (){
    
    NSArray * title;
    NSMutableArray *object;
    NSMutableArray *serverObject;
    NSMutableArray *favObject;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    UIView *addButtonView;
    NSString *latitude;
    NSString *longitude;
    
    BOOL ishitAPI;
    
    
    BOOL isFav;
    int index;
    
}

@property CLLocationManager* locationManager;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    favObject = [[NSMutableArray alloc] init];
    
    isFav= true;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
//        [self.sideBarButton setTarget: self.revealViewController];
//        [self.sideBarButton setAction: @selector( revealToggle: )];
        
        //        [self.sideBarButton2 setTarget: self.revealViewController];
        //        [self.sideBarButton2 setAction: @selector( revealToggle: )];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //    title = [NSArray arrayWithObjects:@"Cheer Monthly",
    //             @"Cheer Annual",@"Cheer Annual", nil];
    
    object =[[NSMutableArray alloc] init];
    ishitAPI = true;
    // Do any additional setup after loading the view.
    addButtonView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-65, self.view.frame.size.height-65, 50, 50)];
    [self.view addSubview:addButtonView];
    [addButtonView setBackgroundColor:[Support colorWithHexString:@"345678"]];
    [Support setRoundedView:addButtonView toDiameter:50.0];
    
    UIButton *addArticle = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addArticle addTarget:self action:@selector(addNewNotes:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *ivAdd = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
    [ivAdd setImage:[UIImage imageNamed:@"mapMarker.png"]];
    [addArticle addSubview:ivAdd];
    [addButtonView addSubview:addArticle];
    
    [self CurrentLocationIdentifier];
    
    
    //    self.navigationItem.leftBarButtonItem.isEnabled = false;
    //    sideBarButton2
    
}

-(IBAction)addNewNotes:(id)sender
{
    
    
    
    [self performSegueWithIdentifier:@"mapSegue" sender:nil];
    
    //    MapViewController  *map = [[MapViewController alloc] init];
    //
    //   // editor.initialTitle = [NSString stringWithFormat:@"Unnamed %d", count];
    //    [self presentViewController:map animated:YES completion:nil];
    
    
    
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
            
            [self showLoadingMode];
            [self SignUpuserService];
            ishitAPI = false;
            
            NSLog(@" longitude = %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
            NSLog(@"latitude  = %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        }
    }
}


-(void)SignUpuserService{
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"uid": [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],
                            @"lat": latitude ,
                            @"long": longitude
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
             
             serverObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             NSLog(@"Data is s%@",serverObject);
             [self hideLoadingView];
             
             for (int i=0; i<serverObject.count; i++) {
                 NSString *IsFavorite =  [NSString stringWithFormat:@"%@",serverObject[i][@"IsFavorite"]];
                 if([IsFavorite isEqualToString:@"<null>"] || [IsFavorite isEqualToString:@"0"] ){
                     
                     
                 }else{
                     
                     [favObject addObject:serverObject[i]];
                 }
             }
             
             
             object = [[NSMutableArray alloc]initWithArray:favObject copyItems:YES];
             
             
             [self.tableView reloadData];
             
         }];
    }
    
    else if(reqCode == 2){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             NSLog(@"Data is s%@",object);
             [self SignUpuserService];
             
         }];
    }
    }else{
        [self hideLoadingView];
        [Support showAlert:@"please check your interent connection"];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (object.count + 1);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    static NSString *simpleTable = @"SimpleTable";
    
    
   
    if(indexPath.row !=0){
        VenueListTableViewCell *cell = (VenueListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTable];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VenueListTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        NSString *url = [NSString stringWithFormat:@"http://ritusha.in/manage/services/venueimg/%@",object[indexPath.row-1][@"ImageUrl1"]];
        
        cell.ivBannerImageOutlet.amendURL =   [NSURL URLWithString:url];
        
        
        CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
        
        CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[object[indexPath.row-1][@"Latitude"] doubleValue] longitude:[object[indexPath.row-1][@"Longitude"] doubleValue]];
        CLLocationDistance distance = [startLocation distanceFromLocation:endLocation]; // aka double
        
        cell.lbDistanceOutlet.text = [NSString stringWithFormat:@"%.2f Miles",(0.621371 * distance)];
        cell.lbReviewListOutlet.text = [NSString stringWithFormat:@"0 Review"];
        
        cell.lbplaceNameOutlet.text = [NSString stringWithFormat:@"%@ , %@",object[indexPath.row-1][@"Name"],object[indexPath.row-1][@"Address"]];
        
        
        
        [cell.btLikedOutlet addTarget:self action:@selector(btLikedOutletAction:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *IsFavorite =  [NSString stringWithFormat:@"%@",object[indexPath.row-1][@"IsFavorite"]];
        if([IsFavorite isEqualToString:@"<null>"] || [IsFavorite isEqualToString:@"0"] ){
            
            cell.btLikedOutlet.tag = indexPath.row;
            UIImage *btnImage = [UIImage imageNamed:@"like.png"];
            [cell.btLikedOutlet setImage:btnImage forState:UIControlStateNormal];
            
        }else{
            cell.btLikedOutlet.tag = indexPath.row * 1000 ;
            UIImage *btnImage = [UIImage imageNamed:@"liked.png"];
            [cell.btLikedOutlet setImage:btnImage forState:UIControlStateNormal];
        }
        
        [cell.btLikedOutlet setTitle:[NSString stringWithFormat:@"%d",object[indexPath.row-1][@"Id"]] forState:UIControlStateNormal];
        
        NSString *ratingValue = [NSString stringWithFormat:@"%@",object[indexPath.row-1][@"Rating"]];
        
        if([ratingValue isEqualToString:@"<null>"] || [ratingValue isEqualToString:@"0"] ){
            cell.vStarViewOutlet.value =  0;
        }else{
            cell.vStarViewOutlet.value = [object[indexPath.row-1][@"Rating"] doubleValue];
        }
        cell.vStarViewOutlet.tintColor= [UIColor yellowColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
        
    }else{
        
        HeaderListViewTableViewCell *cell = (HeaderListViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HeaderListViewTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        cell.lbNameOutlet.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"uname"];
        
        
        return cell;
    }
    
}

-(void)btLikedOutletAction:(id)sender{
    int likedIndex = [sender tag];
    int isfavourite;
    
    if(likedIndex == 0 ||  likedIndex >= 1000){
        likedIndex = likedIndex / 1000;
        isfavourite = 1;
    }else{
        isfavourite = 0;
        
    }
    
    
    NSLog(@"%@",[[sender titleLabel] text]);
    
    [self showLoadingMode];
    
    
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"uid": [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],
                            @"vid": [[sender titleLabel] text] ,
                            @"isfavourite": [NSString stringWithFormat:@"%d",isfavourite]
                            }
                    };
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        
    {
        [Support showAlert:@"Please Check Your Internet Connection"];

        
    }else{
    [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"%@favOnOff",BASE_URL] parameters:parameters reqCode:2] execute];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    index = indexPath.row;
//    [self performSegueWithIdentifier:@"venueToVenieDetails" sender:self];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"venueToVenieDetails"])
    {
        VenueDetailsViewController *venueDetailsViewController = [segue destinationViewController];
        venueDetailsViewController.venueDetails = object[index];
    }
}

- (IBAction)btLogoutAction:(id)sender {
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uid"];
    //    [self performSegueWithIdentifier:@"dashboardToLogin" sender:nil];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0){
        
        return 254;
    }else{
        
        return 94;
        
    }
}

-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    
}
- (IBAction)reloadTableWithFav:(id)sender {
    if(!isFav){
        isFav = true;
        
        object = [[NSMutableArray alloc]initWithArray:favObject copyItems:YES];
        
        [self.tableView reloadData];
        
    }else{
        object = [[NSMutableArray alloc]initWithArray:serverObject copyItems:YES];
        isFav = true;
        
        [self.tableView reloadData];
        
    }
    
}

@end
