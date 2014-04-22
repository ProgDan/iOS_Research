//
//  TecladoViewController.h
//  TecladoCustomizado
//
//  Created by Eduardo Lima on 4/6/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

//Criar um delegate
//Definir o protocolo
//Definir o ponteiro que vai indicar quem é o delegate (VC)
//Momento que o delegate será notificado
@protocol TecladoViewControllerDelegate <NSObject>

-(void)inserirTextoNoCampoTexto:(NSString*)novoTexto;

@end

@interface TecladoViewController : UIViewController

//Indica para quem as chamadas dos metodos do protocolo será enviado
@property(nonatomic,weak) id<TecladoViewControllerDelegate> delegate;

@end
