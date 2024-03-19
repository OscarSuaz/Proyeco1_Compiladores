
/* PROYECTO DE COMPILADORES: ANALIZADOR LÉXICO
	OBJETIVO: Aplicar los conocimientos adquiridos durante la clase de compiladores para implementar un analizador léxico.
	Utilizaremos la gramática propuesta por el grupo para identificar y validar la estructura léxica de un archivo fuente,
	aplicando las características específicas del analizador léxico previamente desarrollado.
	FECHA: 10/10/2023
	ALUMNOS:
		SADAM LÓPEZ
		ROSAURA PAREDES
		FRANCO RUIZ GODOY
		*/


/* 1-EN ESTE CODIGO SE ENCUENTRA TODO LO RELACIONADO AL ANALIZADOR
EXPRESIONES REGULARES, REGLAS, YYLEX()*/



/* DEFINICIONES */
%{
/* BIBLIOTECAS */
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>
#include "tabla_anlex.h"
//#include "lex.yy.h" 

/*Declaraciones para el arreglo de los catálogos*/
#define NUM_CLASES 9
#define TAM_RESERVADA 17
#define TAM_ARITMETICO 6
#define TAM_ASIGNACION 6
#define TAM_SIMB_ESP 9
#define TAM_OP_RELACIONAL 6
extern FILE *yyin; /*yyin se configura para leer la entrada */

int cont_num_ent = 0;
int cont_num_real = 0;
int cont_cadena = 0;


// Catálogo de palabras reservadas
const char *reservada[TAM_RESERVADA] = {"alternative", "big", "evaluate", "instead", "large", "loop", "make", "number", "other", "real", "repeat", "select", "small", "step", "stop", "symbol", "throw"};

// Catálogo de operadores aritméticos
const char *aritmeticos[TAM_ARITMETICO] = {"+", "-", "*", "/", "%", "^"};

// Catálogo de operadores de asignación
//const char *asignacion[TAM_ASIGNACION] = {"~", "+~", "-~", "*~", "/~", "$~"};

// Catálogo de símbolos especiales
const char *simb_especial[TAM_SIMB_ESP] = {"(", ")", "{", "}", "[", "]", ",", ";", ":"};

// Catálogo de operadores relacionales
const char *op_relacionales[TAM_OP_RELACIONAL] = {"<", ">", "<=", ">=", "==", "!="};

/*Función que busca un lexema dentro del catálogo de palabras reservadas.
Devuelve la posición en el arreglo si encuentra el lexema, de lo contrario devuelve -1.*/
int posc_Cat_R(char *lexema) {
    for (int i = 0; i < TAM_RESERVADA; i++) {
        if (strcmp(lexema, reservada[i]) == 0) {
            return i;
        }
    }
    return -1;
}

/* Función que busca un operador dentro del catálogo de operadores de asignación.
Devuelve la posición en el arreglo si encuentra el operador, de lo contrario devuelve -1.*/
// int posc_Cat_Asignacion(char *op) {
//     for (int i = 0; i < TAM_ASIGNACION; i++) {
//         if (strcmp(op, asignacion[i]) == 0) {
//             return i;
//         }
//     }
//     return -1;
// }

/* Función que busca un operador dentro del catálogo de operadores relacionales.
Devuelve la posición en el arreglo si encuentra el operador, de lo contrario devuelve -1.*/
int posc_Cat_OpRelacional(char *op) {
    for (int i = 0; i < TAM_OP_RELACIONAL; i++) {
        if (strcmp(op, op_relacionales[i]) == 0) {
            return i;
        }
    }
    return -1;
}

/* !!!!!!!! HABIAMOS DEFINIDO LAS EXPRESIONES PRIMERO PARA, POSTERIORMENTE, DEFINIR LAS REGLAS   !!!!!!
    PERO NO FUNCIONO, TUVIMOS QUE PONER DIRECTAMENTE LAS EXPRESIONES REGULARES ANTES DE SUS ACCIONES O REGLAS*/ 


    //EXPRESION REGULAR PARA LA CLASE 0 (PALABRAS RESERVADAS)
    //RESERVADA cadena|caracter|else|entero|for|if|real|return|void|while

    //EXPRESION REGULAR PARA LA CLASE 1 (OPERADOR ARITMETICO)
    //OPARITMETICO [\+-\*\/\$]|\+\x20|\-\x20

    //EXPRESION REGULAR PARA LA CLASE 2 (OPERADOR DE ASIGNACION)
    //OP_ASIGNACION ~|\+~|\-~|\*~|\/~|\$~

    //EXPRESION REGULAR PARA LA CLASE 3 (SIMBOLOS ESPECIALES)
    //SIMB_ESPECIAL [\(\)\{\}\[\]&,:]

    //EXPRESION REGULAR PARA LA CLASE 4 (OPERADORES RELACIONALES)
    //OP_RELACIONALES \^\^|\^\x22|\=\=|\^\^\=|\^\x22=|<>

    //EXPRESION REGULAR PARA LA CLASE 5 (IDENTIFICADORES)
    //IDENT ^[a-zA-Z][a-zA-Z0-9]{1,5}_$

    //EXPRESION REGULAR PARA LA CLASE 6 (CONSTANTES NÚMERICAS ENTERAS)
    //CONST_NUMERICA_ENTERA  [-|\+]?[0-9]{1,6}

    //EXPRESION REGULAR PARA LA CLASE 7 (CONSTANTES NÚMERICAS REALES)
    //CONST_NUMERICA_REALES \d*\.\d*

    //EXPRESION REGULAR PARA LA CLASE 8 (CONSTANTES CADENAS)
    //CONST_CADENAS ^\x22[^\x22]{0,38}\x22$

    //EXPRESION REGULAR PARA LA CLASE 9 (CONSTANTES CARÁCTER)
    //CONST_CARACTER \x27[^.]\x27

    //DELIMITADOR [ \t\n]+

    //ERROR .+

%}


    
/*{COMO PUEDE VER, LAS EXPRESIONES SE PUSIERON DE FORMA DIRECTA (NO LES PUDIMOS PONER UN NOMBRE), DESCONOCEOMS LA RAZON POR LA QUE
EL COMPILADOR NOS MARCABA ERROR SI LO HACIAMOS DEFINIEDNDO PRIMERO LAS EXPRESIONES Y ASISGNANDOLES NOMBRE
PARA POSTERIORMENTE EN LAS REGLAS ESCRIBIR {NOMBRE_EXPRESIO} {ACCION}*/


