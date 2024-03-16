# Progetto di Tecnologie software per il web

Tutta la documentazione presente in `docs/`.

# Struttura delle directory

- **data-base**: database sql file
- **java-src**: java webserver source

```
.
├── data-base
├── docs
│   ├── build.sh
│   ├── README.md
│   └── README.tex
├── java-src
│   ├── mvnw
│   ├── mvnw.cmd
│   ├── pom.xml
│   ├── src
│   │   └── main
│   │       ├── java
│   │       │   └── org
│   │       │       └── dinosauri
│   │       │           └── dinosauri
│   │       │               └── HelloServlet.java
│   │       └── webapp
│   │           ├── index.jsp
│   │           └── WEB-INF
│   │               └── web.xml
│   └── target
│       ├── classes
│       │   └── org
│       │       └── dinosauri
│       │           └── dinosauri
│       │               └── HelloServlet.class
│       ├── dinosauri-1.0-SNAPSHOT
│       │   ├── index.jsp
│       │   ├── META-INF
│       │   │   └── MANIFEST.MF
│       │   └── WEB-INF
│       │       ├── classes
│       │       │   └── org
│       │       │       └── dinosauri
│       │       │           └── dinosauri
│       │       │               └── HelloServlet.class
│       │       └── web.xml
│       ├── dinosauri-1.0-SNAPSHOT.war
│       └── generated-sources
│           └── annotations
└── README.md

26 directories, 16 files
```