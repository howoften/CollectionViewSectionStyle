//
//  LLCollectionSectionDecorationUtils.m
//  CollectionViewSectionStyle
//
//  Created by 刘江 on 2020/3/14.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import "LLCollectionSectionDecorationUtils.h"

@implementation LLCollectionSectionDecorationUtils
+ (CGFloat)evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:(UICollectionViewFlowLayout *)layout atIndex:(NSInteger)sectionIndex {
    CGFloat minimumInteritemSpacing = layout.minimumInteritemSpacing;
    if ([layout.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {

        id delegate = layout.collectionView.delegate;
        minimumInteritemSpacing = [delegate collectionView:layout.collectionView layout:layout minimumInteritemSpacingForSectionAtIndex:sectionIndex];
    }
    return minimumInteritemSpacing;
}

+ (UIEdgeInsets)evaluatedSectionInsetForItemWithCollectionLayout:(UICollectionViewFlowLayout *)layout atIndex:(NSInteger)index{
    UIEdgeInsets sectionInset = layout.sectionInset;
    if ([layout.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {

        id delegate = layout.collectionView.delegate;
        sectionInset = [delegate collectionView:layout.collectionView layout:layout insetForSectionAtIndex:index];
    }
    return sectionInset;
}
@end
