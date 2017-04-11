//
//  AMDBHelper.m
//  AnyMed
//
//  Created by 周鑫 on 3/23/15.
//  Copyright (c) 2015 HZTeam. All rights reserved.
//

#import "AMDBHelper.h"
#import "FMDatabaseQueue.h"
#import "FMDatabaseAdditions.h"
#import "NSString+SHA.h"
#import "NSString+AES256.h"
#import "FMDatabaseAdditions.h"

#define DB_DBNAME           @"noixdb"
#define DB_KEYFORAES        @"nioxjE4aChUc"

#define DB_BASETABLE        @"noixbasetable"
#define DB_VERSION          @"version"
#define DB_CITYNAME         @"cityName"
#define DB_HOSPID           @"hospId"
#define DB_CURRENTUSERID    @"currentuserId"
#define DB_CURRENTPID       @"currentPId"
#define DB_REMARK           @"remark"

#define DB_TABLECOMMONTABLE @"commontable"
#define DB_KEYWORD          @"commonkeyword"

#define DB_TABLECITIES      @"cities"
#define DB_PROVINCEID       @"provinceId"
#define DB_PROVINCE         @"province"
#define DB_CITYID           @"cityId"
#define DB_CITY             @"city"
#define DB_TIMESTAMP        @"timeStamp"
#define DB_CITYEN           @"cityEn"
#define DB_OPENED           @"opened"

#define DB_TABLEDEPTS       @"depts"

#define DB_HOSPNAME         @"hospName"
#define DB_DEPTNAME         @"deptName"
#define DB_DEPTID           @"deptId"
#define DB_ISHOT            @"isHot"
#define DB_NOTICE           @"notice"
#define DB_ENABLE           @"enable"


#define DB_TABLECOMDEPTS    @"comdepts"
#define DB_COMDEPTNAME      @"comDeptName"
#define DB_COMDEPTID        @"comDeptId"
#define DB_COMDEPTNOTICE    @"comDeptNotice"


#define DB_TABLENOTICE      @"notices"
#define DB_MSGID            @"msgId"
#define DB_TABLENOTICEM     @"noticesM"
#define DB_TYPE             @"type"
#define DB_USERID           @"userid"
#define DB_MSGBODY          @"msgBody"
#define DB_MSGDATE          @"msgDate"
#define DB_HOSPID           @"hospId"
#define DB_REGID            @"regId"
#define DB_PATIENTID        @"patientId"
#define DB_STATUS           @"status"
#define DB_ORDERID          @"orderId"
#define DB_ORDERTYPE        @"orderType"
#define DB_CATEGORY         @"category"
#define DB_SUBCATEGORY      @"subCategory"
#define DB_HOSPNAME         @"hospName"
#define DB_DEPT             @"dept"
#define DB_DOCNAME          @"docName"
#define DB_FEE              @"fee"
#define DB_MEDICALTIME      @"medicalTime"
#define DB_ITEMNOS          @"itemNos"
#define DB_TRADETIME        @"tradeTime"
#define DB_BEDNO            @"bedNo"
#define DB_BALANCE          @"balance"
#define DB_CHECKTIME        @"checkTime"
#define DB_REPORTID         @"reportId"
#define DB_REPORTNAME       @"reportName"
#define DB_REPORTTYPE       @"reportType"
#define DB_ANYMEDTITLE      @"anyMedTitle"
#define DB_ANYMEDSUMMAR     @"anyMedSummary"
#define DB_ANYMEDDATE       @"anyMedDate"
#define DB_ANYMEDPIC        @"anyMedPic"
#define DB_ANYMEDURL        @"anyMedUrl"
#define DB_DOCHEAD          @"docHead"
#define DB_INPATIENTRECORDID @"inpatientRecordId"
#define DB_ALERT            @"alert"
#define DB_DOCID            @"docId"
#define DB_UNREAD           @"unread"
#define DB_ICONURL          @"iconUrl"
#define DB_IMID             @"imId"
#define DB_REGDATE          @"regDate"

#define DB_TABLEUSERINFO    @"userinfo"
#define DB_PASSWORD         @"password"
#define DB_GESPASSWORD      @"gespassword"
#define DB_GESOPENED        @"gesopened"
#define DB_GESTRACKOPENED   @"gestrackopened"
#define DB_PHONENO          @"phoneno"
#define DB_CURRENTUSER      @"currentuser"
#define DB_GENDER           @"gender"
#define DB_TOKEN            @"userx"
#define DB_SIGNINGKEY       @"usery"
#define DB_ACTID            @"actId"
#define DB_TIMESHOW         @"timeShow"
#define DB_TITLE            @"title"
#define DB_STOPINSDESC      @"stopInsDesc"
#define DB_TIMID            @"tImId"
#define DB_ROOMID           @"roomId"
#define DB_USERNAME         @"userName"
#define DB_MARKNO           @"markNo"
#define DB_MEDGUIDE         @"medGuide"
#define DB_PRODUCTNAME      @"productName"
#define DB_ORDERNO          @"orderNo"
#define DB_FINISHTIME       @"finishTime"


#define DB_TABLEPATIENT     @"patient"
#define DB_HEADERIMG        @"headImg"
#define DB_NAME             @"name"
#define DB_GENDER           @"gender"
#define DB_POINTNAME        @"pointName"
#define DB_PAPERSNO         @"papersNo"
#define DB_PAPERTYPEID      @"papersTypeId"
#define DB_MEDINSUREANCE    @"medInsureance"
#define DB_STATURE          @"stature"
#define DB_WEIGHT           @"weight"
#define DB_BORNDATE         @"bornDate"
#define DB_ADDRESS          @"address"
#define DB_RELATIONID       @"relationId"
#define DB_BLOODTYPE        @"bloodType"
#define DB_ILLNESS          @"criticalIllness"
#define DB_ALLHISTORY       @"allergicHistory"
#define DB_FAMHISTORY       @"familyHistory"
#define DB_BLOODTYPE        @"bloodType"
#define DB_CARDNO           @"cardNo"
#define DB_INPATIENTNO      @"inpatientNo"
#define DB_CARDCOUNT        @"cardCount"
#define DB_INPATIENTCOUNT   @"inpatientCount"
#define DB_REASON           @"reason"
#define DB_NOTICE           @"notice"
#define DB_LOGISNO          @"logisNo"
#define DB_LOGISCOMPANY     @"logisCompany"
#define DB_LOGISSENDTIME    @"logisSendTime"

#define DB_TABLEHOS         @"hosptals"
#define DB_SERCODE          @"serviceCode"


#define DB_TABLEDOCS        @"docs"
#define DB_HOSPTYE          @"hospType"
#define DB_HOSPLEVEL        @"hospLevel"
#define DB_DEPTNAME         @"deptName"
#define DB_LEVELNAME        @"levelName"
#define DB_REMARK           @"remark"
#define DB_HEADIMG          @"headImg"
#define DB_DESC             @"desc"
#define DB_FLOWERS          @"flowers"
#define DB_TOTALVISITS      @"totalVisits"
#define DB_ISEXPERT         @"isExpert"
#define DB_ISREGISTED       @"isRegisted"
#define DB_EVALUAION        @"evaluation"
#define DB_ISCONSULTED      @"isConsulted"
#define DB_HOSPABBRNAME     @"hospAbbrName"


#define DB_TABLEHOSPS       @"hosps"
#define DB_HOSPID           @"hospId"
#define DB_NAME             @"name"
#define DB_PATIENTHEAD      @"patientHead"
#define DB_DESC             @"desc"
#define DB_REMARK           @"remark"
#define DB_HOSPLOGOURL      @"hospLogoUrl"
#define DB_IMAGEURL         @"imageUrl"
#define DB_HOSPTYE          @"hospType"
#define DB_HOSPLEVEL        @"hospLevel"
#define DB_PATINETCONUT     @"patientCount"
#define DB_DAILYVISITCOUNT  @"dailyVisitCount"
#define DB_ADDRESS          @"address"
#define DB_CONTACTNO        @"contactNo"
#define DB_DEPTS            @"depts"
#define DB_DEPTDTOS         @"deptDtos"
#define DB_ISSUPPORTREG     @"isSupportReg"
#define DB_ISOPENED         @"isOpened"
#define DB_SERCODE          @"serviceCode"
#define DB_ISINSURASSIGNED  @"isInsurAssigned"
#define DB_LNG              @"lng"
#define DB_LAT              @"lat"
#define DB_DISTANCE         @"distance"
#define DB_ABBRNAME         @"abbrName"
#define DB_MERCHANTNO       @"merchantNo"


@implementation AMDBHelper

+ (NSString*)getAppCachePath
{
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return cacheFolder;
}

+ (NSString*)getDBPath
{
    NSString* folder = [self getAppCachePath];
    return [folder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",DB_DBNAME]] ;
}

static AMDBHelper * shareDBHelper = nil;

+ (AMDBHelper *)shareDBHelper
{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareDBHelper = [[AMDBHelper alloc] init];
        
    });
    return shareDBHelper;
}

