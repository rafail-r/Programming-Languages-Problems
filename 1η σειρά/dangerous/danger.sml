open Array;
open Queue;
open ListMergeSort;

fun parse file =
    let
    (* a function to read an integer from an input stream *)
        fun next_int input =
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
    (* a function to read a real that spans till the end of line *)
        fun next_real input =
        Option.valOf (TextIO.inputLine input)
    (* open input file and read the two integers in the first line *)
        val stream = TextIO.openIn file
        val n = next_int stream
        val m = next_int stream
    val _ = TextIO.inputLine stream
    (* a function to read the pair of integer & real in subsequent lines *)
        fun scanner 0 acc = acc
          | scanner i acc =
            let
                val k = next_int stream
                fun scanline 0 acc = acc
                  | scanline i acc =
                    let
                        val l = next_int stream
                    in
                        scanline (i - 1) (l :: acc)
                    end
                val line = fromList(rev(scanline k [k]))
            in
                scanner (i - 1) (line :: acc)
            end
    in
        (n, m, rev(scanner m []))
    end;
(*this function prints the list with not deleted elements*)
fun printlist(arr, i, m)=(
    if (i=m) then
        []
    else if (sub(arr,i)=1) then
        i+1::printlist(arr,i+1,m)
    else
        printlist(arr,i+1,m)
);
(*BFS on the graph of states*)
fun bfs(myqueue, arr, m)=(
let
    (*this function returns 1 if the element is in the combinations*)
    fun elementexists(i, j, element)=(
    if (sub(sub(arr, j), i) = element) then
        1
    else
        if (sub(sub(arr, j), 0) = i) then
            0
        else
            elementexists(i+1, j, element)
    );
    (*this function deletes the combinations where element exists*)
    fun deletecombinations(combination, element, cur_combinations)=(
    let
        val exists = elementexists(1, combination, element);
        val _ = if (sub(cur_combinations, combination)=1) andalso (exists = 1) then
                    update(cur_combinations,combination,0)
                else
                    if (sub(cur_combinations, combination)=1) then
                        update(cur_combinations,combination,1)
                    else
                        update(cur_combinations,combination,0)
    in    
        if (combination = m-1) then
            1
        else
            deletecombinations(combination+1, element, cur_combinations)
    end
    );
    (*this function returns 1 if all combinations deleted*)
    fun nocombinations (arr1, i)=(
    if (i = m) then
        1
    else if (sub(arr1,i)=1) then
        0
    else 
        nocombinations (arr1, i+1)
    );
    (*this function make the states for each element of the current combination*)
    fun foreachelem(i, k, minindex)=(
    let 
        val node1 = head myqueue;   (*takes the head of the queue*)
        val cur_combinations = array(Array.length(#1(node1)), 2);
        val cur_elements = array(Array.length(#2(node1)), 2);   (*initialize current state*)
        val _ = copy {src= #1(node1), dst=cur_combinations, di=0};
        val _ = copy {src= #2(node1), dst=cur_elements, di=0};  (*copy previous state to current*)
        val _ = deletecombinations(0, sub(sub(arr,minindex), i), cur_combinations); (*delete combinations that includes the current element*)
        val _ = update(cur_elements, sub(sub(arr,minindex), i)-1, 0);   (*delete the current element from solution*)
        val node2 = (cur_combinations, cur_elements);   (*make current state*)
        val _ = enqueue(myqueue, node2);    (*enqueue current state*)
        val zero = nocombinations(cur_combinations, 0); (*check if no other combinations*)
    in
        if (zero = 1) then
            (1,printlist(cur_elements, 0, Array.length cur_elements))   (*if no other combinations return the solution*)
        else if (i = k) then
                (0,[])
            else
                foreachelem(i+1, k, minindex)
    end
    );
    (*this function returns the index of the shortest combination*)
    fun findminindex (combinations, i)=(
    if (sub(combinations, i) = 1) then
        i
    else 
        findminindex (combinations, i+1)
    );
    val node1 = head myqueue;
    val minindex = findminindex(#1(node1), 0);
    val ret = foreachelem(1, sub(sub(arr,minindex), 0), minindex);
    val _ = dequeue myqueue
in
    if (#1(ret)=0) then
        bfs(myqueue, arr, m)    (*if there are still danger combinations continue bfs*)
    else
        #2(ret) (*else return the solution*)
end
);

fun danger fileName=
let
    val (n, m, lista)= parse fileName
    val listb = sort (fn (x,y) => sub(x,0) > sub(y,0)) lista;
    val arr = fromList(listb);
    val combinations = array(m, 1);
    val elements = array(n, 1);
    val node1 = (combinations, elements);
    val myqueue = mkQueue ();
    val _ = enqueue(myqueue, node1);
    val lista = bfs(myqueue, arr, m);
in
    lista
end;