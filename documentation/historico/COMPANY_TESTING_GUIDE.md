# Test Guide - Company Registration Feature

## How to Test

### Prerequisites
1. Run the app: `flutter run -d <device>`.
2. Open the "Company Registration" screen through:
   - The "Company Registration" card on the Home screen, or
   - The bottom navigation bar (Business icon).

---

## Test Cases

### ✅ CT-01: Complete Company Registration
**Objective**: Validate registration with all fields filled in.

**Steps**:
1. Enter "Legal Name": `Empresa Teste LTDA`.
2. Enter "CNPJ": `12345678000195` (14 digits).
3. Enter "Email": `contato@empresateste.com`.
4. Enter "Street": `Av. Paulista, 1000`.
5. Enter "ZIP Code": `01310-100`.
6. Enter "Neighborhood": `Bela Vista`.
7. Enter "City": `São Paulo`.
8. Click "Add Company".

**Expected Result**:
- ✅ Green SnackBar: "Company registered successfully!"
- ✅ The form is cleared.
- ✅ The company appears in the list with all its data.
- ✅ The company card shows its name, CNPJ, email, and city.

---

### ✅ CT-02: Registration with Empty Optional Fields
**Objective**: Validate registration with only required fields.

**Steps**:
1. Enter "Legal Name": `Empresa Mínima`.
2. Enter "CNPJ": `98765432000188`.
3. Leave the other fields empty.
4. Click "Add Company".

**Expected Result**:
- ✅ The company is registered successfully.
- ✅ The card shows "No email" when no email is provided.
- ✅ Details show only the fields that were filled in.

---

### ❌ CT-03: Duplicate CNPJ
**Objective**: Validate the CNPJ `UNIQUE` constraint.

**Steps**:
1. Register a company with CNPJ `11122233000144`.
2. Try to register a second company with the SAME CNPJ, `11122233000144`.
3. Click "Add Company".

**Expected Result**:
- ❌ Red SnackBar: "A company with CNPJ 11122233000144 is already registered."
- ❌ The company is NOT registered.
- ❌ The form retains its data.

---

### ❌ CT-04: Invalid CNPJ Validation
**Objective**: Validate CNPJ length.

**Steps - Fewer than 14 digits**:
1. Enter `123456789` (9 digits) in "CNPJ".
2. Click "Add Company".

**Expected Result**:
- ❌ Error message: "CNPJ must contain 14 digits".

**Steps - More than 14 digits**:
1. Enter `123456789012345` (15 digits) in "CNPJ".
2. Click "Add Company".

**Expected Result**:
- ❌ Error message: "CNPJ must contain 14 digits".

**Steps - Empty field**:
1. Leave "CNPJ" empty.
2. Click "Add Company".

**Expected Result**:
- ❌ Error message: "CNPJ is required".

---

### ❌ CT-05: Legal Name Validation
**Objective**: Validate required fields.

**Steps - Empty field**:
1. Leave "Legal Name" empty.
2. Enter a valid CNPJ.
3. Click "Add Company".

**Expected Result**:
- ❌ Error message: "Legal Name is required".

**Steps - Name too short**:
1. Enter `AB` (2 characters) in "Legal Name".
2. Click "Add Company".

**Expected Result**:
- ❌ Error message: "Legal Name must contain at least 3 characters".

---

### ❌ CT-06: Email Validation
**Objective**: Validate the email format.

**Steps**:
1. Enter valid data.
2. Enter `emailinvalido` (without @) in "Email".
3. Click "Add Company".

**Expected Result**:
- ❌ Red SnackBar: "Error: Invalid email!".

---

### ✅ CT-07: Search for an Existing CNPJ
**Objective**: Validate company search.

**Steps**:
1. Register a company with CNPJ `55566677000100`.
2. Enter `55566677000100` in "Search Company by CNPJ".
3. Click "Search".

