//
//  HMStatus.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMStatus.h"
#import "HMUser.h"
#import "HMPhoto.h"
#import "NSDate+MJ.h"
#import "RegexKitLite.h"
#import "HMRegexResult.h"
#import "HEEmotionTool.h"
#import "HEEmotion.h"
#import "HEEmotionTextAttachment.h"

typedef enum{  //只有在 是否是转发微博， 用户，正文都这只好时才进行普通文本到富文本之间的转换。
    Step_0, // 默认
    Step_1, // 设置第一个值
    Step_2, // 设置第二个值
    Step_finished
} Step;

@interface HMStatus ()
@property (nonatomic,assign) Step step;

@end

@implementation HMStatus


- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [HMPhoto class]};
}
// 根据创建时间,
-(NSString*)created_at{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    //在真机上面必须加上这句话
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }

}
// 设置来源
-(void)setSource:(NSString *)source{
    if (source.length == 0) {
        _source = [source copy];
        return;
    }
    NSRange range;
    range.location = [source rangeOfString:@">"].location +1;
    range.length = [source rangeOfString:@"</a>"].location - range.location;
    NSString *subStr = [source substringWithRange:range];
    _source = [NSString stringWithFormat:@"来自%@",subStr];
}

/** 设置转发微博*/
-(void) setRetweeted_status:(HMStatus *)retweeted_status{
    _retweeted_status = retweeted_status;
    self.isRetweeted = NO;
    _retweeted_status.isRetweeted = YES;
}

/** 设置是否是转发*/
-(void) setIsRetweeted:(BOOL)isRetweeted{
    _isRetweeted = isRetweeted;
    [self createAttributedText];
    
}

/** 设置微博正文*/
-(void) setText:(NSString *)text{
    _text = [text copy];
     [self createAttributedText];
}

/** 设置用户*/
-(void) setUser:(HMUser *)user{
    _user = user;
    [self createAttributedText];
}

/** 创建富文本*/
- (void)createAttributedText{
    // 是否是转发微博， 用户，正文都设置好了才进行普通文本到富文本之间的转换。
    if(self.user !=nil && self.text != nil){
        if (self.isRetweeted) { //转发微博
            NSString *totalStr = [NSString stringWithFormat:@"@%@ %@",self.user.name,self.text];
            self.attributedText = [self attributedStringWithText:totalStr];
        }else{ // 原微博
            self.attributedText = [self attributedStringWithText:self.text];
        }
    }
    
}

/** 通过正则表达式找出所有的表情*/
- (NSArray *)regexResultsWithText:(NSString *)text{
    
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    
    // 匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        HMRegexResult *regexResult = [[HMRegexResult alloc]init];
        regexResult.string = *capturedStrings;
        regexResult.range = *capturedRanges;
        regexResult.emotion = YES;
        [regexResults addObject:regexResult];
    }];
    
    //匹配非表情,  使用正则进行分割
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        HMRegexResult *regexResult = [[HMRegexResult alloc]init];
        regexResult.string = *capturedStrings;
        regexResult.range = *capturedRanges;
        regexResult.emotion = NO;
        [regexResults addObject:regexResult];
    }];
    
    // 按range进行排序
    // 排序
    [regexResults sortUsingComparator:^NSComparisonResult(HMRegexResult *rr1, HMRegexResult *rr2) {
        NSUInteger loc1 = rr1.range.location;
        NSUInteger loc2 = rr2.range.location;
        return [@(loc1) compare:@(loc2)];
    }];
    
    return regexResults;
}


- (NSAttributedString *)attributedStringWithText:(NSString *)text{
    
    /** 将表情与文字分离后的数组*/
    NSArray *attributedResult = [self regexResultsWithText:text];
    
    /** 富文本字符串, 最终的返回值*/
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]init];
    
    [attributedResult enumerateObjectsUsingBlock:^(HMRegexResult *regexResult, NSUInteger idx, BOOL * _Nonnull stop) {
        HEEmotion *emotion = nil;
        if (regexResult.isEmotion) { //是表情
            emotion = [HEEmotionTool emotionWithDesc:regexResult.string];
        }
        if (emotion) { //正则匹配出是表情， 并且在表情模型中找到了
            
            // 创建附件
            HEEmotionTextAttachment *emotionTextAttachment = [[HEEmotionTextAttachment alloc]init];
            
            // 赋值表情model
            emotionTextAttachment.emotion = emotion;
            emotionTextAttachment.bounds = CGRectMake(0, -3, HMStatusOrginalTextFont.lineHeight, HMStatusOrginalTextFont.lineHeight);
            
            // 创建富文本字符串
            NSAttributedString *emotionStr =[NSAttributedString attributedStringWithAttachment:emotionTextAttachment];
            
            // 拼接
            [attributedString appendAttributedString:emotionStr];
        }else{ //不是， 或者没有找到
            
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc]initWithString:regexResult.string];
            
            // 匹配#话题#
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [regexResult.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:HMStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:HMLinkText value:*capturedStrings range:*capturedRanges];
            }];
            
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-_]+";
            [regexResult.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:HMStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:HMLinkText value:*capturedStrings range:*capturedRanges];
            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [regexResult.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:HMStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:HMLinkText value:*capturedStrings range:*capturedRanges];
            }];
            
            [attributedString appendAttributedString:substr];
        }
        
    }];
    // 设置字体
    [attributedString addAttribute:NSFontAttributeName value:HMStatusRichTextFont range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}






@end