+ (id) allocWithZone:(NSZone *)zone {
    @synchronized (self) {
        if (shareDBHelper == nil) {
            shareDBHelper = [super allocWithZone:zone];
            return shareDBHelper;
        }
    }
    return nil;
}

+ (void)createTable
{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *createcommoneSql = [NSString stringWithFormat:
                                      @"CREATE TABLE IF NOT EXISTS %@ (%@ text, %@ text, PRIMARY KEY(%@))",
                                      DB_TABLECOMMONTABLE,DB_KEYWORD,DB_TIMESTAMP,DB_KEYWORD];
        [db executeUpdate:createcommoneSql, nil];
        
        NSString *createNoticesMSql = [NSString stringWithFormat:
                                     @"CREATE TABLE IF NOT EXISTS %@ (%@ text,%@ text,%@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text, id INTEGER PRIMARY KEY AUTOINCREMENT)",
                                     DB_TABLENOTICEM,DB_MSGID,DB_TYPE,DB_USERID,DB_MSGBODY,DB_MSGDATE,DB_HOSPID,DB_REGID,DB_PATIENTID,DB_STATUS,DB_ORDERID,DB_ORDERTYPE,DB_CATEGORY,DB_SUBCATEGORY,DB_HOSPNAME,DB_DEPT,DB_DOCNAME,DB_FEE,DB_MEDICALTIME,DB_ITEMNOS,DB_TRADETIME,DB_BEDNO,DB_BALANCE,DB_REPORTID,DB_REPORTNAME,DB_REPORTTYPE,DB_ANYMEDTITLE,DB_ANYMEDSUMMAR,DB_ANYMEDDATE,DB_ANYMEDPIC,DB_ANYMEDURL,DB_DOCHEAD,DB_INPATIENTRECORDID,DB_ALERT,DB_DOCID,DB_CHECKTIME,DB_REGDATE,DB_UNREAD,DB_ICONURL,DB_IMID,DB_TIMID,DB_ROOMID,DB_USERNAME,DB_GENDER,DB_MEDGUIDE,DB_PRODUCTNAME,DB_ORDERNO,DB_FINISHTIME];
        [db executeUpdate:createNoticesMSql, nil];
        
        
        NSString *createUserInfoSql = [NSString stringWithFormat:
                                     @"CREATE TABLE IF NOT EXISTS %@ (%@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text,%@ text,%@ text,PRIMARY KEY(%@))",
                                     DB_TABLEUSERINFO,DB_USERID,DB_PASSWORD,DB_GESPASSWORD,DB_GESTRACKOPENED,DB_GESOPENED,DB_PHONENO,DB_PATIENTID,DB_CURRENTUSER,DB_SIGNINGKEY,DB_TOKEN,DB_GENDER,DB_NAME,DB_PATIENTHEAD,DB_MERCHANTNO,DB_USERID];
        [db executeUpdate:createUserInfoSql, nil];
        
        NSString *createHospsSql = [NSString stringWithFormat:
                                   @"CREATE TABLE IF NOT EXISTS %@ (%@ text, %@ text, PRIMARY KEY(%@))",
                                   DB_TABLEHOS,DB_HOSPID,DB_SERCODE,DB_HOSPID];
        [db executeUpdate:createHospsSql, nil];
        
        NSString *createVersionSql = [NSString stringWithFormat:
                                     @"CREATE TABLE IF NOT EXISTS %@ (%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,PRIMARY KEY(%@))",
                                     DB_BASETABLE,DB_VERSION,DB_CITYNAME,DB_HOSPID,DB_CURRENTUSERID,DB_CURRENTPID,DB_REMARK,DB_VERSION];
        [db executeUpdate:createVersionSql, nil];

        NSString *createRDocsSql = [NSString stringWithFormat:
                                   @"CREATE TABLE IF NOT EXISTS %@ (%@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, PRIMARY KEY(%@))",
                                   DB_TABLEDOCS,DB_DOCID,DB_DOCNAME,DB_HOSPID,DB_HOSPNAME,DB_HOSPTYE,DB_HOSPLEVEL,DB_DEPTNAME,DB_LEVELNAME,DB_REMARK,DB_HEADIMG,DB_DESC,DB_FLOWERS,DB_TOTALVISITS,DB_ISEXPERT,DB_ISREGISTED,DB_EVALUAION,DB_ISCONSULTED,DB_DOCID];
        [db executeUpdate:createRDocsSql, nil];

        NSString *createRHospsSql = [NSString stringWithFormat:
                                   @"CREATE TABLE IF NOT EXISTS %@ (%@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, PRIMARY KEY(%@))",
                                   DB_TABLEHOSPS,DB_HOSPID,DB_NAME,DB_DESC,DB_REMARK,DB_HOSPLOGOURL,DB_IMAGEURL,DB_HOSPTYE,DB_HOSPLEVEL,DB_PATINETCONUT,DB_DAILYVISITCOUNT,DB_ADDRESS,DB_CONTACTNO,DB_DEPTS,DB_ISSUPPORTREG,DB_ISOPENED,DB_SERCODE,DB_ISINSURASSIGNED,DB_LNG,DB_LAT,DB_DISTANCE,DB_ABBRNAME,DB_HOSPID];
        [db executeUpdate:createRHospsSql, nil];

        // 检查数据库里有没有缺少的字段
        [self alertUserInfoTable];
        [self alertNoticeTable];
        [db close];
        
    }];

}

+ (void)alertTable:(FMDatabase *)db {

    NSString *versionStr = [AMDBHelper getVersion];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * versionStrT = @"";
    
    if(versionStr.length>0) {
        versionStrT = [versionStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    } else {
        versionStrT = @"260";
    }
    
    switch (versionStrT.longLongValue) {
        case 260 ... 269:
        {
            NSString *alterTalbeSql1 = [NSString stringWithFormat:
                                       @"ALTER TABLE %@ ADD COLUMN %@ text",
                                       DB_TABLEUSERINFO,DB_NAME];
            
            BOOL ret1 = [db executeUpdate:alterTalbeSql1, nil];
            if (ret1) {
                NSString *updateTalbeSql = [NSString stringWithFormat:
                                           @"UPDATE %@ SET %@ = ''",
                                           DB_TABLEUSERINFO,DB_NAME];
                [db executeUpdate:updateTalbeSql, nil];
            }
        }
        case 270 ... 2110:
        {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
            NSString *selectSql = [NSString stringWithFormat:
                                   @"SELECT * FROM %@",DB_TABLENOTICE];
            FMResultSet *rs = [db executeQuery:selectSql];
            while ([rs next]){
                
                AMMNotice *model = [[AMMNotice alloc] init];
                model.orderId    = [[rs resultDictionary] objectForKey:@"orderId"];
                model.status     = [[rs resultDictionary] objectForKey:@"status"];
                model.userId     = [[rs resultDictionary] objectForKey:@"userid"];
                model.type       = [[rs resultDictionary] objectForKey:@"type"];
                model.msgBody    = [[rs resultDictionary] objectForKey:@"msgBody"];
                model.patientId  = [[rs resultDictionary] objectForKey:@"patientId"];
                model.unread     = [[rs resultDictionary] objectForKey:@"unread"];
                model.index      = [[rs resultDictionary] objectForKey:@"id"];
                model.msgDate    = [[rs resultDictionary] objectForKey:@"msgDate"];
                model.regId      = [[rs resultDictionary] objectForKey:@"regId"];
                model.reportType = [[rs resultDictionary] objectForKey:@"reportType"];
                model.reportId   = [[rs resultDictionary] objectForKey:@"reportId"];
                model.hospId     = [[rs resultDictionary] objectForKey:@"hospId"];
                model.hospName   = [[rs resultDictionary] objectForKey:@"hospName"];
                model.orderType  = [[rs resultDictionary] objectForKey:@"orderType"];
                [array addObject:model];
            }
            
            [AMDBHelper replaceNoticesWithArray:array];
            
            break;
        }
        default:
            break;
    }

    
    NSString *addSql= [NSString stringWithFormat:
                       @"REPLACE INTO %@ (%@) VALUES ('%@')",
                       DB_BASETABLE,DB_VERSION,version];
    
    BOOL ret = [db executeUpdate:addSql, nil];
    if (ret) {
        
    }

}

+ (BOOL)isTableOK:(FMDatabase *)db tableName:(NSString *)tableName
{
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

+ (NSString *) validateNilString:(NSString *)strValue {
    
    
    NSString *returnString = @"";
    
    if(!strValue || ![strValue isKindOfClass:[NSString class]] ) {
        return returnString;
    }

    @try {
        if (!strValue)
            return returnString;
        
        if ([strValue isKindOfClass:[NSNull class]])
            return returnString;
        
        if ([strValue isEqualToString:@"<nil>"])
            return returnString;
        
        if ([strValue isEqualToString:@"<null>"])
            return returnString;
        
        if ([strValue isEqualToString:@"NULL"])
            return returnString;
        
        if ([strValue isEqualToString:@"nil"])
            return returnString;
        
        if ([strValue isEqualToString:@"(null)"])
            return returnString;
        
        return strValue;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
        return returnString;
    }
}

+ (NSString *)getVersion {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    __block NSString * version = @"";
    
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *selectSql = [NSString stringWithFormat:
                               @"SELECT * FROM %@",DB_BASETABLE];
        
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            version = [[rs resultDictionary] objectForKey:DB_VERSION];
            
        }
        [db close];

    }];
    
    return version;
}


