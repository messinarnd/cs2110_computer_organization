/**
 * CS 2110 - Spring 2019 - Timed Lab #5
 *
 * @author Christopher Messina
 *
 * tl5.c: Complete the functions!
 */

// Do not add ANY additional includes!!!
#include "tl5.h"
#include "string.h"

///* You should NOT have any global variables. */

/** copy_list
  *
  * Create a new list and new pokemon nodes  
  *
  * If listToCopy is NULL return NULL. For any memory allocations
  * failures your code must not leak memory. This means that if any
  * memory allocation failures occur, before you return NULL, you must destroy
  * the list 
  *
  * @param listToCopy A pointer to the struct list structure to make a copy of
  * @return The struct list structure created by copying the old one, or NULL on
  *         failure (includes any of the parameters being null)
  */
struct list *copy_list(struct list *listToCopy)
{
    // UNUSED_PARAMETER(listToCopy);
    if (listToCopy == NULL) {
      return NULL;
    }

    // Creating the new list that will be the copy
    // Will be returning newList
    struct list *newList;
    if ((newList = malloc(sizeof(struct pokemon))) == NULL) {
      return NULL;
    }
    newList->starter_pokemon = NULL;


    // Set pointers to head of each list
    // struct pokemon *newCurr = newList->starter_pokemon;
    struct pokemon *curr = listToCopy->starter_pokemon;
    
    if (curr == NULL) {
      return newList;
    }


    // Create new starter node
    // struct pokemon *newNode;
    struct pokemon *newCurr;
    if ((newCurr = malloc(sizeof(struct pokemon))) == NULL) {
      destroy(newList);
      return NULL;
    }
    newCurr->type = NULL;
    newCurr->evolve = NULL;

    newList->starter_pokemon = newCurr;
    newCurr->level = curr->level;

    char *buffer;
    if ((buffer = malloc(sizeof(curr->type))) == NULL) {
      destroy(newList);
      return NULL;
    }
    newCurr->type = strcpy(buffer, curr->type);

    curr = curr->evolve;

    while (curr != NULL) {
      struct pokemon *next;
      if ((next = malloc(sizeof(struct pokemon))) == NULL) {
        destroy(newList);
        return NULL;
      }

      newCurr->evolve = next;
      next->level = curr->level;
      char *buffer;
      if ((buffer = malloc(sizeof(curr->type))) == NULL) {
        destroy(newList);
        return NULL;
      }
      next->type = strcpy(buffer, curr->type);
      next->evolve = NULL;
      newCurr = next;
      curr = curr->evolve;
    }

    return newList;
}

/** Destroy
  *
  * Destroys the entire struct list. This function removes every list node
  * and finally remove the list itself.
  *
  * HINT: remember every malloc needs a respective free
  * 
  * @param listToEmpty a pointer to the struct list
  */
void destroy(struct list *listToDestroy)
{
    // UNUSED_PARAMETER(listToDestroy);
    if (listToDestroy == NULL) {
      return;
    }

    while (listToDestroy->starter_pokemon != NULL) {
      struct pokemon *temp = listToDestroy->starter_pokemon->evolve;
      free(listToDestroy->starter_pokemon->type);
      free(listToDestroy->starter_pokemon);
      listToDestroy->starter_pokemon = temp;
    }
    free(listToDestroy);
    return;
}

