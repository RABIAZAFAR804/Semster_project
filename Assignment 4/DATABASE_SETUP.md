# 🗄️ Supabase Database Setup Guide

## Quick Start

### Step 1: Access Your Supabase Project
1. Go to: https://lmtaosvgovbgdqtraslz.supabase.co
2. Sign in with your credentials
3. Navigate to **SQL Editor**

### Step 2: Create the Items Table

Copy and paste this SQL command in the SQL Editor:

```sql
-- Create items table
CREATE TABLE IF NOT EXISTS items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger
DROP TRIGGER IF EXISTS update_items_updated_at ON items;
CREATE TRIGGER update_items_updated_at
BEFORE UPDATE ON items
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Enable RLS
ALTER TABLE items ENABLE ROW LEVEL SECURITY;

-- Create policy for anonymous access
CREATE POLICY "Allow anonymous access" ON items
  FOR ALL
  USING (true);
```

### Step 3: Verify Table Creation

1. Go to **Table Editor** in Supabase dashboard
2. You should see the `items` table
3. Columns should be: id, name, description, category, price, created_at, updated_at

### Step 4: Test the Connection

1. Open the Flutter app in Chrome
2. The app should now be connected to your Supabase project
3. Try adding an item using the **Create Item** button
4. Check Supabase dashboard to see if the item appears

## ✅ Verification Checklist

- [ ] Supabase project accessible
- [ ] SQL editor opened
- [ ] Items table created
- [ ] Columns visible in table editor
- [ ] RLS enabled
- [ ] Policies configured
- [ ] Flutter app running
- [ ] Can create items
- [ ] Can view items
- [ ] Can update items
- [ ] Can delete items
- [ ] Can search items

## 🐛 Troubleshooting

### App Not Connecting?
- Check URL: https://lmtaosvgovbgdqtraslz.supabase.co
- Verify API key is correct
- Check internet connection
- Refresh the browser

### Table Not Found?
- Ensure table name is exactly `items` (lowercase)
- Verify all columns are created
- Check RLS is enabled
- Confirm policies are set correctly

### Can't Add Items?
- Check RLS policy allows INSERT
- Verify column names match exactly
- Ensure price is a valid decimal
- Check browser console for errors

### Slow Performance?
- Check internet connection
- Verify database indexes are created
- Monitor Supabase dashboard for slow queries
- Clear browser cache if needed

## 📞 Support

For issues with Supabase:
- Visit: https://supabase.com/docs
- Check your Supabase project logs
- Review RLS policies
- Verify authentication settings

## 🔒 Security Notes

**Current Setup**: Anonymous access enabled
- Good for: Development and testing
- Not recommended for: Production with sensitive data

**For Production**:
1. Implement user authentication
2. Create row-level security policies
3. Restrict data access by user
4. Enable audit logging
5. Set up backups

## 📚 Useful Supabase Links

- **Project URL**: https://lmtaosvgovbgdqtraslz.supabase.co
- **API Documentation**: https://supabase.com/docs/reference/dart
- **Supabase Dashboard**: https://app.supabase.com
- **SQL Editor**: Direct access from project dashboard

## 🚀 Next Steps

1. ✅ Create items table (SQL above)
2. ✅ Add test data via app
3. ✅ Verify CRUD operations work
4. ✅ Deploy to production
5. ✅ Set up monitoring

---

**Setup Completed**: December 11, 2025
**Status**: Ready for use
**Database**: Supabase (https://lmtaosvgovbgdqtraslz.supabase.co)
