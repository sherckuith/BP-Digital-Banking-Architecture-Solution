# Changelog

## [Unreleased]

### Added
- **Structurizr DSL Model**: Se ha creado el archivo `diagrams/structurizr/workspace.dsl` para modelar formalmente la arquitectura.
    - **Nivel 1 (Contexto)**: Definición de actores (Clientes, Reguladores) y sistemas externos (Core, IdP, Fraude).
    - **Nivel 2 (Contenedores)**: Mapeo completo de microservicios, BFFs, Gateway y capas de datos (Aurora, MSK, Redis).
    - **Nivel 3 (Componentes)**: Detalle granular para *Transaction Service* (Saga, Outbox), *Onboarding* (Biometría), *Audit* (Ledger Inmutable) y *Notification*.
    - **Nivel 4 (Despliegue)**: Representación de infraestructura AWS Multi-Región y conexión On-Premise.
- **Cumplimiento de Test**: El modelo refleja estrictamente los requisitos de `test_instructions.md` (e.g., FAPI 2.0, Zero-Trust, HA, WORM).

### Changed
- **Renombrado de Imágenes**: Se estandarizaron los nombres de las imágenes exportadas de Structurizr en `diagrams/structurizr/` siguiendo la convención `c4_level[N]_[nombre]` para mayor claridad y orden.

### Refined
- **Arquitectura (V2)**: Implementación de origen dual de datos en **Customer Service** (Core + Customer-360) y actualización de diagramas de contenedores a V2.
- **Justificaciones Técnicas**: Robustecimiento de `Design_Rationale.md` para **Flutter** (AOT, Impeller) y **API Gateway** (PEP, FAPI 2.0).
- **Costos**: Inclusión del impacto financiero de Warm-Standby (+35%) y activación de DR.


