;========================================================
; SAFE DRIVE SYSTEM - EMU8086
;========================================================
; FUNCIONES:
; - Login
; - Unidad virtual Z:
; - Explorador de archivos
; - Encriptacion XOR
; - Busqueda
; - Eliminacion
; - Estadisticas
;
; USUARIO: admin
; PASSWORD: 1234
;========================================================

.model small
.stack 100h

.data

;========================================================
; TITULOS
;========================================================

titulo db 13,10,'========================================$'
titulo2 db 13,10,'        SAFE DRIVE SYSTEM               $'
titulo3 db 13,10,'========================================$'

msgUser db 13,10,'Usuario: $'
msgPass db 13,10,'Password: $'

msgOk db 13,10,'ACCESO CONCEDIDO$'
msgError db 13,10,'ACCESO DENEGADO$'

;========================================================
; MENU
;========================================================

menu db 13,10
     db 13,10,'=========== UNIDAD Z: ==========='
     db 13,10,'1. Ver archivos'
     db 13,10,'2. Crear archivo'
     db 13,10,'3. Encriptar archivo'
     db 13,10,'4. Buscar archivo'
     db 13,10,'5. Eliminar archivo'
     db 13,10,'6. Estadisticas'
     db 13,10,'7. Salir'
     db 13,10,'Seleccione opcion: $'

;========================================================
; LOGIN
;========================================================

usuarioCorrecto db 'admin','$'
passwordCorrecto db '1234','$'

inputUser db 20 dup('$')
inputPass db 20 dup('$')

;========================================================
; ARCHIVOS
;========================================================

archivo1 db 'reporte.txt','$'
archivo2 db 'tareas.doc','$'
archivo3 db 'foto.bmp','$'
archivo4 db 'vacio','$'
archivo5 db 'vacio','$'

msgArchivos db 13,10
             db 13,10,'====== ARCHIVOS EN Z: ======$'

msgCrear db 13,10,'Nombre nuevo archivo: $'

msgBuscar db 13,10,'Buscar archivo: $'

msgEliminar db 13,10
              db 'Eliminar archivo (1-5): $'

msgEncontrado db 13,10,'ARCHIVO ENCONTRADO$'
msgNoEncontrado db 13,10,'ARCHIVO NO ENCONTRADO$'

msgEliminado db 13,10,'ARCHIVO ELIMINADO$'

msgEncrypt db 13,10,'Archivo encriptado XOR$'

msgStats db 13,10
          db 13,10,'USO DE ALMACENAMIENTO'
          db 13,10,'[##########------] 65%$'

newline db 13,10,'$'

buffer db 30 dup('$')

opcion db ?

.code

;========================================================
; MAIN
;========================================================

main PROC

mov ax,@data
mov ds,ax

call limpiar

;========================================================
; TITULO
;========================================================

lea dx,titulo
call imprimir

lea dx,titulo2
call imprimir

lea dx,titulo3
call imprimir

;========================================================
; LOGIN
;========================================================

lea dx,msgUser
call imprimir

lea dx,inputUser
call leerCadena

lea dx,msgPass
call imprimir

lea dx,inputPass
call leerCadena

; VALIDAR USUARIO

mov al,inputUser[0]
cmp al,'a'
jne accesoDenegado

; VALIDAR PASSWORD

mov al,inputPass[0]
cmp al,'1'
jne accesoDenegado

lea dx,msgOk
call imprimir

jmp menuPrincipal

;========================================================
; ACCESO DENEGADO
;========================================================

accesoDenegado:

lea dx,msgError
call imprimir

jmp salir

;========================================================
; MENU PRINCIPAL
;========================================================

menuPrincipal:

call nuevaLinea

lea dx,menu
call imprimir

mov ah,01h
int 21h

mov opcion,al

;----------------------------------------
; OPCION 1
;----------------------------------------

cmp opcion,'1'
jne opcion2
jmp verArchivos

;----------------------------------------
; OPCION 2
;----------------------------------------

opcion2:
cmp opcion,'2'
jne opcion3
jmp crearArchivo

;----------------------------------------
; OPCION 3
;----------------------------------------

opcion3:
cmp opcion,'3'
jne opcion4
jmp encriptar

;----------------------------------------
; OPCION 4
;----------------------------------------

opcion4:
cmp opcion,'4'
jne opcion5
jmp buscarArchivo

;----------------------------------------
; OPCION 5
;----------------------------------------

