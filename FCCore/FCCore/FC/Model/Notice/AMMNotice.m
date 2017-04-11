//
//  AMMNotice.m
//  Anymed
//
//  Created by 周鑫 on 3/26/15.
//  Copyright (c) 2015 HZTeam. All rights reserved.
//

#import "AMMNotice.h"

@implementation AMMNotice

- (NSString*)dateToNSString:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd hh/mm/ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}


- (id)init {
    self = [super init];
    if (self != nil) {
       //self.date = [self dateToNSString:[NSDate date]];
    }
    return self;
}


@end
