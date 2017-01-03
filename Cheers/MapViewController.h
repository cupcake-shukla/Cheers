//
//  MapViewController.h
//  Cheers
//
//  Created by macOS on 10/12/16.
//  Copyright © 2016 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;




@interface MapViewController : UIViewController<GMSMapViewDelegate>
@property (nonatomic,retain) UIView *actionOverlayCalloutView;

@property (weak, nonatomic) IBOutlet UIView *viewList;
@property (weak, nonatomic) IBOutlet UIView *vmapViewOutlet;

@end
