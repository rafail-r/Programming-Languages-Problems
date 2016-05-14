#include <stdio.h>
#include <stdlib.h>

int find_length(long int num){
	int length = 0;
	while(num > 0){
		length++;
		num /= 10;
	}
	return length;
}

void init(float *number, int length, long int input){
	int i;
	for (i=length-1; i>=0; i--){
		number[i]=(float)(input%10);
		input /= 10;
	}
}

int Pow(int a, int b){
	int i;
	int temp = 1;
	for (i=0; i<b; i++)
		temp = temp*a;
	return temp;
}

int create_group(int i, float *number,int length, float* number1){
	int j,length1;
	int temp = i;
	length1 = 0;
	int cnt = 0;
	number1[0] = number[0];
	for (j=0; j<length-1; j++){
		if (temp&1){
			number1[length1] = number1[length1]*10+number[cnt+1];
			cnt++;
		}
		else {
			number1[length1+1] = number[cnt+1];
			length1++;
			cnt++;
		}
		temp = temp>>1;
	}
	length1++;
	return length1;
}	

void create_opers(int **oper2, int length){
	int i,j;
	for(i=0; i<Pow(4,(length-1)); i++){
		int temp = i;
		for (j=0; j < length-1; j++){
			oper2[i][j] = temp%4;
			temp = temp/4;
		}
	}
}

void copy_arrays(float *a, float *a2, int *b, int *b2, int length){
	int i;
	for (i=0; i<length; i++){
		a2[i] = a[i];
	}
	for (i=0; i<length-1; i++){
		b2[i] = b[i];
	}
}

float calc(float a, float b, int c){
	if(c==0)
		return a+b;
	else if (c==1)
		return a-b;
	else if (c==2)
		return a*b;
	else {
		if (b==0)
			return a+b;
		return a/b;
	}
}

void shift_array(float *number3, int *oper3, int pos, int length){
	int i;
	for (i=pos+1; i<length; i++){
		number3[i-1]=number3[i];
	}
	for (i=pos+1; i<length-1; i++){
		oper3[i-1]=oper3[i];
	}
}

int check1(float *number3, int *oper3){
	if (number3[0]==100)
		return 1;
	else
		return 0;
}

int check2(float *number3, int *oper3){
	int w;
	float num2[2];
	int op2[1];
	for (w=0; w<1; w++){
		copy_arrays(number3,num2,oper3,op2,2);
		num2[w] = calc(num2[w],num2[w+1],op2[w]);
		shift_array(num2,op2,w,2);
		if (num2[0]==100)
			return 1;
	}
	return 0;
}

int check3(float *number3, int *oper3){
	int z,w;
	float num3[3];
	float num2[2];
	int op3[2];
	int op2[1];
	for (z=0; z<2; z++){
		copy_arrays(number3,num3,oper3,op3,3);
		num3[z+1] = calc(num3[z],num3[z+1],op3[z]);
		shift_array(num3,op3,z,3);
		for (w=0; w<1; w++){
			copy_arrays(num3,num2,op3,op2,2);
			num2[w+1] = calc(num2[w],num2[w+1],op2[w]);
			shift_array(num2,op2,w,2);
			if (num2[0]==100)
				return 1;
		}
	}
	return 0;
}

int check4(float *number3, int *oper3){
	int n,z,w;
	float num4[4];
	float num3[3];
	float num2[2];
	int op4[3];
	int op3[2];
	int op2[1];
	for (n=0; n<3; n++){
		copy_arrays(number3,num4,oper3,op4,4);
		num4[n+1] = calc(num4[n],num4[n+1],op4[n]);
		shift_array(num4,op4,n,4);
		for (z=0; z<2; z++){
			copy_arrays(num4,num3,op4,op3,3);
			num3[z+1] = calc(num3[z],num3[z+1],op3[z]);
			shift_array(num3,op3,z,3);
			for (w=0; w<1; w++){
				copy_arrays(num3,num2,op3,op2,2);
				num2[w+1] = calc(num2[w],num2[w+1],op2[w]);
				shift_array(num2,op2,w,2);
				if (num2[0]==100){
					return 1;
				}
			}
		}
	}
	return 0;
}

