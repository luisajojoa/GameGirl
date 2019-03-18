# Documentación proyecto  GameGirl
Luisa Jojoa, Sebastián Ruiz, Sebastián Gómez, Juan Pablo Huertas M

A continuación, se describirá el funcionamiento y la arquitectura de una consola para videojuegos propuesta como proyecto final de la asignatura electrónica digital II, en la Universidad Nacional de Colombia. Basándose en la consola creada por Nintendo (GameBoy) se plantea el diseño de la GameGirl. El propósito es implementar un SoC con un procesador LM32 y diversos periféricos que permitan la interacción con la consola en el momento de hacer uso del juego que sea escogido. Los periféricos siguen una lógica de maestro-esclavos y se unen al procesador LM32 mediante un bus wishbone.
A continuación se muestra el diagrama de funcionamiento de nuestro SoC, donde se usa un procesador LM32, se interconectan los periféricos por medio de un wishbone y se realizan los protocolos de comunicación SPI, UART y GPIO.

