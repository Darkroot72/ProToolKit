# **ProToolkit V11.2 – Ethical Network & Security Diagnostic Suite**

## 🛡️ **Descripción General**

ProToolkit V11.2 es una herramienta profesional diseñada para **auditoría de red**, **diagnóstico avanzado**, **fingerprinting**, **enumeración** y **recolección de inteligencia técnica** en infraestructura. Está construida para entornos donde se requiere **precisión, rapidez y trazabilidad**, y siempre bajo el marco de **pentesting ético autorizado**.

Se trata de una evolución madura basada en más de **10 años de experiencia real** en análisis de redes, pruebas de intrusión, análisis forense y observabilidad operativa. La herramienta busca ser:

* **Modular** → cada componente es independiente y fácil de extender.
* **Transparente** → todo se registra en logs y puede exportarse en JSON.
* **Rápida** → prioriza escaneos eficientes y multihilo cuando es seguro hacerlo.
* **Segura** → bloquea funciones agresivas sin autorización explícita.
* **Ergonómica** → menú mejorado, perfiles de escaneo y salida colorizada.
* **Profesional** → orientada a equipos de seguridad, analistas SOC, pentesters y sysadmins.

---

## 🎯 **Objetivo Principal**

Brindar una **suite completa de reconocimiento y análisis** que permita a un auditor:

1. Obtener una visión inmediata del estado de un objetivo.
2. Identificar puertos, servicios, rutas, subdominios y errores de configuración.
3. Recopilar evidencia técnica exportable para reportes profesionales.
4. Realizar escaneos avanzados sólo cuando exista autorización.
5. Mantener todo organizado mediante logs, perfiles y exportaciones limpias.

---

## ⚙️ **Funciones Principales**

ProToolkit V11.2 incluye:

### 🔍 **Escaneos Básicos y Avanzados**

* Fast Scan (Top 100) con Nmap.
* OS Fingerprinting.
* Detalle de servicios y versiones.
* Escaneo de vulnerabilidades con NSE.
* Masscan (1–65535) con control de rate.
* UDP (top 30).

### 🌐 **Información del Entorno**

* WHOIS + DNS completo.
* HTTP/S fingerprint + headers de seguridad.
* SSL/TLS cert dump + fingerprinting.
* Subdomain enumeration automatizada vía CRT.sh.
* Traceroute/MTR inteligente.

### 🚨 **Inteligencia & Reputation**

* Lookup automatico en AbuseIPDB.
* Validación del estado del objetivo.
* Identificación automática de WAF/CDN.

### 📦 **Gestión de Reportes y Exportación**

* Logs completos en tiempo real.
* Exportación en `Report_*.json`.
* Compresión automática de todos los resultados.
* Estructura ordenada en carpeta temporal.

### 🧩 **Usabilidad y Flujo de Trabajo Mejorado**

* Menú con opciones bien organizadas.
* Perfiles de escaneo personalizables.
* Resúmenes instantáneos post-scan.
* Estados rápidos por objetivo.
* Modo agresivo bloqueado por defecto.
* Historial de objetivos recientes.

---

## 🧱 **Arquitectura y Estructura del Proyecto**

```
ProToolkit/
│
├── protoolkit.sh           # Script principal (menu + core)
├── config.sh               # Configuración global
├── utils/
│   ├── log.sh              # Logging + colores
│   ├── validate.sh         # Validaciones
│   ├── checks.sh           # Dependencias
│
├── scans/
│   ├── nmap.sh
│   ├── masscan.sh
│   ├── dns_whois.sh
│   ├── http.sh
│   ├── ssl.sh
│   ├── traceroute.sh
│   └── subdomains.sh
│
├── export/
│   ├── json.sh
│   └── compress.sh
│
└── README.md               # Documentación de la herramienta
```

Diseñada para que cualquier módulo pueda sustituirse, ampliarse o ejecutarse de forma independiente.

---

## 🔐 **Modo Agresivo (Opcional)**

ProToolkit respeta estrictamente las reglas del pentesting.

Para habilitar escaneos invasivos (Masscan, Nmap vuln, UDP intensivo), se requiere:

* Confirmación manual escrita: `YES`
* Ser consciente del impacto en redes productivas
* Tener autorización explícita del cliente/equipo

Esto añade seguridad para evitar ejecutar accidentalmente algo crítico.

---

## 🚀 **¿Qué Aporta ProToolkit al Usuario Final?**

### Para pentesters:

* Flujo de reconocimiento completo en un solo lugar.
* Exportación lista para reportes.
* Automatización de tareas repetitivas.

### Para analistas SOC:

* Verificación rápida de incidentes.
* Lookup de reputación.
* Diagnósticos instantáneos de servicios externos.

### Para administradores:

* Comprobación de configuraciones.
* Verificación de dominio, DNS, HTTP y SSL.

### Para equipos híbridos en respuesta a incidentes:

* Evidencia clara y organizada.
* Trazabilidad mediante timestamps.
* Identificación rápida de vectores potenciales.

---

## 📌 **Requisitos Técnicos**

* Bash 4+
* nmap
* masscan
* dig (bind-utils)
* whois
* jq
* curl
* openssl
* mtr o traceroute

Todos los módulos detectan automáticamente si faltan dependencias.

---

## 🧭 **Instalación Rápida**

```bash
chmod +x install.sh
sudo ./install.sh
```

O ejecución directa:

```bash
chmod +x protoolkit.sh
./protoolkit.sh
```

---

## 🧑‍💻 **Autoría y Visión**

ProToolkit es una herramienta de **auditoría ética seria**, diseñada por DarkRoot y asistida por un motor IA con experiencia consolidada en redes, ciberseguridad, automatización y shell scripting profesional.

El objetivo es ofrecer una base sólida, modular y profesional para:

* Equipos de seguridad.
* Investigadores.
* Pentesters.
* Administradores de sistemas.
* Laboratorios personales.

Y evolucionar constantemente hacia un toolkit **más inteligente, más rápido y más útil**.

---

## 🌟 **Roadmap Futuros (V11.3 en adelante)**

* Integración con Telegram/Slack para envío de reportes.
* API interna en Python para análisis adicionales.
* Autodetección de tecnologías mediante favicon hashing.
* Modo "Live Recon" continuo.
* Dashboards HTML de resultados.

---

## 🏁 **Conclusión**

ProToolkit es una herramienta profesional diseñada para quienes necesitan **claridad, velocidad y precisión** en el reconocimiento de red.

Flexible, segura, modular y con visión de futuro.

> "El reconocimiento es el 80% del pentest. Si el reconocimiento es sólido, el resto fluye." — DarkRoot
