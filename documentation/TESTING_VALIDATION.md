# Manual Testing Guide - Validation System

This document provides a complete guide for manually testing the implemented validation improvements.

## Test Objectives

Verify that:
1. Negative values are rejected in numeric fields.
2. Error messages are clear and specific.
3. Input formatting works correctly.
4. Validation does not block valid values.
5. The user experience is intuitive.

## Product Screen

### Test Scenarios

#### Price Field

**Test 1: Valid Values**
1. Open the product registration screen.
2. Enter `10.50` in the price field.
3. ✅ **Expected**: The value is accepted.
4. Also try: `10,50`, `100`, `0`, `0.01`.
5. ✅ **Expected**: All values are accepted.

**Test 2: Invalid Negative Values**
1. Enter `-10.50` in the price field.
2. Try to submit the form.
3. ✅ **Expected**: Message "Price cannot be negative".

**Test 3: Invalid Format**
1. Enter `abc` in the price field.
2. Observe that letters are not entered (input formatter).
3. ✅ **Expected**: Only numbers and a period/comma are allowed.

**Test 4: Invalid Decimal Precision**
1. Enter `10.505` in the price field.
2. Observe that it is limited to `10.50` (input formatter).
3. ✅ **Expected**: A maximum of 2 decimal places.

**Test 5: Comma Conversion**
1. Enter `10,50` in the price field.
2. Observe that it is converted to `10.50`.
3. ✅ **Expected**: The comma is automatically converted to a period.

#### Stock Field

**Test 6: Valid Values**
1. Enter `10` in the stock field.
2. ✅ **Expected**: The value is accepted.
3. Also try: `0`, `100`, `9999`.
4. ✅ **Expected**: All values are accepted.

**Test 7: Invalid Negative Values**
1. Try entering `-10` in the stock field.
2. Observe that the minus sign is not accepted (input formatter).
3. ✅ **Expected**: Only digits are allowed.

**Test 8: Invalid Decimal Values**
1. Try entering `10.5` in the stock field.
2. Observe that the decimal point is not accepted.
3. ✅ **Expected**: Only whole numbers are allowed.

#### Code Field

**Test 9: Valid Values**
1. Enter `ABC-123` in the code field.
2. ✅ **Expected**: The value is accepted and converted to uppercase.
3. Also try: `PROD001`, `12345`, `ABC`.
4. ✅ **Expected**: All values are accepted.

**Test 10: Uppercase Conversion**
1. Enter `abc-123` in the code field.
2. Observe that it is converted to `ABC-123`.
3. ✅ **Expected**: Automatic conversion to uppercase.

**Test 11: Invalid Characters**
1. Try entering `ABC@123`.
2. Observe that `@` is not accepted.
3. ✅ **Expected**: Only letters, numbers, and hyphens are allowed.

**Test 12: Invalid Length**
1. Enter only `AB`.
2. Try to submit the form.
3. ✅ **Expected**: Message "Code must contain at least 3 characters".

#### Complete Flow

**Test 13: Successful Registration**
1. Fill in all fields correctly:
   - Nome: `Notebook Dell`
   - Código: `NOTE-001`
   - Preço: `3500.00`
   - Estoque: `10`
   - Categoria: `Eletrônicos`
   - Descrição: `Notebook Dell Inspiron 15`
2. Click "Add Product".
3. ✅ **Expected**: Success message "Product 'Notebook Dell' registered successfully!".
4. ✅ **Expected**: The form is cleared.
5. ✅ **Expected**: The product appears in the list.

## Sales Screen

### Test Scenarios

#### Quantity Field

**Test 14: Valid Quantity**
1. Open the sales screen.
2. Click "Add Item".
3. Select a product with 10 units in stock.
4. Enter quantity: `5`.
5. ✅ **Expected**: The item is added successfully.

**Test 15: Invalid Negative Quantity**
1. Try to add an item.
2. Try to enter `-5`.
3. Observe that the minus sign is not accepted.
4. ✅ **Expected**: Only positive numbers are allowed.

**Test 16: Quantity Exceeds Stock**
1. Try to add an item for a product with 5 units in stock.
2. Enter quantity: `10`.
3. Try to confirm.
4. ✅ **Expected**: Message "Quantity exceeds available stock".

