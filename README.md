# Proyecto de Pruebas Automatizadas con Karate para Pet Store

Este proyecto contiene un conjunto de pruebas automatizadas para la API de [Swagger Petstore](https://petstore.swagger.io/), desarrolladas utilizando el framework Karate DSL. Las pruebas cubren varios endpoints del flujo de mascotas (pets), incluyendo la creación, obtención por estado e ID, actualización, eliminación y subida de imágenes de mascotas.

## 1. Prerrequisitos

Antes de ejecutar las pruebas, asegúrate de tener instalado y configurado lo siguiente en tu sistema:

*   **Java 17 (o superior):** El proyecto está configurado para usar Java.
*   **Apache Maven:** Se utiliza para la gestión de dependencias y la ejecución de las pruebas.
*   **Variables de Entorno:**
    *   `JAVA_HOME`: Debe apuntar al directorio de instalación de tu JDK.
    *   `M2_HOME`: Debe apuntar al directorio de instalación de Maven.
    *   Asegúrate de que las carpetas `bin` de Java y Maven estén incluidas en la variable `Path` de tu sistema operativo.

## 2. Estructura del Proyecto y Buenas Prácticas

El proyecto está diseñado siguiendo las mejores prácticas de Karate DSL:
*   **`src/test/java/examples/users/users.feature`**: Contiene la lógica principal de las pruebas escritas en Gherkin.
*   **`src/test/java/examples/jsonData/`**: Centraliza los archivos `.json` (payloads) utilizados en las peticiones (creación, actualización), separando los datos de la lógica de prueba.
*   **`src/test/java/examples/imagen/`**: Almacena los recursos multimedia (imágenes) necesarios para probar los endpoints de subida de archivos (multipart).
*   **`karate-config.js`**: Archivo de configuración global que maneja variables dinámicas según el entorno (ej. `dev`, `cert`).

## 3. Ejecución de las Pruebas

Todas las pruebas se ejecutan desde la línea de comandos, ubicándote en la raíz del proyecto.

### Ejecutar todos los casos de prueba (Regresión)

Para ejecutar el conjunto completo de pruebas de regresión, utiliza el siguiente comando. Este comando apunta al runner `UsersRunner` y ejecuta todos los escenarios etiquetados con `@regression` en el entorno de certificación (`cert`).

```bash
mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @regression" -Dkarate.env=cert
```

### Ejecutar casos de prueba ideales (Happy Path)

Para ejecutar únicamente los escenarios "ideales" (donde se espera que las operaciones sean exitosas, como crear, actualizar y consultar exitosamente), ejecuta:

```bash
mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @happypath" -Dkarate.env=cert
```

### Ejecutar un escenario específico

Puedes ejecutar un escenario específico utilizando su etiqueta individual (por ejemplo, `@TEST-1` para la creación de mascota):

```bash
mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @TEST-1" -Dkarate.env=cert
```
