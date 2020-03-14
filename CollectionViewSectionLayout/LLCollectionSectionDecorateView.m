//
//  LLCollectionSectionDecorateView.m
//  CollectionViewSectionStyle
//
//  Created by 刘江 on 2020/3/14.
//

#import "LLCollectionSectionDecorateView.h"
#import "LLCollectionSectionDecorationModel.h"

NSString *const LLCollectionSectionDecorateViewKind = @"com.LLCollectionView.sectionDecoration";
@implementation LLCollectionSectionDecorateView
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    LLCollectionViewSectionLayoutAttributes *attr = (LLCollectionViewSectionLayoutAttributes *)layoutAttributes;
    
    if (attr.configModel) {
        LLCollectionSectionDecorationModel *model = attr.configModel;
        UIView *view = self;
        self.backgroundView.frame = view.bounds;
        [view addSubview:self.backgroundView];
        view.layer.backgroundColor = model.backgroundColor.CGColor;
        view.layer.shadowColor = model.shadowColor.CGColor;
        view.layer.shadowOffset = model.shadowOffset;
        view.layer.shadowOpacity = model.shadowOpacity;
        view.layer.shadowRadius = model.shadowRadius;
        view.layer.cornerRadius = model.cornerRadius;
        view.layer.borderWidth = model.borderWidth;
        view.layer.borderColor = model.borderColor.CGColor;
    }
}
@end


@implementation LLCollectionViewSectionLayoutAttributes

@end
