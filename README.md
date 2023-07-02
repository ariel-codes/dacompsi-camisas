# README cluby.app.br
Plataforma Rails de eventos e vendas, voltada para associações e pequenos organizadores de eventos.

- Ruby version
    - 3.2
- System dependencies
    - sqlite, libvips

### Configuração
Após instalar Ruby e sqlite, rode este script para instalar as dependências pelo Bundler e criar os bancos de dados de dev e teste. 
```bash
bin/setup
```

### Desenvolvimento local
Roda o servidor, compilador Tailwind e fila de _jobs_.
```bash
bin/dev
```

### Como rodar testes
- Testes de unidade: `bin/rails test`
- Testes de aceitação: `bin/rails test:system`
- Todos testes: `bin/rails test:all`

### Deployment instructions
Pelo Fly.io, CI configurado por Github Actions testa e faz deploy em todo commit em `main`.
