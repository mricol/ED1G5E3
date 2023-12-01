# Sumador restador de 4 bits
## Introducción 

En el vasto campo de la electrónica digital, los circuitos sumadores y restadores son componentes fundamentales que posibilitan operaciones aritméticas cruciales en el procesamiento de datos. Un sumador-restador es un dispositivo capaz de llevar a cabo tanto la suma como la resta de números binarios, desempeñando un papel esencial en la realización de cálculos y en la manipulación de información en el ámbito digital.

Este informe se centra en la comprensión y el diseño de un sumador-restador, explorando sus principios fundamentales, su estructura lógica y su funcionamiento a nivel de circuito. Desde su conceptualización hasta su implementación práctica, se analizarán los componentes clave y los métodos utilizados en la construcción de este componente crucial en la electrónica digital. A lo largo de este informe, se abordarán diferentes tipos de sumadores-restadores, sus aplicaciones y su relevancia en diversos contextos tecnológicos.

Nuestro objetivo principal es proporcionar una visión detallada y comprehensiva sobre el funcionamiento de un sumador-restador de 4 bits en el procesamiento de información binaria.

## Marco teórico

El sistema binario es la base fundamental en la electrónica digital, utilizando únicamente dos dígitos, 0 y 1, para representar información. Las operaciones aritméticas básicas, como la suma y la resta, se realizan de manera similar a las operaciones en el sistema decimal, pero adaptadas al sistema binario.

### Suma binaria

La suma de números binarios se lleva a cabo mediante la aplicación de reglas similares a las de la suma decimal. Los bits individuales se suman, considerando acarreos hacia los bits de mayor peso cuando la suma excede el valor binario de 1. En el caso de sumadores digitales, existen diferentes enfoques, como el sumador medio, el sumador completo y el sumador completo con acarreo anticipado (CLA).

### Resta binaria

La resta en el sistema binario implica un proceso que puede reescribirse como una operación de suma con un complemento. Se utiliza el método del complemento a dos, donde se invierten los bits y se suma 1 al número negativo para obtener la resta deseada. En circuitos digitales, se emplean sumadores y complementadores para realizar operaciones de resta.

### Sumador-Restador

Un sumador-restador es un componente esencial en la aritmética binaria, capaz de realizar tanto operaciones de suma como de resta. Este circuito combina las capacidades de un sumador y un restador en una única estructura, utilizando lógica combinacional para determinar el tipo de operación a realizar según la entrada de control.

## Circuitos

### Semisumador
Primero se realizó un circuito base semisumador el cual es una parte inicial del sumador. Utiliza una puerta lógica XOR para calcular la suma binaria de dos bits y una puerta lógica AND para generar la señal de acarreo que indica si hay un acarreo de un bit al siguiente en la suma.

![image](https://github.com/mricol/ED1G5E3/assets/82113257/b6a34a46-627f-4d0c-bc48-0c8596dd9561)

### Sumadores

Para realizar un sumador completo, se utilizan dos circuitos base semisumadores, uno tras otro, se crea un sumador de un solo bit. Este sumador de un bit incluye un acarreo de entrada adicional (Carry In), que representa el acarreo procedente de cálculos previos o la entrada directa de un bit en una suma más grande.

![image](https://github.com/mricol/ED1G5E3/assets/82113257/ad0b914d-3f59-4127-923c-c7ee7dfa8c82)

Ahora, para realizar un sumador de 4 bits, se necesitan cuatro sumadores de un bit. Los sumadores de un bit se conectan en serie, de manera que el acarreo de salida (Carry Out) de un sumador de un bit se convierte en el acarreo de entrada (Carry In) del siguiente sumador de un bit. Esto permite que se procesen los bits y los acarreos a lo largo de los cuatro sumadores.

![image](https://github.com/mricol/ED1G5E3/assets/82113257/46d8b060-5226-4e7b-a2dd-698caa5de9df)

### Restador

Para restar un número en lugar de sumarlo, primero hay que obtener su complemento a dos. Esto se logra invirtiendo todos los bits del número y sumándole 1 al resultado. En la operación de resta de un número de 4 bits, se utiliza compuertas XOR para invertir los bits cuando sea necesario. Después de esta inversión, se agrega 1 al número, completando así la transformación al complemento a dos.

![image](https://github.com/mricol/ED1G5E3/assets/82113257/20060c8b-ab78-4f30-88a1-46c606aea8fc)

###
