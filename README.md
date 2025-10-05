
# Preparación para el examen

# Indice

## Tema 1.1:

   ### Comandos basicos:

   - **man**: man <comando>  -> info de comando
   ![captura1](/capturasTema1/cap1.png)
   ![captura2](/capturasTema1/cap2.png)
   ![captura3](/capturasTema1/cap3.png)
   - **chmod**: Modifica permisos de archivos o directorios
   - **chown**: Modificar UID/GID de un fichero
   - **last** : Las ultimas entradas (-n numero de entradas)
Ejemplos de sort:
- sort -t: -k1,1 /etc/passwd   
- sort -t: -k3,3n /etc/passwd
- sort -t: -k4,4n /etc/passwd

   ### Info directorios: 

   - Ejemplo contenido de **/etc/passwd** o tambien puede ser **/etc/group**:
   ![captura4](/capturasTema1/cap4.png)
   - Ejemplo contenido **/etc/shadow**:

   ![captura5](/capturasTema1/cap5.png)

   ### Shell Info
   ![captura6](/capturasTema1/cap6.png)
   ![captura7](/capturasTema1/cap7.png)

   Algunas expresiones regulares:

   - ^ → principio de línea

    - $ → fin de línea

    - Puedes usar rangos:

    ```bash 
    [a-z]   # letras minúsculas
    [A-Z]   # letras mayúsculas
    [0-9]   # dígitos
    [a-zA-Z0-9]  # alfanuméricos

    ```

    - Negar conjunto: ^ dentro de [] significa “todo menos”. [^0-9]

    | Regex   | Significado                 |
| ------- | --------------------------- |
| `*`     | 0 o más repeticiones        |
| `+`     | 1 o más repeticiones        |
| `?`     | 0 o 1 repetición (opcional) |
| `{n}`   | exactamente n repeticiones  |
| `{n,}`  | n o más                     |
| `{n,m}` | entre n y m repeticiones    |

   ### Principales ejercicios vistos en clase:

   1. Crear un script que pida al usuario que teclee una palabra y escriba por pantalla el número de caracteres de esa palabra.

   ```bash 
   # Pedir palabra al usuario
read -p "Escribe una palabra: " palabra

# Calcular longitud usando ${#variable}
longitud=${#palabra}

# Mostrar resultado
echo "La palabra '$palabra' tiene $longitud caracteres."

   ```

2. Crear un script que pida al usuario que teclee una palabra y compruebe si es un comando del sistema o no.

```bash 
    echo -n "Escribe un comando: " 
    read comando
    if command -v $comando > /dev/null 2>&1; then

            echo " El $comando es un comando de bash."
    else

            echo "El $comando no es un comando de bash."
    fi

```
3. Crear ficheros con una linea de man ls cada uno.

```bash
mkdir -p cosas
man ls | cat -n  > manu_ls.txt
for num in {0..99}; do
        linea=$(sed -n "$((num+1))p" manu_ls.txt)
        echo "$linea" > "cosas/fich${num}.txt"
done
rm manu_ls.txt

```

4. Crear un script que modifique la extensión de todos los ficheros .txt de un directorio a .t.

```bash
for fichero in `ls`; do 
       if [[ $fichero = *.txt ]];then
           nombre=${fichero%.txt}
            mv "$fichero" "${nombre}.t"
       fi
done

```
5. Crear un script borra.sh que reciba un número indefinido de parámetros (de 0 a 9) y borre el fichero correspondiente a la suma del valor de los parámetros que reciba.

```bash
if [ $# -eq 0 ]; then
        echo  "No se ha introducido parametros"
        exit 1
        fi

suma=0

for param in "$@"; do

        case "$param" in
        [0-9]) ;;  # válido
        *)
            echo "Parámetro inválido: $param. Debe ser un número entre 0 y 9."
            exit 1
            ;;
        esac
        suma=$((suma + param))

done

fichero="fich${suma}.txt"

if [ -e "$fichero" ]; then
    rm "$fichero"
    echo "Archivo '$fichero' borrado."
else
    echo "Archivo '$fichero' no existe."
fi

```

6. Crear mensajes para cada persona:

```bash
# Verificamos que los archivos existen
if [[ ! -f cuerpo.txt ]] || [[ ! -f nombres.txt ]]; then
  echo "Faltan cuerpo.txt o nombres.txt"
  exit 1
fi

# Leemos cada nombre de nombres.txt
while read -r nombre; do
  # Creamos un nombre de archivo sin espacios
  archivo="email_${nombre// /_}.txt"

  # Sustituimos "NOMBRE" por el nombre actual y guardamos en un archivo nuevo
  sed "s/NOMBRE/$nombre/g" cuerpo.txt > "$archivo"

  echo "Generado: $archivo"
done < nombres.txt

```
## Tema 1.2:


## Tema 1.3:

## Tema 2.1:

