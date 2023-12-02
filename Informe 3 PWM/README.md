# Informe 3: Generación de Señal PWM con Verilog


## Introducción
La generación de señales de Modulación de Ancho de Pulso (PWM) es un aspecto fundamental en el diseño de sistemas electrónicos y controladores digitales. En la electrónica digital, el PWM se utiliza comúnmente para controlar la potencia entregada a dispositivos como motores, luces y otros componentes, permitiendo una gestión eficiente de la energía. En esta práctica de laboratorio, se abordó la tarea de crear una señal PWM directamente desde Verilog, un lenguaje de descripción de hardware ampliamente utilizado en el diseño de circuitos digitales.

La generación de señales PWM es esencial para el control de velocidad, intensidad luminosa, y otras variables en sistemas embebidos y de control digital. Comprender cómo diseñar y implementar un generador de PWM mediante Verilog es crucial para aquellos que trabajan en el campo de la electrónica digital y diseño de sistemas embebidos.

## Marco Teórico
Modulación de Ancho de Pulso (PWM)
La Modulación de Ancho de Pulso es una técnica que modifica el ancho de los pulsos en una señal periódica, comúnmente una onda cuadrada. La relación entre el tiempo en que la señal está en estado alto y el tiempo total del período se conoce como el ciclo de trabajo o duty cycle. El duty cycle se expresa como un porcentaje y determina la cantidad de tiempo que la señal está en estado alto en comparación con el período completo.

Verilog en el Diseño de Circuitos Digitales
Verilog es un lenguaje de descripción de hardware (HDL) que se utiliza para modelar y simular sistemas digitales. Permite a los diseñadores describir el comportamiento y la estructura de un circuito digital, facilitando la implementación de lógica compleja en hardware. En este contexto, Verilog se utiliza para diseñar y simular la generación de señales PWM, brindando a los ingenieros la capacidad de especificar la funcionalidad de sus circuitos digitales de manera eficiente y precisa.

La combinación de la técnica PWM y el lenguaje de descripción de hardware Verilog proporciona una herramienta poderosa para el diseño de sistemas digitales avanzados, permitiendo la implementación de estrategias de control precisas y eficientes en una variedad de aplicaciones prácticas. En este informe, se detallará el proceso de diseño, implementación y análisis de una señal PWM mediante Verilog, destacando los principios teóricos fundamentales subyacentes en este proceso.

## Procedimiento

### Lógica del código

Para entender la lógica del código requerido diseñamos primero un simple diagrama de flujo con dos sencillos pasos para crear la señal PWM, definiendo un contador que se reiniciará cada tanto tiempo (límite) y estableciendo el ancho que requerimos para el PWM:

![image](https://github.com/mricol/ED1G5E3/assets/142938038/2d5155ca-41a7-49b6-9028-570d5e2b364f)

De esta manera identificamos que para la construcción del código necesitamos tres estapas clave: un contador y dos comparadores, uno de ellos para reiniciar el contador y otro para seleccionar el valor alto o bajo de la señal PWM.

### Construcción del código

En el preámbulo del código establecemos que el módulo tendrá solo una entrada y una salida, la entrada corresponde al reloj y la salida a la señal de PWM y las variables a utilizar:

```
module pwm(
	input clk,
	output pwms
	);
	parameter size = 6; //Tamaño de la variable que almacenará el contador.
	parameter periodo = 100; // Periodo de la señal deseado en segundos
	parameter limit = periodo/2; // Cálculo del límite del contador, se divide entre dos el periodo pues el pasan dos segundos para que el reloj active el código con el posedge
	parameter duty =60; // Porcentaje (0-100%) de ciclo útil para la señal de PWM
	parameter ancho = limit*duty/100; //Cálculo del ancho que tendrá el PWM, valor absoluto en segundos
	
	reg  [size-1:0] count = 0; //Creación de la variable que almacena el contador
```
Posteriormente iniciamos con la sección del contador:

```
	always@(posedge clk) //En cada óflanco de subida del reloj realizar las siguientes acciones
	begin
	  if(count == limit) //Comparar si el contador ya llegó al límite
	  begin
		count <= 1; // Si sí, resetear el contador en 1, inicia a contar nuevamente
	  end
	  else
	  begin
		count <= count + 1; //Si no, sumar uno y continuar.
	  end
	end
```
Y finalmente el comparador de la señal PWM:

```
	assign pwms = (count <= ancho) ? 1:0; //Para la señal PWM comparar el contador con el ancho, si es menor, asignar 1, si supera el valor asignar 0.
```


### Pruebas de escritorio

Creamos el archivo del testbench en el cual simplemente definimos la señal del reloj y la introducimos al módulo de pwm:

```
module pwm_tb;

initial
  begin
	#100; //agregar una pausa antes de terminar
    #400 $finish(); //terminar
 end
 
reg clk = 1; //Creación de la variable reloj
always #1 clk = !clk; //Cada tick invertir el reloj

wire out; //Creación del cable out requerido para el módulo

pwm dut (clk, out); //Módulo bajo prueba, con la entrada clk y salida out.

initial
  begin
    $dumpfile("top.vcd"); //crea el archivo de prueba
    $dumpvars(0, pwm_tb);
  end

endmodule
```

Creamos los archivos de prueba y graficamos usando gtkwave:

Caso 1: Periodo 100s, PWM 60%
```
	parameter periodo = 100; // Periodo de la señal deseado en segundos
	parameter limit = periodo/2; // Cálculo del límite del contador, se divide entre dos el periodo pues el pasan dos segundos para que el reloj active el código con el posedge
	parameter duty =60; // Porcentaje (0-100%) de ciclo útil para la señal de PWM
```

Gráficas: 
![image](https://github.com/mricol/ED1G5E3/assets/142938038/21fb2e43-38d2-4e61-8e0c-765982078bf5)
![image](https://github.com/mricol/ED1G5E3/assets/142938038/62ecfc1e-8100-4cc9-a25b-a6da2ed857d6)
![image](https://github.com/mricol/ED1G5E3/assets/142938038/8b08c5b7-0b54-473a-9b59-b51674ea7c4a)
![image](https://github.com/mricol/ED1G5E3/assets/142938038/f8912f89-6d91-4803-8b57-3945112ad5b2)

Observamos en las gráficas que obtenemos el comportamiento deseado, en el 60% del periodo (60s) la señal de pwm cambia a bajo y el contador continúa hasta que se reinicia.


Caso 2: Periodo 200s, PWM 20%

```
	parameter periodo = 200; // Periodo de la señal deseado en segundos
	parameter limit = periodo/2; // Cálculo del límite del contador, se divide entre dos el periodo pues el pasan dos segundos para que el reloj active el código con el posedge
	parameter duty =20; // Porcentaje (0-100%) de ciclo útil para la señal de PWM
```

Gráficas:
![image](https://github.com/mricol/ED1G5E3/assets/142938038/f10f89b5-9f89-40fd-8ea4-a90163049dd8)
![image](https://github.com/mricol/ED1G5E3/assets/142938038/9fff49bc-6ac9-4792-987f-40dfa9f456f8)






