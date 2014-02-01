//
//  Pessoa.m
//  Classes
//
//  Created by Daniel Arndt Alves on 2/1/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "Pessoa.h"

@implementation Pessoa

// Construtor
- (id)init
{
    self = [super init];
    if (self) {
        self.nome = @"Fulano";
        idade = 10;
        saldoBancario = 1.00;
    }
    return self;
}

// Construtor Customizado
- (id)initWithNome:(NSString *)nome withIdade:(int)pIdade
{
    self = [super init];
    if (self) {
        self.nome = nome;
        idade = pIdade;
        saldoBancario = 1.0;
    }
    return self;
}

-(void)falar {
    NSLog(@"O meu nome é %@!", _nome);
    NSLog(@"O meu nome é %@!", self.nome);
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
