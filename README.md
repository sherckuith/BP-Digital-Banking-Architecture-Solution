# BP Digital Banking Architecture Solution

**Arquitectura de Banca Digital para Banco BP**

Este repositorio contiene el diseño de arquitectura de soluciones para el ecosistema de Banca por Internet de Banco BP. El diseño sigue el modelo **C4 (Context, Containers, Components, Code)** y se adhiere a las mejores prácticas de gobernanza, seguridad (Zero-Trust) y cumplimiento normativo (LOPDP, CNBV, PCI-DSS).


> **Estado del Proyecto:**  **Finalizado (100% Completado)**
>
> **Nota Importante:** El documento de referencia principal y consolidado de este proyecto es el archivo PDF: **`Online Banking Architecture BP.pdf`**.
> Este repositorio sirve como soporte técnico, conteniendo los diagramas fuente, historial de decisiones (ADRs) y código de infraestructura.

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

### 🧭 Roadmap del Proyecto

Para una revisión exhaustiva, se recomienda seguir este flujo de documentos, los cuales han sido validados al **100%** de cumplimiento con los requerimientos de BP.

1. **[Estrategia y Resumen](Summary.md):** Fundamentos del negocio y métricas objetivo (TPS, Disponibilidad).
2. **[Modelo C4 - Índice Visual](indice_C4.md):** **(Recomendado)** Acceso directo a la arquitectura modelada en **Structurizr**. Representa la fuente de verdad del diseño.
3. **[Registro de Decisiones (ADRs)](docs/adrs/README.md):** Justificación técnica de las 18 decisiones críticas (DDD, Saga, DPoP, etc.).
4. **[Racional del Diseño](Design_Rationale.md):** Profundización en la elección de **Flutter**, seguridad de **API Gateway** y resiliencia de infraestructura.

---

**Autor:** Angel David Yaguana Hernandez
