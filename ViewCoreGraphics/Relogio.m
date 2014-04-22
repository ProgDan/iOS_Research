//
//  Relogio.m
//  ViewCoreGraphics
//
//  Created by Eduardo Lima on 11/30/13.
//  Copyright (c) 2013 personal. All rights reserved.
//

#import "Relogio.h"



@interface Relogio ()

@property (nonatomic, assign) float segundos;
@property (nonatomic, assign) float minutos;
@property (nonatomic, assign) float hora;

@property (nonatomic, assign) float anguloSegundos;
@property (nonatomic, assign) float anguloMinutos;
@property (nonatomic, assign) float anguloHora;

@end


@implementation Relogio

- (id)initWithFrame:(CGRect)frame andTimeDifference:(int)difference
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSDate *dataAtual = [NSDate date];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"hh:mm:ss"];
        
        NSString *horaTexto = [format stringFromDate:dataAtual];
        NSLog(@"%@", horaTexto);
        
        NSArray *componentes = [horaTexto componentsSeparatedByString:@":"];
        
        self.segundos = [componentes[2] floatValue];
        self.minutos = [componentes[1] floatValue];
        self.hora = [componentes[0] floatValue] + difference;
        
        self.anguloSegundos = -(2 * M_PI / 60) * self.segundos;
        self.anguloMinutos = -(2 * M_PI / 60) * self.minutos;
        self.anguloHora = -(2 * M_PI / 12) * self.hora;
        
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    CGContextRef contexto = UIGraphicsGetCurrentContext();
    
    //Setando a cor preta
    CGContextSetRGBFillColor(contexto, 0, 0, 0, 1);
    
    //Desenhando um circulo
    CGContextFillEllipseInRect(contexto, rect);
    
    CGContextSetRGBFillColor(contexto, 1, 1, 1, 1);
    CGContextFillEllipseInRect(contexto, CGRectMake(10, 10, rect.size.width - 20, rect.size.height - 20));
    
    //inicio do traço - SEGUNDOS
    CGContextMoveToPoint(contexto, rect.size.width/2, rect.size.height/2);
    
    
    float seno = sin(self.anguloSegundos) * 100;
    float cosseno = cos(self.anguloSegundos) * 100;
    
    
    //final do traço
    CGContextAddLineToPoint(contexto, rect.size.width/2 - seno, rect.size.height/2 - cosseno);
    
    CGContextSetRGBStrokeColor(contexto, 1, 0, 0, 1);
    
    //Finalizar o traço
    CGContextStrokePath(contexto);
    
    
    //Atualizar o angulo
    self.anguloSegundos += -2 * M_PI / 60;
    
    
    //inicio do traço - MINUTOS
    CGContextMoveToPoint(contexto, rect.size.width/2, rect.size.height/2);
    
    
    seno = sin(self.anguloMinutos) * 100;
    cosseno = cos(self.anguloMinutos) * 100;
    
    
    //final do traço
    CGContextAddLineToPoint(contexto, rect.size.width/2 - seno, rect.size.height/2 - cosseno);
    
    CGContextSetRGBStrokeColor(contexto, 0, 0, 0, 1);
    CGContextSetLineWidth(contexto, 2);
    //Finalizar o traço
    CGContextStrokePath(contexto);
    
    
    //Atualizar o angulo
    self.anguloMinutos += -2 * M_PI / 3600;
    
    
    
    //inicio do traço - HORA
    CGContextMoveToPoint(contexto, rect.size.width/2, rect.size.height/2);
    
    
    seno = sin(self.anguloHora) * 70;
    cosseno = cos(self.anguloHora) * 70;
    
    
    //final do traço
    CGContextAddLineToPoint(contexto, rect.size.width/2 - seno, rect.size.height/2 - cosseno);
    
    CGContextSetRGBStrokeColor(contexto, 0, 0, 0, 1);

    CGContextSetLineWidth(contexto, 2);
    
    //Finalizar o traço
    CGContextStrokePath(contexto);

    
    
    //Atualizar o angulo
    self.anguloHora += -(2 * M_PI) / (3600 * 12);
    
    
    
    
    
    
    
    
    
    
    
    //setNeedsDisplay - realiza algumas chamadas e executa novamente o drawRect
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:NO];
}


@end
