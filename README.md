# ECON 520 - Ciencia de Datos para Economía y Negocios

> Docentes: Sergio De Raco y Viktoriya Semeshenko
> Versión: Segundo cuatrimestre 2026

```
25 de Agosto, 2026
```

## Objetivos de aprendizaje

* Entender los elementos y procedimientos básicos de la programación del lenguaje R.

* Comprender y poner en práctica el flujo de trabajo de un proyecto de datos: cargar, emprolijar, manipular, analizar y visualizar datos.

* Conocer diferentes formas de la representación gráfica de datos y comunicación de resultados.

* Familiarizarse con diferentes librerías del lenguaje de programación utilizado.

* Estimular la aplicación del abordaje computacional a problemas de interés económico y social de diversa índole.

* Aprender metodologías seleccionadas de análisis de datos y aplicarlas a conjuntos de datos de interés económico. 2026-C2: procesamiento y análisis de textos, redes complejas.

## Requerimientos

- **Formales**: Análisis Estadístico I (540) y Matemática Aplicada II (544).

- **Técnicos**: Notebook personal con 8Gb RAM (mínimo) y 10Gb de espacio en disco (ideal).

- **Deseables**: Interés por el trabajo participativo en equipo y el aprendizaje mediante prueba y error.

## Criterio de evaluación

Para la aprobación del curso se requiere:

1. participación en clase
2. participación grupal en Hackathon de medio término
3. entrega de tareas periódicas
4. elaboración y aprobación de un proyecto de datos final en grupos

