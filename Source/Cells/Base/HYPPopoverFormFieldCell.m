//
//  HYPPopoverFormFieldCell.m

//
//  Created by Elvis Nunez on 08/10/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "HYPPopoverFormFieldCell.h"

@interface HYPPopoverFormFieldCell () <HYPTextFormFieldDelegate, UIPopoverControllerDelegate>

@property (nonatomic, strong) UIViewController *contentViewController;
@property (nonatomic) CGSize contentSize;

@end

@implementation HYPPopoverFormFieldCell

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame contentViewController:(UIViewController *)contentViewController
               andContentSize:(CGSize)contentSize
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    _contentViewController = contentViewController;
    _contentSize = contentSize;

    return self;
}

#pragma mark - Getters

- (UIPopoverController *)popoverController
{
    if (_popoverController) return _popoverController;

    _popoverController = [[UIPopoverController alloc] initWithContentViewController:self.contentViewController];
    _popoverController.delegate = self;
    _popoverController.popoverContentSize = self.contentSize;
    _popoverController.backgroundColor = [UIColor whiteColor];

    return _popoverController;
}

#pragma mark - HYPTextFormFieldDelegate

- (void)textFormFieldDidBeginEditing:(HYPTextFormField *)textField
{
    [self updateContentViewController:self.contentViewController withField:self.field];

    if (!self.popoverController.isPopoverVisible) {
        [self.popoverController presentPopoverFromRect:self.bounds
                                                inView:self
                              permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown
                                              animated:YES];
    }
}

#pragma mark - Private methods

- (void)updateContentViewController:(UIViewController *)contentViewController withField:(HYPFormField *)field
{
    abort();
}

- (void)updateFieldWithDisabled:(BOOL)disabled
{
    self.textField.enabled = !disabled;
}

- (void)updateWithField:(HYPFormField *)field
{
    self.iconButton.hidden = field.disabled;

    self.textField.hidden         = (field.sectionSeparator);
    self.textField.inputValidator = [self.field inputValidator];
    self.textField.formatter      = [self.field formatter];
    self.textField.typeString     = field.typeString;
    self.textField.enabled        = !field.disabled;
    self.textField.valid          = field.valid;
}

- (CGRect)frameForTextField
{
    CGFloat marginX = HYPTextFormFieldCellMarginX;
    CGFloat marginTop = HYPTextFormFieldCellTextFieldMarginTop;
    CGFloat marginBotton = HYPTextFormFieldCellTextFieldMarginBottom;

    CGFloat width = CGRectGetWidth(self.frame) - (marginX * 2);
    CGFloat height = CGRectGetHeight(self.frame) - marginTop - marginBotton;
    CGRect frame = CGRectMake(marginX, marginTop, width, height);

    return frame;
}

@end
