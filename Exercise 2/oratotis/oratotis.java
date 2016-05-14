import java.io.File;
import java.io.FileNotFoundException;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Hashtable;
import java.util.Locale;
import java.util.Scanner;

public class oratotis {
    public static class building{
        int Xsw;
        int Ysw;
        int Xne;
        int Yne;
        float h;
        int counted;
        public building (int t1, int t2, int t3, int t4, float t5, int c) {
                Xsw = t1;
                Ysw = t2;
                Xne = t3;
                Yne = t4;
                h = t5;
                counted = c;
        }
        /* sort by Ysw */
        static Comparator<building> yComparator() {
            return new Comparator<building>() {
                @Override
                public int compare(building o1, building o2) {
                    return o1.Ysw - o2.Ysw;
                }
            };
        }
    }
    
    public static class interval{
        int x;
        float h;
        /* sort by Ysw */
        static Comparator<interval> xComparator() {
            return new Comparator<interval>() {
                @Override
                public int compare(interval i1, interval i2) {
                    return i1.x - i2.x;
                }
            };
        }
        public interval(int t1, float t2) {
            x = t1;
            h = t2;
        }
    }
    
    private static int Counter(building [] b, interval [] xs, Hashtable<Integer, Integer> hash, int N) {
        int i, j, xstart, xfinnish; int previous = -1;
        int count = 0;
        /* for every  building */
        for (i = 0; i < N; i++){
            xstart = hash.get(b[i].Xsw);
            xfinnish = hash.get(b[i].Xne);
            for (j = xstart; j < xfinnish; j++){
                if (xs[j].x == previous)
                    continue;
                previous = xs[j].x;
                if (xs[j].h < b[i].h){
                    xs[j].h = b[i].h;
                    if (b[i].counted == 0){
                        b[i].counted = 1;
                        count++;
                    }
                }
            }
        }
        return count;
    }
    
    public static void main(String[] args) throws FileNotFoundException{
        
        int i, N, count;
        int t1,t2,t3,t4;
        float t5;
        Hashtable<Integer, Integer> hash = new Hashtable<Integer, Integer>();
        
        File file = new File(args[0]);
        Scanner xscan = new Scanner(file);
        xscan.useLocale(Locale.US);
        
        /*read input size */
        N = xscan.nextInt();
        building[] b = new building[N];
        
        interval[] xs = new interval[2*N];
        if (N==0){
            System.out.printf("0\n");
        }
        else{
            /* read input */
            for (i=0; i<N; i++){
                xscan.nextLine();
                t1 = xscan.nextInt();
                t2 = xscan.nextInt();
                t3 = xscan.nextInt();
                t4 = xscan.nextInt();
                t5 = xscan.nextFloat();
                b[i] = new building(t1,t2,t3,t4,t5,0);
                /* save X in another list */
                xs[i] = new interval(t1,0);
                xs[i+N] = new interval(t3,0);
            }
            xscan.close();
            
            /* sort buildings by Ysw */
            Arrays.sort(b, building.yComparator());
            /* sort X asc */
            Arrays.sort(xs, interval.xComparator());
            
            /* create hashtable */
            t1 = -1;
            for (i=0; i<2*N; i++){
                t2 = xs[i].x;
                if (t2 > t1)
                    hash.put(t2, i);
                t1 = t2;
            }
            
            /* for every building c */
            count = Counter(b, xs, hash, N); 
            System.out.printf("%d\n", count);
        }
    }
}