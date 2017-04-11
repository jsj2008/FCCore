//
//  AMAAppSystemAPI.m
//  FCNetworkApi
//
//  Created by wangzeyu on 16/4/7.
//  Copyright © 2016年 HZTeam. All rights reserved.
//

#import "AMAAppSystemAPI.h"

@implementation AMAAppSystemAPI

+(void)getStartPicsReq:(int32_t)weight height:(int32_t)height prevPicVer:(NSString *)prevPicVer success:(void(^)(NXTFGetStartPicsResp *startPicsResp))successBlock failure:(void(^)(NSError *error))failureBlock{
    NXTFGetStartPicsReq *req = [[NXTFGetStartPicsReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    if (weight > 0 ) {
        [req setWeight:weight];
    }
    if (height > 0 ) {
        [req setHeight:height];
    }
    if (prevPicVer.length > 0 ) {
        [req setPrevPicVer:prevPicVer];
    }

    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getStartPics:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetStartPicsResp class]]) {
            NXTFGetStartPicsResp *startPicsResp = (NXTFGetStartPicsResp *)content;
            successBlock(startPicsResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

@end
