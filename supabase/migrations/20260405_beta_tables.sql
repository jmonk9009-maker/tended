-- ============================================================
-- Tended Beta Program Tables
-- Created: 2026-04-05
-- Run this in the Supabase SQL editor to set up beta tables.
-- ============================================================

-- -------------------------------------------------------
-- beta_signups
-- Stores full applications for beta testers (max 20)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS beta_signups (
  id              uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  full_name       text        NOT NULL,
  email           text        NOT NULL,
  asset_type      text        NOT NULL,
  tech_comfort    text        NOT NULL,
  referral_source text        NOT NULL,
  created_at      timestamptz DEFAULT now(),
  status          text        DEFAULT 'pending'
);

-- -------------------------------------------------------
-- beta_waitlist
-- Stores overflow signups when 20 slots are filled
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS beta_waitlist (
  id         uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  full_name  text        NOT NULL,
  email      text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- -------------------------------------------------------
-- beta_feedback
-- Stores bug reports and feedback from active testers
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS beta_feedback (
  id               uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  email            text        NOT NULL,
  bug_description  text        NOT NULL,
  what_they_did    text        NOT NULL,
  device_type      text        NOT NULL,
  rating           integer     NOT NULL CHECK (rating >= 1 AND rating <= 5),
  screenshot_url   text,
  created_at       timestamptz DEFAULT now()
);

-- -------------------------------------------------------
-- Row Level Security
-- -------------------------------------------------------
ALTER TABLE beta_signups  ENABLE ROW LEVEL SECURITY;
ALTER TABLE beta_waitlist ENABLE ROW LEVEL SECURITY;
ALTER TABLE beta_feedback ENABLE ROW LEVEL SECURITY;

-- Allow anonymous users to INSERT into all three tables
CREATE POLICY "anon_insert_beta_signups"
  ON beta_signups FOR INSERT TO anon WITH CHECK (true);

CREATE POLICY "anon_insert_beta_waitlist"
  ON beta_waitlist FOR INSERT TO anon WITH CHECK (true);

CREATE POLICY "anon_insert_beta_feedback"
  ON beta_feedback FOR INSERT TO anon WITH CHECK (true);

-- Allow anonymous users to SELECT from beta_signups (needed for slot count)
CREATE POLICY "anon_select_beta_signups"
  ON beta_signups FOR SELECT TO anon USING (true);

-- -------------------------------------------------------
-- Supabase Storage — beta-screenshots bucket
-- Create this bucket manually in the Supabase dashboard:
--   Storage > New bucket > Name: beta-screenshots
--   Set to PUBLIC (so uploaded screenshot URLs are accessible)
--   Then add a storage policy:
--     Allowed operation: INSERT
--     Target roles: anon
--     Policy: true
-- -------------------------------------------------------
