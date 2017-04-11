//
//  FCLogin.m
//  Anymed
//
//  Created by 周鑫 on 15/6/4.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import "FCLogin.h"
#import "AMDBHelper.h"

static AMMGesUserInfo* currentUserInfo = nil;
static FCLogin* sharedFCLogin = nil;

@implementation FCLogin

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (instancetype)sharedFCLogin
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedFCLogin = [[FCLogin alloc] init];
    });
    
    return sharedFCLogin;
}

+ (BOOL) isLogin {
    if (currentUserInfo) {
        return NO;
    }
    return YES;
}

+ (void) doLogin:(AMMGesUserInfo *)loginData success:(void(^)(AMMGesUserInfo *model))successBlock failure:(void(^)())failureBlock {
    
    if (loginData) {
        [FCLogin sharedFCLogin].didSignIn    = YES;
        [FCLogin sharedFCLogin].token        = loginData.token;
        [FCLogin sharedFCLogin].signingKey   = loginData.signingKey;
        [FCLogin sharedFCLogin].userId       = loginData.userId;
        [FCLogin sharedFCLogin].patientId    = loginData.patientId;
        [AMDBHelper replaceUserInfo:loginData];
        successBlock(loginData);
    } else {
        AMMGesUserInfo *userInfo = [AMDBHelper getCurrentUserInfo];
        if(userInfo) {
            [FCLogin sharedFCLogin].didSignIn    = YES;
            [FCLogin sharedFCLogin].token        = userInfo.token;
            [FCLogin sharedFCLogin].signingKey   = userInfo.signingKey;
            [FCLogin sharedFCLogin].userId       = userInfo.userId;
            [FCLogin sharedFCLogin].patientId    = userInfo.patientId;
        } else {
            [FCLogin sharedFCLogin].didSignIn    = NO;
        }
        successBlock(userInfo);
    }
    
    
}

+ (void) doLogout:(void(^)(AMMGesUserInfo *model))successBlock {
    
    [AMDBHelper deleteUserInfo];
    [FCLogin sharedFCLogin].didSignIn    = NO;
    [FCLogin sharedFCLogin].token        = @"";
    [FCLogin sharedFCLogin].signingKey   = @"";

}

+ (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    
}

@end
