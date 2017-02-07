//
//  NSObject+XGRuntime.h
//
//  Created by 小果 on 2017/2/7.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XGRuntime)

/**
 *  将 ’字典数组’ 转换成当前模型的对象数组
 *
 *  @param array 字典数组
 *
 *  @return 模型对象数组
 */
+ (NSArray *)xg_objectsWithArray:(NSArray *)array;

/**
 *  返回当前类的所有属性
 *
 *  @return 属性名称的数组
 */
+ (NSArray *)xg_propertiesList;

/**
 *  返回当前类的所有成员变量的属性
 *
 *  @return 成员变量的数组
 */
+ (NSArray *)xg_ivarsList;

@end
