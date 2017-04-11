//
//  NSData+AES256.h
//  FCNetworkApi
//
//  Created by 周鑫 on 16/3/3.
//  Copyright © 2016年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

-(NSData *) aes256Encrypt:(NSString *)key;
-(NSData *) aes256Decrypt:(NSString *)key;

@end
