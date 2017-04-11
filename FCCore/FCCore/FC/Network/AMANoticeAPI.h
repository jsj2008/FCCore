//
//  AMANoticeAPI.h
//  Anymed
//
//  Created by 周鑫 on 3/27/15.
//  Copyright (c) 2015 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMMNotice.h"
#import "FCCoreHeader.h"

@interface AMANoticeAPI : NSObject

/**
 *  描述:添加所有消息
 *  @param  userId
 用户名
 */
+ (void)getNotices:(NSString *)userId success:(void(^)(NSArray *array))successBlock;
/**
 *  描述:添加某个类别的消息
 *  @param  userId      用户名
 *  @param  category    消息类别
 */
+ (void)getNotices:(NSString *)userId category:(NSString *)category success:(void(^)(NSArray *array))successBlock;
/**
 *  描述:添加一条消息
 *  @param  notice       消息数组
 */
+ (void)addNotice:(AMMNotice *)notice;
/**
 *  描述:添加多条消息
 *  @param  array       消息数组
 */
+ (void)replaceNoticesWithArray:(NSArray * )array;
/**
 *  描述:已读一类消息
 *  @param  userId      用户名
 *  @param  category    消息类别
 */
+ (void)modifyUnreadByCategory:(NSString *)userId category:(NSString *)category;
/**
 *  描述:已读一条消息
 *  @param  index      消息ID
 */
+ (void)modifyUnread:(NSString *)index;
/**
 *  描述:添加一条消息
 *  @param  noticeDic   消息字典
 */
+ (void)addNoticeFromApns:(NSDictionary *)noticeDic;
/**
*  描述:删除一大类消息
*  @param  userid      用户名
*  @param  category    消息类别
*/
+ (void)deleteNotices:(NSString *)userid category:(NSString *)category;
/**
 *  描述:删除一条消息
 *  @param  index      消息ID
 */
+ (void)deleteNotice:(NSString *)index;
/**
 *  描述:删除一组消息
 *  @param  array      消息ID数组
 */
+ (void)deleteNotices:(NSArray *)array;

/**
 *  描述: 拉取消息列表
 *  @param  msgStartTime	i64	消息拉取的开始时间戳	optional
 *  return pushmsgDto	list<NXTFRespDto.PushmsgDto>	消息列表
 *  return msgEndTime	i64	消息拉取的结束时间戳	optional
 */
+ (void)pullMsgs:(int64_t)msgStartTime success:(void(^)(NXTFPullMsgsResp *pullMsgsResp))successBlock failure:(void(^)(NSError *error))failureBlock;


@end
