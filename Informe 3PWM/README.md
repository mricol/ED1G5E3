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
