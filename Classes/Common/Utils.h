//
//  Utils.h
//  vipertest
//
//  Created by Kamlesh Mallick on 21/12/14.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    QnA = 1,
    Rating,
    Poll,
    Event
} HuddleType;

@interface Utils : NSObject
{
    
    
    
}

+ (NSString *)relativeDateStringForDate:(NSDate *)date;

+ (NSString *) getHuddleTypeToNumberString:(HuddleType)huddleKind;

+ (HuddleType) getHuddleStringToHuddleType:(NSString *)huddleString;

+ (NSString *) getPhoneWithoutCCode: (NSString *) strCCode phoneNumber: (NSString *) strPhoneNumber;

+ (NSString *) getPhoneWithCCode: (NSString *) strCCode phoneNumber: (NSString *) strPhoneNumber;

+ (NSString *)getTrimmedString: (NSString *)inputString;

+(UIFont *)getAppFont;
+(UIFont *)getAppBoldFont;

+(UIFont *)getiPadAppFont;
+(UIFont *)getiPadAppBoldFont;

@end