//
//  ViewController.h
//  AssetsGestos
//
//  Created by Daniel Arndt Alves on 3/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <UIKit/UIKit.h>

// Manipular fotos/videos sem abrir o UIImagePickerController
@import AssetsLibrary;

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) ALAssetsLibrary *bibliotecaFotos;

@end
