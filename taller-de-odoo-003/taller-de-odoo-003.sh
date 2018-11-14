echo =============================================
echo Taller de Odoo 003
echo Instalando Reportes de Aeroo
echo taller-de-odoo-.slack.com
echo =============================================

echo =============================================
echo Instalando dependencias
echo =============================================
sudo apt-get install libreoffice-script-provider-python python3-genshi python3-cairo python3-lxml

echo =============================================
echo Instalando LibreOffice Standalone
echo =============================================
cd /etc/init.d
wget -L https://github.com/martinllanos/tallerdeodoo/raw/master/taller-de-odoo-003/office.sh
chmod +x /etc/init.d/office.sh
sudo update-rc.d office.sh defaults

echo =============================================
echo Instalando AerooLib
echo =============================================
sudo pip3 install jsonrpc2 daemonize
mkdir /home/odoo/odoo/aeroo
cd /home/odoo/odoo/aeroo
sudo git clone https://github.com/aeroo/aeroolib.git
cd /home/odoo/odoo/aeroo/aeroolib
sudo python3 setup.py install

echo =============================================
echo Instalando Aeroo Docs
echo =============================================
cd /home/odoo/odoo/aeroo/
git clone https://github.com/aeroo/aeroo_docs.git

echo =============================================
echo Creando el archivo de configuración de Aeroo_Docs
echo =============================================
sudo python3 /home/odoo/odoo/aeroo/aeroo_docs/aeroo-docs start -c /etc/aeroo-docs.conf

echo =============================================
echo Configurando el servicio aeroo-docs
echo =============================================
sudo ln -s /home/odoo/odoo/aeroo/aeroo_docs/aeroo-docs /etc/init.d/aeroo-docs
sudo update-rc.d aeroo-docs defaults

echo =============================================
echo Probamos los servicios
echo office.sh  | puerto: 8100
echo aeroo-docs | puerto: 8989
echo =============================================

sudo service office.sh start
sudo netstat -ltnp | grep soffice.bin
#odoo@tallerodoo:~$ sudo netstat -ltnp | grep soffice.bin
#tcp        0      0 127.0.0.1:8100          0.0.0.0:*               LISTEN      2417/soffice.bin

sudo service aeroo-docs start
#odoo@minimarket:~$ sudo netstat -ltnp | grep 8989
#tcp        0      0 127.0.0.1:8989          0.0.0.0:*               LISTEN      2459/python3

echo =============================================
echo Si queremos ver todos los puertos
echo =============================================
sudo netstat -ltna
# odoo@tallerodoo:~$ sudo netstat -ltnap
# Active Internet connections (servers and established)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      764/sshd
# tcp        0      0 0.0.0.0:5432            0.0.0.0:*               LISTEN      625/postgres
# tcp        0      0 127.0.0.1:8989          0.0.0.0:*               LISTEN      2459/python3
# tcp        0      0 127.0.0.1:8100          0.0.0.0:*               LISTEN      2417/soffice.bin
# tcp        0     64 192.168.0.117:22        192.168.0.108:56532     ESTABLISHED 1795/sshd: odoo [pr
# tcp        0      0 127.0.0.1:8100          127.0.0.1:35308         ESTABLISHED 2417/soffice.bin
# tcp        0      0 127.0.0.1:35308         127.0.0.1:8100          ESTABLISHED 2459/python3
# tcp6       0      0 :::22                   :::*                    LISTEN      764/sshd
# tcp6       0      0 :::5432                 :::*                    LISTEN      625/postgres