int check5(float *number3, int *oper3){
	int y,n,z,w;
	float num5[5];
	float num4[4];
	float num3[3];
	float num2[2];
	int op5[4];
	int op4[3];
	int op3[2];
	int op2[1];
	for (y=0; y<4; y++){
		copy_arrays(number3,num5,oper3,op5,5);
		num5[y+1] = calc(num5[y],num5[y+1],op5[y]);
		shift_array(num5,op5,y,5);
		for (n=0; n<3; n++){
			copy_arrays(num5,num4,op5,op4,4);
			num4[n+1] = calc(num4[n],num4[n+1],op4[n]);
			shift_array(num4,op4,n,4);
			for (z=0; z<2; z++){
				copy_arrays(num4,num3,op4,op3,3);
				num3[z+1] = calc(num3[z],num3[z+1],op3[z]);
				shift_array(num3,op3,z,3);
				for (w=0; w<1; w++){
					copy_arrays(num3,num2,op3,op2,2);
					num2[w+1] = calc(num2[w],num2[w+1],op2[w]);
					shift_array(num2,op2,w,2);
					if (num2[0]==100){
						return 1;
					}
				}
			}
		}
	}
	return 0;
}

int check6(float *number3, int *oper3){
	int m,y,n,z,w;
	float num6[6];
	float num5[5];
	float num4[4];
	float num3[3];
	float num2[2];
	int op6[5];
	int op5[4];
	int op4[3];
	int op3[2];
	int op2[1];
	for (m=0; m<5; m++){	//(2 - (7 * (((1 / 3) - 5) * 3)))
		copy_arrays(number3,num6,oper3,op6,6);
		num6[m+1] = calc(num6[m],num6[m+1],op6[m]);
		shift_array(num6,op6,m,6);
		for (y=0; y<4; y++){
			copy_arrays(num6,num5,op6,op5,5);
			num5[y+1] = calc(num5[y],num5[y+1],op5[y]);
			shift_array(num5,op5,y,5);
			for (n=0; n<3; n++){
				copy_arrays(num5,num4,op5,op4,4);
				num4[n+1] = calc(num4[n],num4[n+1],op4[n]);
				shift_array(num4,op4,n,4);
				for (z=0; z<2; z++){
					copy_arrays(num4,num3,op4,op3,3);
					num3[z+1] = calc(num3[z],num3[z+1],op3[z]);
					shift_array(num3,op3,z,3);
					for (w=0; w<1; w++){
						copy_arrays(num3,num2,op3,op2,2);
						num2[w+1] = calc(num2[w],num2[w+1],op2[w]);
						shift_array(num2,op2,w,2);
						if (num2[0]==100){
							return 1;
						}
					}
				}
			}
		}
	}
return 0;
}

int check7(float *number3, int *oper3){
	int l,m,y,n,z,w;
	float num7[7];
	float num6[6];
	float num5[5];
	float num4[4];
	float num3[3];
	float num2[2];
	int op7[6];
	int op6[5];
	int op5[4];
	int op4[3];
	int op3[2];
	int op2[1];
	for (l=0; l<6; l++){
		copy_arrays(number3,num7,oper3,op7,7);
		num7[l+1] = calc(num7[l],num7[l+1],op7[l]);
		shift_array(num4,op4,l,7);
		for (m=0; m<5; m++){
			copy_arrays(num7,num6,op7,op6,6);
			num6[m+1] = calc(num6[m],num6[m+1],op6[m]);
			shift_array(num6,op6,m,6);
			for (y=0; y<4; y++){
				copy_arrays(num6,num5,op6,op5,5);
				num5[y+1] = calc(num5[y],num5[y+1],op5[y]);
				shift_array(num5,op5,y,5);
				for (n=0; n<3; n++){
					copy_arrays(num5,num4,op5,op4,4);
					num4[n+1] = calc(num4[n],num4[n+1],op4[n]);
					shift_array(num4,op4,n,4);
					for (z=0; z<2; z++){
						copy_arrays(num4,num3,op4,op3,3);
						num3[z+1] = calc(num3[z],num3[z+1],op3[z]);
						shift_array(num3,op3,z,3);
						for (w=0; w<1; w++){
							copy_arrays(num3,num2,op3,op2,2);
							num2[w+1] = calc(num2[w],num2[w+1],op2[w]);
							shift_array(num2,op2,w,2);
							if (num2[0]==100)
								return 1;
						}
					}
				}
			}
		}
	}
	return 0;
}

