//
//  ComprasNoAplicativoViewController.h
//  ComprasNoAplicativo
//
//  Created by Fernando Dutra Pastor on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GerenciadorCompras.h"

@interface ComprasNoAplicativoViewController : UIViewController <GerenciadorComprasDelegate>{
    
    
    GerenciadorCompras *minhaLoja;
    
    SKProduct *produtoASerComprado;
    
}

-(IBAction)comprarProduto:(id)sender;
-(IBAction)infoProduto:(id)sender;

@end
