# Ada_Project

Yatzy multiplayer terminal game currently under construction for school project.
Assignment: https://www.ida.liu.se/~TDDD11/2019/Matr/SN/projectmaterial.sv.shtml


# HOW TO COMPILE

First, make sure you are in the correct folder (Klient or Server)

Klient:
gnatmake  -aL/courses/TDDD11/TJa/obj -aI/courses/TDDD11/TJa/src -aO/courses/TDDD11/TJa/obj  klient.adb

Server:
gnatmake  -aL/courses/TDDD11/TJa/obj -aI/courses/TDDD11/TJa/src -aO/courses/TDDD11/TJa/obj -I../ server.adb