int check8(float *number3, int *oper3){
	int k,l,m,y,n,z,w;
	float num8[8];
	float num7[7];
	float num6[6];
	float num5[5];
	float num4[4];
	float num3[3];
	float num2[2];
	int op8[7];
	int op7[6];
	int op6[5];
	int op5[4];
	int op4[3];
	int op3[2];
	int op2[1];
	for (k=0; k<7; k++){
		copy_arrays(number3,num8,oper3,op8,8);
		num8[k+1] = calc(num8[k],num8[k+1],op8[k]);
		shift_array(num8,op8,k,8);
		for (l=0; l<6; l++){
			copy_arrays(num8,num7,op8,op7,7);
			num7[l+1] = calc(num7[l],num7[l+1],op7[l]);
			shift_array(num4,op4,l,7);
			for (m=0; m<5; m++){
				copy_arrays(num7,num6,op7,op6,6);
				num6[m+1] = calc(num6[m],num6[m+1],op6[m]);
				shift_array(num6,op6,m,6);
				for (y=0; y<4; y++){
					copy_arrays(num6,num5,op6,op5,5);
					num5[y+1] = calc(num5[y],num5[y+1],op5[y]);
					shift_array(num5,op5,y,5);
					for (n=0; n<3; n++){
						copy_arrays(num5,num4,op5,op4,4);
						num4[n+1] = calc(num4[n],num4[n+1],op4[n]);
						shift_array(num4,op4,n,4);
						for (z=0; z<2; z++){
							copy_arrays(num4,num3,op4,op3,3);
							num3[z+1] = calc(num3[z],num3[z+1],op3[z]);
							shift_array(num3,op3,z,3);
							for (w=0; w<1; w++){
								copy_arrays(num3,num2,op3,op2,2);
								num2[w+1] = calc(num2[w],num2[w+1],op2[w]);
								shift_array(num2,op2,w,2);
								if (num2[0]==100)
									return 1;
							}
						}
					}
				}
			}
		}
	}
	return 0;
}

int check9(float *number3, int *oper3){
	int j,k,l,m,y,n,z,w;
	float num9[9];
	float num8[8];
	float num7[7];
	float num6[6];
	float num5[5];
	float num4[4];
	float num3[3];
	float num2[2];
	int op9[8];
	int op8[7];
	int op7[6];
	int op6[5];
	int op5[4];
	int op4[3];
	int op3[2];
	int op2[1];
	for (j=0; j<8; j++){
		copy_arrays(number3,num9,oper3,op9,9);
		num9[j+1] = calc(num9[j],num9[j+1],op9[j]);
		shift_array(num9,op9,j,9);
		for (k=0; k<7; k++){
			copy_arrays(num9,num8,op9,op8,8);
			num8[k+1] = calc(num8[k],num8[k+1],op8[k]);
			shift_array(num8,op8,k,8);
			for (l=0; l<6; l++){
				copy_arrays(num8,num7,op8,op7,7);
				num7[l+1] = calc(num7[l],num7[l+1],op7[l]);
				shift_array(num4,op4,l,7);
				for (m=0; m<5; m++){
					copy_arrays(num7,num6,op7,op6,6);
					num6[m+1] = calc(num6[m],num6[m+1],op6[m]);
					shift_array(num6,op6,m,6);
					for (y=0; y<4; y++){
						copy_arrays(num6,num5,op6,op5,5);
						num5[y+1] = calc(num5[y],num5[y+1],op5[y]);
						shift_array(num5,op5,y,5);
						for (n=0; n<3; n++){
							copy_arrays(num5,num4,op5,op4,4);
							num4[n+1] = calc(num4[n],num4[n+1],op4[n]);
							shift_array(num4,op4,n,4);
							for (z=0; z<2; z++){
								copy_arrays(num4,num3,op4,op3,3);
								num3[z+1] = calc(num3[z],num3[z+1],op3[z]);
								shift_array(num3,op3,z,3);
								for (w=0; w<1; w++){
									copy_arrays(num3,num2,op3,op2,2);
									num2[w+1] = calc(num2[w],num2[w+1],op2[w]);
									shift_array(num2,op2,w,2);
									if (num2[0]==100)
										return 1;
								}
							}
						}
					}
				}
			}
		}
	}
	return 0;
}