+ (NSString *)getKey:(NSString *)key {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    __block NSString * timestemp = @"";
    
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *selectSql = [NSString stringWithFormat:
                               @"SELECT * FROM %@ where %@ = '%@' ",DB_TABLECOMMONTABLE,DB_KEYWORD,key];
        
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            [array addObject:[rs resultDictionary]];
            
        }
        [db close];
        
        if (array.count>0) {
            NSDictionary *dic = [array objectAtIndex:0];
            timestemp = [dic objectForKey:DB_TIMESTAMP];
        }
    }];
    
    return timestemp;
}


+ (void)replaceKey:(NSString *)key value:(NSString *)value{
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        
        
        NSString *updateSql= [NSString stringWithFormat:
                              @"REPLACE INTO %@ (%@, %@) VALUES ('%@' ,'%@')",
                              DB_TABLECOMMONTABLE,DB_KEYWORD,DB_TIMESTAMP,[self validateNilString:key],[self validateNilString:value]];
        [db executeUpdate:updateSql];
        
        [db commit];
        [db close];
        
    }];
}

+ (void)deleteUserInfo {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    [queue inDatabase:^(FMDatabase *db){
        
        NSString *delSql= [NSString stringWithFormat:
                           @"DELETE FROM %@",DB_TABLEUSERINFO];
        
        BOOL ret = [db executeUpdate:delSql,nil];
        if (ret) {
            
        }
        [db close];
        
    }];
}

+ (void)alertUserInfoTable {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        
        if (![db columnExists:DB_PATIENTHEAD inTableWithName:DB_TABLEUSERINFO]) {
            NSString *alterTalbeSql = [NSString stringWithFormat:
                                       @"ALTER TABLE %@ ADD COLUMN %@ text",
                                       DB_TABLEUSERINFO,DB_PATIENTHEAD];
            
            BOOL ret = [db executeUpdate:alterTalbeSql, nil];
            
            if (ret) {
                NSString *updateTalbeSql = [NSString stringWithFormat:
                                            @"UPDATE %@ SET %@ = ''",
                                            DB_TABLEUSERINFO,DB_PATIENTHEAD];
                [db executeUpdate:updateTalbeSql, nil];
            }
            
        }
        if (![db columnExists:DB_MERCHANTNO inTableWithName:DB_TABLEUSERINFO]) {
            NSString *alterTalbeSql = [NSString stringWithFormat:
                                       @"ALTER TABLE %@ ADD COLUMN %@ text",
                                       DB_TABLEUSERINFO,DB_MERCHANTNO];
            
            BOOL ret = [db executeUpdate:alterTalbeSql, nil];
            
            if (ret) {
                NSString *updateTalbeSql = [NSString stringWithFormat:
                                            @"UPDATE %@ SET %@ = ''",
                                            DB_TABLEUSERINFO,DB_MERCHANTNO];
                [db executeUpdate:updateTalbeSql, nil];
            }
            
        }

        
        [db commit];
        [db close];
    }];
}

+ (BOOL)replaceUserInfo:(AMMGesUserInfo *)gesUserInfo {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    [self deleteUserInfo];
    
    __block BOOL ret = NO;
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        
        NSString *gender = @"";
        
        if (gesUserInfo.gender > -1) {
            gender = [NSString stringWithFormat:@"%d",gesUserInfo.gender];
        }
        
        NSString *userid    = [gesUserInfo.userId  aes256Encrypt:DB_KEYFORAES];
        NSString *password  = [gesUserInfo.password aes256Encrypt:DB_KEYFORAES];
        NSString *patientid = [gesUserInfo.patientId aes256Encrypt:DB_KEYFORAES];
        NSString *token     = [gesUserInfo.token aes256Encrypt:DB_KEYFORAES];
        NSString *signingKey = [gesUserInfo.signingKey aes256Encrypt:DB_KEYFORAES];
        NSString *phoneNo   = [gesUserInfo.phoneNo aes256Encrypt:DB_KEYFORAES];
        NSString *name   = [gesUserInfo.name aes256Encrypt:DB_KEYFORAES];
        NSString *patientHead   = gesUserInfo.patientHead != nil ? gesUserInfo.patientHead : @"";
        NSString *merchantNo = [gesUserInfo.merchantNo aes256Encrypt:DB_KEYFORAES];
        NSString *updateSql= [NSString stringWithFormat:
                              @"REPLACE INTO %@ (%@ ,%@ ,%@ ,%@ ,%@,%@ ,%@ ,%@ ,%@ ,%@, %@, %@, %@, %@) VALUES ('%@', '%@', '%@', '%@','%@','%@', '%@', '%@', '%@','%@','%@','%@','%@','%@')",
                              DB_TABLEUSERINFO,DB_USERID,DB_PASSWORD,DB_GESOPENED,DB_GESPASSWORD,DB_GESTRACKOPENED,DB_TOKEN,DB_SIGNINGKEY,DB_PATIENTID,DB_PHONENO,DB_CURRENTUSER,DB_GENDER, DB_NAME,DB_PATIENTHEAD,DB_MERCHANTNO,userid,password,gesUserInfo.gesopened,gesUserInfo.gespassword,gesUserInfo.gestrackopened,token,signingKey,patientid,phoneNo,gesUserInfo.currentUser,gender,name,patientHead,merchantNo];
        
        ret = [db executeUpdate:updateSql];
        
        [db commit];
        [db close];
        
    }];
    
    return ret;
}

+ (AMMGesUserInfo *)getCurrentUserInfo {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    __block AMMGesUserInfo *model = nil;
    
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *selectSql = [NSString stringWithFormat:
                               @"SELECT * FROM %@ where %@ = '%@'",
                               DB_TABLEUSERINFO,DB_CURRENTUSER,@"1"];
        
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            model                = [[AMMGesUserInfo alloc] init];
            
            NSString *userid      = [self stringDecrypt:rs key:DB_USERID];
            NSString *password    = [self stringDecrypt:rs key:DB_PASSWORD];
            NSString *patientid   = [self stringDecrypt:rs key:DB_PATIENTID];
            NSString *token       = [self stringDecrypt:rs key:DB_TOKEN];
            NSString *signingKey  = [self stringDecrypt:rs key:DB_SIGNINGKEY];
            NSString *phoneNo     = [self stringDecrypt:rs key:DB_PHONENO];
            NSString *name        = [self stringDecrypt:rs key:DB_NAME];
            
            model.userId         = userid;
            model.password       = password;
            model.gespassword    = [[rs resultDictionary] objectForKey:DB_GESPASSWORD];
            model.gesopened      = [[rs resultDictionary] objectForKey:DB_GESOPENED];
            model.gestrackopened = [[rs resultDictionary] objectForKey:DB_GESTRACKOPENED];
            model.phoneNo        = phoneNo;
            model.patientId      = patientid;
            model.token          = token;
            model.signingKey     = signingKey;
            model.currentUser    = [[rs resultDictionary] objectForKey:DB_CURRENTUSER];
            NSString *gender     = [[rs resultDictionary] objectForKey:DB_GENDER];
            if (gender && gender.length) {
                model.gender     = gender.intValue;
            }
            model.name           = name;
            
            // 患者头像
            NSString *patientHeadTemp = [[rs resultDictionary] objectForKey:DB_PATIENTHEAD];
            if ([patientHeadTemp isKindOfClass:[NSString class]]) {
                model.patientHead = patientHeadTemp;
            } else {
                model.patientHead = @"";
            }
            model.merchantNo = [self stringDecrypt:rs key:DB_MERCHANTNO];
        }
        [db close];
    }];
    
    return model;
}

