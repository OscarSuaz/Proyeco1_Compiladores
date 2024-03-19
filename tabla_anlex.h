//2- CODIGO HEADER, AQUI SE DEFINEN LAS FUNCIONES Y ESTRUCTURAS DE DATOS A USAR PARA ALMACENAR
//LAS TABLAS Y LA LISTA DE TOKENS (CON LISTAS LIGADAS)
//header (.h) tabla_anlex.h

#ifndef TABLA_ANLEX_H
#define TABLA_ANLEX_H

// Define la estructura para un nodo de la tabla de simbolo
typedef struct NodoTabla {
    int posicion;
    const char* lexema;
    struct NodoTabla* siguiente;
} NodoTabla;

typedef struct NodoToken {
    int clase;
    int posicion;
    struct NodoToken* siguiente;
} NodoToken;

// Funciones para operar con la tabla de símbolos

int insertar_Ident(const char* lex);
void insertar_LitNum(int posc, const char* lex);
void insertar_LitReal(int posc, const char* lex);
void insertar_LitString(int posc, const char* lex);
int buscar_Ident(const char* lex);

void insertar_Token(int clase, int posc);

void imprimirTablas();
#endif