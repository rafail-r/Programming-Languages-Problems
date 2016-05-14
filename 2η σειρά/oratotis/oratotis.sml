open ListMergeSort;
open HashTable;
open Array;

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
    val _ = TextIO.inputLine stream
    (* a function to read the pair of integer & real in subsequent lines *)
        fun scanner 0 acc = acc
          | scanner i acc =
            let
                val xsw = next_int stream
                val ysw = next_int stream
                val xne = next_int stream
                val _ = next_int stream
                val (SOME h) = Real.fromString (next_real stream)
                val line = (xsw,ysw,xne,h)
            in
                scanner (i - 1) (line :: acc)
            end
    in
        (n, rev(scanner n []))
    end;

fun first  (x, _, _, _) = x;
fun second (_, x, _, _) = x;
fun third  (_, _, x, _) = x;
fun fourth (_, _, _, x) = x;
fun first2  (x, _) = x;
fun second2 (_, x) = x;

fun makexs(x::xs) = (first(x), 0.0)::(third(x), 0.0)::makexs(xs)
| makexs(nil) = nil;

fun removeduplicates(x::y::xs) = 
    if (first2(x) = first2(y)) then removeduplicates(y::xs)
    else x::removeduplicates(y::xs)
| removeduplicates(x : (int*real) list) = x;

exception cant_find_it;

fun populatehash(myhash, x::xs, i)=
    let
        val _ = insert myhash (first2(x), i)
    in
        populatehash(myhash, xs, i+1)
    end
|   populatehash(myhash, x, i) = 0;

fun xupdate(xstart, xx, height) = 
let
    val fi = first2(sub(xx, xstart));
    val _ = update(xx, xstart, (fi,height));
in
    1
end;

fun checkvis(xstart, xx, height : real, flag)=
    let
        val h = second2(sub(xx, xstart));
    in
        if (Real.>(height,h)) then
            xupdate(xstart, xx, height)
        else
            flag
    end;

fun updatex(xstart, xfinish, xx, height : real, flag)=
let
    val newflag = checkvis(xstart, xx, height, flag)
in
    if (xstart = xfinish) then
        newflag
    else
        updatex(xstart+1, xfinish, xx, height, newflag)
end;

fun counter(x::xs, xx, myhash, n)=
    let
        val firstx = first(x);
        val lastx = third(x);
        val xstart = lookup myhash firstx;
        val xfinish = lookup myhash lastx;
        val height = fourth(x);
        val tempcount = updatex(xstart, xfinish-1, xx, height, 0)
    in
        tempcount + counter(xs, xx, myhash, n)
    end
| counter(nil, xx, myhash, n) = 0

fun oratotis fileName =
    let
        val (n, input)= parse fileName;
        val buildings = sort (fn (x,y) => second(x) > second(y)) input;
        val xtemp = makexs(input);
        val xd = sort (fn (x,y) => first2(x) > first2(y)) xtemp;
        val xxx = removeduplicates(xd);
        val xx = Array.fromList(xxx);
        val myhash = mkTable (Word.fromInt, (op =)) (420000,cant_find_it);
        val _ = populatehash(myhash, xxx, 0);
        val count = counter(buildings, xx, myhash, n);
    in
        count
    end