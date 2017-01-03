//
//  Support.m
//  MavenfyPad
//
//  Created by trend on 29/04/16.
//  Copyright © 2016 hyades apps. All rights reserved.
//

#import "Support.h"



@implementation Support



+(NSString *)getUTCFormateDate{
    NSDate* datetime = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local time zone.
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SS"];
    NSString* dateTimeInIsoFormatForZuluTimeZone = [dateFormatter stringFromDate:datetime];
    return dateTimeInIsoFormatForZuluTimeZone;
}

+(NSString *) getCurrentDate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local time zone.
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
    
}

+(NSString *) getTime:(NSString *) date{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *currentDate = [dateFormater dateFromString:date];
    
    
    dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"hh:mm a"];
    return [dateFormater stringFromDate:currentDate];
    
}

+(NSString *) convertDateFormate:(NSString *) date1{
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if(date1.length>19){
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SS"];
    }
    else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    }
    
    NSDate *date = [dateFormatter dateFromString:date1];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    return [dateFormatter stringFromDate:date];
    
}


+(NSString *)getTimeAgo:(NSString*)date{
    NSDate * today = [NSDate date];
    NSLog(@"today: %@", today);
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local
    
    if(date.length>19){
        [dateFormater setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SS"];
    }
    else{
        [dateFormater setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    }
    //    [dateFormater setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SS"];
    NSDate *past = [dateFormater dateFromString:date];
    
    
    dateFormater=[[NSDateFormatter alloc] init];
    
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    NSDateComponents *t = [gregorian components:unitFlags
                                       fromDate:past
                                         toDate:today
                                        options:0];
    NSString* timeAgo;
    if ([t year]){
        timeAgo = [NSString  stringWithFormat:@"%ld years ago", (long)[t year]];
    }
    else if ([t month]){
        timeAgo = [NSString stringWithFormat:@"%ld months ago", [t month]];
    }
    else if ([t day]) {
        timeAgo = [self convertDateFormate:date];// [NSString stringWithFormat:@"%ld days ago", [t day]];
        
    }
    else if ([t hour]) {
        timeAgo = [NSString stringWithFormat:@"few hrs ago"];
    }
    else if ([t minute]) {
        timeAgo = [NSString stringWithFormat:@"%ld mins ago", [t minute]];
    }
    else if ([t second]) {
        timeAgo = [NSString stringWithFormat:@"few sec ago"];
    }
    return timeAgo;
}

+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6 && [cString length] != 8) return  [UIColor grayColor];
    
    if([cString length]==6){
        
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:1.0f];
    }else{
        NSRange range;
        range.location = 0;
        range.length = 2;
        
        NSString *aString = [cString substringWithRange:range];
        
        range.location = 2;
        NSString *rString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 6;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b, a;
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:((float) a / 255.0f)];
        
    }
}




+ (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    html = [self trim:html];
    
    return html;
}

+(NSString *)getImageUrl:(NSString *)imgUrl{
    //    NSString* baseImgUrl=@"http://endpoint896075.azureedge.net/mavenfypad/";
    
    NSString* baseImgUrl=@"http://endpoint918103.azureedge.net/mavenfypad/";
    
    return [NSString stringWithFormat:@"%@%@",baseImgUrl, imgUrl];
    
}

+(void) showAlert:(NSString *)msg{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alertView show];
     }];
}

+(void) showAlertWithDelegate:(id)delegate Msg:(NSString *)msg Tag:(int)tag PositiveButton:(NSString *)pButton NegativeButton:(NSString *)nButton{
    
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"" message:msg delegate:delegate cancelButtonTitle:nButton otherButtonTitles:pButton, nil];
    alertView.tag=tag;
    [alertView show];
    
}

+(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(NSString *) trim:(NSString *)myString{
    NSString *trimmedString = [myString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

+(NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr,(int) strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+(void) showErrorFromResult:(NSData *) data{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         @try{
             NSMutableDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             if ([object objectForKey:@"Message" ] !=[NSNull null]) {
                 [Support showAlert:object[@"Message"]];
             }else{
                 [Support showAlert:@"Please check internet"];
             }
         }@catch(NSException *ex){
             [Support showAlert:@"Please check internet"];
         }
     }];
}

+ (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}


+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
    CGSize actSize = image.size;
    float scale = actSize.width/actSize.height;
    
    if (scale < 1) {
        newSize.height = newSize.width/scale;
    } else {
        newSize.width = newSize.height*scale;
    }
    
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

+(NSUInteger)wordCount:(NSString *) string {
    __block NSUInteger wordCount = 0;
    [string enumerateSubstringsInRange:NSMakeRange(0, string.length)
                               options:NSStringEnumerationByWords
                            usingBlock:^(NSString *character, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                wordCount++;
                            }];
    return wordCount;
}



@end
