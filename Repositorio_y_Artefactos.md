# Estructura del Repositorio y Artefactos

Este repositorio sigue una estructura estándar alineada con el modelo C4 y las mejores prácticas de gobernanza.

```
online-banking-architecture/
|
|-- docs/
|   |-- adrs/                  # Architecture Decision Records
|   |-- README.md              # Índice de documentación
|   |-- compliance/            # Guías de cumplimiento
|   |-- observability/         # Guías de monitoreo
|
|-- diagrams/                  # Modelos C4
|   |-- context/               # Nivel 1
|   |-- containers/            # Nivel 2
|   |-- components/            # Nivel 3 y Secuencias
|   |-- deployment/            # Nivel 4
|
|-- infra/
|   |-- terraform/             # IaC para AWS
|
|-- services/                  # Definición de Microservicios
|   |-- transaction/
|   |-- onboarding/
|   |-- audit/
|   |-- ...
|
|-- bff/                       # Backends For Frontends
|   |-- web/
|   |-- mobile/
|
|-- Glosario.md                # Definiciones técnicas
|-- Summary.md                 # Resumen ejecutivo
|-- Design_Rationale.md        # Racional de diseño
```

## Herramientas Utilizadas

*   **Diagramas**: draw.io, Mermaid, Eraser (https://app.eraser.io/workspace/TCPJ19WsHy4pC5N50oZ4?origin=share)
*   **Documentación**: Markdown
*   **IaC**: Terraform