//
//  TecladoViewController.h
//  TeladoCustomizado
//
//  Created by Daniel Arndt Alves on 4/6/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <UIKit/UIKit.h>

// Criar um delegate
// Definir o protocolo
// Definir o ponteiro que vai indicar quem é o delegate (VC)
// Momento em que o delegate será notificado
@protocol TecladoViewControllerDelegate <NSObject>

-(void)inserirTextoNoCampoTexto:(NSString*)novoTexto;

@end

@interface TecladoViewController : UIViewController

@property (weak, nonatomic) id<TecladoViewControllerDelegate> delegate;

@end
