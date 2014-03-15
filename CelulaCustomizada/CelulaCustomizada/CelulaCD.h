//
//  CelulaCD.h
//  CelulaCustomizada
//
//  Created by Daniel Arndt Alves on 3/15/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CelulaCD : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgvCapa;
@property (weak, nonatomic) IBOutlet UILabel *lblTitulo;
@property (weak, nonatomic) IBOutlet UILabel *lblArtista;
@property (weak, nonatomic) IBOutlet UILabel *lblAno;
@property (weak, nonatomic) IBOutlet UILabel *lblPreco;

@end
