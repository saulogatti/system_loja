# Category Management Implementation - Build Instructions

## Overview
This implementation separates product categories into a dedicated database table to prevent data loss when products are deleted.

## Required Build Step

After all code changes have been made, you MUST run the following command to generate the necessary Drift and Freezed code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This command generates:
- `category.g.dart` - JSON serialization for Category model
- `category_dao.g.dart` - Drift DAO implementation
- `category_state.freezed.dart` - Freezed state classes for CategoryCubit
- Updates to `app_database.g.dart` - Including the new CategoriesRecords table
- Updates to `product.g.dart` - Reflecting the categoryId field change

## Testing

After code generation, run tests to verify the implementation:

```bash
# Run all tests
flutter test

# Run specific category tests
flutter test test/category_dao_test.dart
```

## Database Migration

The schema version has been incremented from 2 to 3. When the app runs for the first time after this update:
1. A new `categories_records` table will be created
2. A `categoryId` column will be added to `products_records`
3. A default "Sem Categoria" category will be created
4. Existing products will have `null` categoryId (can be updated manually)

## Key Changes

### Domain Model
- **Product**: `category` (String) → `categoryId` (int?)
- **Category**: New model with `id`, `name`, `description`

### Database
- **CategoriesRecords**: New table for categories
- **ProductsRecords**: Updated with foreign key to CategoriesRecords
- **AppDatabase**: Schema version 3 with migration logic

### UI
- **ProductCategory**: Now loads categories from database via CategoryCubit
- **CategoryManagementScreen**: New screen for CRUD operations on categories
- **ProductForm**: Updated to work with categoryId

### Repository & State Management
- **CategoryRepository**: Business logic for category operations
- **CategoryCubit**: State management for category UI
- **ProductCubit**: Updated to work with categoryId

## Known Issues

The ProductCategory widget needs to be integrated into the navigation/routing system. You may need to add it to your route configuration.

## Next Steps for User

1. Run `dart run build_runner build --delete-conflicting-outputs`
2. Test the application
3. Add navigation to the CategoryManagementScreen (e.g., from Settings)
4. Verify that products can be created with categories
5. Verify that deleting a product doesn't delete its category
6. Manually assign categories to existing products if needed
