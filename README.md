# Calculadora Flutter (MVVM)

Calculadora com as quatro operações básicas (adição, subtração, multiplicação e divisão), desenvolvida em Flutter com **StatefulWidget** e organizada no padrão **MVVM**.

## Funcionalidades

- Soma, subtração, multiplicação e divisão
- Números decimais
- Operações encadeadas (ex.: `2 + 3 × 4`)
- Botões `C` (limpar), `⌫` (apagar dígito) e `±` (inverter sinal)
- Tratamento de divisão por zero

## Estrutura (MVVM)

```
lib/
├── main.dart                         # ponto de entrada
├── models/
│   └── calculadora_model.dart        # Model: regras de cálculo
├── viewmodels/
│   └── calculadora_viewmodel.dart    # ViewModel: estado e comandos
└── views/
    ├── calculadora_view.dart         # View: tela (StatefulWidget)
    └── widgets/
        └── botao_calculadora.dart    # widget reutilizável do botão
```

| Camada | Responsabilidade |
|---|---|
| **Model** | Faz os cálculos (`calcular`) e lança `DivisaoPorZeroException`. Não conhece a interface. |
| **ViewModel** | Guarda o estado (visor, operando, operador) e expõe comandos (`digitar`, `definirOperacao`, `calcularResultado`...). Estende `ChangeNotifier` e chama `notifyListeners()` a cada mudança. |
| **View** | Desenha a tela e repassa os toques ao ViewModel. É um `StatefulWidget` que escuta o ViewModel (`addListener`) e chama `setState()` para atualizar a interface. |

## Como executar

```bash
flutter pub get
flutter run
```