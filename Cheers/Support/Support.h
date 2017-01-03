//
//  Support.h
//  State Election Commission
//
//  Created by admin on 28/06/16.
//  Copyright © 2016 TACT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import "UIView+Toast.h"
//#import <Google/Analytics.h>
@interface Support : NSObject

+(NSString *)getUTCFormateDate;
+(NSString *)getTimeAgo:(NSString*)date;
+(UIColor*)colorWithHexString:(NSString*)hex;
+ (NSString *)flattenHTML:(NSString *)html;
+(NSString *)getImageUrl:(NSString *)imgUrl;
+(void) showAlert:(NSString *)msg;
+(void) showAlertWithDelegate:(id)delegate Msg:(NSString *)msg Tag:(int)tag PositiveButton:(NSString *)pButton NegativeButton:(NSString *)nButton;
+(BOOL) isValidEmail:(NSString *)checkString;
+(NSString *) trim:(NSString *)myString;
+(NSString *) md5:(NSString *) input;
+(void) showErrorFromResult:(NSData *) data;
+ (void)resetDefaults;
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;
+(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;
+(NSUInteger)wordCount:(NSString *) string;
@end