## Clases
[Cronograma tentativo de clases](https://bit.ly/crono-e520-2026c2) con contenidos y links a material actualizados a medida que avanza el curso.

## Resumen de contenidos

* *Unidad 0. Instalación y setup de workplace para proyectos de datos en R*. Lenguaje R y entorno en RStudio. Git para control de versiones. Interfase de línea de comandos (CLI) y RStudio.

* *Unidad 1a. Elementos de programación en R*. Introducción a elementos de programación (dato, conjunto de datos). Gestión de variables y almacenamiento. Estructuras de datos (tipos). Operaciones (pivoting/merges para dataframes). Sentencias condicionales y estructuras de control de flujos: `for`, `while`, `if`. Implementación de funciones ad-hoc. Análisis estadístico descriptivo básico. R con tidyverse. Piping. Gestión de flujos de trabajo en el ciclo de los proyectos de datos (PD): Importar. Preprocesar (Emprolijar, Transformar y Explorar). Visualizar. Modelizar. Comunicar.

* *Unidad 1b. Visualización y comunicación en R*. Nociones de graficación (forma, color, tamaño, color). Exploración y Visualización de datos. Introducción a ggplot, template. Casos: tidy datasets, Gapminder. Comunicación: Rmarkdown, Graphics, Notebooks, Presentaciones, Interactivos, Dashboards. 

* *Unidad 2a. Aplicaciones 1: Redes de interacciones*. Introducción al análisis de redes en R. Statistical Analysis of Network Data. Tutorial Kateto. Casos: Redes Gutenberg/Redes sociales ONA Book (API tweets British network) o Trump 

* *Unidad 2b. Aplicaciones 2: Text mining*. Introducción al análisis de textos en R. Tidytext con novelas y datos de Twitter. 


## Fuentes utilizadas

El material para el curso fue extraído y transformado de diversas fuentes, de las que destacamos:
  
-   [https://kateto.net/network-visualization](https://kateto.net/network-visualization)    
-   [https://github.com/kolaczyk/sand](https://github.com/kolaczyk/sand)
-   [https://ladal.edu.au/tutorials/net/net.html](https://ladal.edu.au/tutorials/net/net.html)
-   [https://juliasilge.github.io/tidytext/articles/topic_modeling.html](https://juliasilge.github.io/tidytext/articles/topic_modeling.html)
-   [https://paldhous.github.io/NICAR/2019/r-text-analysis.html](https://paldhous.github.io/NICAR/2019/r-text-analysis.html)


## Bibliografía básica 

+ [Wickham, H., Çetinkaya-Rundel, M., & Grolemund, G. (2023). R for data science. "O'Reilly Media".](https://r4ds.hadley.nz/)
+ [R Core Development Team, (2000), _Introducción a R. Notas sobre R: Un entorno de programación para Análisis de Datos y Gráficos_.]( https://cran.r-project.org/doc/contrib/R-intro-1.1.0-espanol.1.pdf).
+ [Katerina Ognyanova (2021), Network Science Tutorials](https://kateto.net/network-visualization)
+ [Julia Silge y David Robinson (2017), Text Mining With R. "O'Reilly Media".](https://www.tidytextmining.com/) 

## Bibliografía ampliada

+ [Grolemund, G. (2014). Hands-on programming with R. "O'Reilly Media".](https://rstudio-education.github.io/hopr/)
+ [McNulty, K. (2022). Handbook of graphs and networks in people analytics: with examples in R and python. Chapman and Hall/CRC.](https://ona-book.org/)
+ [Tipoe, E., & Becker, R. (2019), Doing Economics](https://www.core-econ.org/doing-economics/)

# Entorno de trabajo

> Pasos para la instalación y configuración del software necesario (normalizado) para el curso. 

> IMPORTANTE: deben seguirse estos pasos independientemente de que tengan instalado el software (`R`, `RStudio`) en cualquiera de sus versiones.

Dado que el curso se construye sobre el aprendizaje y uso de un lenguaje de programación, está pensado para que **cada alumno trabaje individualmente en una máquina**, que *asumiremos* propia en función de que sólo es posible adquirir estas habilidades a través de la práctica por medio de (¡muchas!) pruebas y errores.

Para desarrollar los contenidos del curso utilizaremos el software estadístico [`R`](https://cran.r-project.org/) y [`RStudio Desktop`](https://www.rstudio.com/products/rstudio/) como el entorno de desarrollo integrado (IDE) para la gestión de proyectos de datos. 

Adicionalmente, requeriremos instalar [`git`](https://git-scm.com/downloads), una herramienta para el control de versiones que servirá para gestionar de manera eficiente el desarrollo de los proyectos de datos que encararemos en el curso.

A continuación detallamos los pasos a seguir para poner a punto el entorno de trabajo.

## R y RStudio

Seguir instrucciones para instalar en https://posit.co/download/rstudio-desktop/
  
## Instalar git
  
1. Abrir una terminal y ejecutar el siguiente comando para chequear si ya está instalado:
  
```bash 
git
```

2. Si lo anterior presenta un error, en Windows [descargar](https://git-scm.com/downloads) e instalar `git`, en macOS o Linux usar el administrador de paquetes correspondiente.

> Nota: [Acá](https://docs.microsoft.com/es-mx/devops/develop/git/install-and-set-up-git) se puede consultar una guía provista por Microsoft

## Clonar repo(sitorio) del curso

Este repo del curso https://gitlab.com/netlab.iiep/econ-520 contendrá la información que compartiremos durante el curso y otras carpetas que utilizaremos en los proyectos y se actualizará a lo largo de la cursada. Para usarlo es necesario "clonarlo" con `git` en un directorio de trabajo que elijan ustedes.

1. Crear un directorio de trabajo (p.ej.: `<Usuario>/Documentos/Facultad/MI_CARPETA`) 

2. Abrir una `terminal` en esa posición (ver [aquí](https://www.makeuseof.com/tag/a-beginners-guide-to-the-windows-command-line/) instrucciones según los distintos sistemas operativos (p.ej.: Windows, MacOS, Linux).

3. Ejecutar

```bash
git clone https://gitlab.com/netlab.iiep/econ-520.git
```

> Nota: Se creará una carpeta `econ-520` en el directorio de trabajo seleccionado.

El repositorio clonado tiene la siguiente estructura de directorios:
  
```bash
├── clases
    └── tareas
└── proyectos
    ├── bib
    ├── code
    ├── data
    ├── figs
    └── output
└── repos-interesantes
```

