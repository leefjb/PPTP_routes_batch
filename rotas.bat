@echo off

::verificar o nome da conexão ativa
set connection_string="PPP"
for /f "usebackq tokens=* delims=:" %%f in (`ipconfig ^| findstr /c:%connection_string%`) do set conn=%%f
for %%A IN (%conn%) DO SET conn_name=%%A
set conn_name=%conn_name::=%
::echo %conn_name%

::encontrar o endereço de IP da conexão
set ip_address_string="IP"
for /f "usebackq tokens=2 delims=:" %%f in (`netsh interface ip show address "%conn_name%" ^| findstr /c:%ip_address_string%`) do set gate_ip=%%f
set gate_ip=%gate_ip: =%
::echo %gate_ip%

::configura rotas
if %conn_name%==Schalter (netsh int ipv4 add route 192.168.1.0/24 "%conn_name%" %gate_ip% | echo Adicionada rota para %conn_name%) else (echo .>nul)
if %conn_name%==IPS (netsh int ipv4 add route 10.0.0.0/24 "%conn_name%" %gate_ip% | echo Adicionada rota para %conn_name%) else (echo .>nul)
if %conn_name%==Mullplast (netsh int ipv4 add route 192.168.1.0/24 "%conn_name%" %gate_ip% | echo Adicionada rota para %conn_name%) else (echo .>nul)