+ (AMMGesUserInfo *)getUserInfo:(NSString *)userid {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    __block AMMGesUserInfo *model = nil;
    
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *useridTmp    = [userid aes256Encrypt:DB_KEYFORAES];
        
        NSString *selectSql = [NSString stringWithFormat:
                               @"SELECT * FROM %@ where %@ = '%@'",
                               DB_TABLEUSERINFO,DB_USERID,useridTmp];
        
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            model                 = [[AMMGesUserInfo alloc] init];
            
            NSString *userid      = [self stringDecrypt:rs key:DB_USERID];
            NSString *password    = [self stringDecrypt:rs key:DB_PASSWORD];
            NSString *patientid   = [self stringDecrypt:rs key:DB_PATIENTID];
            NSString *token       = [self stringDecrypt:rs key:DB_TOKEN];
            NSString *signingKey  = [self stringDecrypt:rs key:DB_SIGNINGKEY];
            NSString *phoneNo     = [self stringDecrypt:rs key:DB_PHONENO];
            NSString *name        = [self stringDecrypt:rs key:DB_NAME];
            
            model.userId         = userid;
            model.password       = password;
            model.gespassword    = [[rs resultDictionary] objectForKey:DB_GESPASSWORD];
            model.gesopened      = [[rs resultDictionary] objectForKey:DB_GESOPENED];
            model.gestrackopened = [[rs resultDictionary] objectForKey:DB_GESTRACKOPENED];
            model.phoneNo        = phoneNo;
            model.patientId      = patientid;
            model.token          = token;
            model.signingKey     = signingKey;
            model.currentUser    = [[rs resultDictionary] objectForKey:DB_CURRENTUSER];
            NSString *gender     = [[rs resultDictionary] objectForKey:DB_GENDER];
            if (gender && gender.length) {
                model.gender     = gender.intValue;
            }
            model.name           = name;
            model.merchantNo = [self stringDecrypt:rs key:DB_MERCHANTNO];
        }
        [db close];
    }];
    
    return model;
}

+ (BOOL)replaceHospsCode:(NSString *)hospId serviceCode:(NSString *)serviceCode {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    __block BOOL ret = NO;
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        
        NSString *updateSql= [NSString stringWithFormat:
                              @"REPLACE INTO %@ (%@ ,%@ ) VALUES ('%@', '%@')",
                              DB_TABLEHOS,DB_HOSPID,DB_SERCODE,hospId,serviceCode];
        ret = [db executeUpdate:updateSql];
        
        [db commit];
        [db close];
        
    }];
    
    return ret;
}


+ (BOOL)replaceHospsCode:(NSMutableArray *)hospArray {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    __block BOOL ret = NO;
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db setShouldCacheStatements:YES];
        
        [db beginTransaction];
        
        for (int index=0; index<hospArray.count; index++) {
            
            NXTFFindHospOutput *hosps = [hospArray objectAtIndex:index];

            if (hosps && [hosps isKindOfClass:[NXTFFindHospOutput class]]) {
                
                NSString *updateSql= [NSString stringWithFormat:
                                      @"REPLACE INTO %@ (%@ ,%@ ) VALUES ('%@', '%@')",
                                      DB_TABLEHOS,DB_HOSPID,DB_SERCODE,hosps.hospId,hosps.serviceCode];
                ret = [db executeUpdate:updateSql];
            }
        }
        
        [db commit];
        [db close];
        
    }];
    
    return ret;
}


+ (AMMServiceCode *)getHospsSerCode:(NSString *)hospId {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    __block AMMServiceCode *serviceCode = [[AMMServiceCode alloc] init];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *selectSql = [NSString stringWithFormat:
                               @"SELECT * FROM %@ where %@ = '%@'",
                               DB_TABLEHOS,DB_HOSPID,hospId];
        
        [db setShouldCacheStatements:YES];
        
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            
            NSString *serviceCodeStr= [[rs resultDictionary] objectForKey:DB_SERCODE];
            if (serviceCodeStr && serviceCodeStr.length>0 && ![serviceCodeStr isEqualToString:@""]) {
                
                long long serviceCodeInt = [serviceCodeStr longLongValue];
                serviceCode = [AMDBHelper supportService:serviceCodeInt];
                break;
            }
            
        }
        [db close];
    }];
    
    return serviceCode;
}

+(AMMServiceCode *)supportService:(long long)serviceCodeInt {
    
    AMMServiceCode *serviceCode = [[AMMServiceCode alloc] init];
    
    long long serviceCodeTmp = serviceCodeInt;
    for(int index=0;index<25;index++) {
        
        serviceCodeTmp = serviceCodeInt>>index;
        switch (index) {
            case 0:
            {
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportAppointment = NO;
                } else {
                    serviceCode.supportAppointment = YES;
                }
                break;
            }
            case 1:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportPay = NO;
                } else {
                    serviceCode.supportPay = YES;
                }
                break;
            case 2:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportWaitting = NO;
                } else {
                    serviceCode.supportWaitting = YES;
                }
                break;
            case 3:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportReport = NO;
                } else {
                    serviceCode.supportReport = YES;
                }
                break;
            case 4:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportPrescriptionsPay = NO;
                } else {
                    serviceCode.supportPrescriptionsPay = YES;
                }
                break;
            case 5:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportInhospital = NO;
                } else {
                    serviceCode.supportInhospital = YES;
                }
                break;
            case 6:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportState = NO;
                } else {
                    serviceCode.supportState = YES;
                }
                break;
            case 7:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportMap = NO;
                } else {
                    serviceCode.supportMap = YES;
                }
                break;
            case 8:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportIllness = NO;
                } else {
                    serviceCode.supportIllness = YES;
                }
                break;
            case 9:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportMessage = NO;
                } else {
                    serviceCode.supportMessage = YES;
                }
                break;
            case 10:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportPush = NO;
                } else {
                    serviceCode.supportPush = YES;
                }
                break;
            case 11:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportRefund = NO;
                } else {
                    serviceCode.supportRefund = YES;
                }
            case 12:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportTodayRefund = NO;
                } else {
                    serviceCode.supportTodayRefund = YES;
                }
                break;
            case 13:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportPrescriptionsList = NO;
                } else {
                    serviceCode.supportPrescriptionsList = YES;
                }
                break;
            case 14:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportInhospitalPay = NO;
                } else {
                    serviceCode.supportInhospitalPay = YES;
                }
                break;
            case 15:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportHiddenCardNo = NO;
                } else {
                    serviceCode.supportHiddenCardNo = YES;
                }
                break;
            case 16:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.support120 = NO;
                } else {
                    serviceCode.support120 = YES;
                }
                break;
            case 17:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportNoPayRecipeDetail = NO;
                } else {
                    serviceCode.supportNoPayRecipeDetail = YES;
                }
                break;
            case 18:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportDisableAutoRegCardNo = NO;
                } else {
                    serviceCode.supportDisableAutoRegCardNo = YES;
                }
                break;
            case 19:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportCheckIn = NO;
                } else {
                    serviceCode.supportCheckIn = YES;
                }
                break;
            case 20:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportPacsReportImage = NO;
                } else {
                    serviceCode.supportPacsReportImage = YES;
                }
                break;
            case 21:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportPhysicalExamination = NO;
                } else {
                    serviceCode.supportPhysicalExamination = YES;
                }
                break;
            case 22:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportPayPrescription = NO;
                } else {
                    serviceCode.supportPayPrescription = YES;
                }
                break;
            case 23:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportIdentityCard = NO;
                } else {
                    serviceCode.supportIdentityCard = YES;
                }
                break;
            case 24:
                if (serviceCodeTmp%2 == 0) {
                    serviceCode.supportTopUpTreamentCard = NO;
                } else {
                    serviceCode.supportTopUpTreamentCard = YES;
                }
                break;
            default:
                break;
        }
    }
    return serviceCode;
}

