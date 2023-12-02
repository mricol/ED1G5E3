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

### Componente restadora

Para restar un número en lugar de sumarlo, primero hay que obtener su complemento a dos. Esto se logra invirtiendo todos los bits del número y sumándole 1 al resultado. Para el circuito complemento a2 de un número de 4 bits, se utilizan compuertas XOR para invertir los bits cuando sea necesario. Después de esta inversión, se agrega 1 al número, completando así la transformación al complemento a2.

![image](https://github.com/mricol/ED1G5E3/assets/82113257/20060c8b-ab78-4f30-88a1-46c606aea8fc)

### Sumador-Restador de 4 bits

En la finalización del diseño del sumador-restador de 4 bits, se utiliza primero un circuitos complemento a2 para cada entrada, después de esto se le agrega un sumador de 4 bits y luego de esto, se coloca otro módulo de complemento a2 a la salida del sumador para facilitar la interpretación del resultado.

Para determinar el signo del resultado, se suman los bits de signo de los números de entrada. Sin embargo, cuando ambos números son negativos, se emplea una compuerta lógica AND y un multiplexor para decidir si se utiliza la señal del semisumador de signo o la salida de la compuerta AND de signo para establecer el signo resultante. Esto se hace para gestionar correctamente los casos especiales donde ambos números son negativos.

Y de esta manera se puede leer en la salida el signo corespontiente de la operación y el número binario.

![image](https://github.com/mricol/ED1G5E3/assets/82113257/832fc686-ef26-4284-985a-7fe21a67e29b)

## TestBench Sumador-Restador de 4 bits

Cada uno de estos circuitos base se declaran cuando exportamos a verilog el circuito final del Sumador-Restador de 4 bits, como se observa en el archivo SumRes.v

Para hacer las pruebas creamos un nuevo archivo testbench de este archivo base SumRes_tb.v, en él definimos las variables que entran al SumRes, que son los 5 digitos de cada número de entrada, dónde el quinto dígito es el correspondiente al signo. 

Hacemos la prueba con dos números: 4 y 9 y probamos las 4 combinaciones posibles: 4+9, 4-9, 9-4, -4-9, es decir, en cada caso solo cambian los signos:

```
reg a0=1, a1=0, a2=0, a3=1, sa=0, b0=0, b1=0, b2=1, b3=0, sb=0;
initial
	begin
		sa=0;
		sb=0;
		#10
		sa=0;
		sb=1;
		#10;
		sa=1;
		sb=0;
		#10;
		sa=1;
		sb=1;
		#10;
		$finish;
		#10;
	end
```
 y obtenemos la gráfica con gtkwave, ayudándonos del curso verificamos cada combinación:
 
En este caso tenemos la suma de dos número binarios 9 y 4 respectivamente 

![image](https://github.com/mricol/ED1G5E3/assets/82113257/981f0eb9-8b51-4cfa-b1b3-dac317454b60)

En este caso tenemos la suma de dos número binarios 9 y -4 respectivamente 

![image](https://github.com/mricol/ED1G5E3/assets/82113257/3b32bda6-5dc3-4985-9812-05b77a29a0d9)

En este caso tenemos la suma de dos número binarios -9 y 4 respectivamente 

![image](https://github.com/mricol/ED1G5E3/assets/82113257/c30164b6-2d6d-4677-881b-b54824182ea1)


En este caso tenemos la suma de dos número binarios -9 y -4 respectivamente 

![image](https://github.com/mricol/ED1G5E3/assets/82113257/a35a227b-3693-4419-8d7f-37ddf50dcbc4)

### Aclaración
Se contempló una suma cuyo resultado fuera de 4 signos también, por lo que el acarreo se descarta y por lo tanto solo se pueden realizar sumas hasta 15.
