//
//  AMDBHelper.h
//  AnyMed
//
//  Created by 周鑫 on 3/23/15.
//  Copyright (c) 2015 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMMNotice.h"
#import "AMMGesUserInfo.h"
#import "AMMServiceCode.h"
#import "FCCoreHeader.h"

@interface AMDBHelper : NSObject

+ (AMDBHelper *)shareDBHelper;
+ (void)createTable;

+ (NSString *)getKey:(NSString *)key;
+ (void)replaceKey:(NSString *)key value:(NSString *)value;


//-----Notices-----//
+ (void)replaceNoticesWithArray:(NSArray *)array;
+ (void)replaceNotices:(AMMNotice *)notice;
+ (NSArray *)getNotices:(NSString *)userid;
+ (NSArray *)getNotices:(NSString *)userid category:(NSString *)category;
+ (void)modifyUnread:(NSString *)index;
+ (void)modifyUnreadByCategory:(NSString *)userid category:(NSString *)category;
+ (void)deleteNotices:(NSString *)userid category:(NSString *)category;
+ (void)deleteNotice:(NSString *)index;
+ (void)deleteNotices:(NSArray *)array;
//-----手势密码-----//
//添加,修改手势密码
+ (BOOL)replaceUserInfo:(AMMGesUserInfo *)gesUserInfo;
//获取手势密码
+ (AMMGesUserInfo *)getUserInfo:(NSString *)userid;
+ (AMMGesUserInfo *)getCurrentUserInfo;
+ (void)deleteUserInfo;

//-----医院服务码-----//
+ (BOOL)replaceHospsCode:(NSString *)hospId serviceCode:(NSString *)serviceCode;
+ (AMMServiceCode *)getHospsSerCode:(NSString *)hospId ;
+ (BOOL)replaceHospsCode:(NSMutableArray *)hospArray;
+(AMMServiceCode *)supportService:(long long)serviceCodeInt;

//更新就诊人列表
+ (void)replacePatientsWithArray:(NSArray *)array;
//获取就诊人列表
+ (NSArray *)getPatients:(NSString *)userid;

//更新医院列表
+ (void)replaceHospsWithArray:(NSArray *)array;
//获取缓存的医院
+ (NSMutableArray *)getHosps;

//更新医生列表
+ (void)replaceDocsWithArray:(NSArray *)array;
//获取医生列表
+ (NSArray *)getDocs;

@end
