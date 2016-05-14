open List;
open Array;
open Queue;

fun chartoint([], intlist)=rev intlist
    | chartoint(#"b"::xs, intlist) = chartoint(xs,1::intlist)
    | chartoint(#"g"::xs, intlist) = chartoint(xs,2::intlist)
    | chartoint(#"r"::xs, intlist) = chartoint(xs,3::intlist)
    | chartoint(#"y"::xs, intlist) = chartoint(xs,4::intlist)
    | chartoint(#"G"::xs, intlist) = chartoint(xs,0::intlist)
    | chartoint(_::xs, intlist) = chartoint(xs,intlist);

fun rotate(intarr,1)=
let
    val temp = sub(intarr,0);
    val _ = update(intarr, 0, sub(intarr,2));
    val _ = update(intarr, 2, sub(intarr,5));
    val _ = update(intarr, 5, sub(intarr,3));
    val _ = update(intarr, 3, temp);
in
    "1"
end
| rotate(intarr,2)=
let
    val temp = sub(intarr,1);
    val _ = update(intarr, 1, sub(intarr,3));
    val _ = update(intarr, 3, sub(intarr,6));
    val _ = update(intarr, 6, sub(intarr,4));
    val _ = update(intarr, 4, temp);
in
    "2"
end
| rotate(intarr,3)=
let
    val temp = sub(intarr,5);
    val _ = update(intarr, 5, sub(intarr,7));
    val _ = update(intarr, 7, sub(intarr,10));
    val _ = update(intarr, 10, sub(intarr,8));
    val _ = update(intarr, 8, temp);
in
    "3"
end
| rotate(intarr,4)=
let
    val temp = sub(intarr,6);
    val _ = update(intarr, 6, sub(intarr,8));
    val _ = update(intarr, 8, sub(intarr,11));
    val _ = update(intarr, 11, sub(intarr,9));
    val _ = update(intarr, 9, temp);
in
    "4"
end
| rotate(intarr,_)=
    "0";

fun deal(arr) = 
    if (sub(arr,0)=1 andalso sub(arr,1)=2 andalso sub(arr,2)=1 andalso
    sub(arr,3)=0 andalso sub(arr,4)=2 andalso sub(arr,5)=0 andalso
    sub(arr,6)=0 andalso sub(arr,7)=3 andalso sub(arr,8)=0 andalso
    sub(arr,9)=4 andalso sub(arr,10)=3 andalso sub(arr,11)=4) then
        true 
    else 
        false;

fun enq(myqueue,temp_arr, temp_list, mems, memb, dec)=
if (dec < 134217720) then
    if (BitArray.sub(mems, dec)) then
        0
    else
        let
            val _ = enqueue(myqueue, (temp_arr,temp_list));
            val _ = BitArray.setBit(mems, dec);
        in
            1
        end
else
    if (BitArray.sub(memb, dec-134217720)) then
        0
    else
        let
            val _ = enqueue(myqueue, (temp_arr,temp_list));
            val _ = BitArray.setBit(memb, dec-134217720);
        in
            1
        end;

fun calcdec (temp_arr, digits, sum, i)=(
    if (i < 12) then 
        let
            val temp = sum + (sub(temp_arr, i) * sub(digits, i));
        in
            calcdec(temp_arr,digits, temp, i+1)
        end
    else sum
);

fun foreachelem(i, myqueue, mems, memb, digits)=(
let 
    val node = head myqueue;
    val temp_arr = array(12, 0); 
    val _ = copy {src= #1(node), dst=temp_arr, di=0};
    
    val temp_string = rotate(temp_arr, i);
    val temp_list = temp_string::(#2(node));
    val check = deal(temp_arr);
    val dec = calcdec(temp_arr, digits, 0, 0);
    val _ = enq(myqueue,temp_arr, temp_list, mems, memb, dec);
in
    if (check = true) then
        (1,temp_list)   (*if no other combinations return the solution*)
    else if (i = 4) then
            (0,[])
        else
            foreachelem(i+1, myqueue, mems, memb, digits)
end
);

fun bfs(myqueue,mems, memb, digits)=(
let
    val ret = foreachelem(1,myqueue, mems, memb, digits);
    val _ = dequeue myqueue
in
    if (#1(ret)=0) then
        bfs(myqueue, mems,memb, digits)
    else
        #2(ret)
end
);

fun makedigits (a, i)=(
    update (a, i, sub(a, i-1)*5);
    if (i < 11) then makedigits(a, i+1) else 0
);

fun noprint(result,intarr)=(
    if(deal(intarr)) then
        ""
    else
        result
);

fun diapragmateysi input=
let
    val inputstring = input^"m";
    val charlist = explode inputstring;
    val intlist = chartoint (charlist, []);
    val intarr = fromList intlist;
    val node1 = (intarr, []);
    val myqueue = mkQueue ();
    val _ = enqueue(myqueue, node1);
    val mems = BitArray.bits(134217720, []);
    val memb = BitArray.bits(107379790, []);
    val digits = array(12,1);
    val _ = makedigits(digits, 1);
    val lista = bfs(myqueue, mems, memb, digits);
    val listb = rev(lista);
    val result = String.concat listb;
    val result2 = noprint(result,intarr);
in
    result2
end