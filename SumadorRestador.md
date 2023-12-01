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

Después de convertir todos los archivos previos a Verilog

```
module SemiS (
  input a,
  input b,
  output Sum,
  output Cout
);
  assign Sum = (a ^ b);
  assign Cout = (a & b);
endmodule
```
```
module CompA2 (
  input Sign,
  input A0,
  input A1,
  input A2,
  input A3,
  output B0,
  output B1,
  output B2,
  output B3
);
  wire s0;
  wire s1;
  wire s2;
  wire s3;
  wire s4;
  wire s5;
  assign s0 = (A0 ^ Sign);
  assign s2 = (A1 ^ Sign);
  assign s4 = (A2 ^ Sign);
  SemiS SemiS_i0 (
    .a( Sign ),
    .b( s0 ),
    .Sum( B0 ),
    .Cout( s1 )
  );
  SemiS SemiS_i1 (
    .a( s1 ),
    .b( s2 ),
    .Sum( B1 ),
    .Cout( s3 )
  );
  SemiS SemiS_i2 (
    .a( s3 ),
    .b( s4 ),
    .Sum( B2 ),
    .Cout( s5 )
  );
  assign B3 = (s5 ^ (A3 ^ Sign));
endmodule

module Sumador (
  input a,
  input b,
  input c,
  output Sum,
  output Cout
);
  wire s0;
  wire s1;
  wire s2;
  SemiS SemiS_i0 (
    .a( a ),
    .b( b ),
    .Sum( s2 ),
    .Cout( s1 )
  );
  SemiS SemiS_i1 (
    .a( s2 ),
    .b( c ),
    .Sum( Sum ),
    .Cout( s0 )
  );
  assign Cout = (s0 | s1);
endmodule
```
```
module Sumador4b (
  input a0,
  input a1,
  input b0,
  input b1,
  input cin,
  input a2,
  input b2,
  input a3,
  input b3,
  output s0,
  output s1,
  output s2,
  output s3,
  output cout
);
  wire s4;
  wire s5;
  wire s6;
  Sumador Sumador_i0 (
    .a( a0 ),
    .b( b0 ),
    .c( cin ),
    .Sum( s0 ),
    .Cout( s4 )
  );
  Sumador Sumador_i1 (
    .a( a1 ),
    .b( b1 ),
    .c( s4 ),
    .Sum( s1 ),
    .Cout( s5 )
  );
  Sumador Sumador_i2 (
    .a( a2 ),
    .b( b2 ),
    .c( s5 ),
    .Sum( s2 ),
    .Cout( s6 )
  );
  Sumador Sumador_i3 (
    .a( a3 ),
    .b( b3 ),
    .c( s6 ),
    .Sum( s3 ),
    .Cout( cout )
  );
endmodule
```
```
module Mux_2x1
(
    input [0:0] sel,
    input in_0,
    input in_1,
    output reg out
);
    always @ (*) begin
        case (sel)
            1'h0: out = in_0;
            1'h1: out = in_1;
            default:
                out = 'h0;
        endcase
    end
endmodule
```
```
module SumRes (
  input A0,
  input A1,
  input A2,
  input A3,
  input SA,
  input B0,
  input B1,
  input B2,
  input B3,
  input SB,
  output C0,
  output C1,
  output C2,
  output C3,
  output SC
);
  wire s0;
  wire s1;
  wire s2;
  wire s3;
  wire s4;
  wire s5;
  wire s6;
  wire s7;
  wire s8;
  wire s9;
  wire s10;
  wire s11;
  wire s12;
  wire SC_temp;
  wire s13;
  wire s14;
  CompA2 CompA2_i0 (
    .Sign( SB ),
    .A0( B0 ),
    .A1( B1 ),
    .A2( B2 ),
    .A3( B3 ),
    .B0( s0 ),
    .B1( s1 ),
    .B2( s2 ),
    .B3( s3 )
  );
  CompA2 CompA2_i1 (
    .Sign( SA ),
    .A0( A0 ),
    .A1( A1 ),
    .A2( A2 ),
    .A3( A3 ),
    .B0( s4 ),
    .B1( s5 ),
    .B2( s6 ),
    .B3( s7 )
  );
  assign s13 = (SA & SB);
  Sumador4b Sumador4b_i2 (
    .a0( s4 ),
    .a1( s5 ),
    .b0( s0 ),
    .b1( s1 ),
    .cin( 1'b0 ),
    .a2( s6 ),
    .b2( s2 ),
    .a3( s7 ),
    .b3( s3 ),
    .s0( s8 ),
    .s1( s9 ),
    .s2( s10 ),
    .s3( s11 ),
    .cout( s12 )
  );
  Sumador Sumador_i3 (
    .a( SA ),
    .b( SB ),
    .c( s12 ),
    .Sum( s14 )
  );
  Mux_2x1 Mux_2x1_i4 (
    .sel( s13 ),
    .in_0( s14 ),
    .in_1( s13 ),
    .out( SC_temp )
  );
  CompA2 CompA2_i5 (
    .Sign( SC_temp ),
    .A0( s8 ),
    .A1( s9 ),
    .A2( s10 ),
    .A3( s11 ),
    .B0( C0 ),
    .B1( C1 ),
    .B2( C2 ),
    .B3( C3 )
  );
  assign SC = SC_temp;
endmodule
```

### 
En este caso tenemos la suma de dos número binarios 9 y 4 respectivamente 

![image](https://github.com/mricol/ED1G5E3/assets/82113257/981f0eb9-8b51-4cfa-b1b3-dac317454b60)

En este caso tenemos la suma de dos número binarios 9 y -4 respectivamente 

![image](https://github.com/mricol/ED1G5E3/assets/82113257/3b32bda6-5dc3-4985-9812-05b77a29a0d9)

En este caso tenemos la suma de dos número binarios -9 y 4 respectivamente 

![image](https://github.com/mricol/ED1G5E3/assets/82113257/c30164b6-2d6d-4677-881b-b54824182ea1)


En este caso tenemos la suma de dos número binarios -9 y -4 respectivamente 

![image](https://github.com/mricol/ED1G5E3/assets/82113257/a35a227b-3693-4419-8d7f-37ddf50dcbc4)

