//
// CountryListManager.m
//
// Copyright (c) 2014. All rights reserved.
//

#import "CountryListManager.h"


@implementation CountryListManager

- (NSArray *) getCountryList
{
    NSArray *ccList = [[NSMutableArray alloc] init];
    
    NSString *countriesPath = [[NSBundle mainBundle] pathForResource:@"countries"
                                                              ofType:@"plist"];
    
    NSDictionary *countryDict;
    countryDict = [NSDictionary dictionaryWithContentsOfFile:countriesPath];
    ccList = [[countryDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    if (!countryDict || !ccList)
    {
        NSLog(@"Countries could not be loaded");
        return nil;
    }
    
    return ccList;
}

- (NSDictionary *) getCountryData
{
    NSString *countriesPath = [[NSBundle mainBundle] pathForResource:@"countries"
                                                              ofType:@"plist"];
    
    NSDictionary *countryDict;
    countryDict = [NSDictionary dictionaryWithContentsOfFile:countriesPath];
    
    return countryDict;
}


@end
