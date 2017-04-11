//
//  AMAAppSystemAPI.h
//  FCNetworkApi
//
//  Created by wangzeyu on 16/4/7.
//  Copyright © 2016年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCoreHeader.h"

@interface AMAAppSystemAPI : NSObject

/** add by 3.5.0 thrift wangzeyu
 *  描述:查询首页切换图片
 *  认证方式:	默认签名
 *  param  header      请求头信息
 *  @param  weight       宽度    string
 *  @param  height       高度    string
 *  param  timeFlag     更新时间   string
 *  return ChangePics   首页切换图片返回信息    list
 *  return header      响应头信息 (status (i32)状态码;msg	(string)返回结果描述)
 */

+(void)getStartPicsReq:(int32_t)weight height:(int32_t)height prevPicVer:(NSString *)prevPicVer success:(void(^)(NXTFGetStartPicsResp *startPicsResp))successBlock failure:(void(^)(NSError *error))failureBlock;
@end
