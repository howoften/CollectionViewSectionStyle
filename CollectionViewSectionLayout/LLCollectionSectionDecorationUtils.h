//
//  LLCollectionSectionDecorationUtils.h
//  CollectionViewSectionStyle
//
//  Created by 刘江 on 2020/3/14.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLCollectionSectionDecorationUtils : NSObject

//获取cell间距
+ (CGFloat)evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:(UICollectionViewFlowLayout *)layout atIndex:(NSInteger)sectionIndex;

//获取用户设置CollectionView 对应section的 sectionInset
+ (UIEdgeInsets)evaluatedSectionInsetForItemWithCollectionLayout:(UICollectionViewFlowLayout *)layout atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
