//
//  LLCollectionSectionDecorateView.h
//  CollectionViewSectionStyle
//
//  Created by 刘江 on 2020/3/14.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class LLCollectionSectionDecorationModel;
@interface LLCollectionViewSectionLayoutAttributes  : UICollectionViewLayoutAttributes
@property (nonatomic, strong) LLCollectionSectionDecorationModel *configModel;

@end


extern NSString *const LLCollectionSectionDecorateViewKind;
@interface LLCollectionSectionDecorateView : UICollectionReusableView
@property (nonatomic, strong) UIView *backgroundView;


@end

NS_ASSUME_NONNULL_END
