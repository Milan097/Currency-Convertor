# Currency-Convertor
This is application build in bison that is used to convert amount given in one currency to another.

Compilation Steps :
    <pre><code>
        yacc -d currency.y<br>
        lex currency.l<br>
        cc lex.yy.c y.tab.c -o currency_convertor.exe<br>
        ./currency_convertor.exe
    </code></pre>
