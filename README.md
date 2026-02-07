# BP Digital Banking Architecture Solution

**Arquitectura de Banca Digital para Banco BP**

Este repositorio contiene el diseño de arquitectura de soluciones para el ecosistema de Banca por Internet de Banco BP. El diseño sigue el modelo **C4 (Context, Containers, Components, Code)** y se adhiere a las mejores prácticas de gobernanza, seguridad (Zero-Trust) y cumplimiento normativo (LOPDP, CNBV, PCI-DSS).

> **Estado del Proyecto:** [Release Candidate] **95% Completado**
>
> La arquitectura ha sido modelada formalmente utilizando Structurizr DSL. Se han generado los diagramas C4 (Niveles 1-4), definido los ADRs y estructurado el repositorio para la fase de implementación.

## Resumen Ejecutivo

La solución propone una arquitectura basada en **Microservicios (DDD)** y **Event-Driven Architecture (EDA)**, diseñada para soportar:

*   **Escalabilidad:** Hasta 200,000 TPS en pico.
*   **Alta Disponibilidad:** 99.99% (Multi-AZ + Multi-Region Warm Standby).
*   **Seguridad:** Flujos FAPI 2.0, DPoP, y validación biométrica IAL2.
*   **Cumplimiento:** Auditoría inmutable (WORM) y trazabilidad completa.

## Estructura del Repositorio

La organización del código y la documentación sigue un estándar riguroso:

```text
online-banking-architecture/
├── diagrams/                  # Modelos Visuales (C4 Model)
│   ├── structurizr/           # MODELO FORMAL DEL PROYECTO
│   │   ├── workspace.dsl      # Código fuente del modelo C4 (Structurizr DSL)
│   │   ├── c4_level1_...      # Imágenes exportadas del modelo
│   │   └── ...
│   ├── context/               # Diagramas históricos
│   └── ...
│
├── docs/                      # Documentación Técnica y de Procesos
│   ├── adrs/                  # Architecture Decision Records (18 Decisiones Clave)
│   ├── compliance/            # Normativas (LOPDP, PCI-DSS)
│   └── observability/         # Estrategia de OpenTelemetry
│
├── services/                  # Definición de Microservicios (Bounded Contexts)
│   ├── transaction/           # Core transaccional (Saga + Outbox)
│   ├── onboarding/            # Alta digital biométrica
│   ├── audit/                 # Ledger inmutable
│   └── ...
│
├── bff/                       # Backend For Frontend (BFF)
│   ├── web/                   # BFF para SPA (React)
│   └── mobile/                # BFF para App Móvil (Flutter)
│
└── infra/                     # Infraestructura como Código (IaC)
    └── terraform/             # Scripts de despliegue AWS
```

## Visualización del Modelo C4 (Structurizr)

La arquitectura completa está definida como código en el archivo `diagrams/structurizr/workspace.dsl`.

**Instrucciones para visualizar el modelo:**

1.  Acceda a [Structurizr DSL Playground](https://playground.structurizr.com/).
2.  Copie el contenido completo del archivo `diagrams/structurizr/workspace.dsl`.
3.  Pegue el código en el editor del Playground.
4.  Haga clic en el botón **"Render"** para generar los diagramas interactivos.
5.  Navegue entre las vistas (Context, Containers, Components, Deployment) utilizando el menú izquierdo.

Este modelo es la fuente de verdad para la arquitectura, reflejando todos los componentes, relaciones, decisiones de diseño (ADRs) y despliegue en AWS.

## Stack Tecnológico de Referencia

*   **Frontend:** React (Web), Flutter (Mobile).
*   **Backend:** Java (Spring Boot), Go (Audit/Onboarding), Node.js (BFF).
*   **Data & Events:** Aurora PostgreSQL (Global), DynamoDB, Kafka (MSK), Redis.
*   **Infraestructura:** AWS (EKS, Lambda, Outposts) + Terraform.

## Navegación

1.  Comience por **[Summary.md](./Summary.md)** para una visión general de las métricas y objetivos.
2.  Revise **[Arquitectura_de_Banca_por_Internet_BP.md](./Arquitectura_de_Banca_por_Internet_BP.md)** para el documento maestro de diseño.
3.  Consulte los **[ADRs](./docs/adrs/README.md)** para entender las justificaciones detrás de cada decisión técnica.
4.  Explore el modelo C4 en **[diagrams/structurizr/workspace.dsl](./diagrams/structurizr/workspace.dsl)**.

---
**Autor:** Angel David Yaguana Hernandez
**Rol:** Lead Solutions Architect
