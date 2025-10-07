echo "Opciones a realizar en el examen: "
echo "1) Enviar este archivo a la VM (local)"
echo "2) Crear carpeta (VM)"
echo "3) Hacer history y ponerlo en la carpeta (VM)"
echo "4) Copiar el archivo de history automatico (VM)"
echo "5) Comprimir carpeta examen (VM)"
echo "6) Pasarlo a mi escritorio (local)"
read -p "Tu respuesta es: " num

ipServer=34.133.13.204
case $num in
	1) scp controlExamen.sh eneko@$ipServer:/home/eneko/controlExamen.sh ;;
	2) mkdir 46371998_Eneko_Delafuente ;;
	3) history > 46371998_Eneko_Delafuente/eneko_history ;;
	4) cp $HOME/.bash_history   $HOME/46371998_Eneko_Delafuente/eneko_history ;;
	5) tar -cvzf 46371998_Eneko_Delafuente.tar.gz 46371998_Eneko_Delafuente/ ;;
        6)scp eneko@$ipServer:/home/eneko/46371998_Eneko_Delafuente.tar.gz 46371998_Eneko_Delafuente.tar.gz ;;
esac 