**Test 17: Invalid Decimal Quantity**
1. Try to enter `5.5`.
2. Observe that the decimal point is not accepted.
3. ✅ **Expected**: Only whole numbers are allowed.

#### Invoice Fields

**Test 18: Required Fields**
1. Try to save an invoice without filling in its fields.
2. ✅ **Expected**: Specific error messages appear for each empty field.

**Test 19: Customer Validation**
1. Enter the invoice number and payment method.
2. Do not select a customer.
3. Try to save.
4. ✅ **Expected**: Message "Error: Select a customer!".

**Test 20: Item Validation**
1. Fill in all fields but do not add any items.
2. Try to save.
3. ✅ **Expected**: Message "Error: Add at least one item!".

## Customers Screen

### Test Scenarios

**Test 21: Valid Name**
1. Enter the name `João Silva`.
2. ✅ **Expected**: Accepted (>= 3 characters).

**Test 22: Invalid Name - Too Short**
1. Enter the name `Jo`.
2. Try to submit.
3. ✅ **Expected**: Message "Name must contain at least 3 characters".

**Test 23: Empty Name**
1. Leave the name field empty.
2. Try to submit.
3. ✅ **Expected**: Message "Name is required".

## Users Screen

### Test Scenarios

**Test 24: Valid Name**
1. Enter the name `Maria Santos`.
2. ✅ **Expected**: Accepted (>= 3 characters).

**Test 25: Invalid Name - Too Short**
1. Enter the name `Ma`.
2. Try to submit.
3. ✅ **Expected**: Message "Name must contain at least 3 characters".

## Integration Tests

### Complete Sales Flow

**Test 26: Complete Sale**
1. Register a product with 10 units in stock.
2. Register a customer.
3. Create an invoice.
4. Add the product with a quantity of 5.
5. Save the invoice.
6. ✅ **Expected**: The sale is recorded successfully.
7. Check the product stock.
8. ✅ **Expected**: Stock is reduced to 5.

## Regression Tests

**Test 27: Existing Functionality**
1. Test all existing functionality (list, edit, delete).
2. ✅ **Expected**: No functionality is broken.

## Validation Checklist

Use this checklist to ensure that all tests have been completed:

### Products
- [ ] Price accepts positive values.
- [ ] Price rejects negative values.
- [ ] Price is limited to 2 decimal places.
- [ ] Price converts commas to periods.
- [ ] Stock accepts positive integers.
- [ ] Stock rejects negative values.
- [ ] Stock rejects decimal values.
- [ ] Code accepts alphanumeric characters and hyphens.
- [ ] Code is converted to uppercase.
- [ ] Code rejects special characters.
- [ ] Code validates minimum/maximum length.

### Sales
- [ ] Quantity accepts positive integers.
- [ ] Quantity rejects negative values.
- [ ] Quantity rejects decimals.
- [ ] Quantity is validated against stock.
- [ ] Required fields are validated.
- [ ] Customer validation works.
- [ ] Item validation works.

### Customers
- [ ] Name minimum length is validated.
- [ ] Name is validated as required.

### Users
- [ ] Name minimum length is validated.
- [ ] Name is validated as required.

### General
- [ ] Error messages are clear and specific.
- [ ] Helper text guides the user.
- [ ] Formatters prevent invalid input.
- [ ] Validators catch errors.
- [ ] Forms cannot be submitted with errors.
- [ ] The user experience is intuitive.

## Reporting Issues

If you find an issue during testing, report:

1. **Screen**: Which screen was affected.
2. **Field**: Which field had the issue.
3. **Action**: What you tried to do.
4. **Expected**: What should have happened.
5. **Actual**: What happened.
6. **Steps to Reproduce**: How to reproduce the issue.

## Important Notes

1. All formatters work in real time; invalid characters simply do not appear in the field.
2. Validators run when the form is submitted.
3. Error messages appear below the corresponding field.
4. Helper text provides examples of the correct format.
5. Required fields are marked with an asterisk (*).

## Test Environment

Test on multiple platforms when possible:
- [ ] Windows
- [ ] macOS
- [ ] iOS
- [ ] Android

## Conclusion

After completing all tests in this guide, you will have verified that:
- ✅ Negative values are correctly rejected.
- ✅ Input formatting works as expected.
- ✅ Error messages are specific and useful.
- ✅ Validation does not interfere with normal use.
- ✅ The system is more robust and reliable.
