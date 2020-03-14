//
//  LLCollectionViewSectionLayoutConfig.h
//  CollectionViewSectionStyle
//
//  Created by 刘江 on 2020/3/14.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#ifndef LLCollectionSectionDecorationLayoutConfig_h
#define LLCollectionSectionDecorationLayoutConfig_h

typedef enum : NSUInteger {
    LLCollectionViewLayoutAlignmentTypeBySystem = 0,
    LLCollectionViewLayoutAlignmentTypeLeft,
    LLCollectionViewLayoutAlignmentTypeCenter,
    LLCollectionViewLayoutAlignmentTypeRight,
    LLCollectionViewLayoutAlignmentTypeRightAndStartR,
} LLCollectionViewLayoutAlignmentType;

typedef enum : NSUInteger {
    LLCollectionViewSectionDecorateAreaAll = 0,
    LLCollectionViewSectionDecorateAreaHeaderAndCell,
    LLCollectionViewSectionDecorateAreaFooterAndCell,
    LLCollectionViewSectionDecorateAreaCell,
    LLCollectionViewSectionDecorateAreaNone,
} LLCollectionViewSectionDecorateArea;

@class LLCollectionSectionDecorationModel;
@class LLCollectionSectionDecorationLayout;
@protocol UICollectionViewSectionDecorateAttributes <NSObject>
@property (assign, nonatomic) LLCollectionViewSectionDecorateArea decorateAreaKind;//默认 LLCollectionViewSectionDecorateAreaNone
@property (assign, nonatomic) UIEdgeInsets decorateAreaPadding; //默认 //UIEdgesZero
//边框
@property (assign, nonatomic) CGFloat borderWidth; //默认 nil
@property (strong, nonatomic) UIColor *borderColor; //默认 nil

// 背景
@property (strong, nonatomic) UIColor *backgroundColor; //默认 #f2f2f2
@property (strong, nonatomic) UIView *backgroundView; //默认 nil

// 投影相关
@property (strong, nonatomic) UIColor *shadowColor; //默认 nil
@property (assign, nonatomic) CGSize shadowOffset;
@property (assign, nonatomic) CGFloat shadowOpacity;
@property (assign, nonatomic) CGFloat shadowRadius;

// 圆角
@property (assign, nonatomic) CGFloat cornerRadius; //默认 nil
@end

@protocol UICollectionViewSectionDecorationFlowLayout <UICollectionViewDelegateFlowLayout>

/**
 @abstract 配置分区背景试图样式
 @param collectionView collectionView description
 @param collectionViewLayout collectionViewLayout description
 @param section section description
 */
- (LLCollectionSectionDecorationModel *)collectionView:(UICollectionView *)collectionView layout:(LLCollectionSectionDecorationLayout*)collectionViewLayout configModelForSection:(NSInteger)section;


@end

#endif /* LLCollectionSectionDecorationLayoutConfig_h */
