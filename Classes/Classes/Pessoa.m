//
//  Pessoa.m
//  Classes
//
//  Created by Daniel Arndt Alves on 2/1/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "Pessoa.h"

@implementation Pessoa

-(void)falar {
    NSLog(@"O meu nome é fulano!");
}

-(int)getIdade {
    return idade;
}

-(void)falarTexto:(NSString *)fala {
    NSLog(@"%@", fala);
}

-(void)andarRua1:(NSString *)rua1 eRua2:(NSString *)rua2 {
    NSLog(@"Vou andar para a rua %@ e depois para %@", rua1, rua2);
}

@end