+ (void)replacePatientsWithArray:(NSArray *)array {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        [db setShouldCacheStatements:YES];
        
        [db beginTransaction];
        BOOL ret = NO;
        for (int index=0; index<array.count; index++) {
            NXTFPatientDto * patientInfo = [array objectAtIndex:index];
            
            NSString *userid          = [[self validateNilString:patientInfo.userId]  aes256Encrypt:DB_KEYFORAES];
            NSString *patientId       = [[self validateNilString:patientInfo.patientId] aes256Encrypt:DB_KEYFORAES];
            NSString *name            = [[self validateNilString:patientInfo.name] aes256Encrypt:DB_KEYFORAES];
            NSString *papersNo        = [[self validateNilString:patientInfo.papersNo] aes256Encrypt:DB_KEYFORAES];
            NSString *phoneNo         = [[self validateNilString:patientInfo.phoneNo] aes256Encrypt:DB_KEYFORAES];
            NSString *address         = [[self validateNilString:patientInfo.address] aes256Encrypt:DB_KEYFORAES];
            NSString *headImg         = [[self validateNilString:patientInfo.headImg] aes256Encrypt:DB_KEYFORAES];
            NSString *gender          = [[self validateNilString:patientInfo.gender] aes256Encrypt:DB_KEYFORAES];
            NSString *papersTypeId    = [[self validateNilString:patientInfo.papersTypeId] aes256Encrypt:DB_KEYFORAES];
            NSString *medInsureance   = [[self validateNilString:patientInfo.medInsureance] aes256Encrypt:DB_KEYFORAES];
            NSString *stature         = [[self validateNilString:patientInfo.stature] aes256Encrypt:DB_KEYFORAES];
            NSString *weight          = [[self validateNilString:patientInfo.weight] aes256Encrypt:DB_KEYFORAES];
            NSString *bornDate        = [[self validateNilString:patientInfo.bornDate] aes256Encrypt:DB_KEYFORAES];
            NSString *bloodType       = [[self validateNilString:patientInfo.bloodType] aes256Encrypt:DB_KEYFORAES];
            NSString *criticalIllness = [[self validateNilString:patientInfo.criticalIllness] aes256Encrypt:DB_KEYFORAES];
            NSString *allergicHistory = [[self validateNilString:patientInfo.allergicHistory] aes256Encrypt:DB_KEYFORAES];
            NSString *familyHistory   = [[self validateNilString:patientInfo.familyHistory] aes256Encrypt:DB_KEYFORAES];
            NSString *relationId      = [[self validateNilString:patientInfo.relationId] aes256Encrypt:DB_KEYFORAES];
            NSString *cardNo          = [[self validateNilString:patientInfo.cardNo] aes256Encrypt:DB_KEYFORAES];
            NSString *inpatientNo     = [[self validateNilString:patientInfo.inpatientNo] aes256Encrypt:DB_KEYFORAES];
            NSString *cardCount       = [[self validateNilString:patientInfo.cardCount] aes256Encrypt:DB_KEYFORAES];
            NSString *inpatientCount  = [[self validateNilString:patientInfo.inpatientCount] aes256Encrypt:DB_KEYFORAES];
            
            if(patientInfo) {
                
                NSString *updateSql= [NSString stringWithFormat:
                                      @"REPLACE INTO %@ (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@) VALUES ('%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                                      DB_TABLEPATIENT,DB_USERID,DB_PATIENTID,DB_HEADERIMG,DB_NAME,DB_GENDER,DB_PAPERSNO,DB_PHONENO,DB_PAPERTYPEID,DB_MEDINSUREANCE,DB_STATURE,DB_WEIGHT,DB_BORNDATE,DB_ADDRESS,DB_BLOODTYPE,DB_ILLNESS,DB_ALLHISTORY,DB_FAMHISTORY,DB_RELATIONID,DB_CARDNO,DB_INPATIENTNO,DB_CARDCOUNT,DB_INPATIENTCOUNT,userid,patientId,headImg,name,gender,papersNo,phoneNo,papersTypeId,medInsureance,stature,weight,bornDate,address,bloodType,criticalIllness,allergicHistory,familyHistory,relationId,cardNo,inpatientNo,cardCount,inpatientCount];
                ret = [db executeUpdate:updateSql];
                if (!ret) {
                    break;
                }
            }
            
        }
        [db commit];
        [db close];
        
    }];

}

+ (NSArray *)getPatients:(NSString *)userid {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    __block NSMutableArray * array = [NSMutableArray arrayWithCapacity:5];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db setShouldCacheStatements:YES];
        
        NSString *selectSql = [NSString stringWithFormat:
                               @"SELECT * FROM %@ where %@ = '%@' order by %@ DESC",
                               DB_TABLENOTICE,DB_USERID,userid,DB_PATIENTID];
        
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            
            NXTFPatientDto * model  = [[NXTFPatientDto alloc] init];
            model.userId            = [(NSString *)([[rs resultDictionary] objectForKey:@"userId"]) aes256Decrypt:DB_KEYFORAES];
            model.patientId         = [(NSString *)([[rs resultDictionary] objectForKey:@"patientId"]) aes256Decrypt:DB_KEYFORAES];
            model.headImg           = [(NSString *)([[rs resultDictionary] objectForKey:@"headImg"]) aes256Decrypt:DB_KEYFORAES];
            model.name              = [(NSString *)([[rs resultDictionary] objectForKey:@"name"]) aes256Decrypt:DB_KEYFORAES];
            model.gender            = [(NSString *)([[rs resultDictionary] objectForKey:@"gender"]) aes256Decrypt:DB_KEYFORAES];
            model.phoneNo           = [(NSString *)([[rs resultDictionary] objectForKey:@"phoneNo"]) aes256Decrypt:DB_KEYFORAES];
            model.papersNo          = [(NSString *)([[rs resultDictionary] objectForKey:@"papersNo"]) aes256Decrypt:DB_KEYFORAES];
            model.papersTypeId      = [(NSString *)([[rs resultDictionary] objectForKey:@"papersTypeId"]) aes256Decrypt:DB_KEYFORAES];
            model.medInsureance     = [(NSString *)([[rs resultDictionary] objectForKey:@"medInsureance"]) aes256Decrypt:DB_KEYFORAES];
            model.stature           = [(NSString *)([[rs resultDictionary] objectForKey:@"stature"]) aes256Decrypt:DB_KEYFORAES];
            model.weight            = [(NSString *)([[rs resultDictionary] objectForKey:@"weight"]) aes256Decrypt:DB_KEYFORAES];
            model.bornDate          = [(NSString *)([[rs resultDictionary] objectForKey:@"bornDate"]) aes256Decrypt:DB_KEYFORAES];
            model.bloodType         = [(NSString *)([[rs resultDictionary] objectForKey:@"bloodType"]) aes256Decrypt:DB_KEYFORAES];
            model.address           = [(NSString *)([[rs resultDictionary] objectForKey:@"address"]) aes256Decrypt:DB_KEYFORAES];
            model.criticalIllness   = [(NSString *)([[rs resultDictionary] objectForKey:@"criticalIllness"]) aes256Decrypt:DB_KEYFORAES];
            model.allergicHistory   = [(NSString *)([[rs resultDictionary] objectForKey:@"allergicHistory"]) aes256Decrypt:DB_KEYFORAES];
            model.familyHistory     = [(NSString *)([[rs resultDictionary] objectForKey:@"familyHistory"]) aes256Decrypt:DB_KEYFORAES];
            model.relationId        = [(NSString *)([[rs resultDictionary] objectForKey:@"relationId"]) aes256Decrypt:DB_KEYFORAES];
            model.cardNo            = [(NSString *)([[rs resultDictionary] objectForKey:@"cardNo"]) aes256Decrypt:DB_KEYFORAES];
            model.inpatientNo       = [(NSString *)([[rs resultDictionary] objectForKey:@"inpatientNo"]) aes256Decrypt:DB_KEYFORAES];
            model.cardCount         = [(NSString *)([[rs resultDictionary] objectForKey:@"cardCount"]) aes256Decrypt:DB_KEYFORAES];
            model.inpatientCount    = [(NSString *)([[rs resultDictionary] objectForKey:@"inpatientCount"]) aes256Decrypt:DB_KEYFORAES];
            
            [array addObject:model];
        }
        [db close];
    }];
    
    return array;
}


+ (void)deleteHosps {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    [queue inDatabase:^(FMDatabase *db){
        
        NSString *delSql= [NSString stringWithFormat:
                           @"DELETE FROM %@",DB_TABLEHOSPS];
        
        BOOL ret = [db executeUpdate:delSql,nil];
        if (ret) {
            
        }
        [db close];
        
    }];
}

+ (void)replaceHospsWithArray:(NSArray *)array {
    
    [self deleteHosps];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        [db setShouldCacheStatements:YES];
        
        [db beginTransaction];
        BOOL ret = NO;
        for (int index=0; index<array.count; index++) {
            NXTFFindHospOutput * hospOutput = [array objectAtIndex:index];
            if(hospOutput) {
                NSString *updateSql= [NSString stringWithFormat:
                                      @"REPLACE INTO %@ (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@) VALUES ('%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                                      DB_TABLEHOSPS,DB_HOSPID,DB_NAME,DB_DESC,DB_REMARK,DB_HOSPLOGOURL,DB_IMAGEURL,DB_HOSPTYE,DB_HOSPLEVEL,DB_PATINETCONUT,DB_DAILYVISITCOUNT,DB_ADDRESS,DB_CONTACTNO,DB_DEPTS,DB_ISSUPPORTREG,DB_ISOPENED,DB_SERCODE,DB_ISINSURASSIGNED,DB_LNG,DB_LAT,DB_DISTANCE,
                                        [[self validateNilString:hospOutput.hospId] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.name] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.desc] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.remark] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.hospLogoUrl] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.imageUrl] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.hospType] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.hospLevel] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.patientCount] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.dailyVisitCount] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.address] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.contactNo] aes256Encrypt:DB_KEYFORAES],
                                        @"",
                                        [[self validateNilString:hospOutput.isSupportReg] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.isOpened] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.serviceCode] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.isInsurAssigned] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.lng] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.lat] aes256Encrypt:DB_KEYFORAES],
                                        [[self validateNilString:hospOutput.distance] aes256Encrypt:DB_KEYFORAES]
                                        ];
                ret = [db executeUpdate:updateSql];
                if (!ret) {
                    break;
                }
            }
            
        }
        [db commit];
        [db close];
        
    }];
    
}

