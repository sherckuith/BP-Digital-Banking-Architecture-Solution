# ADR-005: Facade/ACL para Core Bancario y Customer-360

## Status
Accepted

## Context
El sistema de Banca por Internet requiere consumir datos críticos de dos fuentes autoritativas dispares:
1.  **Core Bancario Legacy (AS/400)**: Posee la información de cuentas, saldos y lógica contable. Expone interfaces SOAP/XML y protocolos propietarios (ISO 8583).
2.  **Customer-360 (CRM/MDM)**: Sistema independiente que centraliza la información demográfica, preferencias y segmentación del cliente. Expone una API REST con modelos de datos distintos.

El acceso directo a estos sistemas presenta riesgos:
*   **Acoplamiento Fuerte**: Cambios en el Core o Customer-360 romperían múltiples microservicios.
*   **Disonancia de Protocolos**: Mezclar SOAP, XML y REST en la lógica de negocio agrega complejidad accidental.
*   **Latencia y Disponibilidad**: Fallos o lentitud en los sistemas legacy pueden degradar toda la plataforma digital.

## Decision
Implementar una **Capa Anti-Corrupción (Anti-Corruption Layer - ACL)** implementada mediante adaptadores específicos dentro de los servicios de dominio (principalmente en `Transaction Service` y `Customer Service`), complementada con un patrón **Circuit Breaker**.

El `Customer Service` actuará como el **orquestador central** de la información del cliente, unificando en tiempo de ejecución los datos transaccionales del Core y los demográficos del Customer-360 (Dual Source).

## Consequences
### Positivas
*   **Desacoplamiento (Loose Coupling)**: El dominio de Banca Digital permanece agnóstico a la implementación física del Core y Customer-360.
*   **Resiliencia**: El uso de Circuit Breakers (e.g., Resilience4j) impide que la latencia del Core sature los hilos del servidor web.
*   **Normalización**: La ACL traduce modelos arcaicos a entidades de dominio DDD limpias antes de que entren al bounded context.

### Negativas
*   **Latencia Adicional**: La traducción de protocolos agrega un ligero overhead (estimado < 10ms).
*   **Complejidad Operativa**: Se requiere mantener mappings actualizados si los sistemas legacy cambian sus contratos. (Mitigado por pruebas de contrato).
