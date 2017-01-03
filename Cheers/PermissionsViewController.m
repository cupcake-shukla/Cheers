//
//  PermissionsViewController.m
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import "PermissionsViewController.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>

@interface PermissionsViewController (){
    BOOL isLocation;
    BOOL isNotifications;
    BOOL isContacts;
}


@property CLLocationManager* locationManager;
@end

@implementation PermissionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isLocation = false;
    isNotifications = false;
    isContacts = false;
    
    self.continueOutlet.userInteractionEnabled = false;
//    self.allowContactOutlet.userInteractionEnabled = false;
//    self.notificationOutlet.userInteractionEnabled = false;
    
    
    // Do any additional setup after loading the view.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)allowUserLocationAction:(id)sender {
    
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
    isLocation =  true;
}

- (IBAction)notifcationAction:(id)sender {
    if(isLocation){
        isNotifications= true;
    }else{
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Allow Location Access" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
    }

}
- (IBAction)ContactsAction:(id)sender {
   
    
    if(isNotifications){
        isContacts= true;
        self.continueOutlet.userInteractionEnabled = true;

        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"permissions"];
    }else{
        
        // Request authorization to Address Book
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    // First time access has been granted, add the contact
                   // [self addContactToAddressBook];
                } else {
                    // User denied access
                    // Display an alert telling user the contact could not be added
                }
            });
        }
        else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
            // The user has previously given access, add the contact
            //[self _addContactToAddressBook];
        }
        else {
            [[[UIAlertView alloc] initWithTitle:@"" message:@"Change your privacy settings" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }

        
    }
    
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
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
       
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude] forKey:@"longitude"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude] forKey:@"latitude"];
     
         
         NSLog(@" longitude = %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        NSLog(@"latitude  = %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        
        
        
        
//        longitudeLabel.text = ;
//        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
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
