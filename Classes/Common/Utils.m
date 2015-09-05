//
//  Utils.m
//  vipertest
//
//  Created by Kamlesh Mallick on 21/12/14.
//
//

#import "Utils.h"
#import "UserSessionInfo.h"

@implementation Utils


+ (NSString *)relativeDateStringForDate:(NSDate *)date
{
    NSCalendarUnit units = NSDayCalendarUnit | NSWeekOfYearCalendarUnit |
    NSMonthCalendarUnit | NSYearCalendarUnit;
    
    // if `date` is before "now" (i.e. in the past) then the components will be positive
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:date
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.year > 0) {
        return [NSString stringWithFormat:@"%ld years ago", (long)components.year];
    } else if (components.month > 0) {
        return [NSString stringWithFormat:@"%ld months ago", (long)components.month];
    } else if (components.weekOfYear > 0) {
        return [NSString stringWithFormat:@"%ld weeks ago", (long)components.weekOfYear];
    } else if (components.day > 0) {
        if (components.day > 1) {
            return [NSString stringWithFormat:@"%ld days ago", (long)components.day];
        } else {
            return @"Yesterday";
        }
    } else {
        return @"Today";
    }
}

+ (NSString *) getHuddleTypeToNumberString:(HuddleType)huddleKind;
{
    NSString *result = nil;
    
    switch(huddleKind) {
        case QnA:
        result = @"1";
        break;
        case Rating:
        result = @"2";
        break;
        case Poll:
        result = @"3";
        break;
        case Event:
        result = @"4";
        break;
        default:
          result = @"1";
    }
    
    return result;
}


+ (HuddleType) getHuddleStringToHuddleType:(NSString *)huddleString
{
    HuddleType result;
    
    if ([huddleString isEqualToString:@"1"])
    {
        result = QnA;
    }
    else if ([huddleString isEqualToString:@"2"])
    {
        result = Rating;
    }
    else if ([huddleString isEqualToString:@"3"])
    {
        result = Poll;
    }
    else if ([huddleString isEqualToString:@"4"])
    {
        result = Event;
    }
    else
    {
        result = QnA;
    }

    return result;

}


/********************************************************************************************************
 This function returns the phone, prefixed with the CC code
 
 Input 
 strCCode - Country Code selected by user (This can have '+' sign, Example : +91, +39 etc)
            If this is empty - We will need to assume that the CCCode is already present in the number
 strPhoneNumber - Phone number - This can contain 
                    a) '+' sign,  
                    b) countrycode already appended 
                    c) '0' appended  (STD)
                    d) intenrational dialout prefix 00 or 011 appended
 ********************************************************************************************************/
+ (NSString *) getPhoneWithCCode: (NSString *) strCCode phoneNumber: (NSString *) strPhoneNumber
{
    NSString *strPhoneWithCCode = @"";
    UserSessionInfo *userSession = [UserSessionInfo sharedUser];
    
    bool fNumberStartsWithPlus = NO;
    
    if([strPhoneNumber hasPrefix:@"+"])
    {
        fNumberStartsWithPlus = YES;
    }
    
    //Remove the '+' symbol from Country Code
    strCCode = [strCCode stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    //Remove the '+' symbol from Phone number
    strPhoneNumber = [strPhoneNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    //Get Country Code length
    unsigned long strCCLength = strCCode.length;
    
    //If phone number starts with intenrational dialout prefix 00 or 011 then strip them
    NSString* output = nil;
    if([strPhoneNumber hasPrefix:@"00"])
        output = [strPhoneNumber substringFromIndex:2];
    
    if (output != nil)
    {
        strPhoneNumber = output;
        output = nil;
    }
    
    if([strPhoneNumber hasPrefix:@"011"])
        output = [strPhoneNumber substringFromIndex:3];

    if (output != nil)
    {
        strPhoneNumber = output;
        output = nil;
    }
    
    //If phone number starts with STD dialout prefix 0 then strip it
    if([strPhoneNumber hasPrefix:@"0"])
        output = [strPhoneNumber substringFromIndex:1];
    
    if (output != nil)
    {
        strPhoneNumber = output;
        output = nil;        
    }
    
    bool fAppendCountryCode = YES;
    
    if (strCCLength == 0)
    {
        //We need to determine the CC Code if (the number does not have a '+')
        if (fNumberStartsWithPlus == NO)
        {
            //If number doesnot start with + or international prefix, then prefix registered CC
            
            strCCode = userSession.userCountryCode;
            
            fAppendCountryCode = YES;
        }
        else
        {
            fAppendCountryCode = NO;
        }
    }
    else if (strPhoneNumber.length >= strCCLength)
    {
        //We need to determine the CC Code if (the number does not have a '+')
        if (fNumberStartsWithPlus == NO)
        {
            //Get the first 'strCCLength' digits from phone number
        
            NSString *strOutput;
            strOutput=[strPhoneNumber substringToIndex:strCCLength];
            
            if ([[strOutput lowercaseString] isEqualToString:strCCode])
            {
                //If first few digits of the phone nymber matches with the country code - then we dont have to append the CC code
                fAppendCountryCode = NO;
            }
        }
        else
        {
            fAppendCountryCode = NO;
        }
    }
    
    if (fAppendCountryCode)
    {
        //Finally append the CC code with the Phone number
        strPhoneWithCCode = [strCCode stringByAppendingString:strPhoneNumber];
    }
    else
    {
        strPhoneWithCCode = strPhoneNumber;
    }
    
    return strPhoneWithCCode;
}


/********************************************************************************************************
 This function returns the phone, without the CC code
 
 Input
 strCCode - Country Code selected by user (This can have '+' sign, Example : +91, +39 etc)
 ********************************************************************************************************/
+ (NSString *) getPhoneWithoutCCode: (NSString *) strCCode phoneNumber: (NSString *) strPhoneNumber
{
    NSString *strPhoneWithoutCCode = @"";
    
    //Remove the '+' symbol from Country Code
    strCCode = [strCCode stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    //Get Country Code length
    unsigned long strCCLength = strCCode.length;
    
    strPhoneWithoutCCode = [strPhoneNumber substringFromIndex:strCCLength];
    
    return strPhoneWithoutCCode;
}


+ (NSString *)getTrimmedString: (NSString *)inputString
{
    NSString* outputString = inputString;
    outputString = [outputString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return outputString;
}


#pragma mark -
#pragma mark Return the font for the application

+(UIFont *)getAppFont{
    return [UIFont fontWithName:@"HelveticaNeue" size:15.0];
}

+(UIFont *)getAppBoldFont{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
}

+(UIFont *)getiPadAppFont{
    return [UIFont fontWithName:@"HelveticaNeue" size:20.0];
}

+(UIFont *)getiPadAppBoldFont{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
}

@end
