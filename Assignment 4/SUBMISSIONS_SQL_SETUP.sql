-- Create submissions table for Submission Form App
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

-- Create index on email for faster searches
CREATE INDEX idx_submissions_email ON submissions(email);

-- Create index on full_name for faster searches
CREATE INDEX idx_submissions_full_name ON submissions(full_name);

-- Enable RLS (Row Level Security)
ALTER TABLE submissions ENABLE ROW LEVEL SECURITY;

-- Allow anonymous users to read all submissions
CREATE POLICY "Allow anonymous users to read submissions"
  ON submissions
  FOR SELECT
  TO anon
  USING (true);

-- Allow anonymous users to insert submissions
CREATE POLICY "Allow anonymous users to insert submissions"
  ON submissions
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Allow anonymous users to update submissions
CREATE POLICY "Allow anonymous users to update submissions"
  ON submissions
  FOR UPDATE
  TO anon
  USING (true)
  WITH CHECK (true);

-- Allow anonymous users to delete submissions
CREATE POLICY "Allow anonymous users to delete submissions"
  ON submissions
  FOR DELETE
  TO anon
  USING (true);