opcion5:
cmp opcion,'5'
jne opcion6
jmp eliminarArchivo

;----------------------------------------
; OPCION 6
;----------------------------------------

opcion6:
cmp opcion,'6'
jne opcion7
jmp estadisticas

;----------------------------------------
; OPCION 7
;----------------------------------------

opcion7:
cmp opcion,'7'
jne opcionInvalida
jmp salir

opcionInvalida:
jmp menuPrincipal

;========================================================
; VER ARCHIVOS
;========================================================

verArchivos:

call nuevaLinea

lea dx,msgArchivos
call imprimir

call nuevaLinea
lea dx,archivo1
call imprimir

call nuevaLinea
lea dx,archivo2
call imprimir

call nuevaLinea
lea dx,archivo3
call imprimir

call nuevaLinea
lea dx,archivo4
call imprimir

call nuevaLinea
lea dx,archivo5
call imprimir

call nuevaLinea

jmp menuPrincipal

;========================================================
; CREAR ARCHIVO
;========================================================

crearArchivo:

call nuevaLinea

lea dx,msgCrear
call imprimir

lea dx,buffer
call leerCadena

mov si,0

guardarLoop:

mov al,buffer[si]
mov archivo4[si],al

cmp al,'$'
je creado

inc si
jmp guardarLoop

creado:

call nuevaLinea

jmp menuPrincipal

;========================================================
; ENCRIPTAR
;========================================================

encriptar:

mov si,0

encryptLoop:

mov al,archivo1[si]

cmp al,'$'
je finEncrypt

xor al,05h

mov archivo1[si],al

inc si
jmp encryptLoop

finEncrypt:

lea dx,msgEncrypt
call imprimir

jmp menuPrincipal

;========================================================
; BUSCAR ARCHIVO
;========================================================

buscarArchivo:

call nuevaLinea

lea dx,msgBuscar
call imprimir

lea dx,buffer
call leerCadena

mov al,buffer[0]

cmp al,archivo1[0]
je encontrado

cmp al,archivo2[0]
je encontrado

cmp al,archivo3[0]
je encontrado

cmp al,archivo4[0]
je encontrado

cmp al,archivo5[0]
je encontrado

jmp noEncontrado

encontrado:

lea dx,msgEncontrado
call imprimir

jmp menuPrincipal

noEncontrado:

lea dx,msgNoEncontrado
call imprimir

jmp menuPrincipal

;========================================================
; ELIMINAR ARCHIVO
;========================================================

eliminarArchivo:

call nuevaLinea

lea dx,msgEliminar
call imprimir

mov ah,01h
int 21h

cmp al,'1'
je borrar1

cmp al,'2'
je borrar2

cmp al,'3'
je borrar3

cmp al,'4'
je borrar4

cmp al,'5'
je borrar5

jmp menuPrincipal

borrar1:
mov archivo1[0],'X'
jmp eliminado

borrar2:
mov archivo2[0],'X'
jmp eliminado

borrar3:
mov archivo3[0],'X'
jmp eliminado

borrar4:
mov archivo4[0],'X'
jmp eliminado

borrar5:
mov archivo5[0],'X'

eliminado:

lea dx,msgEliminado
call imprimir

jmp menuPrincipal

;========================================================
; ESTADISTICAS
;========================================================

estadisticas:

lea dx,msgStats
call imprimir

jmp menuPrincipal

;========================================================
; SALIR
;========================================================

salir:

mov ah,4Ch
int 21h

main ENDP

;========================================================
; PROCEDIMIENTOS
;========================================================

;--------------------------------------------------------
; IMPRIMIR
;--------------------------------------------------------

imprimir PROC

mov ah,09h
int 21h

ret

imprimir ENDP

;--------------------------------------------------------
; LEER CADENA
;--------------------------------------------------------

leerCadena PROC

mov si,0
mov bx,dx

leerLoop:

mov ah,01h
int 21h

cmp al,13
je finLeer

mov [bx+si],al

inc si
jmp leerLoop

finLeer:

mov byte ptr [bx+si],'$'

ret

leerCadena ENDP

;--------------------------------------------------------
; LIMPIAR PANTALLA
;--------------------------------------------------------

limpiar PROC

mov ah,00h
mov al,03h
int 10h

ret

limpiar ENDP

;--------------------------------------------------------
; NUEVA LINEA
;--------------------------------------------------------

nuevaLinea PROC

lea dx,newline
call imprimir

ret

nuevaLinea ENDP

END main