+ (NSMutableArray *)getHosps {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    __block NSMutableArray * array = [NSMutableArray arrayWithCapacity:5];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db setShouldCacheStatements:YES];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM %@",DB_TABLEHOSPS];
        
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            
            NXTFFindHospOutput * model  = [[NXTFFindHospOutput alloc] init];
            model.hospId                = [(NSString *)([[rs resultDictionary] objectForKey:@"hospId"]) aes256Decrypt:DB_KEYFORAES];
            model.name                  = [(NSString *)([[rs resultDictionary] objectForKey:@"name"]) aes256Decrypt:DB_KEYFORAES];
            model.desc                  = [(NSString *)([[rs resultDictionary] objectForKey:@"desc"]) aes256Decrypt:DB_KEYFORAES];
            model.remark                = [(NSString *)([[rs resultDictionary] objectForKey:@"remark"]) aes256Decrypt:DB_KEYFORAES];
            model.hospLogoUrl           = [(NSString *)([[rs resultDictionary] objectForKey:@"hospLogoUrl"]) aes256Decrypt:DB_KEYFORAES];
            model.imageUrl              = [(NSString *)([[rs resultDictionary] objectForKey:@"imageUrl"]) aes256Decrypt:DB_KEYFORAES];
            model.hospType              = [(NSString *)([[rs resultDictionary] objectForKey:@"hospType"]) aes256Decrypt:DB_KEYFORAES];
            model.hospLevel             = [(NSString *)([[rs resultDictionary] objectForKey:@"hospLevel"]) aes256Decrypt:DB_KEYFORAES];
            model.patientCount          = [(NSString *)([[rs resultDictionary] objectForKey:@"patientCount"]) aes256Decrypt:DB_KEYFORAES];
            model.dailyVisitCount       = [(NSString *)([[rs resultDictionary] objectForKey:@"dailyVisitCount"]) aes256Decrypt:DB_KEYFORAES];
            model.address               = [(NSString *)([[rs resultDictionary] objectForKey:@"address"]) aes256Decrypt:DB_KEYFORAES];
            model.contactNo             = [(NSString *)([[rs resultDictionary] objectForKey:@"contactNo"]) aes256Decrypt:DB_KEYFORAES];
            model.isSupportReg          = [(NSString *)([[rs resultDictionary] objectForKey:@"isSupportReg"]) aes256Decrypt:DB_KEYFORAES];
            model.isOpened              = [(NSString *)([[rs resultDictionary] objectForKey:@"isOpened"]) aes256Decrypt:DB_KEYFORAES];
            model.serviceCode           = [(NSString *)([[rs resultDictionary] objectForKey:@"serviceCode"]) aes256Decrypt:DB_KEYFORAES];
            model.isInsurAssigned       = [(NSString *)([[rs resultDictionary] objectForKey:@"isInsurAssigned"]) aes256Decrypt:DB_KEYFORAES];
            model.lng                   = [(NSString *)([[rs resultDictionary] objectForKey:@"lng"]) aes256Decrypt:DB_KEYFORAES];
            model.lat                   = [(NSString *)([[rs resultDictionary] objectForKey:@"lat"]) aes256Decrypt:DB_KEYFORAES];
            model.distance              = [(NSString *)([[rs resultDictionary] objectForKey:@"distance"]) aes256Decrypt:DB_KEYFORAES];
            [array addObject:model];
        }
        [db close];
    }];
    
    return array;
}

+ (void)deleteDocs {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    [queue inDatabase:^(FMDatabase *db){
        
        NSString *delSql= [NSString stringWithFormat:
                           @"DELETE FROM %@",DB_TABLEDOCS];
        
        BOOL ret = [db executeUpdate:delSql,nil];
        if (ret) {
            
        }
        [db close];
        
    }];
}


//更新医生列表
+ (void)replaceDocsWithArray:(NSArray *)array {
    
    [self deleteDocs];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        [db setShouldCacheStatements:YES];

        [db beginTransaction];
        BOOL ret = NO;
        for (int index=0; index<array.count; index++) {
            NXTFFindDoctorOutput * doctorOutput = [array objectAtIndex:index];
            if(doctorOutput) {
                NSString *updateSql= [NSString stringWithFormat:
                                      @"REPLACE INTO %@ (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@) VALUES ('%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                                      DB_TABLEDOCS,DB_DOCID,DB_DOCNAME,DB_HOSPID,DB_HOSPNAME,DB_HOSPTYE,DB_HOSPLEVEL,DB_DEPTNAME,DB_LEVELNAME,DB_REMARK,DB_HEADIMG,DB_DESC,DB_FLOWERS,DB_TOTALVISITS,DB_ISEXPERT,DB_ISREGISTED,DB_EVALUAION,DB_ISCONSULTED,
                                      [[self validateNilString:doctorOutput.docId]  aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.docName]  aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.hospId]  aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.hospName]  aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.hospType]  aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.hospLevel] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.deptName] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.levelName] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.remark] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.headImg] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.desc] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.flowers] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.totalVisits] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.isExpert] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.isRegisted] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.evaluation] aes256Encrypt:DB_KEYFORAES],
                                      [[self validateNilString:doctorOutput.isConsulted] aes256Encrypt:DB_KEYFORAES]
                                      ];
                ret = [db executeUpdate:updateSql];
                if (!ret) {
                    break;
                }
            }
            
        }
        [db commit];
        [db close];
        
    }];

}


//获取医生列表
+ (NSArray *)getDocs {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    __block NSMutableArray * array = [NSMutableArray arrayWithCapacity:5];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db setShouldCacheStatements:YES];
        
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM %@",DB_TABLEDOCS];
        
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            
            NXTFFindDoctorOutput * model  = [[NXTFFindDoctorOutput alloc] init];
            model.docId                   = [(NSString *)([[rs resultDictionary] objectForKey:@"docId"]) aes256Decrypt:DB_KEYFORAES];
            model.docName                 = [(NSString *)([[rs resultDictionary] objectForKey:@"docName"]) aes256Decrypt:DB_KEYFORAES];
            model.hospId                  = [(NSString *)([[rs resultDictionary] objectForKey:@"hospId"]) aes256Decrypt:DB_KEYFORAES];
            model.hospName                = [(NSString *)([[rs resultDictionary] objectForKey:@"hospName"]) aes256Decrypt:DB_KEYFORAES];
            model.hospType                = [(NSString *)([[rs resultDictionary] objectForKey:@"hospType"]) aes256Decrypt:DB_KEYFORAES];
            model.hospLevel               = [(NSString *)([[rs resultDictionary] objectForKey:@"hospLevel"]) aes256Decrypt:DB_KEYFORAES];
            model.deptName                = [(NSString *)([[rs resultDictionary] objectForKey:@"deptName"]) aes256Decrypt:DB_KEYFORAES];
            model.levelName               = [(NSString *)([[rs resultDictionary] objectForKey:@"levelName"]) aes256Decrypt:DB_KEYFORAES];
            model.remark                  = [(NSString *)([[rs resultDictionary] objectForKey:@"remark"]) aes256Decrypt:DB_KEYFORAES];
            model.headImg                 = [(NSString *)([[rs resultDictionary] objectForKey:@"headImg"]) aes256Decrypt:DB_KEYFORAES];
            model.desc                    = [(NSString *)([[rs resultDictionary] objectForKey:@"desc"]) aes256Decrypt:DB_KEYFORAES];
            model.flowers                 = [(NSString *)([[rs resultDictionary] objectForKey:@"flowers"]) aes256Decrypt:DB_KEYFORAES];
            model.totalVisits             = [(NSString *)([[rs resultDictionary] objectForKey:@"totalVisits"]) aes256Decrypt:DB_KEYFORAES];
            model.isExpert                = [(NSString *)([[rs resultDictionary] objectForKey:@"isExpert"]) aes256Decrypt:DB_KEYFORAES];
            model.isRegisted              = [(NSString *)([[rs resultDictionary] objectForKey:@"isRegisted"]) aes256Decrypt:DB_KEYFORAES];
            model.evaluation              = [(NSString *)([[rs resultDictionary] objectForKey:@"evaluation"]) aes256Decrypt:DB_KEYFORAES];
            model.isConsulted             = [(NSString *)([[rs resultDictionary] objectForKey:@"isConsulted"]) aes256Decrypt:DB_KEYFORAES];
            model.hospAbbrName            = [(NSString *)([[rs resultDictionary] objectForKey:@"hospAbbrName"]) aes256Decrypt:DB_KEYFORAES];
            
            [array addObject:model];
        }
        [db close];

    }];
    
    return array;
    
}

// 解密从数据库取出来的字段
+ (NSString *)stringDecrypt:(FMResultSet *)rs key:(NSString *)key {
    
    NSString *retValue = @"";
    
    id tempValue = [[rs resultDictionary] objectForKey:key];
    if ([tempValue isKindOfClass:[NSString class]]) {
        retValue = (NSString *)tempValue;
        retValue = [retValue aes256Decrypt:DB_KEYFORAES];
    }
    
    return retValue;
}

