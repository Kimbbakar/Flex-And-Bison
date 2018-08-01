<h1 align = "center">Flex And Bison</h1>


<h3 align = "center">Flex</h3>

Total 21 types of token this lexer can recognize. 

<ol>

<li>

Data types:
<i>
<ul>
<li> Int. e.g. 234,3445,2234
<li> Float. e.g. 234.34,345.5,1.00
<li> String. e.g. "sdf", "a", "Ads"
<li> Character. e.g. 's', 'A'
</ul>
</i>
</li>

<li> It also can seperate Binary Operations like:
<ul>
<li> '-'(Minus)
<li> '+'(Addition)
<li> '*'(Multiplication)
<li> '/'(Divide)
<li> ':='(Assignment) 
</ul>
</li>

<li>We Skip space (' '), tab (\t), and new line (\n) </li>
<li> End of statement recognized by semicolon (';'). </li>
<li> 'exit' token terminate the program. </li>

</ol>

<h3 align = "center">Parser</h3>

In our parser we have tried to replicate the grammer below.
~~~
PROG → STMTS
STMTS → STMT STMTS | ɛ
STMT → DTYPE id IDLIST SEMI
STMT → id := EXPR SEMI
IDLIST → , id IDLIST | ɛ
EXPR → EXPR OPTR TERM | TERM
EXPR → ( EXPR ) | neg EXPR
TERM → id | CONST
DTYPE → int | float | char
CONST → ilit | rlit | clit | slit
OPTR → + | - | * | / | %
~~~

<h3 align = "center">Limitation & Compile Process</h3>

1.  Still, we can store value and operate arithmetic operation.

~~~
flex gxx.l
bison -dyv gxx.y
gcc lex.yy.c y.tab.c -o gxx.exe
~~~

