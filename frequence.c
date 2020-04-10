#include "stdio.h"
#include "stdlib.h"
#include "string.h"

int lire(char *chaine, int longueur)
{
   char *positionEntree = NULL;
   if (fgets(chaine, longueur, stdin) != NULL) 
   {
       positionEntree = strchr(chaine, '\n'); 
       if (positionEntree != NULL)
       {
           *positionEntree = '\0';
       }
       return 1;
   }
   else
   {
       return 0;
   }
}

//TODO améliorer la fonction afin qu'elle affiche les décimales
float calculfrequence (int nb, int i, char op) {
   float freq=(100*nb) / (float)(i);
   printf("Pourcentage de %c : %.2f%\n", op, freq);
   return freq;
}

/*int calculpos (int nb) {
	int inc=(nb-97);
        printf("Nbre avant incrément : %i \n, _nbrCar[inc]");
	_nbrCar[inc]=_nbrCar[inc]+1;
        printf("Nbre apres incrément : %i \n, _nbrCar[inc]");
}*/

int main(int argc, char *argv[])
{
   int i; 
   int _nbrCar[26] = {0};
   char _alph[26][1] = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
   char texteChiffre[100];
   char lettre,lettremin;

   printf("Saisir le texte chiffré : ");
   lire(texteChiffre, 100);

   for(i=0; i<strlen(texteChiffre); i++)
   {
     lettre=texteChiffre[i];
     int pos = (int)lettre;  
     //printf ("Code ascii du caractere : %i \n", pos);
       if (pos >= 97 && pos <= 122) {
         //calculpos(pos);
	       int inc=(pos-97);
         /*printf ("Code ascii du caractere %c : %i\n", lettre, pos);    
         printf ("Position dans le tableau : %i \n", inc);   
         printf("Nbre tableau avant incrément : %i \n", _nbrCar[inc]);*/
         _alph[inc][1]=_alph[inc][1]+1;
         _nbrCar[inc]=_nbrCar[inc]+1;
         //printf("Nbre apres incrément : %i \n", _nbrCar[inc]);*/
       }
       else if (pos >= 65 && pos <= 90) {
         int inc=(pos-65);
         /*printf ("Code ascii du caractere %c : %i\n", lettre, pos);    
         printf ("Position dans le tableau : %i \n", inc);   
         printf("Nbre tableau avant incrément : %i \n", _nbrCar[inc]);*/
         _nbrCar[inc]=_nbrCar[inc]+1;
         //printf("Nbre apres incrément : %i \n", _nbrCar[inc]);
       } else
       {
       /* _nbrCar[inc]=_nbrCar[inc];
	ne pas incrémenter le tableau
	*/
       }
   }
   
   printf("Nbre de caracteres: %d \n", i);
   printf("Nbre de a : %i \n", _nbrCar[0]);
   //printf("Nbre de b : %i \n", _b);
   
   /*for (i=0; i<26; i++) {
   //if (_nbrCar[i] !=0) {
     printf("Nombre de lettre %d\n", _nbrCar[i]);
     //calculfrequence (_nbrCar[0], i, _le);
   }*/
   for (i=0; i<26; i++) {
    if (_nbrCar[i] !=0) {
      float toto;
      printf("La lettre est : %c\n", _alph[i][0]);
      toto = calculfrequence (_nbrCar[0], strlen(texteChiffre), _alph[i][0]);
      printf( "Le pourcentage de la lettre est : %f\n", toto );
    }
   }

   return 0;
}