**Expected Result**:
- ✅ A dialog appears with the legal name as its title.
- ✅ The dialog displays all company data:
  - CNPJ
  - Email (if provided)
  - Street (if provided)
  - ZIP code (if provided)
  - Neighborhood (if provided)
  - City (if provided)

---

### ❌ CT-08: Search for a Nonexistent CNPJ
**Objective**: Validate handling of a company that was not found.

**Steps**:
1. Enter a nonexistent CNPJ, `99999999000199`, in the search field.
2. Click "Search".

**Expected Result**:
- ❌ Red SnackBar: "No company found with CNPJ 99999999000199."

---

### ❌ CT-09: Search with an Empty Field
**Objective**: Validate a search with an empty field.

**Steps**:
1. Leave the search field empty.
2. Click "Search".

**Expected Result**:
- ❌ Orange SnackBar: "Enter a CNPJ to search".

---

### 🗑️ CT-10: Delete a Company
**Objective**: Validate deletion with confirmation.

**Steps**:
1. Register a test company.
2. Click the card's trash icon in the list.
3. Click "Cancel" in the confirmation dialog.

**Expected Result**:
- ✅ The dialog closes.
- ✅ The company is NOT deleted.

**Steps (continued)**:
4. Click the trash icon again.
5. Click "Delete" in the dialog.

**Expected Result**:
- ✅ The dialog closes.
- ✅ Green SnackBar: "Company deleted successfully!"
- ✅ The company is REMOVED from the list.
- ✅ The card disappears.

---

### 👆 CT-11: View Details from a Card
**Objective**: Validate clicking a list card.

**Steps**:
1. Register a company with complete data.
2. Click the company card in the list (not the trash icon).

**Expected Result**:
- ✅ The details dialog appears (as it does for search results).
- ✅ It shows all populated fields.
- ✅ The "Close" button closes the dialog.

---

### 📋 CT-12: Empty List
**Objective**: Validate the initial state.

**Steps**:
1. Open the screen when no companies are registered.

**Expected Result**:
- ✅ Message displayed: "No companies registered".
- ✅ Gray, centered text.

---

### 🔄 CT-13: Automatic CNPJ Formatting
**Objective**: Validate removal of special characters.

**Steps**:
1. Enter `12.345.678/0001-95` (formatted) in "CNPJ".
2. Fill in the other fields.
3. Click "Add Company".

**Expected Result**:
- ✅ The company is registered with CNPJ stored as `12345678000195` (unformatted).
- ✅ Search works with or without formatting.

---

## Integration Tests

### 🔗 CT-14: Navigation
**Steps**:
1. Click the "Company Registration" card on the Home screen.
2. Verify that the correct screen opens.
3. Use the bottom navigation to open another screen.
4. Return using the bottom navigation (Business icon).

**Expected Result**:
- ✅ Navigation is smooth.
- ✅ State is preserved (the list does not reload unnecessarily).

---

### 💾 CT-15: Data Persistence
**Steps**:
1. Register 3 companies.
2. Close the app completely.
3. Reopen the app.
4. Open the companies screen.

**Expected Result**:
- ✅ All 3 companies appear in the list.
- ✅ All data is preserved.

---

## Final Validation Checklist

- [ ] The form works correctly.
- [ ] Validation prevents invalid registrations.
- [ ] CNPJ uniqueness is enforced.
- [ ] Search returns the correct results.
- [ ] Deletion works with confirmation.
- [ ] The list displays registered companies.
- [ ] The details dialog shows complete information.
- [ ] Navigation works (Home and bottom navigation).
- [ ] SnackBars provide appropriate feedback.
- [ ] Data persists after restarting the app.
- [ ] There are no crashes or console errors.
- [ ] The interface is responsive (different screen sizes).

---

## Bug Report

If you find issues, report:
1. **Steps to reproduce**
2. **Expected behavior**
3. **Actual behavior**
4. **Screenshots (if applicable)**
5. **Console logs**

---

**Schema version**: 9
**Last updated**: 30/01/2026
