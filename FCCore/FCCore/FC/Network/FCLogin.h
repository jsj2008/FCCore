//
//  FCLogin.h
//  Anymed
//
//  Created by 周鑫 on 15/6/4.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMMGesUserInfo.h"

@interface FCLogin : NSObject

@property (nonatomic,assign) BOOL didSignIn;

@property (nonatomic,copy) NSString *token;

@property (nonatomic,copy) NSString *signingKey;

@property (nonatomic,copy) NSString *userId;

@property (nonatomic,copy) NSString *patientId;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *phoneNo;

@property (nonatomic,copy) NSString *merchantNo;


+ (instancetype)sharedFCLogin;
+ (BOOL) isLogin;
+ (void) doLogin:(AMMGesUserInfo *)loginData success:(void(^)(AMMGesUserInfo *model))successBlock failure:(void(^)())failureBloc;
+ (void) doLogout:(void(^)(AMMGesUserInfo *model))successBlock;

@end