/* A continuación viene la inserción de Tokens, definido como REGLAS. 
    Palabras reservadas: cuando una de ellas es reconocida, se inserta un token con clase 0
    Operadores simples: se insertan con clase 1
    Operadores de asignación: se insertan con clase 2
    Símbolos de puntuación y agrupación: se insertan con clase 3
    Operadores relacionales: se insertan con clase 4
    Identificadores: comienzan con una letra, seguidos de alfanuméricos y terminan en "_". Se insertan con clase 5
    Literales numéricos enteros. Se insertan con clase 6
    Literales numéricos reales. Se insertan con clase 7
    Literales de cadena. Se insertan con clase 8  


/*REGLAS*/
%%

(alternative|big|evaluate|instead|large|loop|make|number|other|real|repeat|select|small|step|stop|symbol|throw) {insertar_Token(0, posc_Cat_R(yytext));}
[\+\-\*\/\%\^]|\+\x20|\-\x20   {insertar_Token(1, (int)(yytext[0]));}
[(){}\[\];,:]       {insertar_Token(3, (int)(yytext[0]));}
\>|\<|\=\=|\>\=|\<\=|[!\=]    {insertar_Token(4, posc_Cat_OpRelacional(yytext)); }

^[a-zA-Z][a-zA-Z0-9]{1,5}_$  {
                            char* lexema = (char*)malloc(yyleng + 1); // Asigna parte de la memoria para la copia
                            strncpy(lexema, yytext, yyleng);
                            lexema[yyleng] = '\0';
                            insertar_Token(5,insertar_Ident(lexema));
                        } 


[\-|\+]?[0-9]{1,6} {
                    char* lexema = (char*)malloc(yyleng + 1); // Asigna parte de la memoria para la copia
                    strncpy(lexema, yytext, yyleng);
                    lexema[yyleng] = '\0';
                    insertar_LitNum(cont_num_ent,lexema);insertar_Token(6, cont_num_ent++);
                }


[0-9]*\.[0-9]* {
                char* lexema = (char*)malloc(yyleng + 1); // Asigna parte de la memoria para la copia
                strncpy(lexema, yytext, yyleng);
                lexema[yyleng] = '\0';
                insertar_LitReal(cont_num_real,lexema);insertar_Token(7, cont_num_real++); }

^\x22[^\x22]{0,38}\x22$ {
                    char* lexema = (char*)malloc(yyleng + 1); // Asigna parte de la memoria para la copia
                    strncpy(lexema, yytext, yyleng);
                    lexema[yyleng] = '\0';
                    insertar_LitString(cont_cadena,lexema);insertar_Token(8, cont_cadena++);
                }

\x27[^.]\x27     {insertar_Token(9, (int)(yytext[1])); }

[\x20\t\n]+         {/* Ignore */ }

.+              {printf("Error de sintaxis: %s\n", yytext); }

%%

//ARCHIVO MAIN QUE INVOCA TODAS LAS FUNCIONES
//PARA PROBAR EL ANALIZADOR TENEMOS DOS FORMAS (POR TERMINAL O INGRESANDO UN ARCHIVO)
main( argc, argv )
    int argc;
    char **argv;
{
    ++argv, --argc; 
    if ( argc > 0 )
    yyin = fopen( argv[0], "r" ); //PARA QUE FUNCIONE BIEN CON UN ARCHIVO, CADA LEXEMA O PATRON DEBE IR SEGUIDO POR UN SALTO DE LINEA
    else
    yyin = stdin; //entrada estandar (terminal) FUNCIONA CORRECTAMENTE, BASTA CON INGRESAR EL PATRON O LEXEMA Y PRESIONAR ENTER
    //printf("TOKENS:\n");
    yylex();
    imprimirTablas();
}