#pragma mark - 消息相关

+ (void)replaceNotices:(AMMNotice *)notice {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        
        // 需要合并多条来自在线咨询的消息
        // 判断是否存在已有在线咨询消息
        NSString *checkRoomIdSql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@' and category = '%@' and subCategory = '%@'",DB_TABLENOTICEM,DB_ROOMID,[self validateNilString:notice.roomId],@"2",@"1"];
        // 获取检索结果
        FMResultSet *checkResultSet = [db executeQuery:checkRoomIdSql];
        if ([checkResultSet next]) {
            // 如果存在相应在线咨询消息,则删除所有对应咨询消息
            NSString *updateDateSql= [NSString stringWithFormat:@"delete from %@ where category = '%@' and subCategory = '%@' and roomId = '%@'",DB_TABLENOTICEM,@"2",@"1",[self validateNilString:notice.roomId]];
            // 删除消息后重新添加本条消息
            BOOL ret = [db executeUpdate:updateDateSql];
            if (ret) {
                
            }
        }
        
        NSString *updateSql= [self updateNoticesSql:notice];
        
        BOOL ret = [db executeUpdate:updateSql];
        if (ret) {
            
        }
        [db commit];
        [db close];
        
    }];
}

+ (void)replaceNoticesWithArray:(NSArray *)array {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        [db setShouldCacheStatements:YES];
        
        [db beginTransaction];
        
        
        for (int index=0; index<array.count; index++) {
            AMMNotice * notice = [array objectAtIndex:index];
            
            if(notice) {
                
                NSString *updateSql= [self updateNoticesSql:notice];
                BOOL ret = [db executeUpdate:updateSql];
                if (!ret) {
                    continue;
                }
            }
            
        }
        [db commit];
        [db close];
        
    }];
}

+ (NSArray *)getNotices:(NSString *)userid {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    __block NSMutableArray * array = [NSMutableArray arrayWithCapacity:5];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db setShouldCacheStatements:YES];
        
        
        NSString *selectSql = [NSString stringWithFormat:
                               @"SELECT * FROM %@ where %@ = '%@' order by %@ DESC",
                               DB_TABLENOTICEM,DB_USERID,userid,DB_MSGDATE];
        if (userid == nil) {
            
            selectSql = [NSString stringWithFormat:
                         @"SELECT * FROM %@ order by %@ DESC",
                         DB_TABLENOTICEM,DB_MSGDATE];
        }
        
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            
            AMMNotice *notice = [self getNoticeFromResultSet:rs];
            [array addObject:notice];
        }
        [db close];
    }];
    
    return array;
}

+ (NSArray *)getNotices:(NSString *)userid category:(NSString *)category {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    __block NSMutableArray * array = [NSMutableArray arrayWithCapacity:5];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db setShouldCacheStatements:YES];
        
        NSString *selectSql = [NSString stringWithFormat:
                               @"SELECT * FROM %@ where %@ = '%@' and %@ = '%@' order by %@ DESC",
                               DB_TABLENOTICEM,DB_USERID,userid,DB_CATEGORY,category,DB_MSGDATE];
        if (userid == nil) {
            
            selectSql = [NSString stringWithFormat:
                         @"SELECT * FROM %@ where %@ = '%@' order by %@ DESC",
                         DB_TABLENOTICEM,DB_CATEGORY,category,DB_MSGDATE];
        }
        
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            
            AMMNotice *notice = [self getNoticeFromResultSet:rs];
            [array addObject:notice];
            
        }
        [db close];
    }];
    
    return array;
}

+ (AMMNotice *)getNoticeFromResultSet:(FMResultSet *)rs {
    
    AMMNotice *model         = [[AMMNotice alloc] init];
    // msgId addBy xuyue 20160706
    model.msgId              = [[rs resultDictionary] objectForKey:@"msgId"];
    model.type               = [[rs resultDictionary] objectForKey:@"type"];
    model.userId             = [[rs resultDictionary] objectForKey:@"userid"];
    model.msgBody            = [[rs resultDictionary] objectForKey:@"msgBody"];
    model.msgDate            = [[rs resultDictionary] objectForKey:@"msgDate"];
    model.hospId             = [[rs resultDictionary] objectForKey:@"hospId"];
    model.regId              = [[rs resultDictionary] objectForKey:@"regId"];
    model.patientId          = [[rs resultDictionary] objectForKey:@"patientId"];
    model.status             = [[rs resultDictionary] objectForKey:@"status"];
    model.orderId            = [[rs resultDictionary] objectForKey:@"orderId"];
    model.orderType          = [[rs resultDictionary] objectForKey:@"orderType"];
    model.category           = [[rs resultDictionary] objectForKey:@"category"];
    model.subCategory        = [[rs resultDictionary] objectForKey:@"subCategory"];
    model.hospName           = [[rs resultDictionary] objectForKey:@"hospName"];
    model.dept               = [[rs resultDictionary] objectForKey:@"dept"];
    model.docName            = [[rs resultDictionary] objectForKey:@"docName"];
    model.fee                = [[rs resultDictionary] objectForKey:@"fee"];
    model.medicalTime        = [[rs resultDictionary] objectForKey:@"medicalTime"];
    model.itemNos            = [[rs resultDictionary] objectForKey:@"itemNos"];
    model.tradeTime          = [[rs resultDictionary] objectForKey:@"tradeTime"];
    model.bedNo              = [[rs resultDictionary] objectForKey:@"bedNo"];
    model.balance            = [[rs resultDictionary] objectForKey:@"balance"];
    model.reportId           = [[rs resultDictionary] objectForKey:@"reportId"];
    model.reportName         = [[rs resultDictionary] objectForKey:@"reportName"];
    model.reportType         = [[rs resultDictionary] objectForKey:@"reportType"];
    model.anyMedDate         = [[rs resultDictionary] objectForKey:@"anyMedDate"];
    model.anyMedPic          = [[rs resultDictionary] objectForKey:@"anyMedPic"];
    model.anyMedSummary      = [[rs resultDictionary] objectForKey:@"anyMedSummary"];
    model.anyMedTitle        = [[rs resultDictionary] objectForKey:@"anyMedTitle"];
    model.anyMedUrl          = [[rs resultDictionary] objectForKey:@"anyMedUrl"];
    model.docHead            = [[rs resultDictionary] objectForKey:@"docHead"];
    model.unread             = [[rs resultDictionary] objectForKey:@"unread"];
    model.inpatientRecordId  = [[rs resultDictionary] objectForKey:@"inpatientRecordId"];
    model.alert              = [[rs resultDictionary] objectForKey:@"alert"];
    model.docId              = [[rs resultDictionary] objectForKey:@"docId"];
    model.checkTime          = [[rs resultDictionary] objectForKey:@"checkTime"];
    model.regDate            = [[rs resultDictionary] objectForKey:@"regDate"];
    model.index              = [[rs resultDictionary] objectForKey:@"id"];
    model.imId               = [[rs resultDictionary] objectForKey:@"imId"];
    model.iconUrl            = [[rs resultDictionary] objectForKey:@"iconUrl"];
    model.gender             = [[rs resultDictionary] objectForKey:@"gender"];
    model.pointName          = [[rs resultDictionary] objectForKey:@"pointName"];
    model.reason             = [[rs resultDictionary] objectForKey:@"reason"];
    model.notice             = [[rs resultDictionary] objectForKey:@"notice"];
    model.logisNo            = [[rs resultDictionary] objectForKey:@"logisNo"];
    model.logisCompany       = [[rs resultDictionary] objectForKey:@"logisCompany"];
    model.logisSendTime      = [[rs resultDictionary] objectForKey:@"logisSendTime"];
    model.actId              = [[rs resultDictionary] objectForKey:@"actId"];
    model.title              = [[rs resultDictionary] objectForKey:@"title"];
    model.timeShow           = [[rs resultDictionary] objectForKey:@"timeShow"];
    model.stopInsDesc        = [[rs resultDictionary] objectForKey:@"stopInsDesc"];
    model.tImId              = [[rs resultDictionary] objectForKey:@"tImId"];
    model.roomId             = [[rs resultDictionary] objectForKey:@"roomId"];
    model.userName           = [[rs resultDictionary] objectForKey:@"userName"];
    model.cardNo             = [[rs resultDictionary] objectForKey:@"cardNo"];
    model.markNo             = [[rs resultDictionary] objectForKey:@"markNo"];
    model.medGuide           = [[rs resultDictionary] objectForKey:@"medGuide"];
    model.productName        = [[rs resultDictionary] objectForKey:@"productName"];
    model.orderNo            = [[rs resultDictionary] objectForKey:@"orderNo"];
    model.finishTime         = [[rs resultDictionary] objectForKey:@"finishTime"];
    return model;
}

