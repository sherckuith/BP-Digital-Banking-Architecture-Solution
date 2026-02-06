# Diagramas de Arquitectura (Modelo C4)

Este directorio contiene los diagramas arquitectónicos organizados según el modelo C4, diseñado para permitir una navegación fluida desde el contexto del negocio hasta el detalle técnico de los componentes.

## Estructura

*   **context/**: Diagramas de Nivel 1. Muestran el sistema en su entorno, interactuando con usuarios y sistemas externos (Reguladores, Core Bancario, etc.).
*   **containers/**: Diagramas de Nivel 2. Muestran los contenedores (aplicaciones, bases de datos) que componen el sistema de Banca Digital.
*   **components/**: Diagramas de Nivel 3. Detallan la estructura interna de los contenedores clave (Transaction Service, Onboarding, Audit). Incluye diagramas de Secuencia.
*   **deployment/**: Diagramas de Nivel 4. Muestran cómo se mapean los contenedores a la infraestructura (AWS Multi-Region + On-Premise).

## Herramientas

Los diagramas están disponibles en formato editable `.drawio` y `.mmd` (Mermaid), así como en imágenes estáticas `.png` para fácil visualización.
