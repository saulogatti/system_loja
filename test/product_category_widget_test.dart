import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/screens/products/widgets/product_category.dart';

/// Testes do widget ProductCategory
///
/// Valida funcionalidades de seleção de categoria existente e criação
/// de novas categorias através de dropdown ou entrada manual.
void main() {
  group('ProductCategory Widget Tests', () {
    late TextEditingController controller;
    late List<Produto> produtos;

    setUp(() {
      controller = TextEditingController();
      produtos = [
        Produto(
          id: 1,
          nome: 'Produto 1',
          codigo: 'P001',
          preco: 10.0,
          estoque: 5,
          descricao: 'Descrição 1',
          categoria: 'Eletrônicos',
        ),
        Produto(
          id: 2,
          nome: 'Produto 2',
          codigo: 'P002',
          preco: 20.0,
          estoque: 10,
          descricao: 'Descrição 2',
          categoria: 'Livros',
        ),
        Produto(
          id: 3,
          nome: 'Produto 3',
          codigo: 'P003',
          preco: 30.0,
          estoque: 15,
          descricao: 'Descrição 3',
          categoria: 'Eletrônicos',
        ),
      ];
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('deve exibir campo de texto quando não há produtos',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: [],
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsNothing);
    });

    testWidgets('deve exibir dropdown quando há produtos com categorias',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('deve extrair categorias únicas dos produtos',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Abre o dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Assert - deve haver 2 categorias únicas (Eletrônicos e Livros)
      expect(find.text('Eletrônicos'), findsOneWidget);
      expect(find.text('Livros'), findsOneWidget);
    });

    testWidgets('deve permitir selecionar categoria do dropdown',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Act - abre dropdown e seleciona uma categoria
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Livros').last);
      await tester.pumpAndSettle();

      // Assert
      expect(controller.text, 'Livros');
    });

    testWidgets('deve alternar para modo entrada manual ao clicar no botão add',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Verifica que inicia com dropdown
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);

      // Act - clica no botão para adicionar nova categoria
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Assert - deve mudar para campo de texto
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsNothing);
      expect(find.byIcon(Icons.list), findsOneWidget);
    });

    testWidgets('deve alternar de volta para dropdown ao clicar no botão list',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Act - alterna para entrada manual
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verifica que está em modo manual
      expect(find.byType(TextFormField), findsOneWidget);

      // Act - alterna de volta para dropdown
      await tester.tap(find.byIcon(Icons.list));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      expect(find.byType(TextFormField), findsNothing);
    });

    testWidgets('deve permitir entrada de texto em modo manual',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Act - alterna para modo manual
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Digita nova categoria
      await tester.enterText(find.byType(TextFormField), 'Brinquedos');
      await tester.pump();

      // Assert
      expect(controller.text, 'Brinquedos');
    });

    testWidgets('deve validar campo obrigatório no modo dropdown',
        (WidgetTester tester) async {
      // Arrange
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: ProductCategory(
                controller: controller,
                produtos: produtos,
                required: true,
              ),
            ),
          ),
        ),
      );

      // Act - tenta validar sem selecionar
      final isValid = formKey.currentState!.validate();

      // Assert
      expect(isValid, false);
      await tester.pumpAndSettle();
      expect(find.text('Selecione uma categoria'), findsOneWidget);
    });

    testWidgets('deve validar campo obrigatório no modo texto',
        (WidgetTester tester) async {
      // Arrange
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: ProductCategory(
                controller: controller,
                produtos: produtos,
                required: true,
              ),
            ),
          ),
        ),
      );

      // Act - alterna para modo manual
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Valida sem preencher
      final isValid = formKey.currentState!.validate();

      // Assert
      expect(isValid, false);
      await tester.pumpAndSettle();
      expect(find.text('Categoria é obrigatória'), findsOneWidget);
    });

    testWidgets('deve desabilitar dropdown quando enabled é false',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
              enabled: false,
            ),
          ),
        ),
      );

      // Assert
      final dropdown = tester.widget<DropdownButtonFormField<String>>(
        find.byType(DropdownButtonFormField<String>),
      );
      expect(dropdown.onChanged, isNull);

      final iconButton = tester.widget<IconButton>(find.byIcon(Icons.add));
      expect(iconButton.onPressed, isNull);
    });

    testWidgets('deve desabilitar campo de texto quando enabled é false',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: [],
              enabled: false,
            ),
          ),
        ),
      );

      // Assert
      final textField = tester.widget<TextFormField>(
        find.byType(TextFormField),
      );
      expect(textField.enabled, false);
    });

    testWidgets('deve chamar onChanged quando categoria é alterada',
        (WidgetTester tester) async {
      // Arrange
      String? categoriaAlterada;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
              onChanged: (value) {
                categoriaAlterada = value;
              },
            ),
          ),
        ),
      );

      // Act - seleciona uma categoria
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Eletrônicos').last);
      await tester.pumpAndSettle();

      // Assert
      expect(categoriaAlterada, 'Eletrônicos');
    });

    testWidgets(
        'deve inicializar com valor do controller se categoria existir',
        (WidgetTester tester) async {
      // Arrange - pré-preenche o controller
      controller.text = 'Livros';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Assert - deve estar no modo dropdown com valor selecionado
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      final dropdown = tester.widget<DropdownButtonFormField<String>>(
        find.byType(DropdownButtonFormField<String>),
      );
      expect(dropdown.value, 'Livros');
    });

    testWidgets(
        'deve inicializar no modo manual se controller tem valor não existente',
        (WidgetTester tester) async {
      // Arrange - pré-preenche com categoria que não existe
      controller.text = 'CategoriaInexistente';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Assert - deve estar no modo manual
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsNothing);
      expect(controller.text, 'CategoriaInexistente');
    });

    testWidgets('deve ignorar categorias vazias ao extrair de produtos',
        (WidgetTester tester) async {
      // Arrange - adiciona produto sem categoria
      final produtosComVazio = [
        ...produtos,
        Produto(
          id: 4,
          nome: 'Produto sem categoria',
          codigo: 'P004',
          preco: 40.0,
          estoque: 20,
          descricao: 'Sem categoria',
          categoria: '',
        ),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtosComVazio,
            ),
          ),
        ),
      );

      // Abre o dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Assert - deve haver apenas 2 categorias (não deve incluir vazio)
      expect(find.text('Eletrônicos'), findsOneWidget);
      expect(find.text('Livros'), findsOneWidget);
      // Verifica que não há item vazio no dropdown
      expect(
        find.descendant(
          of: find.byType(DropdownMenuItem<String>),
          matching: find.text(''),
        ),
        findsNothing,
      );
    });

    testWidgets('deve atualizar categorias quando lista de produtos muda',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Abre dropdown inicial
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      expect(find.text('Eletrônicos'), findsOneWidget);
      expect(find.text('Livros'), findsOneWidget);

      // Fecha o dropdown pressionando ESC ou clicando fora
      await tester.tapAt(tester.getCenter(find.byType(Scaffold)));
      await tester.pumpAndSettle();

      // Act - atualiza com nova lista de produtos
      final novosProdutos = [
        Produto(
          id: 5,
          nome: 'Produto 5',
          codigo: 'P005',
          preco: 50.0,
          estoque: 25,
          descricao: 'Nova categoria',
          categoria: 'Alimentos',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: novosProdutos,
            ),
          ),
        ),
      );

      // Abre dropdown novamente
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Assert - deve mostrar apenas a nova categoria
      expect(find.text('Alimentos'), findsOneWidget);
      expect(find.text('Eletrônicos'), findsNothing);
      expect(find.text('Livros'), findsNothing);
    });

    testWidgets(
        'deve preservar valor existente ao alternar de manual para dropdown',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Act - alterna para modo manual
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Digita uma categoria que já existe
      await tester.enterText(find.byType(TextFormField), 'Livros');
      await tester.pump();

      // Alterna de volta para dropdown
      await tester.tap(find.byIcon(Icons.list));
      await tester.pumpAndSettle();

      // Assert - valor deve ser preservado e selecionado no dropdown
      expect(controller.text, 'Livros');
      final dropdown = tester.widget<DropdownButtonFormField<String>>(
        find.byType(DropdownButtonFormField<String>),
      );
      expect(dropdown.value, 'Livros');
    });

    testWidgets(
        'deve limpar valor não existente ao alternar de manual para dropdown',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCategory(
              controller: controller,
              produtos: produtos,
            ),
          ),
        ),
      );

      // Act - alterna para modo manual
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Digita uma categoria que não existe
      await tester.enterText(find.byType(TextFormField), 'CategoriaInexistente');
      await tester.pump();

      // Alterna de volta para dropdown
      await tester.tap(find.byIcon(Icons.list));
      await tester.pumpAndSettle();

      // Assert - valor deve ser limpo pois não existe nas categorias
      expect(controller.text, '');
      final dropdown = tester.widget<DropdownButtonFormField<String>>(
        find.byType(DropdownButtonFormField<String>),
      );
      expect(dropdown.value, isNull);
    });
  });
}
