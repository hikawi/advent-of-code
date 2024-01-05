#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long int hash(char *str)
{
    unsigned int length = strlen(str);
    long long int hash_value = 0;
    for (unsigned int i = 0; i < length; i++)
    {
        hash_value += str[i];
        hash_value *= 17;
        hash_value %= 256;
    }
    return hash_value;
}

void solve_part_one()
{
    FILE *fp = fopen("./input.txt", "r");
    long long int hash_value = 0;

    char buffer[256], ch = '\0';
    unsigned int buffer_length = 0;
    while ((ch = fgetc(fp)) != EOF)
    {
        switch (ch)
        {
        case ',':
        case '\n':
            buffer[buffer_length] = '\0';
            hash_value += hash(buffer);
            buffer_length = 0;
            break;
        default:
            buffer[buffer_length++] = ch;
            break;
        }
    }

    fclose(fp);
    printf("%lld\n", hash_value);
}

struct Lens
{
    char *label;
    int power;
};

struct Box
{
    struct Lens *lens;
    int size;
    int capacity;
};

void ensure_box_capacity(struct Box *box)
{
    if (box->size == box->capacity)
    {
        box->capacity *= 2;
        box->lens = realloc(box->lens, sizeof(struct Lens) * box->capacity);
    }
}

void add_to_box(struct Box *box, struct Lens lens)
{
    ensure_box_capacity(box);
    box->lens[box->size++] = lens;
}

void remove_from_box(struct Box *box, char *label)
{
    for (int i = 0; i < box->size; i++)
        if (strcmp(box->lens[i].label, label) == 0)
        {
            for (int j = i; j < box->size - 1; j++)
                box->lens[j] = box->lens[j + 1];
            box->size--;
            break;
        }
}

void replace_in_box(struct Box *box, char *label, int power)
{
    for (int i = 0; i < box->size; i++)
        if (strcmp(box->lens[i].label, label) == 0)
        {
            box->lens[i].power = power;
            return;
        }

    struct Lens lens;
    lens.label = malloc(sizeof(char) * strlen(label));
    strcpy(lens.label, label);
    lens.power = power;
    add_to_box(box, lens);
}

void free_box(struct Box *box)
{
    free(box->lens);
}

void place_lens(struct Box **boxes, char *buffer)
{
    int length = strlen(buffer);

    if (buffer[length - 1] == '-') // Remove.
    {
        buffer[length - 1] = '\0';
        remove_from_box(boxes[hash(buffer)], buffer);
    }
    else
    {
        int power = buffer[length - 1] - '0';
        buffer[length - 2] = '\0';
        replace_in_box(boxes[hash(buffer)], buffer, power);
    }
}

void solve_part_two()
{
    FILE *fp = fopen("./input.txt", "r");

    struct Box **boxes = malloc(sizeof(struct Box *) * 256);
    for (int i = 0; i < 256; i++)
    {
        boxes[i] = malloc(sizeof(struct Box));
        boxes[i]->size = 0;
        boxes[i]->capacity = 10;
        boxes[i]->lens = malloc(sizeof(struct Lens) * boxes[i]->capacity);
    }

    char buffer[256], ch = '\0';
    unsigned int buffer_length = 0;
    while ((ch = fgetc(fp)) != EOF)
    {
        switch (ch)
        {
        case ',':
        case '\n':
            buffer[buffer_length] = '\0';
            place_lens(boxes, buffer);
            buffer_length = 0;
            break;
        default:
            buffer[buffer_length++] = ch;
            break;
        }
    }
    fclose(fp);

    long long int focus_power = 0;
    for (int i = 0; i < 256; i++)
    {
        for (int j = 0; j < boxes[i]->size; j++)
            focus_power += (i + 1) * (j + 1) * boxes[i]->lens[j].power;
        free_box(boxes[i]);
    }
    free(boxes);

    printf("%lld\n", focus_power);
}

int main()
{
    solve_part_one();
    solve_part_two();
    return 0;
}
