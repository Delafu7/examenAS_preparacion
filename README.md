
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
### Comandos para discos

Todas las pariciones de disco se encuentran en **/dev/**. Ejemplo: /dev/sda (disco) o /dev/mdX (Raid).

Para crear particiones de disco se emplea **cfdisk**:

```bash

sudo cfdisk /dev/sdb
```

Comando **mkfs** : crea un sistema de ficheros -> mkfs.<tipo-de-sistema> <partición>

```bash
mkfs.ext4 /dev/sda3
```

Para montar una partición, se usa **mount** -> mount <opciones> [fichero-disp] [punto-montaje]

```bash
mount -t ext4 /dev/sdc1 /home/unai/miDisco
```

Desmontar particion, comando **umount** -> umount [punto-montaje]

Visualizar particiones:

- **lsblk -e7** -> Muestra discos y particiones
- **df -h** -> Muestra particiones y puntos de montaje
- **du -sh <archivo>** -> Muestra el tamaño que tiene un archivo o directorio


### Montaje automatico particiones

  ![captura2-1](/capturasTema2/cap1.png)
Para montar archivos debemos de buscar la UUID de nombres las particiones a montar:

  ```bash
        sudo blkid 
  ```

 Ejemplos de montajes en **/etc/fstab** :

```bash
    sudo nano /etc/fstab
```
```bash
UUID=66c8f008-0f46-46ed-9ea1-b0e2dbfaa75f  /disco1  ext3   defaults  0 2
UUID=fa76a4ca-3310-4aeb-b205-4d44d5ef2a7c  /disco2  btrfs  defaults  0 2
UUID=1a2087a0-1583-4430-9372-3252b77f7c45  /disco3  xfs    defaults  0 2
UUID=402841c3-4071-4815-90f5-1605b85fc09d /disco4  ext4   defaults  0 2
```
Probar el montaje automático:

```bash 
sudo mount -a
df -hT
```
### Redimensionar

Redimensionar la particion en un  fichero:

```bash
sudo resize2fs /dev/sdb1 3G
sudo cfdisk /dev/sdb
sudo mount /dev/sdb1 /disco1
df -hT /disco1
```
### Pruebas de rendimiento

```bash 
sudo apt install -y fio
```

```bash
sudo fio --name=random_write_test \
         --ioengine=libaio \
         --iodepth=256 \
         --rw=randwrite \
         --bs=4k \
         --size=1G \
         --runtime=1m --time_based \
         --direct=1 \
         --numjobs=1 \
         --directory=/mnt/disco1

```
| Parámetro                   | Significado                                                    |
| --------------------------- | -------------------------------------------------------------- |
| `--name=random_write_test`  | Nombre de la prueba                                            |
| `--ioengine=libaio`         | Usa la librería de I/O asíncrona de Linux                      |
| `--iodepth=256`             | Profundidad de cola de I/O (número de operaciones simultáneas) |
| `--rw=randwrite`            | Tipo de operación: escritura aleatoria                         |
| `--bs=4k`                   | Tamaño de bloque: 4 KB por operación                           |
| `--size=1G`                 | Tamaño total del archivo de prueba: 1 GB                       |
| `--runtime=1m --time_based` | Ejecutar durante 1 minuto, en lugar de usar tamaño como límite |
| `--direct=1`                | Escritura directa, evita la caché del sistema operativo        |
| `--numjobs=1`               | Número de hilos/trabajos ejecutándose en paralelo              |
| `--directory=/mnt/disco1`   | Carpeta donde se guarda el archivo de prueba                   |

### LVM

Volumen lógico LVM:

```bash
sudo pvcreate /dev/sdb1 /dev/sdb2 /dev/sdc1
sudo pvs
```
```bash
sudo vgcreate vg_datos /dev/sdb1 /dev/sdb2 /dev/sdc1
sudo vgs
```
```bash
sudo lvcreate -l 100%FREE -n lv_datos vg_datos
sudo lvs
```

Para extender el volumen lógico:

```bash
sudo vgextend vg_datos /dev/sdc2
sudo lvextend /dev/vg_datos/lv_datos /dev/sdc2
sudo resize2fs /dev/vg_datos/lv_datos
```
Para eliminar los volumenes lógicos creados:

```bash
sudo umount /mnt/lvm

sudo lvremove /dev/vg_datos/lv_datos
sudo lvs

sudo vgremove vg_datos
sudo vgs

sudo pvremove /dev/sdb1 /dev/sdb2 /dev/sdc1 /dev/sdc2

sudo pvs

```
### Raids

```bash
sudo apt install mdadm -y
```
Crear un sistema RAID 5 con 3 de las particiones. Crear un sistema de ficheros ext4 para el sistema RAID 5 y hacerlo accesible. Copiar el contenido de la carpeta /var a la carpeta del sistema RAID.

```bash
sudo mdadm --create  /dev/md0 --verbose --level=5 --raid-devices=3 /dev/sdb1 /dev/sdb2 /dev/sdc1

#Para ver los cambios
cat /proc/mdstat
sudo mdadm --detail /dev/md0

#Montaje
sudo mkfs.ext4 /dev/md0

sudo mkdir /mnt/raid5
sudo mount /dev/md0 /mnt/raid5
df -h /mnt/raid5

sudo cp -r /var/* /mnt/raid5/
ls /mnt/raid5 | head

```

Simular un fallo en el tercer disco (parámetro -f). Recuperar la información perdida usando la partición que quedó libre.

- Disco a simular fallo 

```bash
cat /proc/mdstat

sudo mdadm -f /dev/md0 /dev/sdc1
```
- Quitar disco
```bash
sudo mdadm -r /dev/md0 /dev/sdc1
```
- Añadir nuevo disco
```bash
sudo mdadm -a /dev/md0 /dev/sdc2
cat /proc/mdstat
sudo du -sh /mnt/raid5
```

### Backups

![captura2-2](/capturasTema2/cap2.png)

- Instalar rsnapshot en el sistema:

```bash
sudo apt install rsnapshot
```

Configurar rsnapshot de la siguiente forma:
a. Directorio para almacenar las copias de seguridad: /backups.
b. Niveles de copia e intervalos:
i. “horaria”, 24
ii. “diaria”, 7
iii. “semanal”, 4
c. Directorios a guardar (todos se almacenan en el directorio /backups): /home, /etc y /var/log


```bash
sudo nano /etc/rsnapshot.conf
```
Ruta de almacenamiento:

Busca la línea que empieza por snapshot_root y cámbiala así:

```bash
snapshot_root   /backups/
```
Intervalos de copia:

Agrega o modifica las líneas retain (en este orden):

```bash
retain  hourly  24
retain  daily   7
retain  weekly  4
```
Directorios a copiar:

Busca las líneas backup y deja así:

```bash
backup  /home/      localhost/
backup  /etc/       localhost/
backup  /var/log/   localhost/
```
- localhost/ es simplemente un nombre lógico dentro de /backups. Ejemplo: /backups/hourly.0/localhost/home/

Verificar que la configuración es correcta:

```bash
sudo rsnapshot configtest
```

Realizar una copia de tipo “horaria”:

```bash
sudo rsnapshot hourly
```
Comprobar cambios entre guardados:

```bash
sudo rsnapshot-diff /backups/hourly.1 /backups/hourly.0
```
## Tema 1.3:

## Tema 2.1:


