#include "todo.h"
// #include "useful_strings.h"

int main(int argc, const char *argv[]) {
    if (argc > 2) {
        printf(ERROR_USAGE);
        return 1;
    }
    
    for (int i = 1; i < argc; i++) { // skip ./todo
        // char arg_buffer[128];
        FILE *in_file = fopen(argv[i], "r");

        if (in_file == NULL) {
            printf("ERROR: File, %s, does not exist!\n", argv[i]);
            return 1;
        }

        // char buffer[128];
        while (read_todo_list_item(in_file)) {
            // fprintf(out_file, buffer); // fprintf is just like printf, except it accepts a file
                                   // descriptor to print to
        }
        // read_todo_list_item(in_file);
        // argv[i]; // as a string
    }

    show_main_menu();
}

void show_main_menu(void) {
    printf(MAIN_MENU_HEADER);
    printf(QUERY);
    printf(OPTIONS_LIST);
    printf(GRAB_INPUT);

    char buffer[128];
    char *user_input = fgets(buffer, 128, stdin);

    switch (*user_input) {
        case '1':
            print_todo_list_items();
            break;
        case '2':
            add_todo_list_item();
            break;
        case '3':
            mark_item_completed();
            break;
        case '4':
            remove_completed_items();
            break;
        case '5':
            save_file();
            break;
        case '6':
            quit();
            break;
        default:
            printf(INVALID_CHOICE);
            // printf("\n");
            show_main_menu();
    }
}

// quit out of the app
void quit(void) {
    exit(0);
}

//Print all of the TO-DO list items
void print_todo_list_items(void) {
    printf(TODO_LIST_HEADER);


    // For each todo_item in TODO_LIST (up to Todo_list_length)
    for (int i = 0; i < Todo_list_length; i++) {
        // Are the todo_item fields already set?
        printf("%s", Todo_list[i].title);
        printf("\n\n");
        if (Todo_list[i].is_done) {
            printf(COMPLETED);
        } else {
            printf("Due: %02d/%02d/%04d\n", Todo_list[i].due_month, Todo_list[i].due_day, Todo_list[i].due_year);
        }
        printf("Description: %s\n", Todo_list[i].description);
        printf(LINE_BREAK);
    }

    show_main_menu();
}

//Add an item to the to-do list
void add_todo_list_item(void) {
    printf(ADD_TO_LIST_HEADER);
    if (Todo_list_length == 100) {
        printf(LIST_MAX);
        show_main_menu();
    } else {
        printf(ADD_TO_LIST);

        read_todo_list_item(stdin);

        show_main_menu();
    }
}

// Mark an item as completed
void mark_item_completed(void) {
    printf(MARK_ITEM_COMPLETED_HEADER);
    printf(MARK_ITEM_USER_INPUT);
    printf(GRAB_INPUT);

    char buffer[128];
    fgets(buffer, 128, stdin);
    int index = atoi(buffer);

    if (index >= 0 && index < Todo_list_length) {
        Todo_list[index].is_done = 1;
    }

    // Do I need to print anything if it is out of bounds?
    show_main_menu();
}

// Remove all completed items from the list
void remove_completed_items(void) {
    int count = 0;
    int i =0;
    while (i < Todo_list_length) {
        if (Todo_list[i].is_done) {
            int j;
            for (j = i; j < Todo_list_length - 1; j++) {
                Todo_list[j] = Todo_list[j+1];
            }
            Todo_list_length--;
            count++;
        } else {
            i++;
        }
    }

    printf(REMOVE_ITEM_HEADER);
    printf("Success! %d items removed!\n", count);

    show_main_menu();
}

void save_file(void) {
    printf(SAVE_FILE_HEADER);
    printf(INPUT_FILE_NAME);
    printf(GRAB_INPUT);

    char buffer[128];
    FILE *out_file = fopen(fgets_no_newline(buffer, 128, stdin), "w");
    if (out_file == NULL) {
        printf("Something went wrong with output file\n");
        show_main_menu();
    }

    for (int i = 0; i < Todo_list_length; i++) {
        fprintf(out_file, "%s\n%s\n%d\n%d\n%d\n%d\n", Todo_list[i].title, Todo_list[i].description, Todo_list[i].is_done, Todo_list[i].due_day, Todo_list[i].due_month, Todo_list[i].due_year);
    }

    fclose(out_file);

    show_main_menu();
}
