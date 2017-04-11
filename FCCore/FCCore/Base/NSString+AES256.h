//
//  NSString+AES256.h
//  FCNetworkApi
//
//  Created by 周鑫 on 16/3/3.
//  Copyright © 2016年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+AES256.h"

@interface NSString (AES256)

-(NSString *) aes256Encrypt:(NSString *)key;
-(NSString *) aes256Decrypt:(NSString *)key;

@end
