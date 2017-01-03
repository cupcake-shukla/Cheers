//
//  MapViewController.m
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AccessAPI/AccessApi.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MRProgress.h"
#import "Reachability.h"
#import "Support.h"

@interface MapViewController ()<CLLocationManagerDelegate>{
    
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    int REQUEST_GETPLACES;
    BOOL   isResponseNil;
    GMSMapView *mapView;
    NSMutableArray *objectOfMarker;
    NSString *latitude;
    NSString *longitude;
    NSMutableArray *images;
    NSString *url;
    
    BOOL hitAPI;
    
}
@property CLLocationManager* locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    url=@"http://cheersapp.com.au/cp/";
    images=[[NSMutableArray alloc]init];
    REQUEST_GETPLACES=1;
    isResponseNil=TRUE;
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:26.8467
                                                            longitude:80.9462
                                                                 zoom:16];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.vmapViewOutlet = mapView;
  
    
//    [self.view addSubview:_viewList];
    GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    
    marker.position = CLLocationCoordinate2DMake(26.8467 , 80.9462);
    
    marker.title = @"The King Tailor";
    marker.snippet = @"Australia";
    marker.map = mapView;
    
        [self CurrentLocationIdentifier];
    hitAPI = false;
   // [self showLoadingMode];
    [self CurrentLocationIdentifier];
    [self viewVenuesService];
//    [self.view addSubview:_viewList];
    
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
    
    
    if(!hitAPI){
        
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude] forKey:@"longitude"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude] forKey:@"latitude"];
        
        
        latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        
        
        
             [self showLoadingMode];
            [self viewVenuesService];
            
            // Do any additional setup after loading the view.
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currentLocation.coordinate.latitude
                                                                    longitude:currentLocation.coordinate.longitude
                                                                         zoom:16];
            GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
            mapView.myLocationEnabled = YES;
            self.vmapViewOutlet = mapView;
//            [self.view addSubview:_viewList];
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
            marker.title = @"The King Tailor";
            //    marker.snippet = @"Australia";
            marker.map = mapView;
            
            hitAPI= true;
        
        NSLog(@" longitude = %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        NSLog(@"latitude  = %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        
    }
        
        }
}

-(void)viewVenuesService{
    NSString *uid;
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"uid"]){
        uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    }
    NSDictionary *parameters;
    parameters = @{ @"userid": @"AD2WE",
                    @"secret": @"QG58JH12",
                    @"udata" : @{
                            @"uid": uid ,
                            @"lat": @"" ,
                            @"long": @""
                            }
                    };
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        
    {
        [Support showAlert:@"Please Check Your Internet Connection"];

    }else{
    [[[AccessApi alloc] initWithDelegate:self url:[NSString stringWithFormat:@"http://cheersapp.com.au/services/clients.php/venueimg/viewVenues"] parameters:parameters reqCode:REQUEST_GETPLACES] execute];
   
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onDone:(int)statusCode andData:(NSData *)data andReqCode:(int)reqCode{
    
    
    
    if (data == nil)
    {
        [self hideLoadingView];
        [Support showAlert:@"please check your internet connection"];
        
    }else
    {
        switch (reqCode) {
            case 1://REQUEST_SIGNIN:
                [[NSOperationQueue mainQueue] addOperationWithBlock:^
                 {
                     
                     objectOfMarker = [[NSMutableArray alloc] init];
                     
                     objectOfMarker = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                     NSLog(@"Data is s%@",objectOfMarker);
                     for(int i=0;i<[objectOfMarker count];i++){
                         
                         NSString *urlString = [NSString stringWithFormat:@"http://ritusha.in/manage/services/venueimg/%@",objectOfMarker[i][@"ImageUrl1"]];
                         NSURL *weburl = [NSURL URLWithString:urlString];
                         NSData* data = [NSData dataWithContentsOfURL:weburl];
                     UIImage *image = [UIImage imageWithData:data];
                         [images addObject:image];
                     }
                     //                     [self.tableView reloadData];
                     hitAPI =true;
                     [self setMarkers];
                     [self hideLoadingView];
                     
                     
                 }];
        }
    }
    
    
}

-(void)setMarkers{
    
    //    NSMutableArray *latitude=[[NSMutableArray alloc] init];
    //    NSMutableArray *longitude;
    //    NSMutableArray *placesName;
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[latitude doubleValue]
                                                            longitude:[longitude doubleValue]
                                                                 zoom:6];
    // GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = mapView;
    
    
    for(int i=0;i<[objectOfMarker count];i++){
        
        //        // Do any additional setup after loading the view.
        //              GMSMarker *marker = [[GMSMarker alloc] init];
        //        marker.position = CLLocationCoordinate2DMake([objectOfMarker[i][@"Latitude"] doubleValue], [objectOfMarker[i][@"Longitude"] doubleValue]);
        //        marker.title = objectOfMarker[i][@"Name"];
        //        //    marker.snippet = @"Australia";
        //        marker.map = mapView;
        
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([objectOfMarker[i][@"Latitude"] doubleValue], [objectOfMarker[i][@"Longitude"] doubleValue]);
        bounds = [bounds includingCoordinate:marker.position];
        marker.title = objectOfMarker[i][@"Name"];
        
        marker.map = mapView;
        UIImage *mask = [self makeRoundedImage:[images objectAtIndex:i] radius:150];
        
        
        UIImage *image = [UIImage imageNamed:@"marker.png"];
        
        marker.icon=[self drawImage:mask inImage:image atPoint:CGPointMake(0, 0)];
        
        
    }
    [mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
    
    
    [self.view addSubview:_viewList];
    
}
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    
}
-(UIImage*) drawImage:(UIImage*) fgImage
              inImage:(UIImage*) bgImage
              atPoint:(CGPoint)  point
{
    UIGraphicsBeginImageContextWithOptions(bgImage.size, FALSE, 0.0);
    [bgImage drawInRect:CGRectMake( 0, 0, bgImage.size.width, bgImage.size.height)];
    [fgImage drawInRect:CGRectMake( (bgImage.size.width/2 - bgImage.size.width/3)-5, point.y +10, bgImage.size.width-15, bgImage.size.height-50)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)showLoadingMode{
    [MRProgressOverlayView showOverlayAddedTo:mapView animated:YES];
}
-(void)hideLoadingView{
    [MRProgressOverlayView dismissOverlayForView:mapView animated:YES];
    
}



-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}
//- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
//{
//    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    // customView.backgroundColor = [UIColor blueColor];
//
//
//
//    UIImageView *imageView = [[UIImageView alloc] init];
//
//    imageView.frame = customView.bounds;
//
//    //  imageView.image = [UIImage imageNamed:@"abc.png"];
//
//    //[customView addSubview:imageView];
//
//    for(int i=0;i<[notificationDictionary[@"results"] count];i++){
//        if([marker.title isEqualToString:notificationDictionary[@"results"][i][@"name"] ]){
//
//
//            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=50&photoreference=%@&key=AIzaSyDYZ5A0xwF97xwAh49jh4F_gaJZXBzhUvY",notificationDictionary[@"results"][i][@"photos"][0][@"photo_reference"]]]];
//
//
//            // WARNING: is the cell still using the same data by this point??
//            imageView.image=[UIImage imageWithData: data];
//            //  imageView.backgroundColor = [UIColor redColor];
//
//
//            [customView addSubview:imageView];
//            //                                [self.view addSubview:customView];
//            
//            
//        }
//    }
//    
//    return customView;
//}





@end