int check10(float *number3, int *oper3){
	int i,j,k,l,m,y,n,z,w;
	float num10[10];
	float num9[9];
	float num8[8];
	float num7[7];
	float num6[6];
	float num5[5];
	float num4[4];
	float num3[3];
	float num2[2];
	int op10[9];
	int op9[8];
	int op8[7];
	int op7[6];
	int op6[5];
	int op5[4];
	int op4[3];
	int op3[2];
	int op2[1];
	for (i=0; i<9; i++){
		copy_arrays(number3,num10,oper3,op10,10);
		num10[i+1] = calc(number3[i],number3[i+1],oper3[i]);
		shift_array(num10,op10,i,10);
		for (j=0; j<8; j++){
			copy_arrays(num10,num9,op10,op9,9);
			num9[j+1] = calc(num9[j],num9[j+1],op9[j]);
			shift_array(num9,op9,j,9);
			for (k=0; k<7; k++){
				copy_arrays(num9,num8,op9,op8,8);
				num8[k+1] = calc(num8[k],num8[k+1],op8[k]);
				shift_array(num8,op8,k,8);
				for (l=0; l<6; l++){
					copy_arrays(num8,num7,op8,op7,7);
					num7[l+1] = calc(num7[l],num7[l+1],op7[l]);
					shift_array(num4,op4,l,7);
					for (m=0; m<5; m++){
						copy_arrays(num7,num6,op7,op6,6);
						num6[m+1] = calc(num6[m],num6[m+1],op6[m]);
						shift_array(num6,op6,m,6);
						for (y=0; y<4; y++){
							copy_arrays(num6,num5,op6,op5,5);
							num5[y+1] = calc(num5[y],num5[y+1],op5[y]);
							shift_array(num5,op5,y,5);
							for (n=0; n<3; n++){
								copy_arrays(num5,num4,op5,op4,4);
								num4[n+1] = calc(num4[n],num4[n+1],op4[n]);
								shift_array(num4,op4,n,4);
								for (z=0; z<2; z++){
									copy_arrays(num4,num3,op4,op3,3);
									num3[z+1] = calc(num3[z],num3[z+1],op3[z]);
									shift_array(num3,op3,z,3);
									for (w=0; w<1; w++){
										copy_arrays(num3,num2,op3,op2,2);
										num2[w+1] = calc(num2[w],num2[w+1],op2[w]);
										shift_array(num2,op2,w,2);
										if (num2[0]==100)
											return 1;
									}
								}
							}
						}
					}
				}
			}
		}
	}
	return 0;
}

int check(int length1, float *number3, int *oper3){
	if (length1 == 1)
		return check1(number3,oper3);
	if (length1 == 2)
		return check2(number3,oper3);
	if (length1 == 3)
		return check3(number3,oper3);
	if (length1 == 4)
		return check4(number3,oper3);
	if (length1 == 5)
		return check5(number3,oper3);
	if (length1 == 6)
		return check6(number3,oper3);
	if (length1 == 7)
		return check7(number3,oper3);
	if (length1 == 8)
		return check8(number3,oper3);
	if (length1 == 9)
		return check9(number3,oper3);
	if (length1 == 10)
		return check10(number3,oper3);
	return 0;
}

int lucky(char *argn){
	int i,j;
	long int input = atol(argn);
	int length = find_length(input);
	float *number = (float *)malloc(length*sizeof(float));
	init(number,length,input);
	float *number1 = (float *)malloc(length*sizeof(float));
	int **oper2;
	oper2 = (int **)malloc(Pow(4,(length-1))*sizeof(int *));	
	for (i=0; i<Pow(4,(length-1)); i++){
		oper2[i] = (int *)malloc(length*sizeof(int));
	}
	int *oper3 = (int *)malloc(length*sizeof(int));
	float *number3 = (float *)malloc(length*sizeof(float));
	create_opers(oper2,length);
	int length1;
	for (i=0; i<Pow(2,(length-1)); i++){
		length1 = create_group(i,number,length,number1);
		for (j=0; j<Pow(4,(length1-1)); j++){
			copy_arrays(number1,number3,oper2[j],oper3,length1);
			if (check(length1,number3,oper3)){
				return 0;
			}
		}
	}
	return 1;
}

int main(int argc, char **argv){
	int i;
	for (i=1; i<argc; i++)
	{
		if (lucky(argv[i]) == 1)
			printf("true");
		else
			printf("false");
		if (i<argc-1)
			printf(" ");
	}
	printf("\n");
	return 0;
}