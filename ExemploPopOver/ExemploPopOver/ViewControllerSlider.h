//
//  ViewControllerSlider.h
//  ExemploPopOver
//
//  Created by Daniel Arndt Alves on 3/15/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <UIKit/UIKit.h>

// Lista de métodos que poderão ser acionados dentro do delegate quando algum evento ocorrer dentro de nossa classe
@protocol ViewControllerSliderDelegate <NSObject>

@required
-(void) acionaramSliderEACorMudouPara:(UIColor *)novaCor;

@end

@interface ViewControllerSlider : UIViewController

// Espaço em memória onde vamos guardar a instância do objeto que vai ser acionado, quando algo ocorrer.
// Estamos progrmando sem saber se aqui nesta variável qual a classe pertence o objeto que será armazenado.
// Por mais que nesta property possa ser colocado qualquer tipo de objeto, obrigatoriamente, este objeto deverá implmenentar o protocolo
@property (nonatomic, weak) id <ViewControllerSliderDelegate> delegate;

@end
