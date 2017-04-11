//
//  NSString+AES256.m
//  NioxNetworkApi
//
//  Created by 周鑫 on 16/3/3.
//  Copyright © 2016年 HZTeam. All rights reserved.
//

#import "NSString+AES256.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (AES256)

-(NSString *) aes256Encrypt:(NSString *)key
{
    if (![key isKindOfClass:[NSString class]] || self.length == 0) {
        return @"";
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [data aes256Encrypt:key];
    
    if (result && result.length > 0) {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return @"";
}

-(NSString *) aes256Decrypt:(NSString *)key
{
    if (![key isKindOfClass:[NSString class]] || self.length == 0) {
        return @"";
    }
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    NSData* result = [data aes256Decrypt:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return @"";
}

@end
