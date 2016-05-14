open Array;
open List;

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
        val l = next_int stream
    in
        (n, l)
    end;

fun sumdigits(a)=(
if (a=0) then 0
else
((a mod 10)*(a mod 10)+sumdigits(a div 10)));

fun ishappy(a)=(
let
    val n = sumdigits(a);
in
    if (n=1)
        then 1
    else 
        if (n=4 orelse n=16 orelse n=37 orelse n=58 orelse n=89 orelse n=145 orelse n=42 orelse n=20)
            then 0
        else
            ishappy(n)
end
);

fun makeL (a, i)=(
    update (a, i, sub(a, i-1)+81);
    if (i < 9) then makeL(a, i+1) else a
);

fun makeC0 (a)=(
    update (a, 0, 1);
    a
);

fun makeCache (a, i)=(
    update (a, i, ishappy(i));
    if (i < 729) then 
        makeCache (a, i+1) 
    else 
        a
);

fun makefi(c,k,i,j,y)=(
    if (i < sub(y, k)) then
        makefj(c,k,i,j,y)
    else
        makeC(c,k+1,0,0,y)
)
and makefj(c,k,i,j,y)=(
    update(nth(c,k),i+(j*j),sub(nth(c,k),i+(j*j))+sub(nth(c,k-1),i));
    if (j < 9) then
        makefj(c,k,i,j+1,y)
    else
        makefi(c,k,i+1,0,y)
)
and makeC(c,k,i,j,y)=(
    if (k < 10) then
        makefi(c,k,i,j,y)
    else
        c
);

fun sumdigits(a)=(
    if (a=0) then 
        0
    else
        ((a mod 10)*(a mod 10)+sumdigits(a div 10))
);

fun initd(d, i, x)=(
    update(d, i, x mod 10);
    if (x > 0) then 
        initd(d, i+1, x div 10)
    else
        i-1
);

fun calc3(x, z, y, c, d, k, i, j, last)=(
    if (k >= 0) then
        calc2(x, z, y, c, d, k, i, j, last)
    else
        0
)
and calc2(x, z, y, c, d, k, i, j, last)=(
    if (i < sub(d, k)) then
        calc1(x, z, y, c, d, k, i, j, last)
    else
        calc3(x, z, y, c, d, k-1, 0, 0, last+sub(d,k)*sub(d,k))
)
and calc1(x, z, y, c, d, k, i, j, last)=(
    if (j <= sub(y,k)) then
        calc1(x, z, y, c, d, k, i, j+1, last)+sub(nth(c,k),j)*sub(z,j+i*i+last)
    else
        calc2(x, z, y, c, d, k, i+1, 0, last)
);

fun calc(x,z,y,c)=(
let
    val d = array(10, 0);
    val idx = initd(d, 0, x);
    val sum = calc1(x, z, y, c, d, idx, 0, 0, 0);
in
    sum
end
);

fun happy fileName=
let
    val (a, b) = parse fileName;
    val y = makeL(array(10, 0), 1);
    val z = makeCache(array(730, 0), 1);
    val c1 = makeC0(array(730, 0));
    val c = [c1,array(730,0),array(730,0),array(730,0),array(730,0),
        array(730,0),array(730,0),array(730,0),array(730,0),array(810,0)];
    val test = makeC(c, 1, 0, 0, y);
in
    if (a=1000000000 andalso b=1000000000) then 1
    else if (a=0 andalso b=0) then 0
    else if (a=0 andalso b=1000000000) then calc(b-1,z,y,c)-calc(a+1,z,y,c)+1
    else if (a=0) then calc(b+1,z,y,c)-calc(a+1,z,y,c)
    else if (b=1000000000) then calc(b-1,z,y,c)-calc(a,z,y,c)+1
    else calc(b+1,z,y,c)-calc(a,z,y,c)
end;