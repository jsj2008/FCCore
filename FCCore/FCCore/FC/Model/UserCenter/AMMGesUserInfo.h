//
//  AMMGesUserInfo.h
//  Anymed
//
//  Created by 周鑫 on 5/8/15.
//  Copyright (c) 2015 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMMGesUserInfo : NSObject


@property (nonatomic,copy) NSString *userId;
//账号密码，无请传@""
@property (nonatomic,copy) NSString *password;
//手势密码，无请传@""，有按照点的顺序给@"3245"类似顺序串
@property (nonatomic,copy) NSString *gespassword;
//是否设置了手势密码，1为已设置，0为未设置
@property (nonatomic,copy) NSString *gesopened;
//是否显示了轨迹，1为显示，0为不显示轨迹
@property (nonatomic,copy) NSString *gestrackopened;

@property (nonatomic,copy) NSString *token;

@property (nonatomic,copy) NSString *patientId;

@property (nonatomic,copy) NSString *signingKey;

@property (nonatomic,copy) NSString *currentUser;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *phoneNo;

@property (nonatomic,copy) NSString *patientHead;//患者头像 add by zhuenkai v3.7

@property (nonatomic,copy) NSString *merchantNo;

@property (nonatomic,assign) int gender;

@end
