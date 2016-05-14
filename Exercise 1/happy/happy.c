#include <stdio.h>
#include <stdlib.h>

int sum_sqr_digits(int n)
{
	int sum=0;
	int dig;
	for (; n; n /= 10){
		dig = n % 10;
		sum += dig * dig;
	}
	return sum;
}

int happy(int n)
{
	n=sum_sqr_digits(n);
	if (n==1)
        return 1;
	else 
		if (n==4 || n==16 || n==37 || n==58 || n==89 || n==145 || n==42 || n==20)
			return 0;
		else
			return happy(n);
}

int calc(int x, int cache[730], int L[10], int c[10][810]){
	int D[10] = { 0 };
	int i, j, k;
	int idx = 0; 
	int last = 0;
	int sum = 0;

    for (; x; x /= 10){
		D[idx] = x % 10;
		idx++;
	}
	idx--;

 	for (k = idx; k >= 0; k--){
 		for (i = 0; i < D[k]; i++){
 			for (j = 0; j <= L[k]; j++){
 				sum += c[k][j]*cache[j+i*i+last];
 			}
 		}
 		last += D[k]*D[k];
 	}

 	return sum;
}


int main(int argc, char **argv){
	FILE *file;
	int a, b, i, j, c_i;
	int cache[730] = { 0 };
	int c[10][810] = {{ 0 }};
	int L[10] = { 0 };

    for(i=1; i<10; i++)
    	L[i] = L[i-1] + 81;

	for (i = 1; i <730; i++){
		if (happy(i))
			cache[i] = 1;
 	}
 	file = fopen(argv[1], "r");
 	if(fscanf(file, "%d %d", &a, &b)==-1)
 		return -1;

 	c[0][0] = 1;
 	for (c_i = 1; c_i < 10; c_i++) {
		for (i = 0; i < L[c_i]; i++) {
 			for (j = 0; j < 10; j++) {
 				c[c_i][i+j*j] += c[c_i-1][i];
 			}
 		}
 	}

 	if (b == 1000000000){
 		printf("%d\n", calc(b-1,cache,L,c)-calc(a,cache,L,c)+1);
 	}
 	else
 		printf("%d\n", calc(b+1,cache,L,c)-calc(a,cache,L,c));
	return 0;
}