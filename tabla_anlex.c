// 3- COMPLEMENTO HEADER: EN ESTE CODIGO YA SE DEFINEN LAS ACCIONES DE LAS FUNCIONES
//Las siguientes funciones inserta los componentes léxicos para luego verificar su token  
//   - Inserta un componente léxico en la tabla correspondiente. 
//   - Si el componente léxico ya existe, se devuelve su posición. 
//   - Si no, se agrega al final de la lista y se devuelve la posición donde fue insertado.*/

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "tabla_anlex.h"

NodoTabla* tablaIden = NULL; //Tabla de identificadores
NodoTabla* tablaLitNum = NULL; //Tabla de literales Númericas
NodoTabla* tablaLitReal = NULL; //Tabla de literales Reales
NodoTabla* tablaLitString = NULL; //Tabla de cadenas

NodoToken* tablaToken = NULL;

int insertar_Ident(const char* lex) {
   if (tablaIden == NULL){ // Caso donde la tabla está vacía, se crea un nuevo nodo
      NodoTabla* nuevoNodo = (NodoTabla*)malloc(sizeof(NodoTabla));
      nuevoNodo-> posicion = 0; // Como es el primer elemento, su posición es 0
      nuevoNodo-> lexema = lex;
      nuevoNodo-> siguiente = tablaIden;  // En este caso, sería NULL
      tablaIden = nuevoNodo; // El nuevo nodo pasa a ser la cabeza de la lista
      return 0;
   }else{ // El nuevo nodo pasa a ser la cabeza de la lista
      NodoTabla* nuevoNodo = (NodoTabla*)malloc(sizeof(NodoTabla));
      nuevoNodo-> posicion = buscar_Ident(lex); // En este caso, se busca la posición del identificador
      nuevoNodo-> lexema = lex;
      nuevoNodo-> siguiente = NULL;
      NodoTabla* actual = tablaIden; // Se comienza desde la cabeza de la lista
        while (actual->siguiente != NULL) { // Se recorre la lista hasta llegar al último nodo
            actual = actual->siguiente;
        }
        actual->siguiente = nuevoNodo;
        return nuevoNodo-> posicion; // Se devuelve la posición donde fue insertado
   }
}

int buscar_Ident(const char* lex) {
    NodoTabla* actual = tablaIden;
    int i = 0;
    while (actual != NULL) {
        if (strcmp(actual -> lexema,lex) == 0){
            return actual -> posicion;
        }
        actual = actual->siguiente;
        i++;
    }
    return i;
}


void insertar_LitNum(int posc, const char* lex) {    
if (tablaLitNum == NULL){
      NodoTabla* nuevoNodo = (NodoTabla*)malloc(sizeof(NodoTabla));
      nuevoNodo-> posicion = posc;
      nuevoNodo-> lexema = lex;
      nuevoNodo-> siguiente = tablaLitNum;
      tablaLitNum = nuevoNodo;
   }else{
      NodoTabla* nuevoNodo = (NodoTabla*)malloc(sizeof(NodoTabla));
      nuevoNodo-> posicion = posc;
      nuevoNodo-> lexema = lex;
      nuevoNodo-> siguiente = NULL;
      NodoTabla* actual = tablaLitNum;
        while (actual->siguiente != NULL) {
            actual = actual->siguiente;
        }
        actual->siguiente = nuevoNodo;
   }
}

void insertar_LitReal(int posc, const char* lex) {
if (tablaLitReal == NULL){
      NodoTabla* nuevoNodo = (NodoTabla*)malloc(sizeof(NodoTabla));
      nuevoNodo-> posicion = posc;
      nuevoNodo-> lexema = lex;
      nuevoNodo-> siguiente = tablaLitReal;
      tablaLitReal = nuevoNodo;
   }else{
      NodoTabla* nuevoNodo = (NodoTabla*)malloc(sizeof(NodoTabla));
      nuevoNodo-> posicion = posc;
      nuevoNodo-> lexema = lex;
      nuevoNodo-> siguiente = NULL;
      NodoTabla* actual = tablaLitReal;
        while (actual->siguiente != NULL) {
            actual = actual->siguiente;
        }
        actual->siguiente = nuevoNodo;
   }


}

void insertar_LitString(int posc, const char* lex) {
if (tablaLitString == NULL){
      NodoTabla* nuevoNodo = (NodoTabla*)malloc(sizeof(NodoTabla));
      nuevoNodo-> posicion = posc;
      nuevoNodo-> lexema = lex;
      nuevoNodo-> siguiente = tablaLitString;
      tablaLitString = nuevoNodo;
   }else{
      NodoTabla* nuevoNodo = (NodoTabla*)malloc(sizeof(NodoTabla));
      nuevoNodo-> posicion = posc;
      nuevoNodo-> lexema = lex;
      nuevoNodo-> siguiente = NULL;
      NodoTabla* actual = tablaLitString;
        while (actual->siguiente != NULL) {
            actual = actual->siguiente;
        }
        actual->siguiente = nuevoNodo;
   }


}

void insertar_Token(int clase, int posc){
    if (tablaToken == NULL){
      NodoToken* nuevoNodo = (NodoToken*)malloc(sizeof(NodoToken));
      nuevoNodo-> clase = clase;
      nuevoNodo-> posicion = posc;
      nuevoNodo-> siguiente = tablaToken;
      tablaToken = nuevoNodo;
   }else{
      NodoToken* nuevoNodo = (NodoToken*)malloc(sizeof(NodoToken));
      nuevoNodo-> clase = clase;
      nuevoNodo-> posicion = posc;
      nuevoNodo-> siguiente = NULL;
      NodoToken* actual = tablaToken;
        while (actual->siguiente != NULL) {
            actual = actual->siguiente;
        }
        actual->siguiente = nuevoNodo;
   }

}

void imprimirTablas() { //Función que imprime el contenido de las tablas y los tokens
    struct NodoTabla* actual;  // Definimos un puntero para recorrer las listas de las tablas.
    printf("\nTabla de Simbolos (Identificadores):\n"); // Inicializamos el puntero con el inicio de la lista de identificadores.
    actual = tablaIden;  // Mientras no lleguemos al final de la lista imprimimos la posición y el lexema del nodo actual.
    while (actual != NULL) {
        printf("\n(%d,%s)\n",actual->posicion,actual->lexema);
        actual = actual->siguiente; // Nos movemos al siguiente nodo.
    }
    printf("\n");

    printf("\nTabla de literales (numericas):\n");
    actual = tablaLitNum;
    while (actual != NULL) {
        printf("\n(%d,%s)\n",actual->posicion,actual->lexema);
        actual = actual->siguiente;
    }
    printf("\n");


    printf("\nTabla de literales (numericas REALES):\n");
    actual = tablaLitReal;
    while (actual != NULL) {
        printf("\n(%d,%s)\n",actual->posicion,actual->lexema);
        actual = actual->siguiente;
    }
    printf("\n");


    printf("\nTabla de literales (cadenas):\n");
    actual = tablaLitString;
    while (actual != NULL) {
        printf("\n(%d,%s)\n",actual->posicion,actual->lexema);
        actual = actual->siguiente;
    }
    printf("\n");

    struct NodoToken* act = tablaToken;  // Imprimimos la lista de tokens:
    printf("TOKENS:\n"); // Definimos e inicializamos un puntero para recorrer la lista de tokens.
    while (act != NULL) {// Mientras no lleguemos al final de la lista imprimimos la clase y la posición del nodo de token actual.
        printf("\n(%d,%d)\n", act->clase, act->posicion); 
        act = act->siguiente; // Nos movemos al siguiente nodo.
    }
    printf("\n");
}



