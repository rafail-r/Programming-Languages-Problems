#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define MAX_K 43
#define MAX_M 1000
#define maxbuf 1043

int array[MAX_M][MAX_K];


typedef struct state {		/*the data in every state of the solution*/
	char buffer[maxbuf];	/*a buffer of 1043 integers. [0-1000] are '1' if current danger compination still in and
							 *[1001-1042] are '1' if the current number (law) is still in */  
	struct state *next;		/*pointer to the next state*/
} state;

state *head;
state *tail;

state *init(int M, int N)	/*state initialization. At the beggining all '1' (still in)*/
{
	int i;
	state *new;
	new = malloc(sizeof(*new));
	new->next = NULL;
	for (i = 0; i < maxbuf; i++)
		new->buffer[i] = 1;
	return new;
}

state *create_child(int stixio, state *temp, int N, int M, int *flag)	/*creates the next state (child in the graph)*/
{
	int i, j;
	state *new = malloc(sizeof(*new));
	new->next = NULL;
	for (i = 0; i < maxbuf; i++)
		new->buffer[i] = temp->buffer[i];			/*the new buffer is the same with the old without the compinations that
													 *include the current number*/
	for (i = 0; i < M; i++){
		if (new->buffer[i]==1){
			for (j = 1; j <= array[i][0]; j++){
				if (array[i][j]==stixio){
					new->buffer[i] = 0;
					break;
				}
			}
		}
		if (new->buffer[i] == 1){
			*flag = 1;				/*if there are still dangerous compinations flag = 1*/
		}
	}
	new->buffer[1000+stixio] = 0;	/*deletes the current number from solution*/
	return new;
}

void enqueue(state *curr_state)		/*enqueue a state to the queue*/
{
	tail->next = curr_state;
	tail = tail->next;
}

void dequeue()
{
	state *temp = head;
	head = head->next;
	free(temp);
}

int main(int argc, char **argv)
{
	FILE *file;
	int i, j, M, N, flag, index, ret, c;
	head = tail = NULL;
	file = fopen(argv[1], "r");
	ret = fscanf(file, "%d %d", &N, &M);
	if (ret<0){
		printf("No input file\n");
		return -1;
	}
/*  read input  */
	for (i = 0; i < M; i++) {
		int K;
		ret = fscanf(file, "%d", &K);
		if (ret<0){
			printf("No input file\n");
			return -1;
		}
		array[i][0] = K;
		for (j = 1; j <= K; j++)
			ret = fscanf(file, "%d", &array[i][j]);
	}

	state *curr_state = init(M, N);
	head = curr_state;
	tail = curr_state;
	int cnt = 0;
	for (i = 0; i < M; i++){		/*if there is a longer compination that contains a shorter one then delete it*/
		for (c = 0; c < M; c++){
			if (array[c][0] <= array[i][0] || curr_state->buffer[c] == 0)
				continue;
			int test[MAX_K] = { 0 };
			for (j = 1; j <= array[i][0]; j++){
				test[array[i][j]] = 1;
			}
			for (j = 1; j<= array[c][0]; j++){
				test[array[c][j]] = 0;
			}
			int flag2 = 0;
			for (j = 1; j <=array[i][0]; j++){
				if (test[array[i][j]] == 1){
					flag2 = 1;
					break;
				}
			}
			if (flag2 == 0){
				cnt++;
				curr_state->buffer[c] = 0;
			}
		}

	}
	while (head != NULL) {		/*BFS (Breadth First Search) to the graph of states*/
		state *temp = head;
		index = 0;
		flag = 1;
		for (i = 0; i < M; i++) {		/*select the shortest compination of these that are still in*/
			if (temp->buffer[i] == 1){
				if (flag == 1)
					index = i; 
				else {
					if (array[i][0]<array[index][0])
						index = i;
				}
				flag = 0;
			}
		}
		for (i = 1; i <= array[index][0]; i++) {	/*for every number of this compination create a child state in the graph*/
			flag = 0;
			state *curr_state = create_child(array[index][i], temp, N, M, &flag);
			if (flag == 0){		/*if flag is 0 there are no other dangerous compinations and because of BFS we have deleted
								 *the fewest numbers*/
				for (j = 1; j <= N; j++) {
					if (temp->buffer[1000+j] == 1 && j!=array[index][i]){ /*we print the solution (all numbers that are still in until there)*/
						printf("%d ", j);
	                }
				}
					printf("\n");
				break;	/*and break*/
			}
			enqueue(curr_state);	/*else enqueue this state and continue*/
		}
		if (flag == 0)	/*if flag = 0 stop the bfs*/
			break;
		dequeue();	/*else dequeue a state and continue*/
	}
	return 0;
}
