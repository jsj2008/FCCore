//
//  NetworkConfigure.m
//
//  Created by 周鑫 on 2016/11/8.
//  Copyright © 2016年 DC. All rights reserved.
//

#import "NetworkConfigure.h"

@implementation NetworkConfigure

static NetworkConfigure * networkConfigure = nil;

+ (NetworkConfigure *)shareConfigure
{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        networkConfigure = [[NetworkConfigure alloc] init];
        
    });
    return networkConfigure;
}

@end
