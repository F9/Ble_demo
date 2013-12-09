//
//  DetailViewController.h
//  bleranging
//
//  Created by Francesco Novelli on 06/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
