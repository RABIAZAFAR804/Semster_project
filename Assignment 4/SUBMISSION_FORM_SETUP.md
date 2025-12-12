# Submission Form App - Setup Guide

## Overview
This is a complete Flutter application that implements a professional form submission system with full CRUD operations using Supabase as the backend database.

## Features
✅ **Form Fields:**
- Full Name (text input, required)
- Email (email input with validation)
- Phone Number (phone input with minimum 10 digits)
- Address (multiline text input)
- Gender (dropdown: Male, Female, Other)

✅ **Functionality:**
- **Create**: Add new form submissions
- **Read**: View all submissions in a beautiful list
- **Update**: Edit existing submissions
- **Delete**: Remove submissions with confirmation
- **Search**: Search submissions by name or email
- **Validation**: Client-side validation for all fields

✅ **UI Design:**
- Material 3 design system
- Indigo color scheme (#6366F1)
- Professional gradient AppBars
- Smooth animations and transitions
- Responsive layout
- Loading indicators
- Error handling with SnackBars

## Database Setup

### Step 1: Create Submissions Table

Go to your Supabase dashboard and execute the SQL query from `SUBMISSIONS_SQL_SETUP.sql`:

```sql
CREATE TABLE submissions (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  address TEXT NOT NULL,
  gender VARCHAR(50) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### Step 2: Create Indexes

```sql
CREATE INDEX idx_submissions_email ON submissions(email);
CREATE INDEX idx_submissions_full_name ON submissions(full_name);
```

### Step 3: Enable Row Level Security (RLS)

```sql
ALTER TABLE submissions ENABLE ROW LEVEL SECURITY;
```

### Step 4: Create RLS Policies

Run all the policies from `SUBMISSIONS_SQL_SETUP.sql` to allow anonymous users to perform CRUD operations.

## Project Structure

```
lib/
├── main.dart                          # App entry point with theme & routes
├── models/
│   ├── item_model.dart               # Item data model (legacy CRUD)
│   └── submission_model.dart         # Submission data model
├── screens/
│   ├── home_screen.dart              # Item CRUD list screen
│   ├── create_screen.dart            # Item creation form
│   ├── update_screen.dart            # Item update form
│   ├── detail_screen.dart            # Item detail view
│   ├── submissions_screen.dart       # Submission list with search
│   ├── create_submission_screen.dart # Form to create submission
│   └── update_submission_screen.dart # Form to update submission
└── services/
    └── supabase_service.dart         # Database service (items + submissions)
```

## File Descriptions

### Models
**submission_model.dart**
- Submission class with fields: id, fullName, email, phoneNumber, address, gender, createdAt, updatedAt
- toJson(): Converts to Supabase-compatible format (snake_case)
- fromJson(): Creates Submission from database response
- copyWith(): Creates copy with updated fields

### Screens

**submissions_screen.dart** (Main List Screen)
- Displays all submissions in a beautiful card-based list
- Search functionality (by name or email)
- Edit/Delete options via popup menu
- Floating action button to create new submission
- Pull-to-refresh capability
- Empty state when no submissions exist

**create_submission_screen.dart** (Form Screen)
- Comprehensive form with all required fields
- Real-time validation:
  - Full Name: required, text only
  - Email: valid email format
  - Phone: minimum 10 digits
  - Address: required
  - Gender: dropdown selection required
- Loading state during submission
- Success/error notifications
- Cancel button to go back

**update_submission_screen.dart** (Edit Screen)
- Same form as creation with pre-filled values
- All validation rules apply
- Updates existing submission
- Maintains form state during edits

### Service
**supabase_service.dart**
- Singleton pattern for database access
- Methods for submissions:
  - getAllSubmissions()
  - getSubmissionById(id)
  - createSubmission(data)
  - updateSubmission(id, data)
  - deleteSubmission(id)
  - searchSubmissions(query)
- Methods for items (legacy CRUD)
- Error handling with descriptive messages

## Validation Rules

| Field | Rules |
|-------|-------|
| Full Name | Required, non-empty |
| Email | Required, valid email format (xxx@xxx.xxx) |
| Phone Number | Required, minimum 10 digits |
| Address | Required, non-empty |
| Gender | Required, must select from dropdown |

## How to Test

### Testing Create Operation
1. Tap the floating action button "+"
2. Fill in all fields with valid data
3. Tap "Submit"
4. You should see a success message and return to the list
5. New submission should appear in the list

### Testing Read Operation
1. Submissions are automatically loaded and displayed
2. Use the refresh button to reload data
3. Use the search bar to filter by name or email

### Testing Update Operation
1. Tap the popup menu (three dots) on any submission
2. Select "Edit"
3. Modify any fields
4. Tap "Update"
5. Changes should be reflected in the list

### Testing Delete Operation
1. Tap the popup menu (three dots) on any submission
2. Select "Delete"
3. Confirm the delete action in the dialog
4. Submission should be removed from the list

### Testing Validation
- Try submitting without filling required fields
- Enter invalid email formats
- Enter phone numbers with less than 10 digits
- Form should show error messages

## Theme & Colors

The application uses Material 3 design system with:
- **Primary Color**: Indigo (#6366F1)
- **Success Color**: Green (#16A34A)
- **Warning Color**: Orange (#EA580C)
- **Info Color**: Blue (#2563EB)
- **AppBar**: Gradient from Indigo to lighter shade
- **Buttons**: Indigo with white text
- **Input Fields**: Light gray background with Indigo borders

## Running the App

### Prerequisites
- Flutter 3.9.2 or higher
- Dart SDK
- Supabase project with submissions table created

### Setup
1. Update `supabase_service.dart` with your Supabase credentials (already done)
2. Create the submissions table using the SQL setup
3. Run `flutter pub get`
4. Run `flutter run` on your device/emulator

### Supported Platforms
- ✅ Android
- ✅ iOS
- ✅ Web (Chrome, Firefox, Safari)
- ✅ macOS
- ✅ Windows
- ✅ Linux

## Error Handling

The app handles errors gracefully:
- Network errors: Shows error SnackBar with message
- Validation errors: Shows field-level error messages
- Database errors: Displays user-friendly error messages
- Loading states: Shows circular progress indicator

## Performance Features

- Search uses Supabase full-text search (ilike)
- Database indexes on frequently searched fields
- Efficient list rendering with ListView.builder
- Lazy loading of images and data
- Proper disposal of resources

## Future Enhancements

Potential features to add:
- Image upload for submissions
- Date picker for date fields
- File attachments
- Export submissions to CSV/PDF
- Pagination for large datasets
- Real-time updates with Supabase subscriptions
- User authentication
- Email notifications

## Troubleshooting

### Submissions not saving
- Check Supabase connection (check `supabaseUrl` and `supabaseAnonKey`)
- Verify submissions table exists
- Check RLS policies are enabled
- Look at browser console for network errors

### Validation not working
- Ensure form has proper validators
- Check FormState validation is called before submit

### Search not working
- Verify indexes are created on email and full_name columns
- Check Supabase search policy allows anonymous users

### App not building
- Run `flutter clean`
- Run `flutter pub get`
- Check for syntax errors with `flutter analyze`

## Support

For issues or questions:
1. Check the error message in the app
2. Review the validation rules
3. Verify Supabase table structure matches the model
4. Check browser/device console for logs

---

**Version**: 1.0  
**Last Updated**: December 12, 2024
