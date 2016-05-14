import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class diapragmateysi {
	public static class state{
		int [] c; 	//current combination
		List<Integer> moves = new ArrayList<Integer>();
	}
	
	public static int[] encode(char[] input){
		int i;
		int[] coded = new int[12];
		for (i=0; i<12; i++){
			if (input[i] == 'b'){
				coded[i] = 1;
			}
			else if (input[i] == 'g'){
				coded[i] = 2;
			}
			else if (input[i] == 'r'){
				coded[i] = 3;
			}
			else if (input[i] == 'y'){
				coded[i] = 4;
			}
			else if (input[i] == 'G'){
				coded[i] = 0;
			}
		}
		return coded; 
	}
	
	public static void rotate(int[] c, int i){
		if (i==1){
				int temp;
				temp = c[0];
				c[0] = c[2];
				c[2] = c[5];
				c[5] = c[3];
				c[3] = temp;
		}
		else if (i==2){
				int temp;
				temp = c[1];
				c[1] = c[3];
				c[3] = c[6];
				c[6] = c[4];
				c[4] = temp;
			}
		else if (i==3){
				int temp;
				temp = c[5];
				c[5] = c[7];
				c[7] = c[10];
				c[10] = c[8];
				c[8] = temp;
			}
		else if (i==4){
				int temp;
				temp = c[6];
				c[6] = c[8];
				c[8] = c[11];
				c[11] = c[9];
				c[9] = temp;
			}
	}
	
	public static boolean deal(int[] c){
		if (c[0] == 1 && c[1] == 2 && c[2] == 1 && c[3] == 0 && c[4] == 2 && c[5] == 0 &&
				 c[6] == 0 && c[7] == 3 && c[8] == 0 && c[9] == 4 && c[10] == 3 && c[11] == 4)
			return true;
		else 
			return false;
	}
	
	public static void bfs(Queue<state> queue){
		state temp;
		int i, j;
		int decimal;
		boolean [] mem = new boolean[241597501];
		int[] digits = new int[12];
		for (i=0; i<12; i++){
			digits[i]=(int) Math.pow(5, i);		//base5 to decimal conversion
		}
		while(true){
			for (i=1; i<5; i++){		//for every possible move
				temp = new state();		//new temp
				temp.c = new int[12];
				
				//get combination
				System.arraycopy(queue.peek().c, 0, temp.c, 0, 12);		
				
				rotate(temp.c, i);		//move
				
				decimal = 0;
				for (j=0; j<12; j++){
					decimal += digits[j] * temp.c[j];	//convert to decimal
				}
				if (mem[decimal]){		//check with memoization array
					continue;
				}
				else
					mem[decimal] = true;
				for (j=0; j<queue.peek().moves.size(); j++)
					temp.moves.add(queue.peek().moves.get(j));
				temp.moves.add(i);
				
				
				if (deal(temp.c)){		//check if done
					for (j=0; j<temp.moves.size(); j++)
						System.out.printf("%d ", temp.moves.get(j));
					return;
				}
				else
					queue.offer(temp);		//enqueue
			}
			queue.remove();		//dequeue
		}
	}
	
	public static void main(String[] args) {
		char[] input = args[0].toCharArray();	//String -> char[]
		Queue<state> queue = new LinkedList<state>();
		state s = new state();
		s.c = new int[12];
		s.c = encode(input);	// char[] -> int[]
		
		queue.add(s);
		bfs(queue);
	}
}