+ (void)alertNoticeTable {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        
        // 检查数据库中是否有这个字段，没有的话添加，并更新初始值为空字符串
        [self alertColumn:DB_MSGID db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_ICONURL db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_IMID db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_GENDER db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_POINTNAME db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_REASON db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_NOTICE db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_LOGISNO db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_LOGISCOMPANY db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_LOGISSENDTIME db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_ACTID db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_TITLE db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_TIMESHOW db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_STOPINSDESC db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_TIMID db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_ROOMID db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_USERNAME db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_CARDNO db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_MARKNO db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_MEDGUIDE db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_PRODUCTNAME db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_ORDERNO db:db dbName:DB_TABLENOTICEM];
        [self alertColumn:DB_FINISHTIME db:db dbName:DB_TABLENOTICEM];
        
        [db commit];
        [db close];
    }];
}

+ (void)alertColumn:(NSString *)column db:(FMDatabase *)db dbName:(NSString *)dbName {
    
    if (![db columnExists:column inTableWithName:dbName]) {
        
        NSString *alterTalbeSql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ text",dbName,column];
        BOOL ret = [db executeUpdate:alterTalbeSql, nil];
        
        if (ret) {
            NSString *updateTalbeSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ''",dbName,column];
            [db executeUpdate:updateTalbeSql, nil];
        }
    }
}

+ (NSString *)updateNoticesSql:(AMMNotice *)notice {
    
    NSString *updateSql= [NSString stringWithFormat:
                          @"REPLACE INTO %@ (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@) VALUES ('%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                          DB_TABLENOTICEM,DB_MSGID,DB_TYPE,DB_USERID,DB_MSGBODY,DB_MSGDATE,DB_HOSPID,DB_REGID,DB_PATIENTID,DB_STATUS,DB_ORDERID,DB_ORDERTYPE,DB_CATEGORY,DB_SUBCATEGORY,DB_HOSPNAME,DB_DEPT,DB_DOCNAME,DB_FEE,DB_MEDICALTIME,DB_ITEMNOS,DB_TRADETIME,DB_BEDNO,DB_BALANCE,DB_REPORTID,DB_REPORTNAME,DB_REPORTTYPE,DB_ANYMEDTITLE,DB_ANYMEDSUMMAR,DB_ANYMEDDATE,DB_ANYMEDPIC,DB_ANYMEDURL,DB_DOCHEAD,DB_INPATIENTRECORDID,DB_ALERT,DB_DOCID,DB_CHECKTIME,DB_REGDATE,DB_UNREAD,DB_ICONURL,DB_IMID,DB_GENDER,DB_POINTNAME,DB_REASON,DB_NOTICE,DB_LOGISNO,DB_LOGISCOMPANY,DB_LOGISSENDTIME,DB_ACTID,DB_TITLE,DB_TIMESHOW,DB_STOPINSDESC,DB_TIMID,DB_ROOMID,DB_USERNAME,DB_CARDNO,DB_MARKNO,DB_MEDGUIDE,DB_PRODUCTNAME,DB_ORDERNO,DB_FINISHTIME,
                          [self validateNilString:notice.msgId],
                          [self validateNilString:notice.type],
                          [self validateNilString:notice.userId],
                          [self validateNilString:notice.msgBody],
                          [self validateNilString:notice.msgDate],
                          [self validateNilString:notice.hospId],
                          [self validateNilString:notice.regId],
                          [self validateNilString:notice.patientId],
                          [self validateNilString:notice.status],
                          [self validateNilString:notice.orderId],
                          [self validateNilString:notice.orderType],
                          [self validateNilString:notice.category],
                          [self validateNilString:notice.subCategory],
                          [self validateNilString:notice.hospName],
                          [self validateNilString:notice.dept],
                          [self validateNilString:notice.docName],
                          [self validateNilString:notice.fee],
                          [self validateNilString:notice.medicalTime],
                          [self validateNilString:notice.itemNos],
                          [self validateNilString:notice.tradeTime],
                          [self validateNilString:notice.bedNo],
                          [self validateNilString:notice.balance],
                          [self validateNilString:notice.reportId],
                          [self validateNilString:notice.reportName],
                          [self validateNilString:notice.reportType],
                          [self validateNilString:notice.anyMedTitle],
                          [self validateNilString:notice.anyMedSummary],
                          [self validateNilString:notice.anyMedDate],
                          [self validateNilString:notice.anyMedPic],
                          [self validateNilString:notice.anyMedUrl],
                          [self validateNilString:notice.docHead],
                          [self validateNilString:notice.inpatientRecordId],
                          [self validateNilString:notice.alert],
                          [self validateNilString:notice.docId],
                          [self validateNilString:notice.checkTime],
                          [self validateNilString:notice.regDate],
                          [self validateNilString:notice.unread],
                          [self validateNilString:notice.iconUrl],
                          [self validateNilString:notice.imId],
                          [self validateNilString:notice.gender],
                          [self validateNilString:notice.pointName],
                          [self validateNilString:notice.reason],
                          [self validateNilString:notice.notice],
                          [self validateNilString:notice.logisNo],
                          [self validateNilString:notice.logisCompany],
                          [self validateNilString:notice.logisSendTime],
                          [self validateNilString:notice.actId],
                          [self validateNilString:notice.title],
                          [self validateNilString:notice.timeShow],
                          [self validateNilString:notice.stopInsDesc],
                          [self validateNilString:notice.tImId],
                          [self validateNilString:notice.roomId],
                          [self validateNilString:notice.userName],
                          [self validateNilString:notice.cardNo],
                          [self validateNilString:notice.markNo],
                          [self validateNilString:notice.medGuide],
                          [self validateNilString:notice.productName],
                          [self validateNilString:notice.orderNo],
                          [self validateNilString:notice.finishTime]
                          ];
    return updateSql;
}

+ (void)modifyUnreadByCategory:(NSString *)userid category:(NSString *)category {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        
        BOOL ret = NO;
        
        NSString *updateSql= [NSString stringWithFormat:
                              @"update %@ set %@ = %@ where %@ = '%@'" ,
                              DB_TABLENOTICEM,DB_UNREAD,@"0",DB_CATEGORY,category ];
        
        if(![category isEqualToString:@"0"] && userid != nil) {
            
            updateSql= [NSString stringWithFormat:
                        @"update %@ set %@ = %@ where %@ = '%@' and %@ = '%@'" ,
                        DB_TABLENOTICEM,DB_UNREAD,@"0",DB_CATEGORY,category,DB_USERID,userid];
        }
        
        ret = [db executeUpdate:updateSql];
        
        [db commit];
        [db close];
    }];
    
}

+(void)modifyUnread:(NSString *)index {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        
        BOOL ret = NO;
        
        NSString *updateSql= [NSString stringWithFormat:
                              @"update %@ set %@ = %@ where %@ = '%@'" ,
                              DB_TABLENOTICEM,DB_UNREAD,@"0",@"id",index ];
        
        ret = [db executeUpdate:updateSql];
        
        [db commit];
        [db close];
        
    }];
}

+ (void)deleteNotices:(NSString *)userid category:(NSString *)category {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    [queue inDatabase:^(FMDatabase *db){
        
        NSString *delSql= [NSString stringWithFormat:
                           @"DELETE FROM %@ where %@ = '%@' and  %@ = '%@' ",DB_TABLENOTICEM,DB_USERID,userid,DB_CATEGORY,category];
        
        if (userid == nil) {
            [NSString stringWithFormat:
             @"DELETE FROM %@ where %@ = '%@' ",DB_TABLENOTICEM,DB_CATEGORY,category];
        }
        
        BOOL ret = [db executeUpdate:delSql,nil];
        if (ret) {
            
        }
        [db close];
        
    }];
}

+ (void)deleteNotice:(NSString *)index {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    [queue inDatabase:^(FMDatabase *db){
        
        NSString *delSql= [NSString stringWithFormat:
                           @"DELETE FROM %@ where %@ = '%@'",DB_TABLENOTICEM,@"id",index ];
        
        BOOL ret = [db executeUpdate:delSql,nil];
        if (ret) {
            
        }
        [db close];
        
    }];
}

+ (void)deleteNotices:(NSArray *)array {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[AMDBHelper getDBPath]];
    
    [queue inDatabase:^(FMDatabase *db){
        
        [db beginTransaction];
        
        for (int index=0; index<array.count ; index++) {
            NSString *idStr = [array objectAtIndex:index];
            NSString *delSql= [NSString stringWithFormat:
                               @"DELETE FROM %@ where %@ = '%@'",DB_TABLENOTICEM,@"id",idStr ];
            
            BOOL ret = [db executeUpdate:delSql,nil];
            if (!ret) {
                [db rollback];
                break;
            }
        }
        
        
        [db commit];
        [db close];
        
    }];
}

@end
