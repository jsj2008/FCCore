//
//  NSString+md5HexDigest.m
//  Anymed
//
//  Created by 周鑫 on 5/8/15.
//  Copyright (c) 2015 HZTeam. All rights reserved.
//

#import "NSString+md5HexDigest.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (md5HexDigest)

- (NSString *) md5HexDigest
{
    
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    
    return mdfiveString;
    
}

@end
