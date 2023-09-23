import jflex.exceptions.SilentExit;

public class ExecuteJFlex {

    public static void main(String omega[]) {
        // directorios
        String lexerFile = System.getProperty("user.dir") + "/src/Lexer.flex",
                // String lexerFile =
                // System.getProperty("E:/Trabajos/uptc/2023-1/Lenguajes/ProyectoLF/Compilador/Lexer.flex"),
                lexerFileColor = System.getProperty("user.dir") + "/src/LexerColor.flex";
        try {
            jflex.Main.generate(new String[] { lexerFile, lexerFileColor });
        } catch (SilentExit ex) {
            System.out.println("Error al compilar/generar el archivo flex: " + ex);
        }
    }
}
