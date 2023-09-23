import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
ContenidoComentario = ( [^#] |[^*] | \*+ [^/*] )*
ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

/* Comentario */
Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Número */
Numero = 0 | [1-9][0-9]*
%%

/* Comentarios o espacios en blanco */
{Comentario}|{EspacioEnBlanco} { /*Ignorar*/ }

/*Tipos de dato*/

T_NIL |
T_OBJECT |
T_CLASS |
T_MODULE |
T_FLOAT |
T_STRING |
T_REGEXP |
T_ARRAY |
T_HASH |
T_STRUCT |
T_BIGNUM |
T_FIXNUM |
T_COMPLEX |
T_RATIONAL |
T_FILE |
T_TRUE |
T_FALSE |
T_DATA |
T_SYMBOL |
T_ICLASS |
T_MATCH |
T_UNDEF |
T_NODE |
T_ZOMBIE {return token(yytext(), "TIPO_DATO", yyline, yycolumn);}

/*Reservadas*/
BEGIN |
END
alias  |
and |
begind |
break |
case |
class |
def |
defined? |
do |
else |
elsif |
end |
ensure |
false |
for |
if |
in |
module |
next |
nil |
not |
or |
puts |
redo |
rescue |
retry |
return |
self |
super |
then |
true |
undef |
unless |
until |
when |
while |
__file__ |
__LINE__ {return token(yytext(), "RESERVADAS", yyline, yycolumn);}

/*Numero*/
{Numero}{return token(yytext(), "NUMERO", yyline, yycolumn);}

/*Operadores de agrupacion*/
"("{return token(yytext(), "PARENTESIS_OPEN", yyline, yycolumn);}
")" {return token(yytext(), "PARENTESIS_CLOSE", yyline, yycolumn);}
"{"{return token(yytext(), "LLAVE_O", yyline, yycolumn);}
"}" {return token(yytext(), "LLAVE_C", yyline, yycolumn);}

/*Signos de Puntuacion*/
","{return token(yytext(), "COMA", yyline, yycolumn);}
";" {return token(yytext(), "PUNTO_COMA", yyline, yycolumn);}

/*Operadores DE Asignacion*/
"="{return token(yytext(), "OP_ASIG", yyline, yycolumn);}


. { return token(yytext(), "ERROR", yyline, yycolumn); }